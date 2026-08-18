import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/last_exercise_performance.dart';

part 'exercises_controller.g.dart';

typedef LastExercisePerformanceArgs = ({
  String exerciseTemplateId,
  String dailyWorkoutId,
});

final lastExercisePerformanceProvider = FutureProvider.autoDispose
    .family<LastExercisePerformance, LastExercisePerformanceArgs>((ref, args) {
      ref.syncOn(const [DataTopic.training]);
      return ref
          .watch(trainingRepositoryProvider)
          .getLastExercisePerformance(
            exerciseTemplateId: args.exerciseTemplateId,
            dailyWorkoutId: args.dailyWorkoutId,
          );
    });

/// Exercises (with their sets) for a daily workout.
///
/// Deliberately *not* wired to [DataTopic.training]: this is the workout
/// logging hot path, and every mutation here already patches the affected
/// exercise into state in place. Re-fetching the whole day on each completed
/// set would be slower and visibly jumpier. Other screens still pick these
/// changes up, because the same writes bump the topic they watch.
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
      return;
    }
    _patchExercise(updated);
  }

  Future<void> updateSetPlan(
    String setId, {
    int? plannedReps,
    double? plannedWeight,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .updateSetPlan(
          setId,
          plannedReps: plannedReps,
          plannedWeight: plannedWeight,
        );
    _patchExercise(updated);
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
      return;
    }
    _patchExercise(updated);
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
      return;
    }
    state = AsyncValue.data([
      for (final ex in current)
        if (ex.id != exerciseId) ex,
    ]);
  }

  Future<void> skipExercise(
    String exerciseId, {
    required bool isSkipped,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .skipExercise(exerciseId, isSkipped: isSkipped);
    _patchExercise(updated);
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
