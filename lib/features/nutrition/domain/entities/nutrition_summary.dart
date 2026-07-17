import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_summary.freezed.dart';

/// `NutritionSummaryResponse` (API ref §3.17).
@freezed
abstract class NutritionSummary with _$NutritionSummary {
  const factory NutritionSummary({
    required NutritionProfile profile,
    required NutritionCalculation calculation,
    required bool canUseAdvancedAnalysis,
    NutritionDailyLog? todayLog,
  }) = _NutritionSummary;

  const NutritionSummary._();

  /// The profile is incomplete until the calculation can produce targets.
  bool get isProfileComplete => calculation.missingFields.isEmpty;
}

@freezed
abstract class NutritionProfile with _$NutritionProfile {
  const factory NutritionProfile({
    required String activityLevel,
    required String goal,
    double? targetWeightKg,
    int? customCalorieTarget,
    double? proteinPerKg,
    double? fatPerKg,
  }) = _NutritionProfile;
}

@freezed
abstract class NutritionCalculation with _$NutritionCalculation {
  const factory NutritionCalculation({
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
  }) = _NutritionCalculation;
}

@freezed
abstract class NutritionDailyLog with _$NutritionDailyLog {
  const factory NutritionDailyLog({
    required DateTime date,
    required int calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    String? notes,
  }) = _NutritionDailyLog;
}
