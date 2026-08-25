import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../domain/entities/exercise.dart';

/// Totals for a finished training day, derived from its exercises.
class WorkoutResult {
  const WorkoutResult({
    required this.totalExercises,
    required this.completedExercises,
    required this.skippedExercises,
    required this.completedSets,
    required this.totalSets,
    required this.volumeKg,
    required this.averageRpe,
    required this.durationSeconds,
  });

  factory WorkoutResult.fromExercises(List<Exercise> exercises) {
    var completedSets = 0;
    var totalSets = 0;
    var volumeKg = 0.0;
    var rpeTotal = 0.0;
    var rpeCount = 0;
    var durationSeconds = 0;

    for (final exercise in exercises) {
      durationSeconds += exerciseDurationSeconds(exercise);
      totalSets += exercise.sets.length;
      for (final set in exercise.sets) {
        if (!set.isCompleted) continue;
        completedSets++;
        final reps = set.actualReps ?? set.plannedReps;
        final weight =
            set.actualWeight ?? set.plannedWeight ?? exercise.plannedWeight;
        if (weight != null) volumeKg += weight * reps;
        final rpe = set.rpe;
        if (rpe != null) {
          rpeTotal += rpe;
          rpeCount++;
        }
      }
    }

    return WorkoutResult(
      totalExercises: exercises.length,
      completedExercises: exercises.where((e) => e.isCompleted).length,
      skippedExercises: exercises.where((e) => e.isSkipped).length,
      completedSets: completedSets,
      totalSets: totalSets,
      volumeKg: volumeKg,
      averageRpe: rpeCount == 0 ? null : rpeTotal / rpeCount,
      durationSeconds: durationSeconds,
    );
  }

  final int totalExercises;
  final int completedExercises;
  final int skippedExercises;
  final int completedSets;
  final int totalSets;
  final double volumeKg;
  final double? averageRpe;
  final int durationSeconds;
}

int exerciseDurationSeconds(Exercise exercise) {
  final stored = exercise.durationSeconds;
  if (stored != null) return stored;
  final startedAt = exercise.startedAtUtc;
  final endedAt = exercise.endedAtUtc;
  if (startedAt == null || endedAt == null) return 0;
  final seconds = endedAt.difference(startedAt).inSeconds;
  return seconds < 0 ? 0 : seconds;
}

String formatResultDuration(int seconds) {
  if (seconds <= 0) return '0s';
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  final remaining = seconds % 60;
  if (hours > 0) {
    return minutes == 0 ? '${hours}h' : '${hours}h ${minutes}m';
  }
  if (minutes > 0) {
    return remaining == 0 ? '${minutes}m' : '${minutes}m ${remaining}s';
  }
  return '${remaining}s';
}

String formatAverageRpe(double? rpe) {
  if (rpe == null) return '-';
  return rpe == rpe.roundToDouble()
      ? rpe.toStringAsFixed(0)
      : rpe.toStringAsFixed(1);
}

/// The celebratory popup shown the moment a training day resolves.
///
/// Carries the full congratulation banner and a Done button; the persistent
/// summary the day list keeps afterwards is [WorkoutResultCard].
class WorkoutResultDialog extends StatelessWidget {
  const WorkoutResultDialog({
    required this.result,
    required this.unit,
    required this.currentStreak,
    super.key,
  });

  final WorkoutResult result;
  final WeightUnit unit;
  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      backgroundColor: AppColors.bg2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: const BorderSide(color: AppColors.surfaceBorderSoft),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.successBg,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.success,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.trainingResultTitle,
                      style: AppTypography.display(
                        22,
                        color: AppColors.fg1,
                        height: 1.15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              // The banner and the metrics share one scroll view so a short
              // screen or a large text scale shrinks the body instead of
              // pushing the button off the dialog.
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _WorkoutResultCelebration(currentStreak: currentStreak),
                      const SizedBox(height: AppSpacing.lg),
                      _WorkoutResultMetrics(result: result, unit: unit),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.commonDone),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The compact summary pinned to the top of a resolved day's exercise list.
class WorkoutResultCard extends StatelessWidget {
  const WorkoutResultCard({
    required this.result,
    required this.unit,
    required this.currentStreak,
    super.key,
  });

  final WorkoutResult result;
  final WeightUnit unit;
  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      color: AppColors.successBg.withValues(alpha: 0.5),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.emoji_events_outlined,
                  color: AppColors.success,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.trainingResultTitle,
                      style: AppTypography.display(
                        18,
                        color: AppColors.fg1,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.trainingResultStreakMessage(currentStreak),
                      style: const TextStyle(
                        color: AppColors.fg2,
                        fontSize: 12,
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _WorkoutResultMetrics(result: result, unit: unit),
        ],
      ),
    );
  }
}

class _WorkoutResultCelebration extends StatelessWidget {
  const _WorkoutResultCelebration({required this.currentStreak});

  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.successBg.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.14)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.bg2.withValues(alpha: 0.76),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: AppColors.surfaceBorderSoft),
            ),
            child: const Icon(
              Icons.local_fire_department_outlined,
              color: AppColors.success,
              size: 19,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.trainingResultCongratsTitle,
                  style: AppTypography.display(
                    18,
                    color: AppColors.fg1,
                    height: 1.12,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.trainingResultStreakMessage(currentStreak),
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontSize: 12,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-width metric rows. Deliberately free of any measured width: the label
/// takes whatever the value leaves, so no screen size or text scale can make a
/// row overflow or force the label to ellipsize.
class _WorkoutResultMetrics extends ConsumerWidget {
  const _WorkoutResultMetrics({required this.result, required this.unit});

  final WorkoutResult result;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final trackRpe = ref.watch(trackRpeProvider);
    final volume = unit.fromKg(result.volumeKg);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _WorkoutResultMetricRow(
          icon: Icons.scale_outlined,
          label: l10n.trainingResultVolumeLabel,
          value: '${formatWeight(volume)} ${unit.suffix}',
        ),
        // RPE is only collected — and only shown — when the user tracks it.
        if (trackRpe) ...[
          const SizedBox(height: AppSpacing.sm),
          _WorkoutResultMetricRow(
            icon: Icons.speed_rounded,
            label: l10n.trainingResultAvgRpeLabel,
            value: formatAverageRpe(result.averageRpe),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        _WorkoutResultMetricRow(
          icon: Icons.timer_outlined,
          label: l10n.trainingResultTotalTimeLabel,
          value: formatResultDuration(result.durationSeconds),
        ),
      ],
    );
  }
}

class _WorkoutResultMetricRow extends StatelessWidget {
  const _WorkoutResultMetricRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        // A hairline and no shadow: enough to read as a row on the card's
        // green tint *and* on the dialog's white, without the lift that would
        // make it look like a card nested inside a card.
        color: AppColors.bg2.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.bg3.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: 17, color: AppColors.fg2),
          ),
          const SizedBox(width: AppSpacing.md),
          // A Wrap rather than label-Expanded + value: side by side with the
          // value flushed right while both fit, and the value drops onto its
          // own line before the label is ever squeezed narrow enough to
          // truncate. Nothing here is measured, so no width or text scale can
          // break it.
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: AppSpacing.md,
              runSpacing: 2,
              children: [
                Text(
                  label,
                  maxLines: 2,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.mono(
                    17,
                    weight: FontWeight.w500,
                    color: AppColors.fg1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
