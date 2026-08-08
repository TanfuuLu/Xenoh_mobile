import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../../training/domain/entities/daily_workout.dart';
import '../../../training/domain/entities/plan.dart';
import '../../../training/domain/entities/weekly_workout.dart';
import '../../../training/presentation/providers/days_controller.dart';
import '../../../training/presentation/providers/plan_detail_controller.dart';
import '../../../training/presentation/providers/plans_controller.dart';
import '../providers/community_controllers.dart';

const _reportReasons = [
  'Harassment',
  'Spam',
  'Scam',
  'Inappropriate',
  'Other',
];

Future<void> showReportShareDialog(
  BuildContext context,
  WidgetRef ref,
  String shareId,
) async {
  var reason = _reportReasons.first;
  final details = TextEditingController();
  final submitted = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(AppLocalizations.of(context).communityReportShareTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: reason,
              items: [
                for (final value in _reportReasons)
                  DropdownMenuItem(value: value, child: Text(value)),
              ],
              onChanged: (value) => setState(() => reason = value ?? reason),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: details,
              onChanged: (_) => setState(() {}),
              maxLength: 2000,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(
                  context,
                ).communityReportShareHint,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).commonCancel),
          ),
          FilledButton(
            onPressed: details.text.trim().isEmpty
                ? null
                : () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(AppLocalizations.of(context).communityReportSubmit),
          ),
        ],
      ),
    ),
  );
  if (submitted != true || !context.mounted) {
    details.dispose();
    return;
  }
  await ref
      .read(shareActionControllerProvider.notifier)
      .reportShare(
        shareId: shareId,
        reason: reason,
        details: details.text.trim(),
      );
  details.dispose();
  if (!context.mounted) return;
  final result = ref.read(shareActionControllerProvider);
  _showResult(
    context,
    result.error,
    AppLocalizations.of(context).communityReportShareSuccess,
  );
}

Future<void> showCopyWorkoutSheet(
  BuildContext context,
  WidgetRef ref,
  String shareId,
) async {
  final copied = await showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.bgPage,
    builder: (_) => _CopyWorkoutSheet(shareId: shareId),
  );
  if (copied == null || !context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        AppLocalizations.of(context).communityCopyWorkoutSuccess(copied),
      ),
    ),
  );
}

void _showResult(BuildContext context, Object? error, String success) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error == null ? success : apiErrorMessage(error, context)),
    ),
  );
}

class _CopyWorkoutSheet extends ConsumerStatefulWidget {
  const _CopyWorkoutSheet({required this.shareId});

  final String shareId;

  @override
  ConsumerState<_CopyWorkoutSheet> createState() => _CopyWorkoutSheetState();
}

class _CopyWorkoutSheetState extends ConsumerState<_CopyWorkoutSheet> {
  String? _planId;
  String? _weekId;
  String? _dayId;

  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(plansControllerProvider);
    final weeks = _planId == null
        ? null
        : ref.watch(weeksControllerProvider(_planId!));
    final days = _weekId == null
        ? null
        : ref.watch(daysControllerProvider(_weekId!));
    final pending = ref.watch(shareActionControllerProvider).isLoading;
    final l10n = AppLocalizations.of(context);
    final planItems = plans.value ?? const <Plan>[];
    final weekItems = weeks?.value ?? const <WeeklyWorkout>[];
    final dayItems = days?.value ?? const <DailyWorkout>[];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.communityCopyWorkoutTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.communityCopyWorkoutWarning,
              style: const TextStyle(color: AppColors.fg3),
            ),
            const SizedBox(height: AppSpacing.lg),
            DropdownButtonFormField<String>(
              initialValue: _planId,
              decoration: InputDecoration(labelText: l10n.communitySelectPlan),
              items: [
                for (final plan in planItems)
                  DropdownMenuItem(value: plan.id, child: Text(plan.name)),
              ],
              onChanged: (value) => setState(() {
                _planId = value;
                _weekId = null;
                _dayId = null;
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _weekId,
              decoration: InputDecoration(labelText: l10n.communitySelectWeek),
              items: [
                for (final week in weekItems)
                  DropdownMenuItem(value: week.id, child: Text(week.name)),
              ],
              onChanged: weeks?.hasValue == true
                  ? (value) => setState(() {
                      _weekId = value;
                      _dayId = null;
                    })
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _dayId,
              decoration: InputDecoration(labelText: l10n.communitySelectDay),
              items: [
                for (final day in dayItems)
                  DropdownMenuItem(
                    value: day.id,
                    child: Text(
                      '${day.dayOfWeek} · ${day.date.toIso8601String().split('T').first}',
                    ),
                  ),
              ],
              onChanged: days?.hasValue == true
                  ? (value) => setState(() => _dayId = value)
                  : null,
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.icon(
              onPressed: _dayId == null || pending ? null : _copy,
              icon: const Icon(Icons.copy_all_outlined),
              label: Text(l10n.communityCopyWorkoutAction),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copy() async {
    try {
      final copied = await ref
          .read(shareActionControllerProvider.notifier)
          .copyShare(
            shareId: widget.shareId,
            targetDailyWorkoutId: _dayId!,
          );
      if (mounted) Navigator.pop(context, copied);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    }
  }
}
