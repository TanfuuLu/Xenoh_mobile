import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_plan.freezed.dart';

class MealPlanRangeResult {
  const MealPlanRangeResult({
    required this.startDate,
    required this.endDate,
    required this.affectedDayCount,
  });

  final DateTime startDate;
  final DateTime endDate;
  final int affectedDayCount;
}

@freezed
abstract class MealPlanTotals with _$MealPlanTotals {
  const factory MealPlanTotals({
    required int calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
  }) = _MealPlanTotals;
}

@freezed
abstract class MealPlanItem with _$MealPlanItem {
  const factory MealPlanItem({
    required String id,
    required String foodItemId,
    required String nameVi,
    required String nameEn,
    required int sortOrder,
    required double grams,
    required int plannedCalories,
    required double plannedProteinG,
    required double plannedCarbsG,
    required double plannedFatG,
    required bool isChecked,
    String? servingLabelVi,
    String? servingLabelEn,
    double? servingCount,
    DateTime? checkedAt,
    String? foodLogId,
  }) = _MealPlanItem;

  const MealPlanItem._();

  String displayNameFor(String languageCode) {
    if (languageCode == 'vi') {
      return nameVi.isNotEmpty ? nameVi : nameEn;
    }
    return nameEn.isNotEmpty ? nameEn : nameVi;
  }

  String get displayName => displayNameFor('vi');

  String amountLabelFor(String languageCode) {
    final label = languageCode == 'vi'
        ? (servingLabelVi ?? servingLabelEn)
        : (servingLabelEn ?? servingLabelVi);
    final count = servingCount;
    final gramsText = grams == grams.roundToDouble()
        ? grams.toStringAsFixed(0)
        : grams.toStringAsFixed(1);
    if (label != null && label.isNotEmpty && count != null) {
      final countText = count == count.roundToDouble()
          ? count.toStringAsFixed(0)
          : count.toStringAsFixed(1);
      return '$countText x $label ($gramsText g)';
    }
    return '$gramsText g';
  }

  String get amountLabel => amountLabelFor('vi');
}

@freezed
abstract class MealPlanMeal with _$MealPlanMeal {
  const factory MealPlanMeal({
    required String id,
    required String name,
    required int sortOrder,
    required List<MealPlanItem> items,
    required MealPlanTotals plannedTotals,
    required MealPlanTotals checkedTotals,
  }) = _MealPlanMeal;
}

@freezed
abstract class MealPlanDay with _$MealPlanDay {
  const factory MealPlanDay({
    required String userId,
    required DateTime date,
    required List<MealPlanMeal> meals,
    required MealPlanTotals plannedTotals,
    required MealPlanTotals checkedTotals,
    required int totalItemCount,
    required int checkedItemCount,
    String? id,
    String? notes,
  }) = _MealPlanDay;

  const MealPlanDay._();

  double get progress =>
      totalItemCount <= 0 ? 0 : checkedItemCount / totalItemCount;
}
