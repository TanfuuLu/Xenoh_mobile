import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/meal_plan.dart';

part 'meal_plan_dto.freezed.dart';
part 'meal_plan_dto.g.dart';

@freezed
abstract class MealPlanTotalsDto with _$MealPlanTotalsDto {
  const factory MealPlanTotalsDto({
    required int calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
  }) = _MealPlanTotalsDto;

  const MealPlanTotalsDto._();

  factory MealPlanTotalsDto.fromJson(Map<String, dynamic> json) =>
      _$MealPlanTotalsDtoFromJson(json);

  MealPlanTotals toEntity() => MealPlanTotals(
    calories: calories,
    proteinG: proteinG,
    carbsG: carbsG,
    fatG: fatG,
  );
}

@freezed
abstract class MealPlanItemDto with _$MealPlanItemDto {
  const factory MealPlanItemDto({
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
    String? checkedAt,
    String? foodLogId,
  }) = _MealPlanItemDto;

  const MealPlanItemDto._();

  factory MealPlanItemDto.fromJson(Map<String, dynamic> json) =>
      _$MealPlanItemDtoFromJson(json);

  MealPlanItem toEntity() => MealPlanItem(
    id: id,
    foodItemId: foodItemId,
    nameVi: nameVi,
    nameEn: nameEn,
    sortOrder: sortOrder,
    grams: grams,
    servingLabelVi: servingLabelVi,
    servingLabelEn: servingLabelEn,
    servingCount: servingCount,
    plannedCalories: plannedCalories,
    plannedProteinG: plannedProteinG,
    plannedCarbsG: plannedCarbsG,
    plannedFatG: plannedFatG,
    isChecked: isChecked,
    checkedAt: checkedAt == null ? null : DateTime.tryParse(checkedAt!),
    foodLogId: foodLogId,
  );
}

@freezed
abstract class MealPlanMealDto with _$MealPlanMealDto {
  const factory MealPlanMealDto({
    required String id,
    required String name,
    required int sortOrder,
    required MealPlanTotalsDto plannedTotals,
    required MealPlanTotalsDto checkedTotals,
    @Default(<MealPlanItemDto>[]) List<MealPlanItemDto> items,
  }) = _MealPlanMealDto;

  const MealPlanMealDto._();

  factory MealPlanMealDto.fromJson(Map<String, dynamic> json) =>
      _$MealPlanMealDtoFromJson(json);

  MealPlanMeal toEntity() => MealPlanMeal(
    id: id,
    name: name,
    sortOrder: sortOrder,
    items: items.map((e) => e.toEntity()).toList(),
    plannedTotals: plannedTotals.toEntity(),
    checkedTotals: checkedTotals.toEntity(),
  );
}

@freezed
abstract class MealPlanDayDto with _$MealPlanDayDto {
  const factory MealPlanDayDto({
    required String userId,
    required String date,
    required MealPlanTotalsDto plannedTotals,
    required MealPlanTotalsDto checkedTotals,
    required int totalItemCount,
    required int checkedItemCount,
    @Default(<MealPlanMealDto>[]) List<MealPlanMealDto> meals,
    String? id,
    String? notes,
  }) = _MealPlanDayDto;

  const MealPlanDayDto._();

  factory MealPlanDayDto.fromJson(Map<String, dynamic> json) =>
      _$MealPlanDayDtoFromJson(json);

  MealPlanDay toEntity() => MealPlanDay(
    id: id,
    userId: userId,
    date: DateOnly.tryParse(date) ?? DateTime(1970),
    notes: notes,
    meals: meals.map((e) => e.toEntity()).toList(),
    plannedTotals: plannedTotals.toEntity(),
    checkedTotals: checkedTotals.toEntity(),
    totalItemCount: totalItemCount,
    checkedItemCount: checkedItemCount,
  );
}
