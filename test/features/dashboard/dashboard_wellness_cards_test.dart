import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/core/widgets/xn_card.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/nutrition_card.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/supplements_card.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/today_meal_plan_card.dart';
import 'package:xenoh_mobile/features/nutrition/data/repositories/nutrition_repository_provider.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/food_log.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/meal_plan.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/nutrition_summary.dart';
import 'package:xenoh_mobile/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:xenoh_mobile/features/supplements/data/repositories/supplement_repository_provider.dart';
import 'package:xenoh_mobile/features/supplements/domain/entities/supplement_models.dart';
import 'package:xenoh_mobile/features/supplements/domain/repositories/supplement_repository.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockNutritionRepository extends Mock implements NutritionRepository {}

class _MockSupplementRepository extends Mock implements SupplementRepository {}

void main() {
  testWidgets('checked meal text clears its card border', (tester) async {
    await tester.binding.setSurfaceSize(const Size(403, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);
    final repository = _MockNutritionRepository();
    const totals = MealPlanTotals(
      calories: 330,
      proteinG: 62,
      carbsG: 0,
      fatG: 7,
    );
    when(() => repository.getMealPlan(date)).thenAnswer(
      (_) async => MealPlanDay(
        userId: 'user-1',
        date: date,
        meals: const [
          MealPlanMeal(
            id: 'breakfast',
            name: 'Breakfast',
            sortOrder: 0,
            items: [
              MealPlanItem(
                id: 'chicken',
                foodItemId: 'food-1',
                nameVi: 'Ức gà (luộc)',
                nameEn: 'Chicken breast',
                sortOrder: 0,
                grams: 200,
                plannedCalories: 330,
                plannedProteinG: 62,
                plannedCarbsG: 0,
                plannedFatG: 7,
                isChecked: true,
                servingLabelEn: 'piece',
                servingCount: 1,
              ),
            ],
            plannedTotals: totals,
            checkedTotals: totals,
          ),
        ],
        plannedTotals: totals,
        checkedTotals: totals,
        totalItemCount: 1,
        checkedItemCount: 1,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          nutritionRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(child: TodayMealPlanCard()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final title = find.text('Chicken breast');
    final itemCard = find.ancestor(of: title, matching: find.byType(XnCard));
    final titleRect = tester.getRect(title);
    final cardRect = tester.getRect(itemCard);
    expect(titleRect.left, greaterThanOrEqualTo(cardRect.left + AppSpacing.md));
    expect(titleRect.top, greaterThanOrEqualTo(cardRect.top + AppSpacing.md));
    expect(tester.takeException(), isNull);
  });

  testWidgets('food card highlights calorie progress and balanced macros', (
    tester,
  ) async {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    final repository = _MockNutritionRepository();
    when(repository.getSummary).thenAnswer(
      (_) async => const NutritionSummary(
        profile: NutritionProfile(activityLevel: 'Moderate', goal: 'Maintain'),
        calculation: NutritionCalculation(
          calorieTarget: 2000,
          proteinG: 150,
          carbsG: 220,
          fatG: 65,
        ),
        canUseAdvancedAnalysis: false,
      ),
    );
    when(() => repository.getFoodLogs(date)).thenAnswer(
      (_) async => FoodLogsForDate(
        date: date,
        totals: const FoodLogTotals(
          totalCalories: 1250,
          totalProteinG: 90,
          totalCarbsG: 130,
          totalFatG: 42,
        ),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          nutritionRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(child: NutritionCard()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.restaurant_rounded), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
    expect(find.text('1,250/2,000 kcal'), findsOneWidget);
    expect(find.text('750 kcal remaining'), findsOneWidget);
    expect(find.text('Protein'), findsOneWidget);
    expect(find.text('Carbs'), findsOneWidget);
    expect(find.text('Fat'), findsOneWidget);

    final macroIndicators = tester
        .widgetList<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator),
        )
        .toList()
        .sublist(1);
    expect(macroIndicators[0].valueColor!.value, AppColors.macroProtein);
    expect(macroIndicators[1].valueColor!.value, AppColors.macroCarbs);
    expect(macroIndicators[2].valueColor!.value, AppColors.macroFat);
  });

  testWidgets('supplements card shows adherence and today doses', (
    tester,
  ) async {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    final repository = _MockSupplementRepository();
    when(() => repository.getDaily(date)).thenAnswer(
      (_) async => SupplementDaily(
        userId: 'u1',
        date: date,
        totals: const SupplementAdherenceTotals(
          planned: 2,
          taken: 1,
          skipped: 0,
          missed: 0,
          pending: 1,
          adherencePercentage: 50,
        ),
        doses: const [
          SupplementDailyDose(
            doseSlotId: 'd1',
            regimenId: 'r1',
            regimenName: 'Creatine',
            amount: 5,
            unit: 'g',
            time: '08:00',
            status: SupplementDoseStatus.taken,
          ),
          SupplementDailyDose(
            doseSlotId: 'd2',
            regimenId: 'r2',
            regimenName: 'Magnesium',
            amount: 200,
            unit: 'mg',
            time: '21:00',
            status: SupplementDoseStatus.pending,
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          supplementRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(child: SupplementsCard()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Supplements'), findsOneWidget);
    expect(find.text('1 of 2 taken'), findsOneWidget);
    expect(find.text('Creatine'), findsOneWidget);
    expect(find.text('Magnesium'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
  });
}
