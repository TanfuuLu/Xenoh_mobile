import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/meal_plan.dart';
import 'package:xenoh_mobile/features/nutrition/presentation/widgets/meal_plan_setup_sheet.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('meal plan editor uses one compact date row and grouped meals', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: MealPlanSetupSheet(
              date: DateTime(2026, 8, 2),
              onSave: _save,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(MealPlanSetupSheet.scopeSelectorKey),
      findsOneWidget,
    );
    expect(
      tester.getSize(find.byKey(MealPlanSetupSheet.scopeSelectorKey)).height,
      44,
    );
    final selectedScope = tester.widget<AnimatedContainer>(
      find.byKey(MealPlanSetupSheet.selectedScopeKey),
    );
    final selectedDecoration = selectedScope.decoration! as BoxDecoration;
    expect(selectedDecoration.color, AppColors.accentSoft);
    expect(selectedDecoration.border, isNotNull);
    expect(
      tester.getSize(find.byKey(MealPlanSetupSheet.selectedScopeKey)).height,
      42,
    );
    expect(find.byKey(MealPlanSetupSheet.dateRowKey), findsOneWidget);
    expect(find.text('2026-08-02'), findsOneWidget);
    expect(find.byKey(MealPlanSetupSheet.mealListPanelKey), findsOneWidget);
    expect(find.byKey(MealPlanSetupSheet.footerKey), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('weekly editor stays usable in Vietnamese on a narrow phone', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          locale: const Locale('vi'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: MealPlanSetupSheet(
              date: DateTime(2026, 8, 2),
              onSave: _save,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Theo tuần'));
    await tester.pumpAndSettle();

    expect(find.text('2026-07-27 - 2026-08-02'), findsOneWidget);
    expect(find.text('Tạo cho tuần'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('day save sends a serving amount without response-only fields', (
    tester,
  ) async {
    final saves = <({DateTime date, List<Map<String, dynamic>> meals})>[];
    await _pumpEditor(
      tester,
      initialPlan: _planWithServingItem(),
      onSave: ({required date, required meals, notes}) async {
        saves.add((date: date, meals: meals));
      },
    );

    await tester.tap(find.text('Create day'));
    await tester.pumpAndSettle();

    expect(saves, hasLength(1));
    final item = (saves.single.meals.single['items'] as List).single as Map;
    expect(item, {
      'foodItemId': 'food-1',
      'sortOrder': 0,
      'servingLabel': 'chén',
      'servingCount': 1,
    });
    expect(item, isNot(contains('grams')));
    expect(item, isNot(contains('servingLabelVi')));
    expect(item, isNot(contains('servingLabelEn')));
  });

  testWidgets('week save uses one canonical range payload', (
    tester,
  ) async {
    final saves =
        <
          ({
            DateTime startDate,
            DateTime endDate,
            List<Map<String, dynamic>> meals,
          })
        >[];
    await _pumpEditor(
      tester,
      initialPlan: _planWithServingItem(),
      onSaveWeek:
          ({
            required startDate,
            required endDate,
            required meals,
            notes,
          }) async {
            saves.add((startDate: startDate, endDate: endDate, meals: meals));
          },
    );

    await tester.tap(find.text('Whole week'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create week'));
    await tester.pumpAndSettle();

    expect(saves, hasLength(1));
    expect(saves.single.startDate, DateTime(2026, 8, 10));
    expect(saves.single.endDate, DateTime(2026, 8, 16));
    final item = (saves.single.meals.single['items'] as List).single as Map;
    expect(item, containsPair('servingLabel', 'chén'));
    expect(item, containsPair('servingCount', 1));
    expect(item, isNot(contains('grams')));
  });

  testWidgets('weekly date row selects and saves a custom date range', (
    tester,
  ) async {
    DateTimeRange? savedRange;
    await _pumpEditor(
      tester,
      initialPlan: _planWithServingItem(),
      pickDateRange: ({required initialRange}) async => DateTimeRange(
        start: DateTime(2026, 8, 18),
        end: DateTime(2026, 8, 28),
      ),
      onSaveWeek:
          ({
            required startDate,
            required endDate,
            required meals,
            notes,
          }) async {
            savedRange = DateTimeRange(start: startDate, end: endDate);
          },
    );

    await tester.tap(find.text('Whole week'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(MealPlanSetupSheet.dateRowKey));
    await tester.pumpAndSettle();

    expect(find.text('2026-08-18 - 2026-08-28'), findsOneWidget);

    await tester.tap(find.text('Create week'));
    await tester.pumpAndSettle();

    expect(savedRange?.start, DateTime(2026, 8, 18));
    expect(savedRange?.end, DateTime(2026, 8, 28));
  });
}

Future<void> _save({
  required DateTime date,
  required List<Map<String, dynamic>> meals,
  String? notes,
}) async {}

Future<void> _pumpEditor(
  WidgetTester tester, {
  required MealPlanDay initialPlan,
  MealPlanSaveHandler? onSave,
  MealPlanWeekSaveHandler? onSaveWeek,
  MealPlanDateRangePicker? pickDateRange,
}) async {
  await tester.binding.setSurfaceSize(const Size(430, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: MealPlanSetupSheet(
            date: DateTime(2026, 8, 13),
            initialPlan: initialPlan,
            onSave: onSave ?? _save,
            onSaveWeek: onSaveWeek,
            pickDateRange: pickDateRange,
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

MealPlanDay _planWithServingItem() {
  const zero = MealPlanTotals(
    calories: 0,
    proteinG: 0,
    carbsG: 0,
    fatG: 0,
  );
  return MealPlanDay(
    userId: 'user-1',
    date: DateTime(2026, 8, 13),
    meals: const [
      MealPlanMeal(
        id: 'meal-1',
        name: 'Lunch',
        sortOrder: 0,
        items: [
          MealPlanItem(
            id: 'item-1',
            foodItemId: 'food-1',
            nameVi: 'Cơm trắng (chín)',
            nameEn: 'Cooked white rice',
            sortOrder: 0,
            grams: 200,
            servingLabelVi: 'chén',
            servingLabelEn: 'bowl',
            servingCount: 1,
            plannedCalories: 260,
            plannedProteinG: 5,
            plannedCarbsG: 56,
            plannedFatG: 1,
            isChecked: false,
          ),
        ],
        plannedTotals: zero,
        checkedTotals: zero,
      ),
    ],
    plannedTotals: zero,
    checkedTotals: zero,
    totalItemCount: 1,
    checkedItemCount: 0,
  );
}
