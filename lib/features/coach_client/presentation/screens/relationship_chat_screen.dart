import 'dart:async';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/chat_bubble.dart';
import '../../../../core/widgets/chat_composer.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../blocks_reports/presentation/widgets/moderation_dialogs.dart';
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
    final peerId = _peerId(messages.value, myId);

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        toolbarHeight: 68,
        titleSpacing: 4,
        title: _RelationshipChatHeader(peerName: peerName),
        actions: [
          if (peerId != null)
            PopupMenuButton<String>(
              tooltip: l10n.moderationActionsTooltip,
              onSelected: (action) async {
                if (action == 'report_user') {
                  await showReportUserDialog(
                    context,
                    ref,
                    userId: peerId,
                    userName: peerName,
                  );
                } else if (action == 'block_user') {
                  await showBlockUserDialog(
                    context,
                    ref,
                    userId: peerId,
                    userName: peerName,
                  );
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'report_user',
                  child: ListTile(
                    leading: const Icon(Icons.flag_outlined),
                    title: Text(l10n.moderationReportUserAction),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: 'block_user',
                  child: ListTile(
                    leading: const Icon(
                      Icons.block_outlined,
                      color: AppColors.danger,
                    ),
                    title: Text(
                      l10n.moderationBlockUserAction,
                      style: const TextStyle(color: AppColors.danger),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _body(messages, myId, l10n)),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppLayout.contentMaxWidth,
              ),
              child: ChatComposer(
                controller: _message,
                hint: l10n.coachRelationshipChatMessageHint(peerName),
                sending: _sending,
                onSend: () => unawaited(_send()),
                onAttach: () => unawaited(_pickAttachment(l10n)),
                pendingAttachments: _pendingAttachments,
                onRemoveAttachment: (a) =>
                    setState(() => _pendingAttachments.remove(a)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The chat route carries only the relationship id and the peer's display
  /// name, so the peer's user id comes from whichever message they sent. An
  /// empty thread yields null — and has nothing to report or block over.
  String? _peerId(List<JsonMap>? messages, String? myId) {
    if (messages == null || myId == null) return null;
    for (final msg in messages) {
      final senderId = textOf(msg, ['senderId']);
      if (senderId.isNotEmpty && senderId != myId) return senderId;
    }
    return null;
  }

  Widget _body(
    AsyncValue<List<JsonMap>> messages,
    String? myId,
    AppLocalizations l10n,
  ) {
    return switch (messages) {
      AsyncData(:final value) when value.isEmpty => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: _RelationshipChatEmptyState(
            peerName: widget.peerName,
            title: l10n.coachRelationshipChatEmptyTitle,
            message: l10n.coachRelationshipChatEmptyMessage,
          ),
        ),
      ),
      AsyncData(:final value) => LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth > 788
              ? (constraints.maxWidth - AppLayout.contentMaxWidth) / 2 +
                    AppSpacing.lg
              : AppSpacing.lg;
          return ListView.builder(
            reverse: true,
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              AppSpacing.xl,
              horizontalPadding,
              AppSpacing.lg,
            ),
            itemCount: value.length,
            itemBuilder: (_, i) {
              final messageIndex = value.length - 1 - i;
              final msg = value[messageIndex];
              final senderId = textOf(msg, ['senderId']);
              final mine = senderId.isNotEmpty && senderId == myId;
              final attachments = msg['attachments'];
              final sentAt = _parseMessageDate(msg['createdAt']);
              final previousSentAt = messageIndex == 0
                  ? null
                  : _parseMessageDate(value[messageIndex - 1]['createdAt']);
              final startsDay =
                  sentAt != null &&
                  (previousSentAt == null ||
                      !_isSameCalendarDay(sentAt, previousSentAt));

              return Column(
                children: [
                  if (startsDay) _ChatDateDivider(date: sentAt),
                  ChatBubble(
                    text: textOf(msg, ['content']),
                    mine: mine,
                    timestamp: _fmtTime(msg['createdAt']),
                    attachments: attachments is List
                        ? attachments.whereType<Map<String, dynamic>>().toList()
                        : null,
                  ),
                ],
              );
            },
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

class _RelationshipChatHeader extends StatelessWidget {
  const _RelationshipChatHeader({required this.peerName});

  final String peerName;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('relationship-chat-header'),
      children: [
        _ChatAvatar(name: peerName, size: 40),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            peerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.fg1,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _RelationshipChatEmptyState extends StatelessWidget {
  const _RelationshipChatEmptyState({
    required this.peerName,
    required this.title,
    required this.message,
  });

  final String peerName;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: const ValueKey('relationship-chat-empty-state'),
      constraints: const BoxConstraints(maxWidth: 330),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ChatAvatar(name: peerName, size: 72),
          const SizedBox(height: AppSpacing.xl),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.display(
              22,
              weight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 14,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar({required this.name, required this.size});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.clay200,
        borderRadius: BorderRadius.circular(size > 48 ? AppRadius.xl : 12),
        border: Border.all(color: AppColors.buttonBorder),
      ),
      child: Text(
        _chatInitials(name),
        style: AppTypography.display(
          size > 48 ? 23 : 13,
          weight: FontWeight.w700,
          color: AppColors.clay900,
        ),
      ),
    );
  }
}

class _ChatDateDivider extends StatelessWidget {
  const _ChatDateDivider({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.sm,
        bottom: AppSpacing.lg,
      ),
      child: Row(
        children: [
          const Expanded(
            child: SizedBox(
              height: 1,
              child: ColoredBox(color: AppColors.surfaceBorderSoft),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              MaterialLocalizations.of(context).formatMediumDate(date),
              style: AppTypography.mono(10, color: AppColors.fg4),
            ),
          ),
          const Expanded(
            child: SizedBox(
              height: 1,
              child: ColoredBox(color: AppColors.surfaceBorderSoft),
            ),
          ),
        ],
      ),
    );
  }
}

DateTime? _parseMessageDate(Object? value) =>
    value is String ? DateTime.tryParse(value)?.toLocal() : null;

bool _isSameCalendarDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

String _chatInitials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}

String? _fmtTime(Object? value) {
  if (value is! String) return null;
  final dt = DateTime.tryParse(value)?.toLocal();
  if (dt == null) return null;
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(dt.hour)}:${two(dt.minute)}';
}
