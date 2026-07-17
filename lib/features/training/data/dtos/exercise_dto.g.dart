// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseSetDto _$ExerciseSetDtoFromJson(Map<String, dynamic> json) =>
    _ExerciseSetDto(
      id: json['id'] as String,
      setNumber: (json['setNumber'] as num).toInt(),
      plannedReps: (json['plannedReps'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
      plannedWeight: (json['plannedWeight'] as num?)?.toDouble(),
      actualReps: (json['actualReps'] as num?)?.toInt(),
      actualWeight: (json['actualWeight'] as num?)?.toDouble(),
      rpe: (json['rpe'] as num?)?.toDouble(),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$ExerciseSetDtoToJson(_ExerciseSetDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'setNumber': instance.setNumber,
      'plannedReps': instance.plannedReps,
      'isCompleted': instance.isCompleted,
      'plannedWeight': instance.plannedWeight,
      'actualReps': instance.actualReps,
      'actualWeight': instance.actualWeight,
      'rpe': instance.rpe,
      'completedAt': instance.completedAt?.toIso8601String(),
    };

_ExerciseDto _$ExerciseDtoFromJson(Map<String, dynamic> json) => _ExerciseDto(
  id: json['id'] as String,
  exerciseTemplateId: json['exerciseTemplateId'] as String,
  name: json['name'] as String,
  primaryMuscleGroup: json['primaryMuscleGroup'] as String,
  exerciseKind: json['exerciseKind'] as String,
  plannedSets: (json['plannedSets'] as num).toInt(),
  plannedReps: (json['plannedReps'] as num).toInt(),
  completedSetsCount: (json['completedSetsCount'] as num).toInt(),
  isCompleted: json['isCompleted'] as bool,
  isSkipped: json['isSkipped'] as bool,
  dailyWorkoutId: json['dailyWorkoutId'] as String,
  sortOrder: (json['sortOrder'] as num).toInt(),
  sets:
      (json['sets'] as List<dynamic>?)
          ?.map((e) => ExerciseSetDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ExerciseSetDto>[],
  secondaryMuscleGroups:
      (json['secondaryMuscleGroups'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  plannedWeight: (json['plannedWeight'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
  personalRecordWeight: (json['personalRecordWeight'] as num?)?.toDouble(),
  startedAtUtc: json['startedAtUtc'] == null
      ? null
      : DateTime.parse(json['startedAtUtc'] as String),
  endedAtUtc: json['endedAtUtc'] == null
      ? null
      : DateTime.parse(json['endedAtUtc'] as String),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  isCompetitionLift: json['isCompetitionLift'] as bool?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ExerciseDtoToJson(_ExerciseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseTemplateId': instance.exerciseTemplateId,
      'name': instance.name,
      'primaryMuscleGroup': instance.primaryMuscleGroup,
      'exerciseKind': instance.exerciseKind,
      'plannedSets': instance.plannedSets,
      'plannedReps': instance.plannedReps,
      'completedSetsCount': instance.completedSetsCount,
      'isCompleted': instance.isCompleted,
      'isSkipped': instance.isSkipped,
      'dailyWorkoutId': instance.dailyWorkoutId,
      'sortOrder': instance.sortOrder,
      'sets': instance.sets,
      'secondaryMuscleGroups': instance.secondaryMuscleGroups,
      'plannedWeight': instance.plannedWeight,
      'notes': instance.notes,
      'personalRecordWeight': instance.personalRecordWeight,
      'startedAtUtc': instance.startedAtUtc?.toIso8601String(),
      'endedAtUtc': instance.endedAtUtc?.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'isCompetitionLift': instance.isCompetitionLift,
      'imageUrl': instance.imageUrl,
    };
