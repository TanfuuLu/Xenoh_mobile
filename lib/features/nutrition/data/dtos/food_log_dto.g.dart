// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FoodLogItemDto _$FoodLogItemDtoFromJson(Map<String, dynamic> json) =>
    _FoodLogItemDto(
      id: json['id'] as String,
      foodItemId: json['foodItemId'] as String,
      nameVi: json['nameVi'] as String,
      nameEn: json['nameEn'] as String,
      grams: (json['grams'] as num).toDouble(),
      computedCalories: (json['computedCalories'] as num).toInt(),
      computedProteinG: (json['computedProteinG'] as num).toDouble(),
      computedCarbsG: (json['computedCarbsG'] as num).toDouble(),
      computedFatG: (json['computedFatG'] as num).toDouble(),
      servingLabelVi: json['servingLabelVi'] as String?,
      servingLabelEn: json['servingLabelEn'] as String?,
      servingCount: (json['servingCount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FoodLogItemDtoToJson(_FoodLogItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foodItemId': instance.foodItemId,
      'nameVi': instance.nameVi,
      'nameEn': instance.nameEn,
      'grams': instance.grams,
      'computedCalories': instance.computedCalories,
      'computedProteinG': instance.computedProteinG,
      'computedCarbsG': instance.computedCarbsG,
      'computedFatG': instance.computedFatG,
      'servingLabelVi': instance.servingLabelVi,
      'servingLabelEn': instance.servingLabelEn,
      'servingCount': instance.servingCount,
    };

_FoodLogTotalsDto _$FoodLogTotalsDtoFromJson(Map<String, dynamic> json) =>
    _FoodLogTotalsDto(
      totalCalories: (json['totalCalories'] as num).toInt(),
      totalProteinG: (json['totalProteinG'] as num).toDouble(),
      totalCarbsG: (json['totalCarbsG'] as num).toDouble(),
      totalFatG: (json['totalFatG'] as num).toDouble(),
    );

Map<String, dynamic> _$FoodLogTotalsDtoToJson(_FoodLogTotalsDto instance) =>
    <String, dynamic>{
      'totalCalories': instance.totalCalories,
      'totalProteinG': instance.totalProteinG,
      'totalCarbsG': instance.totalCarbsG,
      'totalFatG': instance.totalFatG,
    };

_FoodLogsForDateDto _$FoodLogsForDateDtoFromJson(Map<String, dynamic> json) =>
    _FoodLogsForDateDto(
      date: json['date'] as String,
      totals: FoodLogTotalsDto.fromJson(json['totals'] as Map<String, dynamic>),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => FoodLogItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FoodLogItemDto>[],
    );

Map<String, dynamic> _$FoodLogsForDateDtoToJson(_FoodLogsForDateDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'totals': instance.totals,
      'items': instance.items,
    };
