import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/plate_calculator_card.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('barbell visual stays prominent on a narrow phone', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: SingleChildScrollView(child: PlateCalculatorCard()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final visual = find.byKey(PlateCalculatorCard.barbellVisualKey);
    expect(visual, findsOneWidget);
    expect(tester.getSize(visual).height, 92);
    expect(
      tester.getTopLeft(find.text('Calculate')).dy,
      lessThan(tester.getTopLeft(visual).dy),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('count mode fits a standard phone without scrolling', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: PlateCalculatorCard()),
      ),
    );
    await tester.tap(find.text('Sum plates'));
    await tester.pumpAndSettle();

    expect(
      tester.getSize(find.byType(PlateCalculatorCard)).height,
      lessThanOrEqualTo(844),
    );
    expect(tester.takeException(), isNull);
  });

  // Regression: rapidly toggling Calculate <-> Sum plates while the mode
  // transition was mid-flight used to crash the calculator with a
  // "Duplicate keys" error (an AnimatedSwitcher re-selecting a child still
  // animating out), replacing the whole panel with the red error widget.
  testWidgets('rapid mode toggling never crashes the calculator', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: Center(child: PlateCalculatorButton())),
      ),
    );

    await tester.tap(find.byType(PlateCalculatorButton));
    await tester.pumpAndSettle();

    // Toggle modes faster than the transition can settle.
    for (var i = 0; i < 8; i++) {
      await tester.tap(find.text('Sum plates'));
      await tester.pump(const Duration(milliseconds: 40));
      expect(tester.takeException(), isNull, reason: 'sum frame $i');
      await tester.tap(find.text('Calculate'));
      await tester.pump(const Duration(milliseconds: 40));
      expect(tester.takeException(), isNull, reason: 'calc frame $i');
    }

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
