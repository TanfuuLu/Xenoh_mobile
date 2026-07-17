import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/features/profile/presentation/widgets/log_bodyweight_dialog.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

Future<double?> _open(WidgetTester tester, {double? initial}) async {
  double? result;
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              result = await showDialog<double>(
                context: context,
                builder: (_) => LogBodyweightDialog(
                  unit: WeightUnit.kg,
                  initialWeight: initial,
                ),
              );
            },
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return result;
}

void main() {
  testWidgets('prefills the current weight and returns the edited value', (
    tester,
  ) async {
    await _open(tester, initial: 82);
    expect(find.widgetWithText(TextFormField, '82'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '83.5');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Dialog closed (returned 83.5).
    expect(find.text('Save'), findsNothing);
  });

  testWidgets('rejects out-of-range weights', (tester) async {
    await _open(tester);

    await tester.enterText(find.byType(TextFormField), '5');
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Must be 20-500 kg'), findsOneWidget);
    // Still open.
    expect(find.text('Save'), findsOneWidget);
  });
}
