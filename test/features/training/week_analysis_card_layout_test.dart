import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/widgets/xn_card.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/week_analysis_provider.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/week_analysis_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  final analysis = WeekAnalysis(
    days: const [],
    daily: const [],
    completedDays: 3,
    totalDays: 7,
    restDays: 2,
    missedDays: 1,
    warningDays: 1,
    actualVolume: 2472,
    plannedVolume: 16384,
    completedSets: 8,
    totalSets: 58,
    averageRpe: 8.5,
    totalDurationSeconds: 6000,
    muscleFocus: const [],
    recommendations: const [],
  );

  for (final locale in const [Locale('en'), Locale('vi')]) {
    for (final size in const [
      Size(320, 640),
      Size(390, 844),
      Size(768, 1024),
    ]) {
      testWidgets(
        'week metrics are cards at ${locale.languageCode} ${size.width.toInt()}x${size.height.toInt()}',
        (tester) async {
          await tester.binding.setSurfaceSize(size);
          addTearDown(() => tester.binding.setSurfaceSize(null));
          tester.platformDispatcher.textScaleFactorTestValue = 1.3;
          addTearDown(
            tester.platformDispatcher.clearTextScaleFactorTestValue,
          );

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                weekAnalysisProvider('week-1').overrideWith(
                  (ref) async => analysis,
                ),
              ],
              child: MaterialApp(
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const WeekAnalysisScreen(weekId: 'week-1'),
              ),
            ),
          );
          await tester.pumpAndSettle();

          final metricLabels = locale.languageCode == 'vi'
              ? ['KL so kế hoạch', 'Thời gian', 'RPE trung bình', 'Calo']
              : ['Volume vs plan', 'Time', 'Average RPE', 'Calories'];
          final cardElements = <Element>{};
          for (final label in metricLabels) {
            final labelFinder = find.text(label).first;
            await tester.scrollUntilVisible(
              labelFinder,
              100,
              scrollable: find.byType(Scrollable).first,
            );
            final card = find.ancestor(
              of: labelFinder,
              matching: find.byType(XnCard),
            );
            expect(card, findsOneWidget);
            cardElements.add(tester.element(card));
          }

          expect(cardElements, hasLength(4));
          expect(find.byType(Divider), findsNothing);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
