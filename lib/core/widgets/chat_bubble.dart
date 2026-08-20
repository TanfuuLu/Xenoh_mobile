import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';
import '../utils/inline_markdown.dart';
import 'chat_attachment.dart';

/// A single chat message bubble. [mine] right-aligns it with the clay accent
/// fill; otherwise it's a left-aligned light bubble. An optional [author] label
/// and [timestamp] caption frame the text, and a long-press offers whichever of
/// [onDelete] and [onReport] are provided. Optional [attachments] (the message
/// DTO's `attachments`
/// array — `{id, fileName, contentType, sizeBytes, isImage}`) render as inline
/// image thumbnails or file cards above the text.
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.text,
    required this.mine,
    this.author,
    this.timestamp,
    this.onDelete,
    this.onReport,
    this.attachments,
    this.markdown = false,
    super.key,
  });

  final String text;
  final bool mine;
  final String? author;
  final String? timestamp;
  final VoidCallback? onDelete;

  /// Flags this message's content. Long-pressing offers it alongside
  /// [onDelete]; when only one of the two is set, the gesture runs it directly.
  final VoidCallback? onReport;

  final List<Map<String, dynamic>>? attachments;

  /// Renders a small subset of Markdown (`**bold**`, `*italic*`, bullets) in the
  /// message body. Used for AI replies, which come back as Markdown; off for
  /// human chat so literal asterisks stay literal.
  final bool markdown;

  @override
  Widget build(BuildContext context) {
    final bg = mine ? AppColors.accent : AppColors.bg2;
    final fg = mine ? AppColors.fgOnClay : AppColors.fg1;
    const radius = Radius.circular(AppRadius.lg);

    final bubble = GestureDetector(
      onLongPress: onDelete == null && onReport == null
          ? null
          : () => _showActions(context),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: bg,
          border: mine ? null : Border.all(color: AppColors.surfaceBorderSoft),
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
            bottomLeft: mine ? radius : const Radius.circular(4),
            bottomRight: mine ? const Radius.circular(4) : radius,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (author != null && author!.isNotEmpty) ...[
              Text(
                author!,
                style: AppTypography.mono(
                  10,
                  color: mine ? AppColors.clay100 : AppColors.fg3,
                ),
              ),
              const SizedBox(height: 3),
            ],
            if (attachments != null && attachments!.isNotEmpty) ...[
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final a in attachments!)
                    a['isImage'] == true
                        ? ChatImageAttachment(attachmentId: '${a['id']}')
                        : ChatFileAttachment(
                            attachmentId: '${a['id']}',
                            fileName: '${a['fileName']}',
                            sizeBytes: (a['sizeBytes'] as num?)?.toInt() ?? 0,
                            mine: mine,
                          ),
                ],
              ),
              if (text.isNotEmpty) const SizedBox(height: 6),
            ],
            if (text.isNotEmpty)
              if (markdown)
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: fg, fontSize: 14, height: 1.35),
                    children: inlineMarkdownSpans(text),
                  ),
                )
              else
                Text(
                  text,
                  style: TextStyle(color: fg, fontSize: 14, height: 1.35),
                ),
            if (timestamp != null && timestamp!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                timestamp!,
                style: AppTypography.mono(
                  10,
                  color: mine ? AppColors.clay200 : AppColors.fg4,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Align(
        alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
        child: bubble,
      ),
    );
  }

  Future<void> _showActions(BuildContext context) async {
    if (onReport == null) return _confirmDelete(context);
    if (onDelete == null) {
      onReport!.call();
      return;
    }
    final l10n = AppLocalizations.of(context);
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.bgPage,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: Text(l10n.communityReportSubmit),
              onTap: () => Navigator.pop(sheetContext, 'report'),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: AppColors.danger,
              ),
              title: Text(
                l10n.commonDelete,
                style: const TextStyle(color: AppColors.danger),
              ),
              onTap: () => Navigator.pop(sheetContext, 'delete'),
            ),
          ],
        ),
      ),
    );
    if (choice == 'report') {
      onReport!.call();
    } else if (choice == 'delete' && context.mounted) {
      await _confirmDelete(context);
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.commonDeleteCommentTitle),
        content: Text(l10n.commonDeleteCommentMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) onDelete?.call();
  }
}
