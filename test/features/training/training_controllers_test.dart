import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/models/paged_result.dart';
import 'package:xenoh_mobile/features/training/data/repositories/training_repository_provider.dart';
import 'package:xenoh_mobile/features/training/domain/entities/daily_workout.dart';
import 'package:xenoh_mobile/features/training/domain/entities/exercise.dart';
import 'package:xenoh_mobile/features/training/domain/entities/exercise_template.dart';
import 'package:xenoh_mobile/features/training/domain/entities/plan.dart';
import 'package:xenoh_mobile/features/training/domain/repositories/training_repository.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/days_controller.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/exercise_templates_controller.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/exercises_controller.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/plans_controller.dart';

class MockTrainingRepository extends Mock implements TrainingRepository {}

Plan _plan(String id, {bool active = false}) => Plan(
  id: id,
  name: 'Plan $id',
  startDate: DateTime(2026, 6),
  endDate: DateTime(2026, 8),
  planType: 'Self',
  ownerName: 'Ada',
  totalWeeks: 8,
  completedWeeks: 1,
  totalDays: 40,
  completedDays: 10,
  isActive: active,
);

PagedResult<Plan> _page(List<Plan> items, {bool hasMore = false}) =>
    PagedResult(
      items: items,
      pageNumber: 1,
      pageSize: 20,
      totalCount: items.length,
      hasMore: hasMore,
    );

const _set = ExerciseSet(
  id: 's1',
  setNumber: 1,
  plannedReps: 5,
  isCompleted: false,
);

Exercise _exercise({
  required bool completed,
  String id = 'e1',
  String name = 'Squat',
  int sortOrder = 0,
  ExerciseSet? set,
  DateTime? startedAtUtc,
  DateTime? endedAtUtc,
  int? durationSeconds,
}) => Exercise(
  id: id,
  exerciseTemplateId: 't1',
  name: name,
  primaryMuscleGroup: 'Quads',
  exerciseKind: 'Strength',
  plannedSets: 1,
  plannedReps: 5,
  completedSetsCount: completed ? 1 : 0,
  isCompleted: completed,
  isSkipped: false,
  dailyWorkoutId: 'd1',
  sortOrder: sortOrder,
  sets: [set ?? _set],
  startedAtUtc: startedAtUtc,
  endedAtUtc: endedAtUtc,
  durationSeconds: durationSeconds,
);

DailyWorkout _day(String id, {String status = 'Normal'}) => DailyWorkout(
  id: id,
  date: DateTime(2026, 6, 7),
  dayOfWeek: 'Monday',
  isCompleted: false,
  weeklyWorkoutId: 'w1',
  totalExercises: 2,
  completedExercises: 0,
  hasWarning: false,
  status: status,
);

PagedResult<DailyWorkout> _daysPage(List<DailyWorkout> items) => PagedResult(
  items: items,
  pageNumber: 1,
  pageSize: 100,
  totalCount: items.length,
  hasMore: false,
);

ExerciseTemplate _template(String id, {bool custom = true}) => ExerciseTemplate(
  id: id,
  name: 'Template $id',
  primaryMuscleGroup: 'Chest',
  exerciseKind: 'Strength',
  isCustom: custom,
);

ProviderContainer _container(TrainingRepository repo) {
  final container = ProviderContainer(
    overrides: [trainingRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('PlansController loads the first page of plans', () async {
    final repo = MockTrainingRepository();
    when(
      () => repo.getPlans(pageNumber: 1, pageSize: 20),
    ).thenAnswer((_) async => _page([_plan('1'), _plan('2', active: true)]));

    final container = _container(repo);
    final plans = await container.read(plansControllerProvider.future);

    expect(plans, hasLength(2));
    expect(plans.last.isActive, isTrue);
  });

  test('markSetComplete patches the exercise in place', () async {
    final repo = MockTrainingRepository();
    when(
      () => repo.getExercisesByDay('d1'),
    ).thenAnswer((_) async => [_exercise(completed: false)]);
    when(
      () => repo.markSetComplete(
        any(),
        actualReps: any(named: 'actualReps'),
        actualWeight: any(named: 'actualWeight'),
        rpe: any(named: 'rpe'),
      ),
    ).thenAnswer(
      (_) async => _exercise(
        completed: true,
        set: _set.copyWith(isCompleted: true, actualReps: 5),
      ),
    );

    final container = _container(repo);
    final sub = container.listen(
      exercisesControllerProvider('d1'),
      (_, _) {},
    );
    addTearDown(sub.close);

    await container.read(exercisesControllerProvider('d1').future);
    await container
        .read(exercisesControllerProvider('d1').notifier)
        .markSetComplete('s1', actualReps: 5, actualWeight: 100, rpe: 8);

    final exercises = sub.read().value!;
    expect(exercises.single.isCompleted, isTrue);
    expect(exercises.single.sets.single.isCompleted, isTrue);
  });

  test(
    'updateSetPlan patches planned reps and weight without completing',
    () async {
      final repo = MockTrainingRepository();
      when(
        () => repo.getExercisesByDay('d1'),
      ).thenAnswer((_) async => [_exercise(completed: false)]);
      when(
        () => repo.updateSetPlan(
          's1',
          plannedReps: 6,
          plannedWeight: 102.5,
        ),
      ).thenAnswer(
        (_) async => _exercise(
          completed: false,
          set: _set.copyWith(plannedReps: 6, plannedWeight: 102.5),
        ),
      );

      final container = _container(repo);
      await container.read(exercisesControllerProvider('d1').future);
      await container
          .read(exercisesControllerProvider('d1').notifier)
          .updateSetPlan('s1', plannedReps: 6, plannedWeight: 102.5);

      final updated = container.read(exercisesControllerProvider('d1')).value!;
      expect(updated.single.sets.single.plannedReps, 6);
      expect(updated.single.sets.single.plannedWeight, 102.5);
      expect(updated.single.sets.single.isCompleted, isFalse);
    },
  );

  test('duplicatePlan delegates and refreshes the plan list', () async {
    final repo = MockTrainingRepository();
    when(
      () => repo.getPlans(pageNumber: 1, pageSize: 20),
    ).thenAnswer((_) async => _page([_plan('1')]));
    when(
      () => repo.duplicatePlan(
        sourcePlanId: '1',
        name: 'Copy',
        startDate: DateTime(2026, 7),
        endDate: DateTime(2026, 9),
      ),
    ).thenAnswer((_) async => _plan('2'));

    final container = _container(repo);
    await container.read(plansControllerProvider.future);
    final copied = await container
        .read(plansControllerProvider.notifier)
        .duplicatePlan(
          sourcePlanId: '1',
          name: 'Copy',
          startDate: DateTime(2026, 7),
          endDate: DateTime(2026, 9),
        );

    expect(copied.id, '2');
    verify(() => repo.getPlans(pageNumber: 1, pageSize: 20)).called(2);
  });

  test('DaysController copies a day then refreshes', () async {
    final repo = MockTrainingRepository();
    when(
      () => repo.getDays('w1', pageNumber: 1, pageSize: 100),
    ).thenAnswer((_) async => _daysPage([_day('d1'), _day('d2')]));
    when(
      () => repo.copyDay(
        sourceDailyWorkoutId: 'd1',
        targetDailyWorkoutId: 'd2',
      ),
    ).thenAnswer((_) async => 3);

    final container = _container(repo);
    await container.read(daysControllerProvider('w1').future);
    final copied = await container
        .read(daysControllerProvider('w1').notifier)
        .copyDay(sourceDailyWorkoutId: 'd1', targetDailyWorkoutId: 'd2');

    expect(copied, 3);
    verify(() => repo.getDays('w1', pageNumber: 1, pageSize: 100)).called(2);
  });

  test('ExercisesController reorders and patches timer updates', () async {
    final repo = MockTrainingRepository();
    final first = _exercise(completed: false, id: 'e1', sortOrder: 0);
    final second = _exercise(
      completed: false,
      id: 'e2',
      name: 'Bench',
      sortOrder: 1,
    );
    when(
      () => repo.getExercisesByDay('d1'),
    ).thenAnswer((_) async => [first, second]);
    when(
      () => repo.reorderExercises(
        dailyWorkoutId: 'd1',
        exerciseIds: ['e2', 'e1'],
      ),
    ).thenAnswer((_) async => [second, first]);
    when(() => repo.startExerciseTimer('e2')).thenAnswer(
      (_) async => second.copyWith(startedAtUtc: DateTime(2026, 6, 7, 10)),
    );

    final container = _container(repo);
    final sub = container.listen(exercisesControllerProvider('d1'), (_, _) {});
    addTearDown(sub.close);

    await container.read(exercisesControllerProvider('d1').future);
    await container.read(exercisesControllerProvider('d1').notifier).reorder([
      'e2',
      'e1',
    ]);
    await container
        .read(exercisesControllerProvider('d1').notifier)
        .startTimer('e2');

    final exercises = sub.read().value!;
    expect(exercises.first.id, 'e2');
    expect(exercises.first.isTimerRunning, isTrue);
  });

  test(
    'ExerciseTemplatesController deletes a custom template in place',
    () async {
      final repo = MockTrainingRepository();
      when(
        () => repo.getExerciseTemplates(muscleGroup: null, clientId: null),
      ).thenAnswer((_) async => [_template('t1'), _template('t2')]);
      when(
        () => repo.deleteCustomExerciseTemplate('t1'),
      ).thenAnswer((_) async {});

      final container = _container(repo);
      final sub = container.listen(
        exerciseTemplatesControllerProvider(),
        (_, _) {},
      );
      addTearDown(sub.close);

      await container.read(exerciseTemplatesControllerProvider().future);
      await container
          .read(exerciseTemplatesControllerProvider().notifier)
          .deleteCustom('t1');

      final templates = sub.read().value!;
      expect(templates.map((t) => t.id), ['t2']);
    },
  );

  test(
    'ExerciseTemplatesController creates a client-scoped template in place',
    () async {
      final repo = MockTrainingRepository();
      final created = _template(
        'client-template',
      ).copyWith(primaryMuscleGroup: 'Quads');
      when(
        () => repo.getExerciseTemplates(
          muscleGroup: 'Quads',
          clientId: 'client-1',
        ),
      ).thenAnswer((_) async => const []);
      when(
        () => repo.createCustomExerciseTemplate(
          name: 'Client squat',
          primaryMuscleGroup: 'Quads',
          secondaryMuscleGroups: const [],
          exerciseKind: 'Strength',
          description: null,
          clientId: 'client-1',
        ),
      ).thenAnswer((_) async => created);

      final container = _container(repo);
      final provider = exerciseTemplatesControllerProvider(
        muscleGroup: 'Quads',
        clientId: 'client-1',
      );
      final sub = container.listen(provider, (_, _) {});
      addTearDown(sub.close);

      await container.read(provider.future);
      await container
          .read(provider.notifier)
          .createCustom(
            name: 'Client squat',
            primaryMuscleGroup: 'Quads',
            secondaryMuscleGroups: const [],
            exerciseKind: 'Strength',
          );

      expect(sub.read().value, [created]);
      verify(
        () => repo.createCustomExerciseTemplate(
          name: 'Client squat',
          primaryMuscleGroup: 'Quads',
          secondaryMuscleGroups: const [],
          exerciseKind: 'Strength',
          description: null,
          clientId: 'client-1',
        ),
      ).called(1);
    },
  );

  test(
    'created templates do not leak into a different muscle filter',
    () async {
      final repo = MockTrainingRepository();
      final created = _template('chest-template');
      when(
        () => repo.getExerciseTemplates(
          muscleGroup: 'Quads',
          clientId: 'client-1',
        ),
      ).thenAnswer((_) async => const []);
      when(
        () => repo.createCustomExerciseTemplate(
          name: 'Chest press',
          primaryMuscleGroup: 'Chest',
          secondaryMuscleGroups: const [],
          exerciseKind: 'Strength',
          description: null,
          clientId: 'client-1',
        ),
      ).thenAnswer((_) async => created);

      final container = _container(repo);
      final provider = exerciseTemplatesControllerProvider(
        muscleGroup: 'Quads',
        clientId: 'client-1',
      );
      final sub = container.listen(provider, (_, _) {});
      addTearDown(sub.close);

      await container.read(provider.future);
      await container
          .read(provider.notifier)
          .createCustom(
            name: 'Chest press',
            primaryMuscleGroup: 'Chest',
            secondaryMuscleGroups: const [],
            exerciseKind: 'Strength',
          );

      expect(sub.read().value, isEmpty);
    },
  );
}
