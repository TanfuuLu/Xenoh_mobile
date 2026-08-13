import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/features/community/domain/entities/community_models.dart';
import 'package:xenoh_mobile/features/community/presentation/widgets/community_widgets.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/preferences_provider.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('shows the exercises that were trained and hides skipped ones', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [weightUnitProvider.overrideWithValue(WeightUnit.kg)],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: TrainingDayShareCard(
                share: _share(),
                onUserTap: () {},
                onLoveToggle: () {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Bench Press'), findsOneWidget);
    expect(find.text('Cable Row'), findsOneWidget);
    expect(find.text('Skipped Curl'), findsNothing);
    expect(find.text('2/3 Sets'), findsOneWidget);
    expect(find.text('1/2 Sets'), findsOneWidget);
  });
}

TrainingDayShare _share() => TrainingDayShare(
  id: 'share-1',
  userId: 'user-1',
  userFullName: 'Demo Athlete',
  sourceDailyWorkoutId: 'workout-1',
  workoutDate: DateTime(2026, 8, 9),
  dayOfWeek: 'Sunday',
  dayStatus: 'Completed',
  exerciseCount: 3,
  completedSets: 3,
  totalVolume: 1250,
  totalDurationSeconds: 3600,
  hasPersonalRecord: false,
  loveCount: 0,
  lovedByCurrentUser: false,
  createdAt: DateTime(2026, 8, 9),
  exercises: [
    _exercise(
      id: 'row',
      name: 'Cable Row',
      sortOrder: 2,
      completedSets: 1,
      totalSets: 2,
    ),
    _exercise(
      id: 'bench',
      name: 'Bench Press',
      sortOrder: 1,
      completedSets: 2,
      totalSets: 3,
    ),
    _exercise(
      id: 'curl',
      name: 'Skipped Curl',
      sortOrder: 3,
      completedSets: 0,
      totalSets: 3,
      isSkipped: true,
    ),
  ],
);

TrainingDayShareExercise _exercise({
  required String id,
  required String name,
  required int sortOrder,
  required int completedSets,
  required int totalSets,
  bool isSkipped = false,
}) => TrainingDayShareExercise(
  id: id,
  name: name,
  primaryMuscleGroup: 'Upper body',
  exerciseKind: 'Strength',
  sortOrder: sortOrder,
  isSkipped: isSkipped,
  isPersonalRecord: false,
  sets: [
    for (var index = 0; index < totalSets; index++)
      TrainingDayShareSet(
        id: '$id-set-$index',
        setNumber: index + 1,
        isCompleted: index < completedSets,
      ),
  ],
);
