import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/nutrition_card.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/supplements_card.dart';
import 'package:xenoh_mobile/features/nutrition/data/repositories/nutrition_repository_provider.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/food_log.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/nutrition_summary.dart';
import 'package:xenoh_mobile/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:xenoh_mobile/features/supplements/data/repositories/supplement_repository_provider.dart';
import 'package:xenoh_mobile/features/supplements/domain/entities/supplement_models.dart';
import 'package:xenoh_mobile/features/supplements/domain/repositories/supplement_repository.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockNutritionRepository extends Mock implements NutritionRepository {}

class _MockSupplementRepository extends Mock implements SupplementRepository {}

void main() {
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
