// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanDto _$PlanDtoFromJson(Map<String, dynamic> json) => _PlanDto(
  id: json['id'] as String,
  name: json['name'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  planType: json['planType'] as String,
  ownerName: json['ownerName'] as String,
  totalWeeks: (json['totalWeeks'] as num).toInt(),
  completedWeeks: (json['completedWeeks'] as num).toInt(),
  totalDays: (json['totalDays'] as num).toInt(),
  completedDays: (json['completedDays'] as num).toInt(),
  isActive: json['isActive'] as bool,
  coachName: json['coachName'] as String?,
);

Map<String, dynamic> _$PlanDtoToJson(_PlanDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'planType': instance.planType,
  'ownerName': instance.ownerName,
  'totalWeeks': instance.totalWeeks,
  'completedWeeks': instance.completedWeeks,
  'totalDays': instance.totalDays,
  'completedDays': instance.completedDays,
  'isActive': instance.isActive,
  'coachName': instance.coachName,
};
