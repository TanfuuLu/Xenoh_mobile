import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/models/paged_result.dart';
import 'package:xenoh_mobile/features/coach_client/domain/client_today_workout_resolver.dart';
import 'package:xenoh_mobile/features/training/domain/entities/daily_workout.dart';
import 'package:xenoh_mobile/features/training/domain/entities/weekly_workout.dart';
import 'package:xenoh_mobile/features/training/domain/repositories/training_repository.dart';

class _MockTrainingRepository extends Mock implements TrainingRepository {}

void main() {
  test('resolves today from the active plan week and day', () async {
    final repository = _MockTrainingRepository();
    when(
      () => repository.getWeeks(
        'plan-1',
        pageNumber: 1,
        pageSize: 100,
      ),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [_week('week-1', DateTime(2026, 8, 3), DateTime(2026, 8, 9))],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 1,
        hasMore: false,
      ),
    );
    when(
      () => repository.getDays(
        'week-1',
        pageNumber: 1,
        pageSize: 100,
      ),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [
          _day('day-1', DateTime(2026, 8, 3)),
          _day('day-2', DateTime(2026, 8, 4)),
        ],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 2,
        hasMore: false,
      ),
    );

    final result = await resolveClientTodayWorkout(
      repository: repository,
      planId: 'plan-1',
      today: DateTime(2026, 8, 4, 14),
    );

    expect(result?.weekId, 'week-1');
    expect(result?.dayId, 'day-2');
  });

  test('falls back to the latest started week and its first day', () async {
    final repository = _MockTrainingRepository();
    when(
      () => repository.getWeeks(
        'plan-1',
        pageNumber: 1,
        pageSize: 100,
      ),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [
          _week('week-1', DateTime(2026, 7, 20), DateTime(2026, 7, 26)),
          _week('week-2', DateTime(2026, 7, 27), DateTime(2026, 8, 2)),
        ],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 2,
        hasMore: false,
      ),
    );
    when(
      () => repository.getDays(
        'week-2',
        pageNumber: 1,
        pageSize: 100,
      ),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [
          _day('later', DateTime(2026, 7, 29)),
          _day('first', DateTime(2026, 7, 27)),
        ],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 2,
        hasMore: false,
      ),
    );

    final result = await resolveClientTodayWorkout(
      repository: repository,
      planId: 'plan-1',
      today: DateTime(2026, 8, 3),
    );

    expect(result?.weekId, 'week-2');
    expect(result?.dayId, 'first');
  });

  test('returns null when the active plan has no weeks', () async {
    final repository = _MockTrainingRepository();
    when(
      () => repository.getWeeks(
        'plan-1',
        pageNumber: 1,
        pageSize: 100,
      ),
    ).thenAnswer(
      (_) async => const PagedResult(
        items: [],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 0,
        hasMore: false,
      ),
    );

    final result = await resolveClientTodayWorkout(
      repository: repository,
      planId: 'plan-1',
      today: DateTime(2026, 8, 3),
    );

    expect(result, isNull);
  });
}

WeeklyWorkout _week(String id, DateTime start, DateTime end) => WeeklyWorkout(
  id: id,
  weekNumber: 1,
  name: 'Week',
  startDate: start,
  endDate: end,
  planId: 'plan-1',
  totalDays: 2,
  completedDays: 0,
  hasWarning: false,
  isCompleted: false,
);

DailyWorkout _day(String id, DateTime date) => DailyWorkout(
  id: id,
  date: date,
  dayOfWeek: 'Monday',
  isCompleted: false,
  weeklyWorkoutId: 'week-1',
  totalExercises: 1,
  completedExercises: 0,
  hasWarning: false,
  status: 'Normal',
);
