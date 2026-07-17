import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/exercise.dart';

part 'exercise_dto.freezed.dart';
part 'exercise_dto.g.dart';

/// `ExerciseSetResponse` (API ref §3.6).
@freezed
abstract class ExerciseSetDto with _$ExerciseSetDto {
  const factory ExerciseSetDto({
    required String id,
    required int setNumber,
    required int plannedReps,
    required bool isCompleted,
    double? plannedWeight,
    int? actualReps,
    double? actualWeight,
    double? rpe,
    DateTime? completedAt,
  }) = _ExerciseSetDto;

  const ExerciseSetDto._();

  factory ExerciseSetDto.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetDtoFromJson(json);

  ExerciseSet toEntity() => ExerciseSet(
    id: id,
    setNumber: setNumber,
    plannedReps: plannedReps,
    isCompleted: isCompleted,
    plannedWeight: plannedWeight,
    actualReps: actualReps,
    actualWeight: actualWeight,
    rpe: rpe,
    completedAt: completedAt,
  );
}

/// `ExerciseResponse` (API ref §3.6).
@freezed
abstract class ExerciseDto with _$ExerciseDto {
  const factory ExerciseDto({
    required String id,
    required String exerciseTemplateId,
    required String name,
    required String primaryMuscleGroup,
    required String exerciseKind,
    required int plannedSets,
    required int plannedReps,
    required int completedSetsCount,
    required bool isCompleted,
    required bool isSkipped,
    required String dailyWorkoutId,
    required int sortOrder,
    @Default(<ExerciseSetDto>[]) List<ExerciseSetDto> sets,
    @Default(<String>[]) List<String> secondaryMuscleGroups,
    double? plannedWeight,
    String? notes,
    double? personalRecordWeight,
    DateTime? startedAtUtc,
    DateTime? endedAtUtc,
    int? durationSeconds,
    bool? isCompetitionLift,
    String? imageUrl,
  }) = _ExerciseDto;

  const ExerciseDto._();

  factory ExerciseDto.fromJson(Map<String, dynamic> json) =>
      _$ExerciseDtoFromJson(json);

  Exercise toEntity() => Exercise(
    id: id,
    exerciseTemplateId: exerciseTemplateId,
    name: name,
    primaryMuscleGroup: primaryMuscleGroup,
    exerciseKind: exerciseKind,
    plannedSets: plannedSets,
    plannedReps: plannedReps,
    completedSetsCount: completedSetsCount,
    isCompleted: isCompleted,
    isSkipped: isSkipped,
    dailyWorkoutId: dailyWorkoutId,
    sortOrder: sortOrder,
    sets: sets.map((e) => e.toEntity()).toList(),
    secondaryMuscleGroups: secondaryMuscleGroups,
    plannedWeight: plannedWeight,
    notes: notes,
    personalRecordWeight: personalRecordWeight,
    startedAtUtc: startedAtUtc,
    endedAtUtc: endedAtUtc,
    durationSeconds: durationSeconds,
    isCompetitionLift: isCompetitionLift,
    imageUrl: imageUrl,
  );
}
