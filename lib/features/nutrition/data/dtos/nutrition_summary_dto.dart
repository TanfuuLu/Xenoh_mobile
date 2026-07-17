import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/nutrition_summary.dart';

part 'nutrition_summary_dto.freezed.dart';
part 'nutrition_summary_dto.g.dart';

/// `NutritionSummaryResponse` (API ref §3.17).
@freezed
abstract class NutritionSummaryDto with _$NutritionSummaryDto {
  const factory NutritionSummaryDto({
    required NutritionProfileDto profile,
    required NutritionCalculationDto calculation,
    required bool canUseAdvancedAnalysis,
    NutritionDailyLogDto? todayLog,
  }) = _NutritionSummaryDto;

  const NutritionSummaryDto._();

  factory NutritionSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$NutritionSummaryDtoFromJson(json);

  NutritionSummary toEntity() => NutritionSummary(
    profile: profile.toEntity(),
    calculation: calculation.toEntity(),
    canUseAdvancedAnalysis: canUseAdvancedAnalysis,
    todayLog: todayLog?.toEntity(),
  );
}

@freezed
abstract class NutritionProfileDto with _$NutritionProfileDto {
  const factory NutritionProfileDto({
    required String activityLevel,
    required String goal,
    double? targetWeightKg,
    int? customCalorieTarget,
    double? proteinPerKg,
    double? fatPerKg,
  }) = _NutritionProfileDto;

  const NutritionProfileDto._();

  factory NutritionProfileDto.fromJson(Map<String, dynamic> json) =>
      _$NutritionProfileDtoFromJson(json);

  NutritionProfile toEntity() => NutritionProfile(
    activityLevel: activityLevel,
    goal: goal,
    targetWeightKg: targetWeightKg,
    customCalorieTarget: customCalorieTarget,
    proteinPerKg: proteinPerKg,
    fatPerKg: fatPerKg,
  );
}

@freezed
abstract class NutritionCalculationDto with _$NutritionCalculationDto {
  const factory NutritionCalculationDto({
    @Default(<String>[]) List<String> missingFields,
    double? bodyweightKg,
    int? age,
    int? bmr,
    int? tdee,
    int? recommendedCalories,
    int? calorieTarget,
    double? proteinG,
    double? carbsG,
    double? fatG,
  }) = _NutritionCalculationDto;

  const NutritionCalculationDto._();

  factory NutritionCalculationDto.fromJson(Map<String, dynamic> json) =>
      _$NutritionCalculationDtoFromJson(json);

  NutritionCalculation toEntity() => NutritionCalculation(
    missingFields: missingFields,
    bodyweightKg: bodyweightKg,
    age: age,
    bmr: bmr,
    tdee: tdee,
    recommendedCalories: recommendedCalories,
    calorieTarget: calorieTarget,
    proteinG: proteinG,
    carbsG: carbsG,
    fatG: fatG,
  );
}

@freezed
abstract class NutritionDailyLogDto with _$NutritionDailyLogDto {
  const factory NutritionDailyLogDto({
    required String date,
    required int calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    String? notes,
  }) = _NutritionDailyLogDto;

  const NutritionDailyLogDto._();

  factory NutritionDailyLogDto.fromJson(Map<String, dynamic> json) =>
      _$NutritionDailyLogDtoFromJson(json);

  NutritionDailyLog toEntity() => NutritionDailyLog(
    date: DateOnly.tryParse(date)!,
    calories: calories,
    proteinG: proteinG,
    carbsG: carbsG,
    fatG: fatG,
    notes: notes,
  );
}
