// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bodyweight_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BodyweightLogDto _$BodyweightLogDtoFromJson(Map<String, dynamic> json) =>
    _BodyweightLogDto(
      id: json['id'] as String,
      weight: (json['weight'] as num).toDouble(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$BodyweightLogDtoToJson(_BodyweightLogDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'date': instance.date,
    };
