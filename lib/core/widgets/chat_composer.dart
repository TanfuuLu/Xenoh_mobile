import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../l10n/app_localizations.dart';

/// A file/image picked locally, not yet uploaded.
typedef PendingChatAttachment = ({String path, String fileName, bool isImage});

/// Pinned chat composer: attach + emoji buttons, a rounded multi-line text
/// field, and a circular send button. Sits at the bottom of a chat screen
/// above the keyboard. Send is enabled when there's text OR at least one
/// pending attachment (matches the backend, which allows attachment-only
/// messages). Purely presentational — picking/uploading is owned by the
/// screen; this widget just renders pending chips and forwards taps.
class ChatComposer extends StatefulWidget {
  const ChatComposer({
    required this.controller,
    required this.onSend,
    this.hint,
    this.sending = false,
    this.onAttach,
    this.pendingAttachments = const [],
    this.onRemoveAttachment,
    super.key,
  });

  final TextEditingController controller;

  /// Called when the send button is tapped (and the field is non-empty, or
  /// there's a pending attachment).
  final VoidCallback onSend;
  final String? hint;

  /// Shows a spinner in the send button and blocks further sends.
  final bool sending;

  /// Opens the attach-image-or-file picker (bottom sheet owned by the screen).
  final VoidCallback? onAttach;

  final List<PendingChatAttachment> pendingAttachments;
  final ValueChanged<PendingChatAttachment>? onRemoveAttachment;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  final _focusNode = FocusNode();
  bool _showEmoji = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEmoji() {
    if (_showEmoji) {
      setState(() => _showEmoji = false);
      return;
    }
    _focusNode.unfocus();
    setState(() => _showEmoji = true);
  }

  void _insertEmoji(Emoji emoji) {
    final selection = widget.controller.selection;
    final text = widget.controller.text;
    final cursor = selection.start < 0 ? text.length : selection.start;
    final next = text.replaceRange(
      cursor,
      selection.end < 0 ? cursor : selection.end,
      emoji.emoji,
    );
    widget.controller.text = next;
    widget.controller.selection = TextSelection.collapsed(
      offset: cursor + emoji.emoji.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasAttachments = widget.pendingAttachments.isNotEmpty;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg2,
        border: Border(top: BorderSide(color: AppColors.surfaceBorderSoft)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasAttachments) _PendingAttachmentsRow(widget: widget),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: l10n.commonAttachTooltip,
                    icon: const Icon(Icons.attach_file_rounded),
                    color: AppColors.fg3,
                    onPressed: widget.onAttach,
                  ),
                  IconButton(
                    tooltip: l10n.commonEmojiTooltip,
                    icon: Icon(
                      _showEmoji
                          ? Icons.keyboard_alt_outlined
                          : Icons.emoji_emotions_outlined,
                    ),
                    color: AppColors.fg3,
                    onPressed: _toggleEmoji,
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () {
                        if (_showEmoji) setState(() => _showEmoji = false);
                      },
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.md,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _SendButton(
                    controller: widget.controller,
                    onSend: widget.onSend,
                    sending: widget.sending,
                    hasAttachments: hasAttachments,
                  ),
                ],
              ),
            ),
            if (_showEmoji)
              SizedBox(
                height: 260,
                child: EmojiPicker(
                  onEmojiSelected: (_, emoji) => _insertEmoji(emoji),
                  config: const Config(
                    height: 260,
                    emojiViewConfig: EmojiViewConfig(
                      backgroundColor: AppColors.bg2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PendingAttachmentsRow extends StatelessWidget {
  const _PendingAttachmentsRow({required this.widget});

  final ChatComposer widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          0,
        ),
        itemCount: widget.pendingAttachments.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) {
          final attachment = widget.pendingAttachments[i];
          return Chip(
            avatar: Icon(
              attachment.isImage
                  ? Icons.image_outlined
                  : Icons.insert_drive_file_outlined,
              size: 18,
            ),
            label: Text(
              attachment.fileName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            onDeleted: widget.onRemoveAttachment == null
                ? null
                : () => widget.onRemoveAttachment!(attachment),
            backgroundColor: AppColors.bg3,
          );
        },
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.controller,
    required this.onSend,
    required this.sending,
    required this.hasAttachments,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool sending;
  final bool hasAttachments;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final enabled =
            !sending && (value.text.trim().isNotEmpty || hasAttachments);
        return Material(
          color: enabled ? AppColors.accent : AppColors.bg3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: enabled ? onSend : null,
            child: SizedBox(
              width: 48,
              height: 48,
              child: sending
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.fgOnClay,
                      ),
                    )
                  : Icon(
                      Icons.send_rounded,
                      size: 20,
                      color: enabled ? AppColors.fgOnClay : AppColors.fg4,
                    ),
            ),
          ),
        );
      },
    );
  }
}
