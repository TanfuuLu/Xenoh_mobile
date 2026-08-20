import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/xenoh_api.dart';

/// Report and block affordances for user-generated content.
///
/// Play's UGC policy requires an in-app way to both report and block another
/// user, and its Generative AI policy requires a way to flag offensive model
/// output. This file is the single implementation behind every entry point
/// (community feed, athlete profile, coach-client chat, AI coach chat) so the
/// wording, the reason vocabulary, and the error handling stay identical.
///
/// Blocking maps to `POST /users/{userId}/block`, which `topicsForMutation`
/// already routes to `DataTopic.community` — the blocklist and the feed
/// refresh themselves, so callers must not invalidate anything by hand.

/// Reasons accepted by `POST /users/{userId}/reports`. The API stores the
/// English enum value; only the label shown to the user is localized.
const userReportReasons = ['Harassment', 'Spam', 'Inappropriate', 'Other'];

/// Reasons accepted by `POST /training-day-shares/{shareId}/reports`.
const shareReportReasons = [
  'Harassment',
  'Spam',
  'Scam',
  'Inappropriate',
  'Other',
];

String moderationReasonLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Harassment' => l10n.moderationReasonHarassment,
      'Spam' => l10n.moderationReasonSpam,
      'Scam' => l10n.moderationReasonScam,
      'Inappropriate' => l10n.moderationReasonInappropriate,
      'Other' => l10n.moderationReasonOther,
      _ => value,
    };

/// Confirms, then blocks [userId]. The blocklist screen is the undo path.
Future<void> showBlockUserDialog(
  BuildContext context,
  WidgetRef ref, {
  required String userId,
  required String userName,
}) async {
  final reason = TextEditingController();
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      final l10n = AppLocalizations.of(dialogContext);
      return AlertDialog(
        title: Text(l10n.moderationBlockUserTitle(userName)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.moderationBlockUserMessage,
              style: const TextStyle(color: AppColors.fg3),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: reason,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: l10n.moderationBlockReasonHint,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(l10n.moderationBlockConfirm),
          ),
        ],
      );
    },
  );
  final note = reason.text.trim();
  reason.dispose();
  if (confirmed != true || !context.mounted) return;

  await _submit(
    context,
    action: () => ref.read(xenohApiProvider).postVoid('/users/$userId/block', {
      if (note.isNotEmpty) 'reason': note,
    }),
    success: (l10n) => l10n.moderationBlockSuccess(userName),
  );
}

/// Reports [userId] to the admin moderation queue.
Future<void> showReportUserDialog(
  BuildContext context,
  WidgetRef ref, {
  required String userId,
  required String userName,
}) async {
  final l10n = AppLocalizations.of(context);
  final input = await _showReasonDialog(
    context,
    title: l10n.moderationReportUserTitle(userName),
    detailsHint: l10n.moderationReportUserHint,
    reasons: userReportReasons,
  );
  if (input == null || !context.mounted) return;

  await _submit(
    context,
    action: () =>
        ref.read(xenohApiProvider).postObject('/users/$userId/reports', {
          'reportedUserId': userId,
          'reason': input.reason,
          'details': input.details,
        }),
    success: (l10n) => l10n.moderationReportUserSuccess,
  );
}

/// Flags an AI-generated response. There is no dedicated AI-report endpoint —
/// this rides on `POST /bug-reports`, which lands in the same admin queue. The
/// offending text is attached verbatim so a reviewer can see what was
/// generated without having to reproduce the prompt.
Future<void> showReportAiResponseDialog(
  BuildContext context,
  WidgetRef ref, {
  required String content,
}) async {
  final details = TextEditingController();
  final submitted = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (builderContext, setState) {
        final l10n = AppLocalizations.of(builderContext);
        return AlertDialog(
          title: Text(l10n.moderationReportAiTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.moderationReportAiMessage,
                  style: const TextStyle(color: AppColors.fg3),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.bg2,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.surfaceBorderSoft),
                  ),
                  child: Text(
                    _preview(content),
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: details,
                  onChanged: (_) => setState(() {}),
                  maxLength: 2000,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: l10n.moderationReportAiHint,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: details.text.trim().isEmpty
                  ? null
                  : () => Navigator.pop(dialogContext, true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              child: Text(l10n.communityReportSubmit),
            ),
          ],
        );
      },
    ),
  );
  final note = details.text.trim();
  details.dispose();
  if (submitted != true || !context.mounted) return;

  final title = AppLocalizations.of(context).moderationReportAiBugTitle;
  await _submit(
    context,
    action: () => ref.read(xenohApiProvider).postObject('/bug-reports', {
      'title': title,
      'description': '$note\n\n---\n$content',
      'severity': 'High',
      'pageUrl': '/insights/coach-chat',
    }),
    success: (l10n) => l10n.moderationReportAiSuccess,
  );
}

/// Reason dropdown + mandatory free-text details. Returns null when dismissed.
Future<({String reason, String details})?> _showReasonDialog(
  BuildContext context, {
  required String title,
  required String detailsHint,
  required List<String> reasons,
}) async {
  var reason = reasons.first;
  final details = TextEditingController();
  final submitted = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (builderContext, setState) {
        final l10n = AppLocalizations.of(builderContext);
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: reason,
                  decoration: InputDecoration(
                    labelText: l10n.moderationReasonLabel,
                  ),
                  items: [
                    for (final value in reasons)
                      DropdownMenuItem(
                        value: value,
                        child: Text(moderationReasonLabel(value, l10n)),
                      ),
                  ],
                  onChanged: (value) =>
                      setState(() => reason = value ?? reason),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: details,
                  onChanged: (_) => setState(() {}),
                  maxLength: 2000,
                  maxLines: 4,
                  decoration: InputDecoration(hintText: detailsHint),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: details.text.trim().isEmpty
                  ? null
                  : () => Navigator.pop(dialogContext, true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              child: Text(l10n.communityReportSubmit),
            ),
          ],
        );
      },
    ),
  );
  final result = submitted == true
      ? (reason: reason, details: details.text.trim())
      : null;
  details.dispose();
  return result;
}

String _preview(String content) {
  final collapsed = content.trim().replaceAll(RegExp(r'\s+'), ' ');
  return collapsed.length <= 280
      ? collapsed
      : '${collapsed.substring(0, 280)}…';
}

Future<void> _submit(
  BuildContext context, {
  required Future<void> Function() action,
  required String Function(AppLocalizations l10n) success,
}) async {
  try {
    await action();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success(AppLocalizations.of(context)))),
    );
  } catch (error) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(apiErrorMessage(error, context))));
  }
}
