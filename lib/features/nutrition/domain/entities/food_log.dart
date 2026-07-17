import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_log.freezed.dart';

/// A single logged food entry for a date (`FoodLogItemResponse`, API ref §3.17).
@freezed
abstract class FoodLogItem with _$FoodLogItem {
  const factory FoodLogItem({
    required String id,
    required String foodItemId,
    required String nameVi,
    required String nameEn,
    required double grams,
    required int computedCalories,
    required double computedProteinG,
    required double computedCarbsG,
    required double computedFatG,
    String? servingLabelVi,
    String? servingLabelEn,
    double? servingCount,
  }) = _FoodLogItem;

  const FoodLogItem._();

  String displayNameFor(String languageCode) {
    if (languageCode == 'vi') {
      return nameVi.isNotEmpty ? nameVi : nameEn;
    }
    return nameEn.isNotEmpty ? nameEn : nameVi;
  }

  String get displayName => displayNameFor('vi');

  /// e.g. `2 × bát (300 g)` or `150 g`.
  String amountLabelFor(String languageCode) {
    final label = languageCode == 'vi'
        ? (servingLabelVi ?? servingLabelEn)
        : (servingLabelEn ?? servingLabelVi);
    final count = servingCount;
    final g = grams == grams.roundToDouble()
        ? grams.toStringAsFixed(0)
        : grams.toStringAsFixed(1);
    if (label != null && label.isNotEmpty && count != null) {
      final c = count == count.roundToDouble()
          ? count.toStringAsFixed(0)
          : count.toStringAsFixed(1);
      return '$c × $label ($g g)';
    }
    return '$g g';
  }

  String get amountLabel => amountLabelFor('vi');
}

@freezed
abstract class FoodLogTotals with _$FoodLogTotals {
  const factory FoodLogTotals({
    required int totalCalories,
    required double totalProteinG,
    required double totalCarbsG,
    required double totalFatG,
  }) = _FoodLogTotals;
}

/// All logged foods + totals for a date (`FoodLogsForDateResponse`).
@freezed
abstract class FoodLogsForDate with _$FoodLogsForDate {
  const factory FoodLogsForDate({
    required DateTime date,
    required FoodLogTotals totals,
    @Default(<FoodLogItem>[]) List<FoodLogItem> items,
  }) = _FoodLogsForDate;
}
