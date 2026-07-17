import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/nutrition/data/repositories/nutrition_repository_provider.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/food_log.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/meal_plan.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/nutrition_summary.dart';
import 'package:xenoh_mobile/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:xenoh_mobile/features/nutrition/presentation/providers/nutrition_controller.dart';
import 'package:xenoh_mobile/features/nutrition/presentation/screens/nutrition_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockNutritionRepository extends Mock implements NutritionRepository {}

const _summary = NutritionSummary(
  profile: NutritionProfile(activityLevel: 'Athlete', goal: 'Bulk'),
  calculation: NutritionCalculation(
    calorieTarget: 3050,
    proteinG: 160,
    carbsG: 440,
    fatG: 72,
    bmr: 1769,
    tdee: 3361,
  ),
  canUseAdvancedAnalysis: true,
);

void main() {
  setUpAll(() {
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(<Map<String, dynamic>>[]);
  });

  testWidgets('renders targets, today totals, and a logged food', (
    tester,
  ) async {
    final repo = MockNutritionRepository();
    when(repo.getSummary).thenAnswer((_) async => _summary);
    when(() => repo.getFoodLogs(any())).thenAnswer(
      (_) async => FoodLogsForDate(
        date: DateTime(2026, 6, 8),
        totals: const FoodLogTotals(
          totalCalories: 3145,
          totalProteinG: 177,
          totalCarbsG: 435,
          totalFatG: 77,
        ),
        items: const [
          FoodLogItem(
            id: 'f1',
            foodItemId: 'food1',
            nameVi: 'Cơm trắng',
            nameEn: 'White rice',
            grams: 300,
            computedCalories: 390,
            computedProteinG: 8,
            computedCarbsG: 86,
            computedFatG: 1,
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [nutritionRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NutritionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('3050 kcal target'), findsOneWidget);
    expect(find.text('3145'), findsOneWidget); // consumed from food totals
    expect(find.text('CALCULATION'), findsOneWidget);
    expect(find.text('1769 kcal'), findsOneWidget);
    expect(find.text('3361 kcal'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -420));
    await tester.pumpAndSettle();

    expect(find.text("TODAY'S FOOD"), findsOneWidget);
    expect(find.text('White rice'), findsOneWidget);
    expect(find.text('Add food'), findsOneWidget);
  });

  test('food log display names follow the requested language', () {
    const item = FoodLogItem(
      id: 'f1',
      foodItemId: 'food1',
      nameVi: 'Cơm trắng',
      nameEn: 'White rice',
      grams: 300,
      computedCalories: 390,
      computedProteinG: 8,
      computedCarbsG: 86,
      computedFatG: 1,
    );

    expect(item.displayNameFor('en'), 'White rice');
    expect(item.displayNameFor('vi'), 'Cơm trắng');
  });

  test('weekly meal plan setup upserts seven dates', () async {
    final repo = MockNutritionRepository();
    final meals = [
      {
        'name': 'Breakfast',
        'sortOrder': 0,
        'items': <Map<String, dynamic>>[],
      },
    ];

    when(
      () => repo.upsertMealPlan(
        date: any(named: 'date'),
        meals: any(named: 'meals'),
        notes: any(named: 'notes'),
      ),
    ).thenAnswer(
      (invocation) async => _mealPlan(
        invocation.namedArguments[#date] as DateTime,
      ),
    );

    final container = ProviderContainer(
      overrides: [nutritionRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    await container
        .read(mealPlanActionControllerProvider.notifier)
        .saveWeek(
          weekStart: DateTime(2026, 6),
          meals: meals,
          notes: 'prep',
        );

    for (var i = 0; i < 7; i++) {
      verify(
        () => repo.upsertMealPlan(
          date: DateTime(2026, 6, 1 + i),
          meals: meals,
          notes: 'prep',
        ),
      ).called(1);
    }
  });
}

MealPlanDay _mealPlan(DateTime date) => MealPlanDay(
  userId: 'u1',
  date: date,
  meals: const [],
  plannedTotals: const MealPlanTotals(
    calories: 0,
    proteinG: 0,
    carbsG: 0,
    fatG: 0,
  ),
  checkedTotals: const MealPlanTotals(
    calories: 0,
    proteinG: 0,
    carbsG: 0,
    fatG: 0,
  ),
  totalItemCount: 0,
  checkedItemCount: 0,
);
