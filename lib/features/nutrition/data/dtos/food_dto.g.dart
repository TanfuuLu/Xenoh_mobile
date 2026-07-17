// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FoodItemDto _$FoodItemDtoFromJson(Map<String, dynamic> json) => _FoodItemDto(
  id: json['id'] as String,
  nameVi: json['nameVi'] as String,
  nameEn: json['nameEn'] as String,
  caloriesPer100g: (json['caloriesPer100g'] as num).toDouble(),
  proteinPer100g: (json['proteinPer100g'] as num).toDouble(),
  carbsPer100g: (json['carbsPer100g'] as num).toDouble(),
  fatPer100g: (json['fatPer100g'] as num).toDouble(),
  servings:
      (json['servings'] as List<dynamic>?)
          ?.map((e) => FoodServingDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FoodServingDto>[],
);

Map<String, dynamic> _$FoodItemDtoToJson(_FoodItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameVi': instance.nameVi,
      'nameEn': instance.nameEn,
      'caloriesPer100g': instance.caloriesPer100g,
      'proteinPer100g': instance.proteinPer100g,
      'carbsPer100g': instance.carbsPer100g,
      'fatPer100g': instance.fatPer100g,
      'servings': instance.servings,
    };

_FoodServingDto _$FoodServingDtoFromJson(Map<String, dynamic> json) =>
    _FoodServingDto(
      id: json['id'] as String,
      labelVi: json['labelVi'] as String,
      grams: (json['grams'] as num).toDouble(),
      labelEn: json['labelEn'] as String?,
    );

Map<String, dynamic> _$FoodServingDtoToJson(_FoodServingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'labelVi': instance.labelVi,
      'grams': instance.grams,
      'labelEn': instance.labelEn,
    };
