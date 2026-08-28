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
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../dashboard/presentation/providers/dashboard_controller.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_template.dart';
import '../../domain/services/training_calorie_estimator.dart';
import '../providers/exercises_controller.dart';
import '../widgets/exercise_form_sheet.dart';
import '../widgets/exercise_template_picker_sheet.dart';
import '../widgets/workout_result_view.dart';

class DayScreen extends ConsumerStatefulWidget {
  const DayScreen({
    required this.dayId,
    this.canComplete = true,
    this.coachPlan = false,
    this.clientId,
    super.key,
  });

  final String dayId;
  final bool canComplete;
  final bool coachPlan;
  final String? clientId;

  @override
  ConsumerState<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends ConsumerState<DayScreen> {
  bool _reorderMode = false;
  bool _resultDialogShown = false;

  bool get _canComplete {
    final isCoach =
        ref.read(authControllerProvider).sessionOrNull?.user.isCoach ?? false;
    return widget.canComplete && !isCoach;
  }

  bool get _canAddExercises {
    final isCoach =
        ref.read(authControllerProvider).sessionOrNull?.user.isCoach ?? false;
    return !widget.coachPlan || isCoach;
  }

  Future<void> _addExercise() async {
    if (!_canAddExercises) return;
    final l10n = AppLocalizations.of(context);
    final template = await showModalBottomSheet<ExerciseTemplate>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseTemplatePickerSheet(
        clientId: _canComplete ? null : widget.clientId,
      ),
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
    final isCoach =
        ref.watch(authControllerProvider).sessionOrNull?.user.isCoach ?? false;
    final canComplete = widget.canComplete && !isCoach;
    final canAddExercises = !widget.coachPlan || isCoach;
    final currentStreak = ref
        .watch(dashboardControllerProvider)
        .value
        ?.profile
        .currentStreak;

    if (canComplete) {
      ref.listen<AsyncValue<List<Exercise>>>(exercisesProvider, (
        previous,
        next,
      ) {
        final previousItems = previous?.value;
        final nextItems = next.value;
        if (nextItems == null || nextItems.isEmpty) {
          return;
        }
        if (!_allExercisesCompleted(nextItems)) {
          _resultDialogShown = false;
          return;
        }
        // Loading an already-completed day is not a new completion. Only show
        // the result when this mounted screen observes every exercise complete.
        if (previousItems == null || _allExercisesCompleted(previousItems)) {
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
              builder: (_) => WorkoutResultDialog(
                result: WorkoutResult.fromExercises(nextItems),
                unit: ref.read(weightUnitProvider),
                currentStreak: dialogStreak ?? 0,
              ),
            ),
          );
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.trainingWorkoutTitle),
        actions: [
          if (canComplete)
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
      bottomNavigationBar: canComplete
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                color: AppColors.accentSoft,
                child: Text(
                  l10n.coachClientWorkoutCoachViewLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                          if (canAddExercises)
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
                      canComplete: canComplete,
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
                  itemCount:
                      items.length +
                      (canAddExercises ? 1 : 0) +
                      (_dayResolved(items) ? 1 : 0),
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, i) {
                    final result = _dayResolved(items)
                        ? WorkoutResult.fromExercises(items)
                        : null;
                    if (result != null && i == 0) {
                      return WorkoutResultCard(
                        result: result,
                        unit: unit,
                        currentStreak: currentStreak ?? 0,
                      );
                    }

                    final exerciseIndex = i - (result == null ? 0 : 1);
                    if (canAddExercises && exerciseIndex == items.length) {
                      return _AddExerciseListButton(onPressed: _addExercise);
                    }

                    return _ExerciseTile(
                      exercise: items[exerciseIndex],
                      dayId: widget.dayId,
                      canComplete: canComplete,
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

bool _allExercisesCompleted(List<Exercise> items) =>
    items.isNotEmpty && items.every((exercise) => exercise.isCompleted);

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
    this.canComplete = true,
  });

  final Exercise exercise;
  final String dayId;
  final bool reorderMode;
  final bool canComplete;

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
    final note = (exercise.notes ?? '').trim();
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
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.bgPage.withValues(alpha: 0.52),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExerciseThumbnail(
                  imageUrl: exercise.imageUrl,
                  exerciseKind: exercise.exerciseKind,
                  size: 72,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              exercise.name,
                              softWrap: true,
                              style: AppTypography.display(
                                20,
                                weight: FontWeight.w600,
                                letterSpacing: -0.15,
                                height: 1.12,
                              ),
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
                              onSkip: canComplete
                                  ? () => _skip(context, ref)
                                  : null,
                              onDelete: exerciseDisabled
                                  ? null
                                  : () => _delete(context, ref),
                            ),
                        ],
                      ),
                      if (note.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        _ExerciseNoteLine(
                          note: note,
                          onTap: exerciseDisabled
                              ? null
                              : () => _editExercise(context, ref),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.md),
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
              ],
            ),
          ),
          if (exercise.exerciseKind.toLowerCase() != 'cardio') ...[
            const SizedBox(height: AppSpacing.sm),
            _LastPerformanceLine(
              exerciseTemplateId: exercise.exerciseTemplateId,
              dailyWorkoutId: dayId,
            ),
          ],
          if (controlsEnabled && canComplete) ...[
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
              canEditPlan: controlsEnabled,
              canComplete: controlsEnabled && canComplete,
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

class _LastPerformanceLine extends ConsumerWidget {
  const _LastPerformanceLine({
    required this.exerciseTemplateId,
    required this.dailyWorkoutId,
  });

  final String exerciseTemplateId;
  final String dailyWorkoutId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(
      lastExercisePerformanceProvider((
        exerciseTemplateId: exerciseTemplateId,
        dailyWorkoutId: dailyWorkoutId,
      )),
    );
    final performance = value.value;
    if (performance == null || !performance.hasPerformance) {
      return const SizedBox.shrink();
    }
    final unit = ref.watch(weightUnitProvider);
    final details = <String>[
      '${formatWeight(unit.fromKg(performance.lastActualWeight!))} ${unit.suffix}',
      if (performance.lastActualReps != null) '× ${performance.lastActualReps}',
      if (performance.lastRpe != null && ref.watch(trackRpeProvider))
        'RPE ${formatAverageRpe(performance.lastRpe)}',
      if (performance.workoutDate != null)
        _formatPerformanceDate(performance.workoutDate!),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.36),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Text(
        '${AppLocalizations.of(context).trainingLastPerformanceLabel}: '
        '${details.join(' · ')}',
        style: const TextStyle(color: AppColors.fg3, fontSize: 12),
      ),
    );
  }
}

String _formatPerformanceDate(DateTime date) => [
  date.day.toString().padLeft(2, '0'),
  date.month.toString().padLeft(2, '0'),
  date.year.toString(),
].join('/');

class _ExerciseActionButtons extends StatelessWidget {
  const _ExerciseActionButtons({
    required this.disabled,
    required this.onEdit,
    required this.onSkip,
    required this.onDelete,
  });

  final bool disabled;
  final VoidCallback? onEdit;
  final VoidCallback? onSkip;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.bg2,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: SizedBox.square(
        dimension: 34,
        child: PopupMenuButton<_ExerciseAction>(
          tooltip: l10n.trainingExerciseActionsTooltip,
          enabled: onEdit != null || onSkip != null || onDelete != null,
          position: PopupMenuPosition.under,
          padding: EdgeInsets.zero,
          iconSize: 20,
          icon: const Icon(Icons.more_vert_rounded),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          onSelected: (action) {
            switch (action) {
              case _ExerciseAction.edit:
                onEdit?.call();
              case _ExerciseAction.toggleSkip:
                onSkip?.call();
              case _ExerciseAction.delete:
                onDelete?.call();
            }
          },
          itemBuilder: (_) => [
            _exerciseActionItem(
              action: _ExerciseAction.edit,
              label: l10n.trainingEditExerciseTitle,
              icon: Icons.edit_outlined,
              enabled: onEdit != null,
            ),
            _exerciseActionItem(
              action: _ExerciseAction.toggleSkip,
              label: l10n.trainingSkipUnskipTooltip,
              icon: disabled
                  ? Icons.keyboard_return_rounded
                  : Icons.do_not_disturb_alt_outlined,
              enabled: onSkip != null,
            ),
            _exerciseActionItem(
              action: _ExerciseAction.delete,
              label: l10n.trainingDeleteExerciseTooltip,
              icon: Icons.delete_outline_rounded,
              enabled: onDelete != null,
              danger: true,
            ),
          ],
        ),
      ),
    );
  }
}

enum _ExerciseAction { edit, toggleSkip, delete }

PopupMenuItem<_ExerciseAction> _exerciseActionItem({
  required _ExerciseAction action,
  required String label,
  required IconData icon,
  required bool enabled,
  bool danger = false,
}) {
  final color = !enabled
      ? AppColors.fg3
      : danger
      ? AppColors.danger
      : AppColors.fg2;
  return PopupMenuItem<_ExerciseAction>(
    value: action,
    enabled: enabled,
    child: Row(
      children: [
        Icon(icon, size: 19, color: color),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
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
    final estimatedCalories = estimateTrainingCalories(
      Duration(seconds: elapsedSeconds),
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
              label: estimatedCalories > 0
                  ? '~$estimatedCalories ${l10n.nutritionKcalLabel}'
                  : l10n.trainingNoEstLabel,
              muted: estimatedCalories <= 0,
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
    required this.canEditPlan,
    required this.canComplete,
    required this.isLast,
    super.key,
  });

  final ExerciseSet set;
  final Exercise exercise;
  final String dayId;
  final bool canEditPlan;
  final bool canComplete;
  final bool isLast;

  @override
  ConsumerState<_SetLogRow> createState() => _SetLogRowState();
}

class _SetLogRowState extends ConsumerState<_SetLogRow> {
  late final TextEditingController _reps;
  late final TextEditingController _weight;
  late final TextEditingController _rpe;
  late WeightUnit _displayWeightUnit;
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
    _displayWeightUnit = ref.read(weightUnitProvider);
    _reps.text = (set.actualReps ?? set.plannedReps).toString();
    final weightKg =
        set.actualWeight ?? set.plannedWeight ?? widget.exercise.plannedWeight;
    _weight.text = weightKg == null
        ? ''
        : formatWeight(_displayWeightUnit.fromKg(weightKg));
    _rpe.text = set.rpe?.toString() ?? '';
  }

  void _updateDisplayedWeightUnit(WeightUnit unit) {
    if (unit == _displayWeightUnit) return;

    final enteredWeight = double.tryParse(_weight.text.trim());
    if (enteredWeight != null) {
      final converted = formatWeight(
        unit.fromKg(_displayWeightUnit.toKg(enteredWeight)),
      );
      _weight.value = TextEditingValue(
        text: converted,
        selection: TextSelection.collapsed(offset: converted.length),
      );
    }
    _displayWeightUnit = unit;
  }

  Future<void> _complete() async {
    if (widget.set.isCompleted || !widget.canComplete || _saving) return;

    final trackRpe = ref.read(trackRpeProvider);
    double? rpe;
    if (trackRpe) {
      rpe = await showModalBottomSheet<double>(
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
    }

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

  Future<void> _editPlan() async {
    if (widget.set.isCompleted || !widget.canEditPlan || _saving) return;
    final unit = ref.read(weightUnitProvider);
    await showDialog<void>(
      context: context,
      builder: (_) => _SetPlanDialog(
        set: widget.set,
        unit: unit,
        onSave: (plannedReps, plannedWeight) async {
          await ref
              .read(exercisesControllerProvider(widget.dayId).notifier)
              .updateSetPlan(
                widget.set.id,
                plannedReps: plannedReps,
                plannedWeight: plannedWeight,
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final set = widget.set;
    final done = set.isCompleted;
    final completionEnabled = widget.canComplete && !done && !_saving;
    final planEditingEnabled = widget.canEditPlan && !done && !_saving;
    final unit = ref.watch(weightUnitProvider);
    final trackRpe = ref.watch(trackRpeProvider);
    _updateDisplayedWeightUnit(unit);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 350;
        return Container(
          height: 49,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 6,
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
                width: compact ? 56 : 64,
                child: _SetLabel(
                  setNumber: set.setNumber,
                  done: done,
                  onEdit: planEditingEnabled ? _editPlan : null,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _InlineSetInput(
                  controller: _reps,
                  enabled: completionEnabled,
                  suffix: AppLocalizations.of(context).trainingRepsSuffix,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: _inputGap),
              Expanded(
                child: _InlineSetInput(
                  controller: _weight,
                  enabled: completionEnabled,
                  suffix: unit.suffix,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              if (trackRpe) ...[
                const SizedBox(width: _inputGap),
                Expanded(
                  child: _InlineSetInput(
                    controller: _rpe,
                    enabled: completionEnabled,
                    hint: '-',
                    suffix: '',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
              if (widget.canComplete) ...[
                const SizedBox(width: _inputGap),
                _SetDoneButton(
                  done: done,
                  saving: _saving,
                  enabled: completionEnabled,
                  onPressed: _complete,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SetPlanDialog extends StatefulWidget {
  const _SetPlanDialog({
    required this.set,
    required this.unit,
    required this.onSave,
  });

  final ExerciseSet set;
  final WeightUnit unit;
  final Future<void> Function(int plannedReps, double? plannedWeight) onSave;

  @override
  State<_SetPlanDialog> createState() => _SetPlanDialogState();
}

class _SetPlanDialogState extends State<_SetPlanDialog> {
  late final TextEditingController _reps;
  late final TextEditingController _weight;
  String? _error;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _reps = TextEditingController(text: widget.set.plannedReps.toString());
    _weight = TextEditingController(
      text: widget.set.plannedWeight == null
          ? ''
          : formatWeight(widget.unit.fromKg(widget.set.plannedWeight!)),
    );
  }

  @override
  void dispose() {
    _reps.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final reps = int.tryParse(_reps.text.trim());
    if (reps == null || reps < 1 || reps > 1000) {
      setState(() => _error = l10n.trainingSetRepsRangeError);
      return;
    }
    final enteredWeight = _weight.text.trim().isEmpty
        ? null
        : double.tryParse(_weight.text.trim());
    final weightKg = enteredWeight == null
        ? null
        : widget.unit.toKg(enteredWeight);
    if (_weight.text.trim().isNotEmpty &&
        (weightKg == null || weightKg < 0 || weightKg > 10000)) {
      setState(() => _error = l10n.trainingSetWeightRangeError);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(reps, weightKg);
      if (mounted) Navigator.pop(context);
    } catch (error) {
      if (mounted) setState(() => _error = '$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.trainingEditSetPlanTitle(widget.set.setNumber)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _reps,
            enabled: !_saving,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.trainingPlannedRepsLabel,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _weight,
            enabled: !_saving,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.trainingPlannedWeightLabel,
              suffixText: widget.unit.suffix,
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: const TextStyle(color: AppColors.danger, fontSize: 12),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.commonSave),
        ),
      ],
    );
  }
}

class _SetLabel extends StatelessWidget {
  const _SetLabel({
    required this.setNumber,
    required this.done,
    required this.onEdit,
  });

  final int setNumber;
  final bool done;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      AppLocalizations.of(context).trainingSetLabel(setNumber),
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.mono(
        13,
        weight: FontWeight.w500,
        color: done ? AppColors.success : AppColors.fg1,
      ),
    );
    if (onEdit == null) return label;
    return Tooltip(
      message: AppLocalizations.of(context).trainingEditSetPlanTooltip,
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: label),
            const SizedBox(width: 2),
            const Icon(Icons.edit_outlined, size: 11, color: AppColors.fg3),
          ],
        ),
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
