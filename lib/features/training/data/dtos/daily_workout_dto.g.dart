// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_workout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CopyDailyWorkoutDto _$CopyDailyWorkoutDtoFromJson(Map<String, dynamic> json) =>
    _CopyDailyWorkoutDto(
      targetDailyWorkoutId: json['targetDailyWorkoutId'] as String,
      exercisesCopied: (json['exercisesCopied'] as num).toInt(),
    );

Map<String, dynamic> _$CopyDailyWorkoutDtoToJson(
  _CopyDailyWorkoutDto instance,
) => <String, dynamic>{
  'targetDailyWorkoutId': instance.targetDailyWorkoutId,
  'exercisesCopied': instance.exercisesCopied,
};

_DailyWorkoutDto _$DailyWorkoutDtoFromJson(Map<String, dynamic> json) =>
    _DailyWorkoutDto(
      id: json['id'] as String,
      date: json['date'] as String,
      dayOfWeek: json['dayOfWeek'] as String,
      isCompleted: json['isCompleted'] as bool,
      weeklyWorkoutId: json['weeklyWorkoutId'] as String,
      totalExercises: (json['totalExercises'] as num).toInt(),
      completedExercises: (json['completedExercises'] as num).toInt(),
      hasWarning: json['hasWarning'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DailyWorkoutDtoToJson(_DailyWorkoutDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'dayOfWeek': instance.dayOfWeek,
      'isCompleted': instance.isCompleted,
      'weeklyWorkoutId': instance.weeklyWorkoutId,
      'totalExercises': instance.totalExercises,
      'completedExercises': instance.completedExercises,
      'hasWarning': instance.hasWarning,
      'status': instance.status,
    };
