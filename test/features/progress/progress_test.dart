import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/features/progress/data/datasources/progress_remote_data_source.dart';
import 'package:xenoh_mobile/features/progress/data/dtos/exercise_pr_dto.dart';
import 'package:xenoh_mobile/features/progress/data/repositories/progress_repository_impl.dart';
import 'package:xenoh_mobile/features/progress/data/repositories/progress_repository_provider.dart';
import 'package:xenoh_mobile/features/progress/domain/entities/exercise_pr.dart';
import 'package:xenoh_mobile/features/progress/domain/entities/plan_analytics.dart';
import 'package:xenoh_mobile/features/progress/domain/repositories/progress_repository.dart';
import 'package:xenoh_mobile/features/progress/presentation/providers/progress_controllers.dart';
import 'package:xenoh_mobile/features/progress/presentation/screens/plan_analytics_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockProgressRepository extends Mock implements ProgressRepository {}

class MockProgressRemoteDataSource extends Mock
    implements ProgressRemoteDataSource {}

PlanAnalytics _analytics() => const PlanAnalytics(
  totalWorkoutsCompleted: 12,
  totalVolume: 42000,
  consistencyPercent: 80,
  avgSessionsPerWeek: 3.5,
  completedSets: 120,
  highRpeSets: 8,
  warningDays: 1,
  totalDurationSeconds: 7200,
  trainingScore: 78,
  insights: [],
  weeklyCompliance: [],
  weeklyVolume: [],
  muscleGroupVolume: [],
);

ProviderContainer _container(ProgressRepository repo) {
  final container = ProviderContainer(
    overrides: [progressRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('exercisePrsProvider loads the personal records', () async {
    final repo = MockProgressRepository();
    when(repo.getExercisePrs).thenAnswer(
      (_) async => [
        ExercisePr(
          exerciseTemplateId: 't1',
          exerciseName: 'Squat',
          currentWeight: 180,
          reps: 1,
          achievedAt: DateTime(2026, 5, 1),
        ),
      ],
    );

    final container = _container(repo);
    final prs = await container.read(exercisePrsProvider.future);

    expect(prs.single.exerciseName, 'Squat');
    expect(prs.single.currentWeight, 180);
  });

  test('planAnalyticsProvider returns analytics for Pro users', () async {
    final repo = MockProgressRepository();
    when(
      () => repo.getPlanAnalytics('p1'),
    ).thenAnswer((_) async => _analytics());

    final container = _container(repo);
    final result = await container.read(planAnalyticsProvider('p1').future);

    expect(result.trainingScore, 78);
    expect(result.totalDuration, const Duration(hours: 2));
  });

  test(
    'repository maps a 403 analytics response to ForbiddenFailure',
    () async {
      final remote = MockProgressRemoteDataSource();
      when(() => remote.getPlanAnalytics('p1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/plans/p1/analytics'),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/plans/p1/analytics'),
            statusCode: 403,
            data: const {'message': 'Pro required.'},
          ),
        ),
      );

      final repo = ProgressRepositoryImpl(remote);

      await expectLater(
        repo.getPlanAnalytics('p1'),
        throwsA(
          isA<ForbiddenFailure>().having(
            (f) => f.message,
            'message',
            'Pro required.',
          ),
        ),
      );
    },
  );

  test('repository sorts PR history oldest → newest', () async {
    final remote = MockProgressRemoteDataSource();
    when(() => remote.getExercisePrHistory('t1')).thenAnswer(
      (_) async => [
        ExercisePrPointDto(
          weight: 100,
          reps: 5,
          achievedAt: DateTime(2026, 3, 10),
        ),
        ExercisePrPointDto(
          weight: 90,
          reps: 5,
          achievedAt: DateTime(2026, 1, 5),
        ),
        ExercisePrPointDto(
          weight: 110,
          reps: 3,
          achievedAt: DateTime(2026, 5, 20),
        ),
      ],
    );

    final repo = ProgressRepositoryImpl(remote);
    final history = await repo.getExercisePrHistory('t1');

    expect(
      history.map((p) => p.weight).toList(),
      [90, 100, 110],
    );
  });

  testWidgets('analytics insight content uses Vietnamese fallbacks', (
    tester,
  ) async {
    final analytics = _analytics().copyWith(
      insights: const [
        TrainingInsight(
          type: 'RepeatWeek',
          severity: 'Critical',
          title: 'Repeat or simplify the week',
          message:
              'The current load may be too much. Reduce friction, repeat key sessions, and rebuild consistency.',
          metricLabel: 'Training stress',
          metricValue: '50',
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('vi'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: PlanAnalyticsView(
              analytics: analytics,
              unit: WeightUnit.kg,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Lặp lại hoặc đơn giản hóa tuần tập'), findsOneWidget);
    expect(find.text('Căng thẳng tập luyện: 50'), findsOneWidget);
    expect(find.text('Repeat or simplify the week'), findsNothing);
  });
}
