// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_activity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingActivityDto _$TrainingActivityDtoFromJson(Map<String, dynamic> json) =>
    _TrainingActivityDto(
      totalDurationSeconds: (json['totalDurationSeconds'] as num).toInt(),
      totalWeightTrainedKg: (json['totalWeightTrainedKg'] as num).toDouble(),
      accountCreatedAt: json['accountCreatedAt'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      trainedDates:
          (json['trainedDates'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$TrainingActivityDtoToJson(
  _TrainingActivityDto instance,
) => <String, dynamic>{
  'totalDurationSeconds': instance.totalDurationSeconds,
  'totalWeightTrainedKg': instance.totalWeightTrainedKg,
  'accountCreatedAt': instance.accountCreatedAt,
  'year': instance.year,
  'month': instance.month,
  'trainedDates': instance.trainedDates,
};
