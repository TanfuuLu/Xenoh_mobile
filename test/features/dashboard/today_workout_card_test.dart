import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/features/dashboard/domain/entities/personal_dashboard.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/today_workout_card.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('rest workout cannot be opened from the dashboard', (
    tester,
  ) async {
    var openCount = 0;
    final workout = TodayWorkout(
      id: 'day-rest',
      weeklyWorkoutId: 'week-1',
      dayOfWeek: 'Saturday',
      date: DateTime(2026, 8, 8),
      status: 'Rest',
      isCompleted: false,
      totalExercises: 0,
      completedExercises: 0,
      totalSets: 0,
      completedSets: 0,
      plannedVolume: 0,
      route: '/days/day-rest',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: TodayWorkoutCard(
            workout: workout,
            currentStreak: 4,
            unit: WeightUnit.kg,
            onOpen: () => openCount++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Saturday'));
    await tester.pump();

    expect(openCount, 0);
    expect(find.text('Rest'), findsOneWidget);
  });
}
