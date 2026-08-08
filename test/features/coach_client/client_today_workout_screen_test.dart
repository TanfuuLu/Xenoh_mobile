import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/models/paged_result.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/client_today_workout_screen.dart';
import 'package:xenoh_mobile/features/training/data/repositories/training_repository_provider.dart';
import 'package:xenoh_mobile/features/training/domain/entities/daily_workout.dart';
import 'package:xenoh_mobile/features/training/domain/entities/weekly_workout.dart';
import 'package:xenoh_mobile/features/training/domain/repositories/training_repository.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockTrainingRepository extends Mock implements TrainingRepository {}

void main() {
  test('coach day location keeps the selected client scope', () {
    expect(
      ClientTodayWorkoutScreen.coachDayLocation(
        dayId: 'day-1',
        clientId: 'client-1',
      ),
      '/days/day-1?coachView=true&clientId=client-1',
    );
  });

  testWidgets('resolves the client plan and opens the coach day view', (
    tester,
  ) async {
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
          WeeklyWorkout(
            id: 'week-1',
            weekNumber: 1,
            name: 'Week 1',
            startDate: DateTime(2026, 8, 3),
            endDate: DateTime(2026, 8, 9),
            planId: 'plan-1',
            totalDays: 1,
            completedDays: 0,
            hasWarning: false,
            isCompleted: false,
          ),
        ],
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
          DailyWorkout(
            id: 'day-1',
            date: DateTime.now(),
            dayOfWeek: 'Monday',
            isCompleted: false,
            weeklyWorkoutId: 'week-1',
            totalExercises: 1,
            completedExercises: 0,
            hasWarning: false,
            status: 'Normal',
          ),
        ],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 1,
        hasMore: false,
      ),
    );
    String? resolvedDay;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trainingRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ClientTodayWorkoutScreen(
            clientId: 'client-1',
            planId: 'plan-1',
            onResolved: (dayId) => resolvedDay = dayId,
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(resolvedDay, 'day-1');
  });

  testWidgets('shows an empty state when no active plan was provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ClientTodayWorkoutScreen(
            clientId: 'client-1',
            planId: '',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(ClientTodayWorkoutScreen.emptyStateKey), findsOneWidget);
  });
}
