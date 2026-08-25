import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/preferences_provider.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/workout_result_view.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

/// The reported bug was size-dependent: the old metric grid computed a tile
/// width from an inverted breakpoint, so wider phones got *narrower* tiles and
/// the Vietnamese labels could only ellipsize. These tests pin the layout at
/// the widths that straddled that breakpoint, in both locales, at a raised text
/// scale.
void main() {
  const result = WorkoutResult(
    totalExercises: 4,
    completedExercises: 4,
    skippedExercises: 0,
    completedSets: 12,
    totalSets: 12,
    volumeKg: 680.5,
    averageRpe: 8.5,
    durationSeconds: 3725,
  );

  const sizes = [Size(320, 640), Size(390, 844), Size(412, 915), Size(768, 1024)];

  const labels = {
    'en': ['Volume', 'Avg RPE', 'Total time'],
    'vi': ['Khối lượng', 'RPE trung bình', 'Tổng thời gian'],
  };

  Widget host(Locale locale, Widget child) => ProviderScope(
    overrides: [trackRpeProvider.overrideWithValue(true)],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );

  /// Every metric label must render in full. `find.text` matches the widget's
  /// string whether or not it fits, so assert on the laid-out paragraph
  /// instead — `didExceedMaxLines` is what turns into the "RPE trung b…" the
  /// user reported.
  void expectNoTruncation(WidgetTester tester, List<String> texts) {
    for (final text in texts) {
      final finder = find.text(text);
      expect(finder, findsOneWidget, reason: 'missing label "$text"');
      final paragraph = tester.renderObject<RenderParagraph>(finder);
      expect(
        paragraph.didExceedMaxLines,
        isFalse,
        reason: 'label "$text" was truncated',
      );
    }
  }

  for (final locale in const [Locale('en'), Locale('vi')]) {
    final code = locale.languageCode;
    for (final size in sizes) {
      final at = '$code ${size.width.toInt()}x${size.height.toInt()}';

      testWidgets('result card fits at $at', (tester) async {
        await tester.binding.setSurfaceSize(size);
        addTearDown(() => tester.binding.setSurfaceSize(null));
        tester.platformDispatcher.textScaleFactorTestValue = 1.3;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        await tester.pumpWidget(
          host(
            locale,
            const Scaffold(
              body: SingleChildScrollView(
                padding: EdgeInsets.all(9),
                child: WorkoutResultCard(
                  result: result,
                  unit: WeightUnit.kg,
                  currentStreak: 1,
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expectNoTruncation(tester, labels[code]!);
        expect(find.byType(Divider), findsNothing);
        expect(tester.takeException(), isNull);
      });

      testWidgets('result dialog fits at $at', (tester) async {
        await tester.binding.setSurfaceSize(size);
        addTearDown(() => tester.binding.setSurfaceSize(null));
        tester.platformDispatcher.textScaleFactorTestValue = 1.3;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        await tester.pumpWidget(
          host(
            locale,
            const WorkoutResultDialog(
              result: result,
              unit: WeightUnit.kg,
              currentStreak: 1,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expectNoTruncation(tester, labels[code]!);
        // The Done button must stay on the surface: it sits outside the scroll
        // area, so it can only be reached if the body gave way first.
        final done = find.byType(FilledButton);
        expect(done, findsOneWidget);
        final dialog = tester.getRect(find.byType(Dialog));
        expect(tester.getRect(done).bottom, lessThanOrEqualTo(dialog.bottom));
        expect(find.byType(Divider), findsNothing);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('metrics hide the RPE row when the user does not track RPE', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [trackRpeProvider.overrideWithValue(false)],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: WorkoutResultCard(
              result: result,
              unit: WeightUnit.kg,
              currentStreak: 1,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Avg RPE'), findsNothing);
    expect(find.text('Volume'), findsOneWidget);
    expect(find.text('Total time'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('duration and RPE formatting is unchanged by the move', () {
    expect(formatResultDuration(0), '0s');
    expect(formatResultDuration(45), '45s');
    expect(formatResultDuration(120), '2m');
    expect(formatResultDuration(125), '2m 5s');
    expect(formatResultDuration(3600), '1h');
    expect(formatResultDuration(3725), '1h 2m');
    expect(formatAverageRpe(null), '-');
    expect(formatAverageRpe(8), '8');
    expect(formatAverageRpe(8.5), '8.5');
  });
}
