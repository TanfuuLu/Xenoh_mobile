// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_pr_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExercisePrDto _$ExercisePrDtoFromJson(Map<String, dynamic> json) =>
    _ExercisePrDto(
      exerciseTemplateId: json['exerciseTemplateId'] as String,
      exerciseName: json['exerciseName'] as String,
      currentWeight: (json['currentWeight'] as num).toDouble(),
      reps: (json['reps'] as num).toInt(),
      achievedAt: DateTime.parse(json['achievedAt'] as String),
    );

Map<String, dynamic> _$ExercisePrDtoToJson(_ExercisePrDto instance) =>
    <String, dynamic>{
      'exerciseTemplateId': instance.exerciseTemplateId,
      'exerciseName': instance.exerciseName,
      'currentWeight': instance.currentWeight,
      'reps': instance.reps,
      'achievedAt': instance.achievedAt.toIso8601String(),
    };

_ExercisePrPointDto _$ExercisePrPointDtoFromJson(Map<String, dynamic> json) =>
    _ExercisePrPointDto(
      weight: (json['weight'] as num).toDouble(),
      reps: (json['reps'] as num).toInt(),
      achievedAt: DateTime.parse(json['achievedAt'] as String),
    );

Map<String, dynamic> _$ExercisePrPointDtoToJson(_ExercisePrPointDto instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'reps': instance.reps,
      'achievedAt': instance.achievedAt.toIso8601String(),
    };
