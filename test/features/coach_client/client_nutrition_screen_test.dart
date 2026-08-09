import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/client_nutrition_screen.dart';
import 'package:xenoh_mobile/features/nutrition/data/repositories/nutrition_repository_provider.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/nutrition_summary.dart';
import 'package:xenoh_mobile/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockNutritionRepository extends Mock implements NutritionRepository {}

void main() {
  testWidgets(
    'shows the same client targets, daily intake and history as web',
    (
      tester,
    ) async {
      final repository = _MockNutritionRepository();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      when(() => repository.getClientSummary('client-1')).thenAnswer(
        (_) async => const NutritionSummary(
          profile: NutritionProfile(
            activityLevel: 'ModeratelyActive',
            goal: 'Maintain',
          ),
          calculation: NutritionCalculation(
            missingFields: [],
            tdee: 2586,
            calorieTarget: 2250,
            proteinG: 120,
            carbsG: 314,
            fatG: 57,
          ),
          canUseAdvancedAnalysis: true,
        ),
      );
      when(
        () => repository.getClientDailyLog('client-1', any()),
      ).thenAnswer(
        (_) async => NutritionDailyLog(
          date: today,
          calories: 2100,
          proteinG: 118,
          carbsG: 290,
          fatG: 60,
        ),
      );
      when(
        () => repository.getClientHistory(
          'client-1',
          from: any(named: 'from'),
          to: any(named: 'to'),
        ),
      ).thenAnswer(
        (_) async => [
          NutritionDailyLog(
            date: today.subtract(const Duration(days: 1)),
            calories: 2200,
            proteinG: 120,
            carbsG: 300,
            fatG: 59,
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            nutritionRepositoryProvider.overrideWithValue(repository),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ClientNutritionScreen(clientId: 'client-1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2586 kcal'), findsOneWidget);
      expect(find.text('2250 kcal'), findsOneWidget);
      expect(find.byKey(ClientNutritionScreen.dailyIntakeKey), findsOneWidget);
      expect(find.text('2100 kcal'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.byKey(ClientNutritionScreen.historyKey),
        250,
      );
      expect(find.byKey(ClientNutritionScreen.historyKey), findsOneWidget);
      expect(find.text('2200 kcal'), findsOneWidget);
    },
  );
}
