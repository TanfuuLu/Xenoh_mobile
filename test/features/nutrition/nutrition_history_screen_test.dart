import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/nutrition/data/repositories/nutrition_repository_provider.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/nutrition_summary.dart';
import 'package:xenoh_mobile/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:xenoh_mobile/features/nutrition/presentation/screens/nutrition_history_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockNutritionRepository extends Mock implements NutritionRepository {}

void main() {
  testWidgets('shows the 30-day athlete history and macro totals', (
    tester,
  ) async {
    final repository = _MockNutritionRepository();
    when(
      () => repository.getHistory(
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenAnswer(
      (_) async => [
        NutritionDailyLog(
          date: DateTime(2026, 8, 2),
          calories: 2100,
          proteinG: 120,
          carbsG: 250,
          fatG: 60,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [nutritionRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const NutritionHistoryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(NutritionHistoryScreen.contentKey), findsOneWidget);
    expect(find.text('2100 kcal'), findsNWidgets(2));
    expect(find.textContaining('P 120g'), findsOneWidget);
  });
}
