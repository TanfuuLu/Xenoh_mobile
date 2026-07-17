import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/food_log.dart';

part 'food_log_dto.freezed.dart';
part 'food_log_dto.g.dart';

/// `FoodLogItemResponse` (API ref §3.17).
@freezed
abstract class FoodLogItemDto with _$FoodLogItemDto {
  const factory FoodLogItemDto({
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
  }) = _FoodLogItemDto;

  const FoodLogItemDto._();

  factory FoodLogItemDto.fromJson(Map<String, dynamic> json) =>
      _$FoodLogItemDtoFromJson(json);

  FoodLogItem toEntity() => FoodLogItem(
    id: id,
    foodItemId: foodItemId,
    nameVi: nameVi,
    nameEn: nameEn,
    grams: grams,
    computedCalories: computedCalories,
    computedProteinG: computedProteinG,
    computedCarbsG: computedCarbsG,
    computedFatG: computedFatG,
    servingLabelVi: servingLabelVi,
    servingLabelEn: servingLabelEn,
    servingCount: servingCount,
  );
}

@freezed
abstract class FoodLogTotalsDto with _$FoodLogTotalsDto {
  const factory FoodLogTotalsDto({
    required int totalCalories,
    required double totalProteinG,
    required double totalCarbsG,
    required double totalFatG,
  }) = _FoodLogTotalsDto;

  const FoodLogTotalsDto._();

  factory FoodLogTotalsDto.fromJson(Map<String, dynamic> json) =>
      _$FoodLogTotalsDtoFromJson(json);

  FoodLogTotals toEntity() => FoodLogTotals(
    totalCalories: totalCalories,
    totalProteinG: totalProteinG,
    totalCarbsG: totalCarbsG,
    totalFatG: totalFatG,
  );
}

/// `FoodLogsForDateResponse` (API ref §3.17).
@freezed
abstract class FoodLogsForDateDto with _$FoodLogsForDateDto {
  const factory FoodLogsForDateDto({
    required String date,
    required FoodLogTotalsDto totals,
    @Default(<FoodLogItemDto>[]) List<FoodLogItemDto> items,
  }) = _FoodLogsForDateDto;

  const FoodLogsForDateDto._();

  factory FoodLogsForDateDto.fromJson(Map<String, dynamic> json) =>
      _$FoodLogsForDateDtoFromJson(json);

  FoodLogsForDate toEntity() => FoodLogsForDate(
    date: DateOnly.tryParse(date)!,
    totals: totals.toEntity(),
    items: items.map((e) => e.toEntity()).toList(),
  );
}
