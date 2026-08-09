import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/personal_dashboard.dart';

/// Today's workout summary. Shows a friendly empty state when there's nothing
/// scheduled (rest day or no active plan).
class TodayWorkoutCard extends StatelessWidget {
  const TodayWorkoutCard({
    required this.workout,
    required this.currentStreak,
    required this.unit,
    this.onOpen,
    super.key,
  });

  final TodayWorkout? workout;
  final int currentStreak;
  final WeightUnit unit;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final w = workout;
    if (w == null) {
      return XnSection(
        child: Row(
          children: [
            const Icon(
              Icons.self_improvement_rounded,
              color: AppColors.sage700,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                l10n.dashboardNoWorkoutMessage,
                style: const TextStyle(color: AppColors.fg2),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            _StreakMetric(currentStreak: currentStreak),
          ],
        ),
      );
    }

    final progress = w.totalExercises == 0
        ? 0.0
        : (w.completedExercises / w.totalExercises).clamp(0.0, 1.0);
    final isRest = w.status.trim().toLowerCase() == 'rest';

    return XnSection(
      onTap: isRest ? null : onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashboardTodaysWorkoutEyebrow,
                  style: _eyebrow,
                ),
              ),
              if (w.isCompleted)
                XnChip(
                  label: l10n.dashboardWorkoutDone,
                  tone: XnChipTone.sage,
                  icon: Icons.check_rounded,
                )
              else if (isRest)
                XnChip(
                  label: l10n.dashboardWorkoutRest,
                  tone: XnChipTone.neutral,
                )
              else if (w.status == 'Missed')
                XnChip(
                  label: l10n.dashboardWorkoutMissed,
                  tone: XnChipTone.danger,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            w.dayOfWeek,
            style: AppTypography.display(20, letterSpacing: 0),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _Metric(
                value: w.completedExercises.toDouble(),
                formatter: (value) => '${value.round()}/${w.totalExercises}',
                label: l10n.dashboardExercisesLabel,
              ),
              const SizedBox(width: AppSpacing.xl),
              _Metric(
                value: w.completedSets.toDouble(),
                formatter: (value) => '${value.round()}/${w.totalSets}',
                label: l10n.dashboardSetsLabel,
              ),
              const SizedBox(width: AppSpacing.xl),
              _Metric(
                value: unit.fromKg(w.plannedVolume),
                formatter: formatWeight,
                label: l10n.dashboardVolumeLabel(unit.suffix),
              ),
              const Spacer(),
              _StreakMetric(currentStreak: currentStreak),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: XnAnimatedLinearProgress(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.bg3,
              color: AppColors.sage500,
            ),
          ),
          if (w.muscleGroups.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in w.muscleGroups) XnChip(label: m),
              ],
            ),
          ],
        ],
      ),
    );
  }

  static const _eyebrow = TextStyle(
    color: AppColors.fg3,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.6,
  );
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.value,
    required this.formatter,
    required this.label,
  });

  final double value;
  final XnNumberFormatter formatter;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnAnimatedNumber(
          value: value,
          formatter: formatter,
          style: AppTypography.mono(18, weight: FontWeight.w500),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.fg3, fontSize: 11),
        ),
      ],
    );
  }
}

class _StreakMetric extends StatelessWidget {
  const _StreakMetric({required this.currentStreak});

  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.local_fire_department_rounded,
          color: AppColors.accent,
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XnAnimatedNumber(
              value: currentStreak.toDouble(),
              formatter: formatAnimatedInt,
              style: AppTypography.mono(18, weight: FontWeight.w500),
            ),
            Text(
              AppLocalizations.of(context).dashboardStreakLabel,
              style: const TextStyle(color: AppColors.fg3, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}
