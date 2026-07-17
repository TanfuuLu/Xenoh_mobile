import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';

/// A food item from the database (`FoodItemResponse`, API ref §3.17).
@freezed
abstract class FoodItem with _$FoodItem {
  const factory FoodItem({
    required String id,
    required String nameVi,
    required String nameEn,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    @Default(<FoodServing>[]) List<FoodServing> servings,
  }) = _FoodItem;

  const FoodItem._();

  String displayNameFor(String languageCode) {
    if (languageCode == 'vi') {
      return nameVi.isNotEmpty ? nameVi : nameEn;
    }
    return nameEn.isNotEmpty ? nameEn : nameVi;
  }

  String get displayName => displayNameFor('vi');
}

@freezed
abstract class FoodServing with _$FoodServing {
  const factory FoodServing({
    required String id,
    required String labelVi,
    required double grams,
    String? labelEn,
  }) = _FoodServing;

  const FoodServing._();

  String displayLabelFor(String languageCode) {
    final en = labelEn ?? '';
    if (languageCode == 'vi') {
      return labelVi.isNotEmpty ? labelVi : en;
    }
    return en.isNotEmpty ? en : labelVi;
  }

  String get displayLabel => displayLabelFor('vi');
}
