import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/food.dart';

part 'food_dto.freezed.dart';
part 'food_dto.g.dart';

/// `FoodItemResponse` (API ref §3.17).
@freezed
abstract class FoodItemDto with _$FoodItemDto {
  const factory FoodItemDto({
    required String id,
    required String nameVi,
    required String nameEn,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    @Default(<FoodServingDto>[]) List<FoodServingDto> servings,
  }) = _FoodItemDto;

  const FoodItemDto._();

  factory FoodItemDto.fromJson(Map<String, dynamic> json) =>
      _$FoodItemDtoFromJson(json);

  FoodItem toEntity() => FoodItem(
    id: id,
    nameVi: nameVi,
    nameEn: nameEn,
    caloriesPer100g: caloriesPer100g,
    proteinPer100g: proteinPer100g,
    carbsPer100g: carbsPer100g,
    fatPer100g: fatPer100g,
    servings: servings.map((e) => e.toEntity()).toList(),
  );
}

@freezed
abstract class FoodServingDto with _$FoodServingDto {
  const factory FoodServingDto({
    required String id,
    required String labelVi,
    required double grams,
    String? labelEn,
  }) = _FoodServingDto;

  const FoodServingDto._();

  factory FoodServingDto.fromJson(Map<String, dynamic> json) =>
      _$FoodServingDtoFromJson(json);

  FoodServing toEntity() =>
      FoodServing(id: id, labelVi: labelVi, grams: grams, labelEn: labelEn);
}
