import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';

/// A single set within an exercise (maps from `ExerciseSetResponse`).
@freezed
abstract class ExerciseSet with _$ExerciseSet {
  const factory ExerciseSet({
    required String id,
    required int setNumber,
    required int plannedReps,
    required bool isCompleted,
    double? plannedWeight,
    int? actualReps,
    double? actualWeight,
    double? rpe,
    DateTime? completedAt,
  }) = _ExerciseSet;
}

/// An exercise within a daily workout (maps from `ExerciseResponse`, §3.6).
@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String exerciseTemplateId,
    required String name,
    required String primaryMuscleGroup,
    required String exerciseKind, // "Strength" | "Cardio"
    required int plannedSets,
    required int plannedReps,
    required int completedSetsCount,
    required bool isCompleted,
    required bool isSkipped,
    required String dailyWorkoutId,
    required int sortOrder,
    required List<ExerciseSet> sets,
    @Default(<String>[]) List<String> secondaryMuscleGroups,
    double? plannedWeight,
    String? notes,
    double? personalRecordWeight,
    DateTime? startedAtUtc,
    DateTime? endedAtUtc,
    int? durationSeconds,
    bool? isCompetitionLift,
    String? imageUrl,
  }) = _Exercise;

  const Exercise._();

  bool get isTimerRunning => startedAtUtc != null && endedAtUtc == null;
}
