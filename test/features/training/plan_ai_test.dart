import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/plan_ai_review_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockXenohApi extends Mock implements XenohApi {}

DioException _dio(int status) => DioException(
  requestOptions: RequestOptions(path: '/x'),
  response: Response(
    requestOptions: RequestOptions(path: '/x'),
    statusCode: status,
  ),
);

void main() {
  testWidgets('balance check renders headline, summary, and warnings', (
    tester,
  ) async {
    final api = MockXenohApi();
    when(() => api.postObject(any(), any())).thenAnswer(
      (_) async => {
        'headline': 'Push-dominant week',
        'severity': 'Warning',
        'summary': 'Your plan favors pressing over pulling.',
        'warnings': ['Back volume is low'],
        'suggestions': ['Add a row variation'],
      },
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlanBalanceCheckScreen(planId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Push-dominant week'), findsOneWidget);
    expect(
      find.text('Your plan favors pressing over pulling.'),
      findsOneWidget,
    );
    expect(find.text('Back volume is low'), findsOneWidget);
    expect(find.text('Add a row variation'), findsOneWidget);
  });

  testWidgets('403 shows the Pro upgrade prompt, not a generic error', (
    tester,
  ) async {
    final api = MockXenohApi();
    when(() => api.postObject(any(), any())).thenThrow(_dio(403));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlanBalanceCheckScreen(planId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pro feature'), findsOneWidget);
    expect(find.text('Upgrade to Pro'), findsOneWidget);
  });

  testWidgets('429 shows the AI quota notice', (tester) async {
    final api = MockXenohApi();
    when(() => api.postObject(any(), any())).thenThrow(_dio(429));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlanBalanceCheckScreen(planId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI limit reached'), findsOneWidget);
  });

  testWidgets(
    'design analysis renders movement coverage and variety response',
    (
      tester,
    ) async {
      final api = MockXenohApi();
      when(() => api.getObject(any())).thenAnswer(
        (_) async => {
          'structure': {
            'totalWeeks': 8,
            'plannedTrainingDays': 32,
            'plannedRestDays': 24,
            'avgTrainingDaysPerWeek': 4,
            'longestTrainingStreak': 3,
          },
          'workload': {
            'plannedExercises': 96,
            'plannedSets': 320,
            'plannedRepVolume': 2400,
            'plannedTonnage': 48000,
            'avgExercisesPerTrainingDay': 3,
          },
          'muscleGroups': <dynamic>[],
          'balance': {
            'dominantMuscleGroups': <String>[],
            'undertrainedMajorMuscleGroups': <String>[],
          },
          'movementPatterns': [
            {
              'pattern': 'Hinge',
              'isCovered': true,
              'exerciseCount': 2,
              'plannedSets': 12,
            },
            {
              'pattern': 'Carry',
              'isCovered': false,
              'exerciseCount': 0,
              'plannedSets': 0,
            },
          ],
          'recoveryRisks': [
            {
              'type': 'Training streak',
              'severity': 'medium',
              'message': 'Three demanding days are adjacent.',
              'metric': '3 days',
            },
          ],
          'variety': {
            'uniqueExercises': 18,
            'repeatedExerciseCount': 2,
            'topRepeatedExercises': [
              {'exerciseName': 'Back squat', 'count': 4},
            ],
          },
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [xenohApiProvider.overrideWithValue(api)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: PlanDesignAnalysisScreen(planId: 'p1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Hinge'), findsOneWidget);
      expect(find.text('Carry'), findsOneWidget);
      expect(find.text('Back squat'), findsOneWidget);
      expect(find.textContaining('3 days'), findsOneWidget);
    },
  );

  testWidgets('plan progress screen renders the new trajectory response', (
    tester,
  ) async {
    final api = MockXenohApi();
    when(() => api.getObject(any())).thenAnswer(
      (_) async => {
        'language': 'en',
        'planName': 'Strength block',
        'generatedAt': '2026-08-02T08:00:00Z',
        'headline': 'Momentum is improving',
        'trajectory': 'improving',
        'summary': 'Completion and volume are trending upward.',
        'whatsWorking': ['Consistent main lifts'],
        'focusAreas': ['Sleep consistency'],
        'nextBlock': ['Add 2.5 kg to squat'],
      },
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlanProgressInsightScreen(planId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Momentum is improving'), findsOneWidget);
    expect(find.text('Consistent main lifts'), findsOneWidget);
    expect(find.text('Sleep consistency'), findsOneWidget);
    expect(find.text('Add 2.5 kg to squat'), findsOneWidget);
  });
}
