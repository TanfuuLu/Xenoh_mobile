import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
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
}

Future<void> _save({
  required DateTime date,
  required List<Map<String, dynamic>> meals,
  String? notes,
}) async {}
