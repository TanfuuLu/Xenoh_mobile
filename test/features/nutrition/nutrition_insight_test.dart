import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/nutrition_summary.dart';
import 'package:xenoh_mobile/features/nutrition/domain/nutrition_insight.dart';

void main() {
  test('builds the same calorie and macro signals from 14-day history', () {
    const summary = NutritionSummary(
      profile: NutritionProfile(
        activityLevel: 'ModeratelyActive',
        goal: 'Maintain',
        targetWeightKg: 60,
      ),
      calculation: NutritionCalculation(
        missingFields: [],
        bodyweightKg: 62,
        calorieTarget: 2250,
        proteinG: 120,
        carbsG: 314,
        fatG: 57,
      ),
      canUseAdvancedAnalysis: true,
    );
    final history = [
      NutritionDailyLog(
        date: DateTime(2026, 8, 2),
        calories: 2500,
        proteinG: 80,
        carbsG: 330,
        fatG: 70,
      ),
      NutritionDailyLog(
        date: DateTime(2026, 8, 3),
        calories: 2400,
        proteinG: 90,
        carbsG: 320,
        fatG: 65,
      ),
    ];

    final insight = buildNutritionInsight(summary: summary, history: history);

    expect(insight.averageCalories, 2450);
    expect(insight.calorieDelta, 200);
    expect(insight.calorieAction, NutritionCalorieAction.reduce);
    expect(insight.proteinAction, NutritionProteinAction.prioritizeProtein);
    expect(insight.weightGapKg, -2);
    expect(insight.macroBalancePercent, inInclusiveRange(70, 100));
    expect(insight.strategies, hasLength(3));
  });

  test('uses today log fallback and reports insufficient data safely', () {
    const summary = NutritionSummary(
      profile: NutritionProfile(activityLevel: 'Light', goal: 'Maintain'),
      calculation: NutritionCalculation(missingFields: []),
      canUseAdvancedAnalysis: true,
    );

    final insight = buildNutritionInsight(summary: summary, history: const []);

    expect(insight.hasMeaningfulData, isFalse);
    expect(insight.calorieAction, NutritionCalorieAction.setTarget);
    expect(insight.macroBalancePercent, isNull);
  });
}
