import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/exercise_thumbnail.dart';
import '../../../../core/widgets/rpe_picker_sheet.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../dashboard/presentation/providers/dashboard_controller.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_template.dart';
import '../providers/exercises_controller.dart';
import '../widgets/exercise_form_sheet.dart';
import '../widgets/exercise_template_picker_sheet.dart';

class DayScreen extends ConsumerStatefulWidget {
  const DayScreen({required this.dayId, super.key});

  final String dayId;

  @override
  ConsumerState<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends ConsumerState<DayScreen> {
  bool _reorderMode = false;
  bool _resultDialogShown = false;

  Future<void> _addExercise() async {
    final l10n = AppLocalizations.of(context);
    final template = await showModalBottomSheet<ExerciseTemplate>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => const ExerciseTemplatePickerSheet(),
    );
    if (template == null || !mounted) return;

    final form = await showModalBottomSheet<ExerciseFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseFormSheet(
        title: template.name,
        submitLabel: l10n.trainingAddExerciseCta,
        unit: ref.read(weightUnitProvider),
      ),
    );
    if (form == null) return;
    try {
      await ref
          .read(exercisesControllerProvider(widget.dayId).notifier)
          .addExercise(
            exerciseTemplateId: template.id,
            plannedSets: form.plannedSets,
            plannedReps: form.plannedReps,
            plannedWeight: form.plannedWeight,
            notes: form.notes,
          );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exercisesProvider = exercisesControllerProvider(widget.dayId);
    final exercises = ref.watch(exercisesProvider);
    final unit = ref.watch(weightUnitProvider);
    final currentStreak = ref
        .watch(dashboardControllerProvider)
        .value
        ?.profile
        .currentStreak;

    ref.listen<AsyncValue<List<Exercise>>>(exercisesProvider, (
      previous,
      next,
    ) {
      final nextItems = next.value;
      if (nextItems == null || nextItems.isEmpty) {
        return;
      }
      if (!_dayResolved(nextItems)) {
        _resultDialogShown = false;
        return;
      }
      if (_resultDialogShown) return;
      _resultDialogShown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted || !context.mounted) return;
        var dialogStreak = ref
            .read(dashboardControllerProvider)
            .value
            ?.profile
            .currentStreak;
        await ref.read(dashboardControllerProvider.notifier).refresh();
        dialogStreak =
            ref
                .read(dashboardControllerProvider)
                .value
                ?.profile
                .currentStreak ??
            dialogStreak;
        if (!mounted || !context.mounted) return;
        unawaited(
          showDialog<void>(
            context: context,
            builder: (_) => _TrainingResultDialog(
              result: _TrainingResult.fromExercises(nextItems),
              unit: ref.read(weightUnitProvider),
              currentStreak: dialogStreak ?? 0,
            ),
          ),
        );
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.trainingWorkoutTitle),
        actions: [
          IconButton(
            tooltip: l10n.trainingCompleteAllTooltip,
            icon: const Icon(Icons.done_all_rounded),
            onPressed: () => unawaited(
              ref
                  .read(exercisesControllerProvider(widget.dayId).notifier)
                  .completeDay(),
            ),
          ),
          if ((exercises.value?.length ?? 0) > 1)
            IconButton(
              tooltip: _reorderMode
                  ? l10n.trainingDoneReorderingTooltip
                  : l10n.trainingReorderExercisesTooltip,
              onPressed: () => setState(() => _reorderMode = !_reorderMode),
              icon: Icon(
                _reorderMode ? Icons.check_rounded : Icons.swap_vert_rounded,
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref
            .read(exercisesControllerProvider(widget.dayId).notifier)
            .refresh(),
        child: AsyncValueView(
          value: exercises,
          onRetry: () =>
              ref.invalidate(exercisesControllerProvider(widget.dayId)),
          data: (items) => items.isEmpty
              ? ListView(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.fitness_center_rounded,
                            size: 44,
                            color: AppColors.fg3,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            l10n.trainingNoExercisesForDayMessage,
                            style: const TextStyle(color: AppColors.fg2),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          FilledButton.icon(
                            onPressed: _addExercise,
                            icon: const Icon(Icons.add_rounded),
                            label: Text(l10n.trainingAddExerciseCta),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : _reorderMode
              ? ReorderableListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xl,
                  ),
                  itemCount: items.length,
                  onReorderItem: (oldIndex, newIndex) =>
                      _reorder(items, oldIndex, newIndex),
                  itemBuilder: (_, i) => Padding(
                    key: ValueKey(items[i].id),
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _ExerciseTile(
                      exercise: items[i],
                      dayId: widget.dayId,
                      reorderMode: true,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.xl,
                  ),
                  itemCount: items.length + 1 + (_dayResolved(items) ? 1 : 0),
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, i) {
                    final result = _dayResolved(items)
                        ? _TrainingResult.fromExercises(items)
                        : null;
                    if (result != null && i == 0) {
                      return _TrainingResultCard(
                        result: result,
                        unit: unit,
                        currentStreak: currentStreak ?? 0,
                      );
                    }

                    final exerciseIndex = i - (result == null ? 0 : 1);
                    if (exerciseIndex == items.length) {
                      return _AddExerciseListButton(onPressed: _addExercise);
                    }

                    return _ExerciseTile(
                      exercise: items[exerciseIndex],
                      dayId: widget.dayId,
                    );
                  },
                ),
        ),
      ),
    );
  }

  void _reorder(List<Exercise> items, int oldIndex, int newIndex) {
    final moved = [...items];
    final item = moved.removeAt(oldIndex);
    moved.insert(newIndex, item);
    unawaited(
      ref
          .read(exercisesControllerProvider(widget.dayId).notifier)
          .reorder(moved.map((e) => e.id).toList()),
    );
  }
}

bool _dayResolved(List<Exercise> items) =>
    items.isNotEmpty && items.every((e) => e.isCompleted || e.isSkipped);

class _TrainingResult {
  const _TrainingResult({
    required this.totalExercises,
    required this.completedExercises,
    required this.skippedExercises,
    required this.completedSets,
    required this.totalSets,
    required this.volumeKg,
    required this.averageRpe,
    required this.durationSeconds,
  });

  factory _TrainingResult.fromExercises(List<Exercise> exercises) {
    var completedSets = 0;
    var totalSets = 0;
    var volumeKg = 0.0;
    var rpeTotal = 0.0;
    var rpeCount = 0;
    var durationSeconds = 0;

    for (final exercise in exercises) {
      durationSeconds += _exerciseDurationSeconds(exercise);
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

    return _TrainingResult(
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

int _exerciseDurationSeconds(Exercise exercise) {
  final stored = exercise.durationSeconds;
  if (stored != null) return stored;
  final startedAt = exercise.startedAtUtc;
  final endedAt = exercise.endedAtUtc;
  if (startedAt == null || endedAt == null) return 0;
  final seconds = endedAt.difference(startedAt).inSeconds;
  return seconds < 0 ? 0 : seconds;
}

class _TrainingResultDialog extends StatelessWidget {
  const _TrainingResultDialog({
    required this.result,
    required this.unit,
    required this.currentStreak,
  });

  final _TrainingResult result;
  final WeightUnit unit;
  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
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
        constraints: BoxConstraints(
          maxWidth: 430,
          maxHeight: size.height * 0.78,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.successBg,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.success,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Training result',
                      style: AppTypography.display(22, color: AppColors.fg1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              _TrainingResultCelebration(currentStreak: currentStreak),
              const SizedBox(height: AppSpacing.xl),
              Flexible(
                child: SingleChildScrollView(
                  child: _TrainingResultMetrics(result: result, unit: unit),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context).commonDone),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrainingResultCard extends StatelessWidget {
  const _TrainingResultCard({
    required this.result,
    required this.unit,
    required this.currentStreak,
  });

  final _TrainingResult result;
  final WeightUnit unit;
  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      color: AppColors.successBg.withValues(alpha: 0.5),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xl,
        AppSpacing.xxl,
        AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events_outlined,
                color: AppColors.success,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Training result',
                  style: AppTypography.display(
                    20,
                    color: AppColors.fg1,
                    height: 1.15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _TrainingResultCelebration(currentStreak: currentStreak),
          const SizedBox(height: AppSpacing.xl),
          _TrainingResultMetrics(result: result, unit: unit),
        ],
      ),
    );
  }
}

class _TrainingResultCelebration extends StatelessWidget {
  const _TrainingResultCelebration({required this.currentStreak});

  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    final dayLabel = currentStreak == 1 ? 'day' : 'days';
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
                  'Congratulations',
                  style: AppTypography.display(
                    18,
                    color: AppColors.fg1,
                    height: 1.12,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Workout finished. $currentStreak $dayLabel streak.',
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

class _TrainingResultMetrics extends StatelessWidget {
  const _TrainingResultMetrics({required this.result, required this.unit});

  final _TrainingResult result;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final volume = unit.fromKg(result.volumeKg);
    return LayoutBuilder(
      builder: (context, constraints) {
        final fallbackWidth =
            MediaQuery.sizeOf(context).width - (AppSpacing.xl * 4);
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : fallbackWidth;
        final columns = availableWidth < 340 ? 2 : 3;
        final tileWidth =
            (availableWidth - (AppSpacing.lg * (columns - 1))) / columns;

        return Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: [
            _TrainingResultMetric(
              width: tileWidth,
              icon: Icons.scale_outlined,
              label: 'Volume',
              value: '${formatWeight(volume)} ${unit.suffix}',
            ),
            _TrainingResultMetric(
              width: tileWidth,
              icon: Icons.speed_rounded,
              label: 'Avg RPE',
              value: _formatAverageRpe(result.averageRpe),
            ),
            _TrainingResultMetric(
              width: tileWidth,
              icon: Icons.timer_outlined,
              label: 'Total time',
              value: _formatResultDuration(result.durationSeconds),
            ),
          ],
        );
      },
    );
  }
}

class _TrainingResultMetric extends StatelessWidget {
  const _TrainingResultMetric({
    required this.width,
    required this.icon,
    required this.label,
    required this.value,
  });

  final double width;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        constraints: const BoxConstraints(minHeight: 82),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.bg2.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.surfaceBorderSoft),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 15, color: AppColors.fg2),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 12,
                      height: 1.15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.mono(
                16,
                weight: FontWeight.w500,
                color: AppColors.fg1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatResultDuration(int seconds) {
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

String _formatAverageRpe(double? rpe) {
  if (rpe == null) return '-';
  return rpe == rpe.roundToDouble()
      ? rpe.toStringAsFixed(0)
      : rpe.toStringAsFixed(1);
}

class _AddExerciseListButton extends StatelessWidget {
  const _AddExerciseListButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: AppSpacing.md),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add_rounded),
          label: Text(AppLocalizations.of(context).trainingAddExerciseCta),
        ),
      ),
    );
  }
}

class _ExerciseTile extends ConsumerWidget {
  const _ExerciseTile({
    required this.exercise,
    required this.dayId,
    this.reorderMode = false,
  });

  final Exercise exercise;
  final String dayId;
  final bool reorderMode;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.trainingDeleteExerciseTitle),
        content: Text(l10n.trainingRemoveExerciseMessage(exercise.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref
          .read(exercisesControllerProvider(dayId).notifier)
          .deleteExercise(exercise.id);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _skip(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(exercisesControllerProvider(dayId).notifier)
          .skipExercise(exercise.id, isSkipped: !exercise.isSkipped);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _startTimer(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(exercisesControllerProvider(dayId).notifier)
          .startTimer(exercise.id);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _finishTimer(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(exercisesControllerProvider(dayId).notifier)
          .finishTimer(exercise.id);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _editExercise(BuildContext context, WidgetRef ref) async {
    final unit = ref.read(weightUnitProvider);
    final form = await showModalBottomSheet<ExerciseFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseFormSheet(
        title: exercise.name,
        submitLabel: AppLocalizations.of(context).commonSave,
        initialSets: exercise.plannedSets,
        initialReps: exercise.plannedReps,
        initialWeight: exercise.plannedWeight,
        initialNotes: exercise.notes,
        unit: unit,
      ),
    );
    if (form == null) return;

    try {
      await ref
          .read(exercisesControllerProvider(dayId).notifier)
          .updateExercise(
            exercise.id,
            plannedSets: form.plannedSets,
            plannedReps: form.plannedReps,
            plannedWeight: form.plannedWeight,
            notes: form.notes,
          );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unit = ref.watch(weightUnitProvider);
    final exerciseDisabled = exercise.isSkipped;
    final controlsEnabled = !reorderMode && !exerciseDisabled;
    return XnCard(
      color: exercise.isSkipped
          ? AppColors.dangerBg
          : exercise.isCompleted
          ? AppColors.successBg
          : AppColors.bg2,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.bgPage.withValues(alpha: 0.58),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.surfaceBorderSoft),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExerciseThumbnail(
                  imageUrl: exercise.imageUrl,
                  exerciseKind: exercise.exerciseKind,
                  size: 68,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.display(
                          16,
                          weight: FontWeight.w500,
                          letterSpacing: 0,
                          height: 1.12,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: [
                          XnChip(
                            label: exercise.primaryMuscleGroup,
                            compact: true,
                          ),
                          if (exercise.isCompetitionLift ?? false)
                            XnChip(
                              label: l10n.trainingCompetitionChip,
                              tone: XnChipTone.warn,
                              compact: true,
                            ),
                          if (exercise.personalRecordWeight != null)
                            XnChip(
                              label: l10n.trainingPrWeightNoSpaceLabel(
                                formatWeight(
                                  unit.fromKg(exercise.personalRecordWeight!),
                                ),
                                unit.suffix,
                              ),
                              tone: XnChipTone.sage,
                              icon: Icons.emoji_events_rounded,
                              compact: true,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                if (reorderMode)
                  const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.xs),
                    child: Icon(
                      Icons.drag_handle_rounded,
                      color: AppColors.fg3,
                    ),
                  )
                else
                  _ExerciseActionButtons(
                    disabled: exerciseDisabled,
                    onEdit: exerciseDisabled
                        ? null
                        : () => _editExercise(context, ref),
                    onSkip: () => _skip(context, ref),
                    onDelete: exerciseDisabled
                        ? null
                        : () => _delete(context, ref),
                  ),
              ],
            ),
          ),
          if ((exercise.notes ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _ExerciseNoteLine(
              note: exercise.notes!.trim(),
              onTap: exerciseDisabled
                  ? null
                  : () => _editExercise(context, ref),
            ),
          ],
          if (controlsEnabled) ...[
            const SizedBox(height: AppSpacing.sm),
            if (exercise.isCompleted &&
                exercise.startedAtUtc == null &&
                exercise.durationSeconds == null)
              _DurationEditor(
                exercise: exercise,
                dayId: dayId,
              )
            else
              _TimerPanel(
                exercise: exercise,
                formatDuration: _formatDuration,
                onStart: () => _startTimer(context, ref),
                onFinish: () => _finishTimer(context, ref),
              ),
          ],
          const SizedBox(height: AppSpacing.sm),
          for (final (index, set) in exercise.sets.indexed)
            _SetLogRow(
              key: ValueKey(set.id),
              set: set,
              exercise: exercise,
              dayId: dayId,
              enabled: controlsEnabled,
              isLast: index == exercise.sets.length - 1,
            ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;
    if (minutes == 0) return '${remaining}s';
    if (remaining == 0) return '${minutes}m';
    return '${minutes}m ${remaining}s';
  }
}

class _ExerciseNoteLine extends StatelessWidget {
  const _ExerciseNoteLine({required this.note, required this.onTap});

  final String note;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bg3.withValues(alpha: 0.36),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.sticky_note_2_outlined,
                  size: 15,
                  color: AppColors.fg3,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  note,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 12,
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              if (onTap != null)
                const Icon(
                  Icons.edit_outlined,
                  size: 15,
                  color: AppColors.fg3,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseActionButtons extends StatelessWidget {
  const _ExerciseActionButtons({
    required this.disabled,
    required this.onEdit,
    required this.onSkip,
    required this.onDelete,
  });

  final bool disabled;
  final VoidCallback? onEdit;
  final VoidCallback onSkip;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          alignment: WrapAlignment.end,
          children: [
            _ExerciseIconAction(
              tooltip: l10n.trainingEditExerciseTitle,
              icon: Icons.edit_outlined,
              onPressed: onEdit,
            ),
            _ExerciseIconAction(
              tooltip: l10n.trainingSkipUnskipTooltip,
              icon: disabled
                  ? Icons.keyboard_return_rounded
                  : Icons.do_not_disturb_alt_outlined,
              onPressed: onSkip,
              color: disabled ? AppColors.danger : AppColors.fg2,
            ),
            _ExerciseIconAction(
              tooltip: l10n.trainingDeleteExerciseTooltip,
              icon: Icons.delete_outline_rounded,
              color: AppColors.danger,
              onPressed: onDelete,
            ),
          ],
        ),
      ],
    );
  }
}

class _ExerciseIconAction extends StatelessWidget {
  const _ExerciseIconAction({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.color = AppColors.fg2,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
      iconSize: 19,
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints.tightFor(width: 34, height: 34),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.bg2,
        hoverColor: AppColors.buttonHover,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.surfaceBorderSoft),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class _TimerPanel extends StatefulWidget {
  const _TimerPanel({
    required this.exercise,
    required this.formatDuration,
    required this.onStart,
    required this.onFinish,
  });

  final Exercise exercise;
  final String Function(int seconds) formatDuration;
  final VoidCallback onStart;
  final VoidCallback onFinish;

  @override
  State<_TimerPanel> createState() => _TimerPanelState();
}

class _TimerPanelState extends State<_TimerPanel> {
  Timer? _ticker;
  DateTime _now = DateTime.now().toUtc();

  /// Device-clock instant that maps to "elapsed = 0" for the running timer.
  /// Derived once per run from the server's `startedAtUtc`, with the initial
  /// offset clamped to >= 0 so server/device clock skew can't make the display
  /// sit at 0:00 for several seconds before it starts counting.
  DateTime? _runAnchorUtc;

  @override
  void initState() {
    super.initState();
    _syncTicker();
  }

  @override
  void didUpdateWidget(covariant _TimerPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercise.isTimerRunning != widget.exercise.isTimerRunning ||
        oldWidget.exercise.startedAtUtc != widget.exercise.startedAtUtc ||
        oldWidget.exercise.endedAtUtc != widget.exercise.endedAtUtc) {
      _syncTicker();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _syncTicker() {
    _ticker?.cancel();
    final deviceNow = DateTime.now().toUtc();
    _now = deviceNow;
    if (!widget.exercise.isTimerRunning) {
      _runAnchorUtc = null;
      return;
    }
    final started = widget.exercise.startedAtUtc?.toUtc();
    final offset = started == null
        ? Duration.zero
        : deviceNow.difference(started);
    _runAnchorUtc = deviceNow.subtract(
      offset.isNegative ? Duration.zero : offset,
    );
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now().toUtc());
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exercise = widget.exercise;
    final running = exercise.isTimerRunning;
    final finished = exercise.endedAtUtc != null;
    final elapsedSeconds = _elapsedSeconds(exercise);
    final displayTime = widget.formatDuration(
      elapsedSeconds < 0 ? 0 : elapsedSeconds,
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          _TimerMetric(
            icon: running ? Icons.timer_rounded : Icons.timer_outlined,
            label: elapsedSeconds > 0 ? displayTime : '0:00',
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _TimerMetric(
              icon: Icons.local_fire_department_outlined,
              label: l10n.trainingNoEstLabel,
              muted: true,
            ),
          ),
          if (!finished && exercise.durationSeconds == null)
            FilledButton.icon(
              onPressed: running ? widget.onFinish : widget.onStart,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.bg2,
                foregroundColor: AppColors.fg1,
                side: const BorderSide(color: AppColors.surfaceBorderSoft),
                minimumSize: const Size(72, 34),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              icon: Icon(
                running ? Icons.stop_circle_outlined : Icons.play_arrow_rounded,
                size: 15,
              ),
              label: Text(
                running ? l10n.trainingFinishCta : l10n.trainingStartCta,
              ),
            ),
        ],
      ),
    );
  }

  int _elapsedSeconds(Exercise exercise) {
    final startedAt = exercise.startedAtUtc?.toUtc();
    final endedAt = exercise.endedAtUtc?.toUtc();
    if (startedAt != null && endedAt != null) {
      return endedAt.difference(startedAt).inSeconds;
    }
    if (exercise.isTimerRunning && _runAnchorUtc != null) {
      return _now.difference(_runAnchorUtc!).inSeconds;
    }
    return exercise.durationSeconds ?? 0;
  }
}

class _TimerMetric extends StatelessWidget {
  const _TimerMetric({
    required this.icon,
    required this.label,
    this.muted = false,
  });

  final IconData icon;
  final String label;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: muted ? AppColors.fg3 : AppColors.fg1,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: muted
                ? const TextStyle(color: AppColors.fg2, fontSize: 11)
                : AppTypography.mono(
                    12,
                    weight: FontWeight.w500,
                    color: AppColors.fg1,
                  ),
          ),
        ),
      ],
    );
  }
}

class _DurationEditor extends ConsumerStatefulWidget {
  const _DurationEditor({
    required this.exercise,
    required this.dayId,
  });

  final Exercise exercise;
  final String dayId;

  @override
  ConsumerState<_DurationEditor> createState() => _DurationEditorState();
}

class _DurationEditorState extends ConsumerState<_DurationEditor> {
  late final TextEditingController _minutes;
  late final TextEditingController _seconds;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final duration = widget.exercise.durationSeconds ?? 0;
    _minutes = TextEditingController(text: (duration ~/ 60).toString());
    _seconds = TextEditingController(
      text: (duration % 60).toString().padLeft(2, '0'),
    );
  }

  @override
  void didUpdateWidget(covariant _DurationEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercise.durationSeconds != widget.exercise.durationSeconds) {
      final duration = widget.exercise.durationSeconds ?? 0;
      _minutes.text = (duration ~/ 60).toString();
      _seconds.text = (duration % 60).toString().padLeft(2, '0');
    }
  }

  @override
  void dispose() {
    _minutes.dispose();
    _seconds.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    final minutes = int.tryParse(_minutes.text.trim()) ?? 0;
    final seconds = int.tryParse(_seconds.text.trim()) ?? 0;
    final durationSeconds = (minutes * 60) + seconds.clamp(0, 59);
    if (durationSeconds <= 0) return;

    setState(() => _saving = true);
    try {
      await ref
          .read(exercisesControllerProvider(widget.dayId).notifier)
          .setTimerDuration(
            exerciseId: widget.exercise.id,
            durationSeconds: durationSeconds,
          );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.bg3.withValues(alpha: 0.46),
          border: Border.all(color: AppColors.border1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 42,
              child: _CompactTimeInput(
                controller: _minutes,
                enabled: !_saving,
                hint: '00',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(':', style: TextStyle(color: AppColors.fg2)),
            ),
            SizedBox(
              width: 42,
              child: _CompactTimeInput(
                controller: _seconds,
                enabled: !_saving,
                hint: '00',
              ),
            ),
            const SizedBox(width: 4),
            Text(
              AppLocalizations.of(context).trainingMinutesSecondsLabel,
              style: const TextStyle(color: AppColors.fg2, fontSize: 12),
            ),
            const SizedBox(width: 6),
            _DurationSaveButton(saving: _saving, onPressed: _save),
          ],
        ),
      ),
    );
  }
}

class _CompactTimeInput extends StatelessWidget {
  const _CompactTimeInput({
    required this.controller,
    required this.enabled,
    required this.hint,
  });

  final TextEditingController controller;
  final bool enabled;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: AppTypography.mono(12, color: AppColors.fg1),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.bg2,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.border1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.border1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
      ),
    );
  }
}

class _DurationSaveButton extends StatelessWidget {
  const _DurationSaveButton({required this.saving, required this.onPressed});

  final bool saving;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppLocalizations.of(context).trainingSaveTimeTooltip,
      child: InkResponse(
        onTap: saving ? null : onPressed,
        radius: 22,
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            border: Border.all(color: AppColors.border1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: saving
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: AppColors.fg1,
                ),
        ),
      ),
    );
  }
}

class _SetLogRow extends ConsumerStatefulWidget {
  const _SetLogRow({
    required this.set,
    required this.exercise,
    required this.dayId,
    required this.enabled,
    required this.isLast,
    super.key,
  });

  final ExerciseSet set;
  final Exercise exercise;
  final String dayId;
  final bool enabled;
  final bool isLast;

  @override
  ConsumerState<_SetLogRow> createState() => _SetLogRowState();
}

class _SetLogRowState extends ConsumerState<_SetLogRow> {
  late final TextEditingController _reps;
  late final TextEditingController _weight;
  late final TextEditingController _rpe;
  bool _saving = false;

  static const _inputGap = AppSpacing.md;

  @override
  void initState() {
    super.initState();
    _reps = TextEditingController();
    _weight = TextEditingController();
    _rpe = TextEditingController();
    _syncControllers();
  }

  @override
  void didUpdateWidget(covariant _SetLogRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.set != widget.set ||
        oldWidget.exercise.plannedWeight != widget.exercise.plannedWeight) {
      _syncControllers();
    }
  }

  @override
  void dispose() {
    _reps.dispose();
    _weight.dispose();
    _rpe.dispose();
    super.dispose();
  }

  void _syncControllers() {
    final set = widget.set;
    _reps.text = (set.actualReps ?? set.plannedReps).toString();
    final weightKg =
        set.actualWeight ?? set.plannedWeight ?? widget.exercise.plannedWeight;
    _weight.text = weightKg == null
        ? ''
        : formatWeight(ref.read(weightUnitProvider).fromKg(weightKg));
    _rpe.text = set.rpe?.toString() ?? '';
  }

  Future<void> _complete() async {
    if (widget.set.isCompleted || !widget.enabled || _saving) return;

    final rpe = await showModalBottomSheet<double>(
      context: context,
      backgroundColor: AppColors.bgPage,
      builder: (_) => RpePickerSheet(
        setNumber: widget.set.setNumber,
        initial: double.tryParse(_rpe.text.trim()),
      ),
    );
    // Sheet dismissed without a choice: leave the set un-completed.
    if (rpe == null || !mounted) return;
    _rpe.text = rpe == rpe.roundToDouble()
        ? rpe.toStringAsFixed(0)
        : rpe.toString();

    setState(() => _saving = true);
    try {
      final enteredWeight = double.tryParse(_weight.text.trim());
      await ref
          .read(exercisesControllerProvider(widget.dayId).notifier)
          .markSetComplete(
            widget.set.id,
            actualReps: int.tryParse(_reps.text.trim()),
            actualWeight: enteredWeight == null
                ? null
                : ref.read(weightUnitProvider).toKg(enteredWeight),
            rpe: rpe,
          );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final set = widget.set;
    final done = set.isCompleted;
    final controlsEnabled = widget.enabled && !done && !_saving;
    final unit = ref.watch(weightUnitProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 350;
        return Container(
          height: 56,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: done
                ? AppColors.successBg.withValues(alpha: 0.55)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: widget.isLast
                    ? Colors.transparent
                    : AppColors.border1.withValues(alpha: 0.72),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: compact ? 44 : 52,
                child: _SetLabel(setNumber: set.setNumber, done: done),
              ),
              const SizedBox(width: _inputGap),
              Expanded(
                child: _InlineSetInput(
                  controller: _reps,
                  enabled: controlsEnabled,
                  suffix: AppLocalizations.of(context).trainingRepsSuffix,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: _inputGap),
              Expanded(
                child: _InlineSetInput(
                  controller: _weight,
                  enabled: controlsEnabled,
                  suffix: unit.suffix,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: _inputGap),
              Expanded(
                child: _InlineSetInput(
                  controller: _rpe,
                  enabled: controlsEnabled,
                  hint: '-',
                  suffix: '',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: _inputGap),
              _SetDoneButton(
                done: done,
                saving: _saving,
                enabled: controlsEnabled,
                onPressed: _complete,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SetLabel extends StatelessWidget {
  const _SetLabel({required this.setNumber, required this.done});

  final int setNumber;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).trainingSetLabel(setNumber),
      style: AppTypography.mono(
        13,
        weight: FontWeight.w500,
        color: done ? AppColors.success : AppColors.fg1,
      ),
    );
  }
}

class _InlineSetInput extends StatelessWidget {
  const _InlineSetInput({
    required this.controller,
    required this.enabled,
    required this.keyboardType,
    required this.suffix,
    this.hint,
  });

  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final String suffix;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      style: AppTypography.mono(12, weight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix.isEmpty
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: Text(
                  suffix,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        suffixIconConstraints: const BoxConstraints(minWidth: 28),
        filled: true,
        fillColor: enabled
            ? AppColors.bg2
            : AppColors.bg2.withValues(alpha: 0.64),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 9,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
          borderSide: const BorderSide(color: AppColors.border1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
          borderSide: const BorderSide(color: AppColors.border1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
          borderSide: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
      ),
    );
  }
}

class _SetDoneButton extends StatelessWidget {
  const _SetDoneButton({
    required this.done,
    required this.saving,
    required this.enabled,
    required this.onPressed,
  });

  final bool done;
  final bool saving;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: done ? l10n.commonDone : l10n.trainingMarkDoneTooltip,
      child: InkResponse(
        onTap: enabled ? onPressed : null,
        radius: 24,
        child: Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: done ? AppColors.success : AppColors.bg2,
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(
              color: done ? AppColors.success : AppColors.border2,
              width: 1.4,
            ),
          ),
          child: saving
              ? const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  done ? Icons.check_rounded : Icons.circle_outlined,
                  size: done ? 19 : 15,
                  color: done ? AppColors.fgOnClay : AppColors.fg3,
                ),
        ),
      ),
    );
  }
}
