import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/cycle/presentation/widgets/cycle_phase_card.dart';

void main() {
  testWidgets('phase card keeps a clear hierarchy on a narrow phone', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    var logged = false;
    var openedSettings = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CyclePhaseCard(
            phase: 'Follicular',
            subtitle: 'Next predicted period: Aug 21, 2026.',
            cycleDayLabel: 'Cycle day',
            cycleDayValue: '10',
            untilPeriodLabel: 'Until period',
            untilPeriodValue: '19 days',
            confidenceLabel: 'Confidence',
            confidenceValue: 'Medium',
            logTodayLabel: 'Log today',
            settingsTooltip: 'Settings',
            onLogToday: () => logged = true,
            onSettings: () => openedSettings = true,
          ),
        ),
      ),
    );

    expect(find.text('Follicular'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('19 days'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Log today'));
    await tester.tap(find.byTooltip('Settings'));
    expect(logged, isTrue);
    expect(openedSettings, isTrue);
  });
}
