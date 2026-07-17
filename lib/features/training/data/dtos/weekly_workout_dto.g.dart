// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_workout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyWorkoutDto _$WeeklyWorkoutDtoFromJson(Map<String, dynamic> json) =>
    _WeeklyWorkoutDto(
      id: json['id'] as String,
      weekNumber: (json['weekNumber'] as num).toInt(),
      name: json['name'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      planId: json['planId'] as String,
      totalDays: (json['totalDays'] as num).toInt(),
      completedDays: (json['completedDays'] as num).toInt(),
      hasWarning: json['hasWarning'] as bool,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$WeeklyWorkoutDtoToJson(_WeeklyWorkoutDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekNumber': instance.weekNumber,
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'planId': instance.planId,
      'totalDays': instance.totalDays,
      'completedDays': instance.completedDays,
      'hasWarning': instance.hasWarning,
      'isCompleted': instance.isCompleted,
    };
