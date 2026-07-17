import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../dashboard/presentation/providers/dashboard_controller.dart';
import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/exercise.dart';
import 'days_controller.dart';
import 'plan_detail_controller.dart';
import 'plans_controller.dart';
import 'week_analysis_provider.dart';

part 'exercises_controller.g.dart';

/// Exercises (with their sets) for a daily workout.
@riverpod
class ExercisesController extends _$ExercisesController {
  @override
  Future<List<Exercise>> build(String dailyWorkoutId) {
    return ref
        .watch(trainingRepositoryProvider)
        .getExercisesByDay(dailyWorkoutId);
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      () => ref
          .read(trainingRepositoryProvider)
          .getExercisesByDay(dailyWorkoutId),
    );
  }

  /// Mark a set complete and patch just that exercise in place (the API returns
  /// the updated exercise, so we avoid refetching the whole list).
  Future<void> markSetComplete(
    String setId, {
    int? actualReps,
    double? actualWeight,
    double? rpe,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .markSetComplete(
          setId,
          actualReps: actualReps,
          actualWeight: actualWeight,
          rpe: rpe,
        );
    final current = state.value;
    if (current == null) {
      await refresh();
      _syncProgressCaches();
      return;
    }
    _patchExercise(updated);
    _syncProgressCaches();
  }

  Future<void> reorder(List<String> exerciseIds) async {
    final reordered = await ref
        .read(trainingRepositoryProvider)
        .reorderExercises(
          dailyWorkoutId: dailyWorkoutId,
          exerciseIds: exerciseIds,
        );
    state = AsyncValue.data(reordered);
  }

  Future<void> startTimer(String exerciseId) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .startExerciseTimer(exerciseId);
    _patchExercise(updated);
  }

  Future<void> finishTimer(String exerciseId) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .finishExerciseTimer(exerciseId);
    _patchExercise(updated);
    _syncProgressCaches();
  }

  Future<void> setTimerDuration({
    required String exerciseId,
    required int durationSeconds,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .setExerciseTimerDuration(
          exerciseId: exerciseId,
          durationSeconds: durationSeconds,
        );
    _patchExercise(updated);
  }

  Future<void> completeDay() async {
    await ref.read(trainingRepositoryProvider).completeDay(dailyWorkoutId);
    await refresh();
    _syncProgressCaches();
  }

  /// Add an exercise (from a template) to this day, then refetch so the new
  /// exercise lands in its server-assigned sort order.
  Future<void> addExercise({
    required String exerciseTemplateId,
    required int plannedSets,
    required int plannedReps,
    double? plannedWeight,
    String? notes,
  }) async {
    await ref
        .read(trainingRepositoryProvider)
        .createExercise(
          dailyWorkoutId: dailyWorkoutId,
          exerciseTemplateId: exerciseTemplateId,
          plannedSets: plannedSets,
          plannedReps: plannedReps,
          plannedWeight: plannedWeight,
          notes: notes,
        );
    await refresh();
    _syncProgressCaches();
  }

  /// Update an exercise's planned metrics and patch it in place.
  Future<void> updateExercise(
    String exerciseId, {
    int? plannedSets,
    int? plannedReps,
    double? plannedWeight,
    String? notes,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .updateExercise(
          exerciseId,
          plannedSets: plannedSets,
          plannedReps: plannedReps,
          plannedWeight: plannedWeight,
          notes: notes,
        );
    final current = state.value;
    if (current == null) {
      await refresh();
      _syncProgressCaches();
      return;
    }
    _patchExercise(updated);
    _syncProgressCaches();
  }

  Future<void> updateExerciseNotes(String exerciseId, {String? notes}) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .updateExerciseNotes(exerciseId, notes: notes);
    final current = state.value;
    if (current == null) {
      await refresh();
      return;
    }
    _patchExercise(updated);
  }

  /// Delete an exercise and drop it from the list in place.
  Future<void> deleteExercise(String exerciseId) async {
    await ref.read(trainingRepositoryProvider).deleteExercise(exerciseId);
    final current = state.value;
    if (current == null) {
      await refresh();
      _syncProgressCaches();
      return;
    }
    state = AsyncValue.data([
      for (final ex in current)
        if (ex.id != exerciseId) ex,
    ]);
    _syncProgressCaches();
  }

  Future<void> skipExercise(
    String exerciseId, {
    required bool isSkipped,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .skipExercise(exerciseId, isSkipped: isSkipped);
    _patchExercise(updated);
    _syncProgressCaches();
  }

  void _syncProgressCaches() {
    ref
      ..invalidate(daysControllerProvider)
      ..invalidate(weekAnalysisProvider)
      ..invalidate(weeksControllerProvider)
      ..invalidate(planDetailProvider)
      ..invalidate(plansControllerProvider)
      ..invalidate(dashboardControllerProvider);
  }

  void _patchExercise(Exercise updated) {
    final current = state.value;
    if (current == null) {
      state = AsyncValue.data([updated]);
      return;
    }
    state = AsyncValue.data([
      for (final ex in current)
        if (ex.id == updated.id) _mergeKnownFields(ex, updated) else ex,
    ]);
  }

  /// The mark-complete / timer endpoints return a lean exercise payload that can
  /// omit fields the client already knows (image URL, planned weights). Keep the
  /// known values whenever the fresh payload doesn't carry them, so the UI
  /// (e.g. the per-set weight boxes) doesn't blank out after an update.
  Exercise _mergeKnownFields(Exercise current, Exercise updated) {
    final imageUrl = updated.imageUrl?.trim();
    final mergedImageUrl = (imageUrl != null && imageUrl.isNotEmpty)
        ? updated.imageUrl
        : current.imageUrl;

    final currentSetWeights = {
      for (final s in current.sets) s.id: s.plannedWeight,
    };
    final mergedSets = [
      for (final s in updated.sets)
        s.plannedWeight == null
            ? s.copyWith(plannedWeight: currentSetWeights[s.id])
            : s,
    ];

    return updated.copyWith(
      imageUrl: mergedImageUrl,
      plannedWeight: updated.plannedWeight ?? current.plannedWeight,
      sets: mergedSets.isEmpty ? current.sets : mergedSets,
    );
  }
}
