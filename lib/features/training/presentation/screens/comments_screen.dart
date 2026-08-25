import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/realtime/realtime_service.dart';
import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../core/utils/date_labels.dart';
import '../../../../core/widgets/chat_bubble.dart';
import '../../../../core/widgets/chat_composer.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

String _scopeLabel(CommentScope scope, AppLocalizations l10n) =>
    switch (scope) {
      CommentScope.plan => l10n.trainingScopePlan,
      CommentScope.week => l10n.trainingScopeWeek,
    };

enum CommentScope { plan, week }

final commentsProvider = FutureProvider.autoDispose
    .family<List<JsonMap>, CommentRequest>((
      ref,
      request,
    ) {
      ref.syncOn(const [DataTopic.community]);
      final base = request.scope == CommentScope.plan ? 'plans' : 'weeks';
      return ref
          .watch(xenohApiProvider)
          .getList('/$base/${request.ownerId}/comments');
    });

@immutable
class CommentRequest {
  const CommentRequest({required this.scope, required this.ownerId});

  final CommentScope scope;
  final String ownerId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentRequest &&
          runtimeType == other.runtimeType &&
          scope == other.scope &&
          ownerId == other.ownerId;

  @override
  int get hashCode => Object.hash(scope, ownerId);
}

class CommentsScreen extends ConsumerStatefulWidget {
  const CommentsScreen({
    required this.scope,
    required this.ownerId,
    super.key,
  });

  final CommentScope scope;
  final String ownerId;

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final _content = TextEditingController();
  bool _posting = false;

  CommentRequest get _request =>
      CommentRequest(scope: widget.scope, ownerId: widget.ownerId);

  String get _base => widget.scope == CommentScope.plan ? 'plans' : 'weeks';

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(realtimeEventsProvider, (_, next) {
      final event = next.value;
      if (event == null) return;
      if (_matches(event)) ref.invalidate(commentsProvider(_request));
    });

    final l10n = AppLocalizations.of(context);
    final comments = ref.watch(commentsProvider(_request));
    final myId = ref.watch(authControllerProvider).sessionOrNull?.user.id;
    final title = widget.scope == CommentScope.plan
        ? l10n.trainingPlanCommentsTitle
        : l10n.trainingWeekCommentsTitle;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Expanded(child: _history(comments, myId)),
          ChatComposer(
            controller: _content,
            hint: l10n.trainingWriteNoteHint(_scopeLabel(widget.scope, l10n)),
            sending: _posting,
            onSend: _post,
          ),
        ],
      ),
    );
  }

  Widget _history(AsyncValue<List<JsonMap>> comments, String? myId) {
    final l10n = AppLocalizations.of(context);
    return switch (comments) {
      AsyncData(:final value) when value.isEmpty => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: EmptyFeatureState(
            title: l10n.trainingNoCommentsTitle,
            message: l10n.trainingNoCommentsMessage,
            icon: Icons.mode_comment_outlined,
          ),
        ),
      ),
      AsyncData(:final value) => RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref.refresh(commentsProvider(_request).future),
        child: ListView.builder(
          reverse: true,
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: value.length,
          itemBuilder: (_, i) {
            final item = value[value.length - 1 - i];
            final authorId = textOf(item, [
              'authorId',
              'userId',
              'createdById',
            ], fallback: '');
            final mine = myId != null && authorId == myId;
            return ChatBubble(
              text: textOf(item, ['content']),
              mine: mine,
              author: mine
                  ? null
                  : textOf(item, ['authorName', 'authorFullName']),
              timestamp: _formatTime(
                textOf(item, ['createdAt', 'createdAtUtc'], fallback: ''),
                Localizations.localeOf(context).toString(),
              ),
              onDelete: () => _delete(item['id']?.toString()),
            );
          },
        ),
      ),
      AsyncError(:final error) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: FeatureError(
            error: error,
            onRetry: () => ref.invalidate(commentsProvider(_request)),
          ),
        ),
      ),
      _ => const LoadingList(),
    };
  }

  bool _matches(RealtimeEvent event) {
    final payload = event.payload;
    if (payload is! JsonMap) return false;
    return switch (widget.scope) {
      CommentScope.plan =>
        (event.name == 'ReceivePlanCommentAdded' ||
                event.name == 'ReceivePlanCommentDeleted') &&
            payload['planId']?.toString() == widget.ownerId,
      CommentScope.week =>
        (event.name == 'ReceiveWeekCommentAdded' ||
                event.name == 'ReceiveWeekCommentDeleted') &&
            payload['weekId']?.toString() == widget.ownerId,
    };
  }

  Future<void> _post() async {
    final content = _content.text.trim();
    if (content.isEmpty) return;
    setState(() => _posting = true);
    try {
      await ref.read(xenohApiProvider).postObject(
        '/$_base/${widget.ownerId}/comments',
        {
          'content': content,
        },
      );
      _content.clear();
    } catch (e) {
      if (!mounted) return;
      _toast(apiErrorMessage(e, context));
    } finally {
      if (mounted) setState(() => _posting = false);
    }
  }

  Future<void> _delete(String? id) async {
    if (id == null || id.isEmpty) return;
    try {
      await ref
          .read(xenohApiProvider)
          .delete('/$_base/${widget.ownerId}/comments/$id');
    } catch (e) {
      if (!mounted) return;
      _toast(apiErrorMessage(e, context));
    }
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// Formats an ISO timestamp as `MMM d, HH:mm` in local time; returns an empty
  /// string when it can't be parsed (so the bubble hides the caption).
  static String _formatTime(String iso, String locale) {
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    return DateLabels.monthDayTime(parsed.toLocal(), locale);
  }
}
