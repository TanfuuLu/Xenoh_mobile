import 'dart:async';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/chat_bubble.dart';
import '../../../../core/widgets/chat_composer.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../providers/chat_unread_controller.dart';
import 'chat_hub_screen.dart' show messagesProvider;

enum _AttachChoice { image, file }

/// One-on-one chat thread for a coach-client relationship — the same
/// `/messages/relationships/{id}` API for both directions (reuses
/// `messagesProvider`). Used by the client ("chat with my coach", pushed from
/// a dedicated entry point) and by the coach (pushed from `ChatHubScreen`'s
/// client picker) — [peerName] is whichever name applies to the viewer.
class RelationshipChatScreen extends ConsumerStatefulWidget {
  const RelationshipChatScreen({
    required this.relationshipId,
    required this.peerName,
    super.key,
  });

  final String relationshipId;
  final String peerName;

  @override
  ConsumerState<RelationshipChatScreen> createState() =>
      _RelationshipChatScreenState();
}

class _RelationshipChatScreenState
    extends ConsumerState<RelationshipChatScreen> {
  final _message = TextEditingController();
  final _pendingAttachments = <PendingChatAttachment>[];
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    unawaited(_markRead());
  }

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _markRead() async {
    try {
      await ref
          .read(chatUnreadControllerProvider.notifier)
          .markRead(widget.relationshipId);
    } catch (_) {
      // Read receipts are non-critical; message loading remains available.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final messages = ref.watch(messagesProvider(widget.relationshipId));
    final myId = ref.watch(authControllerProvider).sessionOrNull?.user.id;
    final peerName = widget.peerName.trim().isEmpty
        ? l10n.coachChatUserFallback
        : widget.peerName.trim();

    return Scaffold(
      appBar: AppBar(title: Text(peerName)),
      body: Column(
        children: [
          Expanded(child: _body(messages, myId, l10n)),
          ChatComposer(
            controller: _message,
            hint: l10n.coachRelationshipChatMessageHint(peerName),
            sending: _sending,
            onSend: () => unawaited(_send()),
            onAttach: () => unawaited(_pickAttachment(l10n)),
            pendingAttachments: _pendingAttachments,
            onRemoveAttachment: (a) =>
                setState(() => _pendingAttachments.remove(a)),
          ),
        ],
      ),
    );
  }

  Widget _body(
    AsyncValue<List<JsonMap>> messages,
    String? myId,
    AppLocalizations l10n,
  ) {
    return switch (messages) {
      AsyncData(:final value) when value.isEmpty => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: EmptyFeatureState(
            title: l10n.coachRelationshipChatEmptyTitle,
            message: l10n.coachRelationshipChatEmptyMessage,
            icon: Icons.forum_outlined,
          ),
        ),
      ),
      AsyncData(:final value) => ListView.builder(
        reverse: true,
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: value.length,
        itemBuilder: (_, i) {
          final msg = value[value.length - 1 - i];
          final senderId = textOf(msg, ['senderId']);
          final mine = senderId.isNotEmpty && senderId == myId;
          final attachments = msg['attachments'];
          return ChatBubble(
            text: textOf(msg, ['content']),
            mine: mine,
            timestamp: _fmtTime(msg['createdAt']),
            attachments: attachments is List
                ? attachments.whereType<Map<String, dynamic>>().toList()
                : null,
          );
        },
      ),
      AsyncError(:final error) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: FeatureError(
            error: error,
            onRetry: () =>
                ref.invalidate(messagesProvider(widget.relationshipId)),
          ),
        ),
      ),
      _ => const Center(child: LoadingList()),
    };
  }

  Future<void> _pickAttachment(AppLocalizations l10n) async {
    final choice = await showModalBottomSheet<_AttachChoice>(
      context: context,
      backgroundColor: AppColors.bgPage,
      showDragHandle: true,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image_outlined),
              title: Text(l10n.coachRelationshipChatAttachImage),
              onTap: () => Navigator.of(context).pop(_AttachChoice.image),
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file_outlined),
              title: Text(l10n.coachRelationshipChatAttachFile),
              onTap: () => Navigator.of(context).pop(_AttachChoice.file),
            ),
          ],
        ),
      ),
    );

    switch (choice) {
      case _AttachChoice.image:
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 2000,
          imageQuality: 90,
        );
        if (image == null || !mounted) return;
        setState(
          () => _pendingAttachments.add((
            path: image.path,
            fileName: image.name,
            isImage: true,
          )),
        );
      case _AttachChoice.file:
        final result = await FilePicker.platform.pickFiles();
        final file = result?.files.single;
        if (file?.path == null || !mounted) return;
        setState(
          () => _pendingAttachments.add((
            path: file!.path!,
            fileName: file.name,
            isImage: false,
          )),
        );
      case null:
        return;
    }
  }

  Future<void> _send() async {
    final content = _message.text.trim();
    if (content.isEmpty && _pendingAttachments.isEmpty) return;
    setState(() => _sending = true);
    try {
      if (_pendingAttachments.isEmpty) {
        await ref.read(xenohApiProvider).postObject(
          '/messages/relationships/${widget.relationshipId}',
          {'content': content},
        );
      } else {
        final formData = FormData.fromMap({
          if (content.isNotEmpty) 'content': content,
          'files': [
            for (final a in _pendingAttachments)
              await MultipartFile.fromFile(a.path, filename: a.fileName),
          ],
        });
        await ref
            .read(xenohApiProvider)
            .postFormData(
              '/messages/relationships/${widget.relationshipId}/attachments',
              formData,
            );
      }
      _message.clear();
      _pendingAttachments.clear();
      ref.invalidate(messagesProvider(widget.relationshipId));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(e, context))),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }
}

String? _fmtTime(Object? value) {
  if (value is! String) return null;
  final dt = DateTime.tryParse(value)?.toLocal();
  if (dt == null) return null;
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(dt.hour)}:${two(dt.minute)}';
}
