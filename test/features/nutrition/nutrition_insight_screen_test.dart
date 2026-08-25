import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/utils/current_date_provider.dart';
import 'package:xenoh_mobile/features/nutrition/data/repositories/nutrition_repository_provider.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/nutrition_summary.dart';
import 'package:xenoh_mobile/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:xenoh_mobile/features/nutrition/presentation/screens/nutrition_insight_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockNutritionRepository extends Mock implements NutritionRepository {}

void main() {
  testWidgets('renders native insight sections for an eligible athlete', (
    tester,
  ) async {
    final repository = _MockNutritionRepository();
    when(repository.getSummary).thenAnswer(
      (_) async => const NutritionSummary(
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
      ),
    );
    when(
      () => repository.getHistory(
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenAnswer(
      (_) async => [
        NutritionDailyLog(
          date: DateTime.now(),
          calories: 2450,
          proteinG: 85,
          carbsG: 320,
          fatG: 65,
        ),
      ],
    );

    await _pump(tester, repository, const NutritionInsightScreen());

    expect(find.byKey(NutritionInsightScreen.contentKey), findsOneWidget);
    expect(find.text('+200 kcal'), findsOneWidget);
    expect(find.text('Next moves'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Macro strategies'), 300);
    expect(find.text('Macro strategies'), findsOneWidget);
  });

  testWidgets('shows the explicit Pro gate when analysis is unavailable', (
    tester,
  ) async {
    final repository = _MockNutritionRepository();
    when(repository.getSummary).thenAnswer(
      (_) async => const NutritionSummary(
        profile: NutritionProfile(activityLevel: 'Light', goal: 'Maintain'),
        calculation: NutritionCalculation(missingFields: []),
        canUseAdvancedAnalysis: false,
      ),
    );

    await _pump(tester, repository, const NutritionInsightScreen());

    expect(find.text('Advanced nutrition analysis'), findsOneWidget);
    verifyNever(
      () => repository.getHistory(
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    );
  });

  testWidgets('uses the shared local day for its rolling history', (
    tester,
  ) async {
    final repository = _MockNutritionRepository();
    final today = DateTime(2030, 1, 14);
    when(repository.getSummary).thenAnswer(
      (_) async => const NutritionSummary(
        profile: NutritionProfile(activityLevel: 'Light', goal: 'Maintain'),
        calculation: NutritionCalculation(missingFields: []),
        canUseAdvancedAnalysis: true,
      ),
    );
    when(
      () => repository.getHistory(
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenAnswer((_) async => const []);

    await _pump(
      tester,
      repository,
      const NutritionInsightScreen(),
      today: today,
    );

    verify(
      () => repository.getHistory(
        from: DateTime(2030, 1, 1),
        to: today,
      ),
    ).called(1);
  });
}

Future<void> _pump(
  WidgetTester tester,
  NutritionRepository repository,
  Widget child, {
  DateTime? today,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        if (today != null) currentDateProvider.overrideWithValue(today),
        nutritionRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    ),
  );
  await tester.pumpAndSettle();
}
