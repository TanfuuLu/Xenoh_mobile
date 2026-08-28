import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/core/models/paged_result.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/core/widgets/exercise_thumbnail.dart';
import 'package:xenoh_mobile/core/widgets/synced_background_card.dart';
import 'package:xenoh_mobile/core/widgets/xn_card.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_controller.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_state.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/preferences_provider.dart';
import 'package:xenoh_mobile/features/progress/presentation/providers/progress_controllers.dart';
import 'package:xenoh_mobile/features/training/data/repositories/training_repository_provider.dart';
import 'package:xenoh_mobile/features/training/domain/entities/daily_workout.dart';
import 'package:xenoh_mobile/features/training/domain/entities/exercise.dart';
import 'package:xenoh_mobile/features/training/domain/entities/exercise_template.dart';
import 'package:xenoh_mobile/features/training/domain/entities/last_exercise_performance.dart';
import 'package:xenoh_mobile/features/training/domain/entities/plan.dart';
import 'package:xenoh_mobile/features/training/domain/entities/weekly_workout.dart';
import 'package:xenoh_mobile/features/training/domain/repositories/training_repository.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/cycle_day_markers_provider.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/exercises_controller.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/day_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/exercise_library_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/plan_detail_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/plans_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/week_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/create_plan_sheet.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/exercise_template_form_sheet.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/exercise_template_picker_sheet.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/plan_card.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/workout_result_view.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockTrainingRepository extends Mock implements TrainingRepository {}

/// Auth controller that resolves to unauthenticated without any network call,
/// so widgets that watch auth don't hit the real session restore in tests.
class _NoNetworkAuthController extends AuthController {
  @override
  AuthState build() => const AuthState.unauthenticated();
}

class _CoachAuthController extends AuthController {
  @override
  AuthState build() => const AuthState.authenticated(
    AuthSession(
      user: User(
        id: 'coach-1',
        email: 'coach@example.com',
        fullName: 'Coach',
        roles: ['Coach'],
      ),
      accessToken: 'test-token',
    ),
  );
}

class _TestWeightUnitController extends Notifier<WeightUnit> {
  @override
  WeightUnit build() => WeightUnit.kg;

  WeightUnit get unit => state;

  set unit(WeightUnit value) => state = value;
}

final _testWeightUnitProvider =
    NotifierProvider<_TestWeightUnitController, WeightUnit>(
      _TestWeightUnitController.new,
    );

Plan _plan(String id) => Plan(
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
  isActive: false,
);

DailyWorkout _day(String id, int day, {String status = 'Normal'}) =>
    DailyWorkout(
      id: id,
      date: DateTime(2026, 6, day),
      dayOfWeek: 'Monday',
      isCompleted: false,
      weeklyWorkoutId: 'w1',
      totalExercises: 2,
      completedExercises: 0,
      hasWarning: false,
      status: status,
    );

Widget _app(Widget child, {TrainingRepository? repo}) {
  final scope = ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(_NoNetworkAuthController.new),
      if (repo != null) trainingRepositoryProvider.overrideWithValue(repo),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
  return scope;
}

void main() {
  testWidgets('day sets expose planned editing and previous performance', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final repo = MockTrainingRepository();
    const exerciseName = 'Barbell High Bar Back Squat With Controlled Tempo';
    const set = ExerciseSet(
      id: 'set-1',
      setNumber: 1,
      plannedReps: 5,
      plannedWeight: 100,
      isCompleted: false,
    );
    const exercise = Exercise(
      id: 'exercise-1',
      exerciseTemplateId: 'template-1',
      name: exerciseName,
      primaryMuscleGroup: 'Quadriceps',
      exerciseKind: 'Strength',
      plannedSets: 1,
      plannedReps: 5,
      completedSetsCount: 0,
      isCompleted: false,
      isSkipped: false,
      dailyWorkoutId: 'day-1',
      sortOrder: 0,
      notes: 'Keep chest tall',
      sets: [set],
    );
    when(
      () => repo.getExercisesByDay('day-1'),
    ).thenAnswer((_) async => [exercise]);
    when(
      () => repo.getLastExercisePerformance(
        exerciseTemplateId: 'template-1',
        dailyWorkoutId: 'day-1',
      ),
    ).thenAnswer(
      (_) async => LastExercisePerformance(
        exerciseTemplateId: 'template-1',
        lastActualWeight: 97.5,
        lastActualReps: 5,
        lastRpe: 8,
        workoutDate: DateTime(2026, 7, 27),
      ),
    );
    when(
      () => repo.updateSetPlan(
        'set-1',
        plannedReps: 6,
        plannedWeight: 102.5,
      ),
    ).thenAnswer(
      (_) async => exercise.copyWith(
        plannedReps: 6,
        sets: [set.copyWith(plannedReps: 6, plannedWeight: 102.5)],
      ),
    );

    await tester.pumpWidget(_app(const DayScreen(dayId: 'day-1'), repo: repo));
    await tester.pumpAndSettle();

    final exerciseNameText = tester.widget<Text>(find.text(exerciseName));
    expect(exerciseNameText.maxLines, isNull);
    expect(exerciseNameText.overflow, isNot(TextOverflow.ellipsis));
    expect(exerciseNameText.style?.fontSize, 20);
    expect(
      tester.getTopLeft(find.text('Keep chest tall')).dy,
      greaterThan(tester.getTopLeft(find.text(exerciseName)).dy),
    );
    expect(
      tester.getTopLeft(find.text('Keep chest tall')).dy,
      lessThan(tester.getTopLeft(find.text('Quadriceps')).dy),
    );
    expect(
      tester.getTopLeft(find.text('Quadriceps')).dx,
      greaterThan(
        tester.getTopRight(find.byType(ExerciseThumbnail)).dx,
      ),
    );
    expect(find.textContaining('Last time: 97.5 kg'), findsOneWidget);
    expect(find.byTooltip('Edit exercise'), findsNothing);
    expect(find.byIcon(Icons.more_vert_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.more_vert_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Edit exercise'), findsOneWidget);
    expect(find.text('Skip or unskip exercise'), findsOneWidget);
    expect(find.text('Delete exercise'), findsOneWidget);

    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit set target'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Planned reps'),
      '6',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Planned weight'),
      '102.5',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verify(
      () => repo.updateSetPlan(
        'set-1',
        plannedReps: 6,
        plannedWeight: 102.5,
      ),
    ).called(1);
  });

  testWidgets('completed exercise shows a calorie estimate from its duration', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    const exercise = Exercise(
      id: 'exercise-1',
      exerciseTemplateId: 'template-1',
      name: 'Romanian Deadlift',
      primaryMuscleGroup: 'Hamstrings',
      exerciseKind: 'Strength',
      plannedSets: 3,
      plannedReps: 6,
      completedSetsCount: 3,
      isCompleted: true,
      isSkipped: false,
      dailyWorkoutId: 'day-1',
      sortOrder: 0,
      durationSeconds: 2400,
      sets: <ExerciseSet>[],
    );
    when(
      () => repo.getExercisesByDay('day-1'),
    ).thenAnswer((_) async => <Exercise>[exercise]);
    when(
      () => repo.getLastExercisePerformance(
        exerciseTemplateId: 'template-1',
        dailyWorkoutId: 'day-1',
      ),
    ).thenAnswer(
      (_) async => const LastExercisePerformance(
        exerciseTemplateId: 'template-1',
      ),
    );

    await tester.pumpWidget(_app(const DayScreen(dayId: 'day-1'), repo: repo));
    await tester.pumpAndSettle();

    expect(find.byType(WorkoutResultDialog), findsNothing);
    expect(find.text('40m'), findsWidgets);
    expect(find.text('~240 kcal'), findsOneWidget);
    expect(find.text('No est.'), findsNothing);
  });

  testWidgets(
    'training result stays hidden until every exercise is completed',
    (tester) async {
      final repo = MockTrainingRepository();
      const firstSet = ExerciseSet(
        id: 'set-1',
        setNumber: 1,
        plannedReps: 5,
        isCompleted: false,
      );
      const secondSet = ExerciseSet(
        id: 'set-2',
        setNumber: 1,
        plannedReps: 5,
        isCompleted: false,
      );
      const firstExercise = Exercise(
        id: 'exercise-1',
        exerciseTemplateId: 'template-1',
        name: 'Squat',
        primaryMuscleGroup: 'Quadriceps',
        exerciseKind: 'Strength',
        plannedSets: 1,
        plannedReps: 5,
        completedSetsCount: 0,
        isCompleted: false,
        isSkipped: false,
        dailyWorkoutId: 'day-1',
        sortOrder: 0,
        sets: [firstSet],
      );
      const skippedExercise = Exercise(
        id: 'exercise-2',
        exerciseTemplateId: 'template-2',
        name: 'Bench Press',
        primaryMuscleGroup: 'Chest',
        exerciseKind: 'Strength',
        plannedSets: 1,
        plannedReps: 5,
        completedSetsCount: 0,
        isCompleted: false,
        isSkipped: true,
        dailyWorkoutId: 'day-1',
        sortOrder: 1,
        sets: [secondSet],
      );
      final completedFirstExercise = firstExercise.copyWith(
        completedSetsCount: 1,
        isCompleted: true,
        sets: [firstSet.copyWith(isCompleted: true)],
      );
      final unskippedExercise = skippedExercise.copyWith(isSkipped: false);
      final completedSecondExercise = unskippedExercise.copyWith(
        completedSetsCount: 1,
        isCompleted: true,
        sets: [secondSet.copyWith(isCompleted: true)],
      );

      when(
        () => repo.getExercisesByDay('day-1'),
      ).thenAnswer((_) async => [firstExercise, skippedExercise]);
      when(
        () => repo.markSetComplete(
          'set-1',
          actualReps: 5,
          actualWeight: null,
          rpe: null,
        ),
      ).thenAnswer((_) async => completedFirstExercise);
      when(
        () => repo.skipExercise('exercise-2', isSkipped: false),
      ).thenAnswer((_) async => unskippedExercise);
      when(
        () => repo.markSetComplete(
          'set-2',
          actualReps: 5,
          actualWeight: null,
          rpe: null,
        ),
      ).thenAnswer((_) async => completedSecondExercise);

      await tester.pumpWidget(
        _app(const DayScreen(dayId: 'day-1'), repo: repo),
      );
      await tester.pumpAndSettle();

      final container = ProviderScope.containerOf(
        tester.element(find.byType(DayScreen)),
      );
      await container
          .read(exercisesControllerProvider('day-1').notifier)
          .markSetComplete('set-1', actualReps: 5);
      await tester.pumpAndSettle();

      expect(find.byType(WorkoutResultDialog), findsNothing);

      await container
          .read(exercisesControllerProvider('day-1').notifier)
          .skipExercise('exercise-2', isSkipped: false);
      await container
          .read(exercisesControllerProvider('day-1').notifier)
          .markSetComplete('set-2', actualReps: 5);
      await tester.pumpAndSettle();

      expect(find.byType(WorkoutResultDialog), findsOneWidget);
    },
  );

  testWidgets('disabled RPE tracking completes a set without RPE input', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    const set = ExerciseSet(
      id: 'set-1',
      setNumber: 1,
      plannedReps: 5,
      plannedWeight: 100,
      isCompleted: false,
    );
    const exercise = Exercise(
      id: 'exercise-1',
      exerciseTemplateId: 'template-1',
      name: 'Squat',
      primaryMuscleGroup: 'Quadriceps',
      exerciseKind: 'Strength',
      plannedSets: 1,
      plannedReps: 5,
      completedSetsCount: 0,
      isCompleted: false,
      isSkipped: false,
      dailyWorkoutId: 'day-1',
      sortOrder: 0,
      sets: [set],
    );
    final completed = exercise.copyWith(
      completedSetsCount: 1,
      sets: [
        set.copyWith(
          actualReps: 5,
          actualWeight: 100,
          isCompleted: true,
        ),
      ],
    );
    when(
      () => repo.getExercisesByDay('day-1'),
    ).thenAnswer((_) async => [exercise]);
    when(
      () => repo.getLastExercisePerformance(
        exerciseTemplateId: 'template-1',
        dailyWorkoutId: 'day-1',
      ),
    ).thenAnswer(
      (_) async => const LastExercisePerformance(
        exerciseTemplateId: 'template-1',
      ),
    );
    when(
      () => repo.markSetComplete(
        'set-1',
        actualReps: 5,
        actualWeight: 100,
        rpe: null,
      ),
    ).thenAnswer((_) async => completed);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_NoNetworkAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
          preferencesProvider.overrideWith(
            (ref) async => <String, dynamic>{
              'language': 'en',
              'theme': 'light',
              'weightUnit': 'kg',
              'trackRpe': false,
            },
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DayScreen(dayId: 'day-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNWidgets(2));
    await tester.tap(find.byTooltip('Mark done'));
    await tester.pumpAndSettle();

    expect(find.text('How hard was set 1?'), findsNothing);
    verify(
      () => repo.markSetComplete(
        'set-1',
        actualReps: 5,
        actualWeight: 100,
        rpe: null,
      ),
    ).called(1);
  });

  testWidgets(
    'coach can edit the client plan without workout completion controls',
    (tester) async {
      final repo = MockTrainingRepository();
      const set = ExerciseSet(
        id: 'set-1',
        setNumber: 1,
        plannedReps: 5,
        isCompleted: false,
      );
      const exercise = Exercise(
        id: 'exercise-1',
        exerciseTemplateId: 'template-1',
        name: 'Squat',
        primaryMuscleGroup: 'Quadriceps',
        exerciseKind: 'Strength',
        plannedSets: 1,
        plannedReps: 5,
        completedSetsCount: 0,
        isCompleted: false,
        isSkipped: false,
        dailyWorkoutId: 'day-1',
        sortOrder: 0,
        sets: [set],
      );
      when(
        () => repo.getExercisesByDay('day-1'),
      ).thenAnswer((_) async => [exercise]);
      when(
        () => repo.getLastExercisePerformance(
          exerciseTemplateId: 'template-1',
          dailyWorkoutId: 'day-1',
        ),
      ).thenAnswer(
        (_) async => const LastExercisePerformance(
          exerciseTemplateId: 'template-1',
        ),
      );

      await tester.pumpWidget(
        _app(
          const DayScreen(
            dayId: 'day-1',
            canComplete: false,
            clientId: 'client-1',
          ),
          repo: repo,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byTooltip('Complete all'), findsNothing);
      expect(find.byTooltip('Mark done'), findsNothing);
      expect(find.byTooltip('Exercise actions'), findsOneWidget);
      expect(find.byTooltip('Edit set target'), findsOneWidget);
      expect(find.text('Add exercise'), findsWidgets);
    },
  );

  testWidgets(
    'coach role blocks completion controls even without route flags',
    (
      tester,
    ) async {
      final repo = MockTrainingRepository();
      const exercise = Exercise(
        id: 'exercise-1',
        exerciseTemplateId: 'template-1',
        name: 'Deadlift',
        primaryMuscleGroup: 'Back',
        exerciseKind: 'Strength',
        plannedSets: 1,
        plannedReps: 3,
        completedSetsCount: 0,
        isCompleted: false,
        isSkipped: false,
        dailyWorkoutId: 'day-1',
        sortOrder: 0,
        sets: [
          ExerciseSet(
            id: 'set-1',
            setNumber: 1,
            plannedReps: 3,
            isCompleted: false,
          ),
        ],
      );
      when(
        () => repo.getExercisesByDay('day-1'),
      ).thenAnswer((_) async => [exercise]);
      when(
        () => repo.getLastExercisePerformance(
          exerciseTemplateId: 'template-1',
          dailyWorkoutId: 'day-1',
        ),
      ).thenAnswer(
        (_) async => const LastExercisePerformance(
          exerciseTemplateId: 'template-1',
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authControllerProvider.overrideWith(_CoachAuthController.new),
            trainingRepositoryProvider.overrideWithValue(repo),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DayScreen(dayId: 'day-1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byTooltip('Complete all'), findsNothing);
      expect(find.byTooltip('Mark done'), findsNothing);
      expect(find.text('Start'), findsNothing);
      expect(find.byTooltip('Edit set target'), findsOneWidget);
    },
  );

  testWidgets('client cannot add exercises to a coaching plan', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    const exercise = Exercise(
      id: 'exercise-1',
      exerciseTemplateId: 'template-1',
      name: 'Coach programmed squat',
      primaryMuscleGroup: 'Quadriceps',
      exerciseKind: 'Strength',
      plannedSets: 1,
      plannedReps: 5,
      completedSetsCount: 0,
      isCompleted: false,
      isSkipped: false,
      dailyWorkoutId: 'day-1',
      sortOrder: 0,
      sets: [],
    );
    when(
      () => repo.getExercisesByDay('day-1'),
    ).thenAnswer((_) async => [exercise]);
    when(
      () => repo.getLastExercisePerformance(
        exerciseTemplateId: 'template-1',
        dailyWorkoutId: 'day-1',
      ),
    ).thenAnswer(
      (_) async => const LastExercisePerformance(
        exerciseTemplateId: 'template-1',
      ),
    );

    await tester.pumpWidget(
      _app(
        const DayScreen(dayId: 'day-1', coachPlan: true),
        repo: repo,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Add exercise'), findsNothing);
    expect(find.byIcon(Icons.add_rounded), findsNothing);
  });

  testWidgets('client cannot add the first exercise to an empty coaching day', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    when(() => repo.getExercisesByDay('day-1')).thenAnswer((_) async => []);

    await tester.pumpWidget(
      _app(
        const DayScreen(dayId: 'day-1', coachPlan: true),
        repo: repo,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Add exercise'), findsNothing);
    expect(find.byIcon(Icons.add_rounded), findsNothing);
  });

  testWidgets('Vietnamese set label stays on one line', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repo = MockTrainingRepository();
    const set = ExerciseSet(
      id: 'set-12',
      setNumber: 12,
      plannedReps: 5,
      plannedWeight: 100,
      isCompleted: false,
    );
    const exercise = Exercise(
      id: 'exercise-1',
      exerciseTemplateId: 'template-1',
      name: 'Squat',
      primaryMuscleGroup: 'Đùi',
      exerciseKind: 'Strength',
      plannedSets: 1,
      plannedReps: 5,
      completedSetsCount: 0,
      isCompleted: false,
      isSkipped: false,
      dailyWorkoutId: 'day-1',
      sortOrder: 0,
      sets: [set],
    );
    when(
      () => repo.getExercisesByDay('day-1'),
    ).thenAnswer((_) async => [exercise]);
    when(
      () => repo.getLastExercisePerformance(
        exerciseTemplateId: 'template-1',
        dailyWorkoutId: 'day-1',
      ),
    ).thenAnswer(
      (_) async => const LastExercisePerformance(
        exerciseTemplateId: 'template-1',
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_NoNetworkAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          locale: Locale('vi'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DayScreen(dayId: 'day-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final label = tester.widget<Text>(find.text('Hiệp 12'));
    expect(label.maxLines, 1);
    expect(label.softWrap, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('set weight value updates when weight unit changes', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    const set = ExerciseSet(
      id: 'set-1',
      setNumber: 1,
      plannedReps: 5,
      plannedWeight: 100,
      isCompleted: false,
    );
    const exercise = Exercise(
      id: 'exercise-1',
      exerciseTemplateId: 'template-1',
      name: 'Squat',
      primaryMuscleGroup: 'Quadriceps',
      exerciseKind: 'Strength',
      plannedSets: 1,
      plannedReps: 5,
      completedSetsCount: 0,
      isCompleted: false,
      isSkipped: false,
      dailyWorkoutId: 'day-1',
      sortOrder: 0,
      sets: [set],
    );
    when(
      () => repo.getExercisesByDay('day-1'),
    ).thenAnswer((_) async => [exercise]);
    when(
      () => repo.getLastExercisePerformance(
        exerciseTemplateId: 'template-1',
        dailyWorkoutId: 'day-1',
      ),
    ).thenAnswer(
      (_) async => const LastExercisePerformance(
        exerciseTemplateId: 'template-1',
      ),
    );

    late ProviderContainer container;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_NoNetworkAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
          weightUnitProvider.overrideWith(
            (ref) => ref.watch(_testWeightUnitProvider),
          ),
        ],
        child: Builder(
          builder: (context) {
            container = ProviderScope.containerOf(context);
            return const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: DayScreen(dayId: 'day-1'),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('kg'), findsWidgets);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is TextField && widget.controller?.text == '100',
      ),
      findsOneWidget,
    );

    container.read(_testWeightUnitProvider.notifier).unit = WeightUnit.lb;
    await tester.pump();

    expect(find.text('lb'), findsWidgets);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is TextField && widget.controller?.text == '220.46',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Vietnamese week carousel fits without header overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(478, 713);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repo = MockTrainingRepository();
    final plan = _plan('responsive');
    final week = WeeklyWorkout(
      id: 'week-1',
      weekNumber: 1,
      name: 'Foundation and technique week',
      startDate: DateTime(2026, 6),
      endDate: DateTime(2026, 6, 7),
      planId: plan.id,
      totalDays: 7,
      completedDays: 2,
      hasWarning: true,
      isCompleted: false,
    );
    when(() => repo.getPlan(plan.id)).thenAnswer((_) async => plan);
    when(
      () => repo.getWeeks(plan.id, pageNumber: 1, pageSize: 100),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [week],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 1,
        hasMore: false,
      ),
    );
    when(
      () => repo.getDays(week.id, pageNumber: 1, pageSize: 100),
    ).thenAnswer(
      (_) async => const PagedResult(
        items: <DailyWorkout>[],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 0,
        hasMore: false,
      ),
    );
    when(() => repo.getExercisesByWeek(week.id)).thenAnswer((_) async => []);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_NoNetworkAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
        ],
        child: MaterialApp(
          locale: const Locale('vi'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.3)),
            child: child!,
          ),
          home: PlanDetailScreen(planId: plan.id),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNothing);
    final weekPages = tester.widget<PageView>(find.byType(PageView));
    expect(weekPages.padEnds, isTrue);
    expect(weekPages.controller!.viewportFraction, 0.88);
    expect(find.text('Foundation and technique week'), findsOneWidget);
    expect(find.text('Đang tập trung'), findsOneWidget);
    final analyticsAction = find.ancestor(
      of: find.byIcon(Icons.insights_rounded),
      matching: find.byType(OutlinedButton),
    );
    expect(analyticsAction, findsOneWidget);
    expect(
      tester.getBottomRight(find.byType(PageView)).dy -
          tester.getBottomRight(analyticsAction).dy,
      lessThan(40),
    );
  });

  testWidgets('CreatePlanSheet supports coach-scoped plan creation', (
    tester,
  ) async {
    final plan = _plan('client-plan');
    String? submittedName;
    DateTime? submittedStart;
    DateTime? submittedEnd;

    await tester.pumpWidget(
      _app(
        CreatePlanSheet(
          initialPlan: plan,
          onCreate:
              ({required name, required startDate, required endDate}) async {
                submittedName = name;
                submittedStart = startDate;
                submittedEnd = endDate;
              },
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).first, 'Client plan');
    await tester.tap(find.text('Create plan'));
    await tester.pump();

    expect(submittedName, 'Client plan');
    expect(submittedStart, DateTime(2026, 6));
    expect(submittedEnd, DateTime(2026, 8));
  });

  testWidgets('CreatePlanSheet edit mode submits updatePlan', (tester) async {
    final repo = MockTrainingRepository();
    final plan = _plan('p1');
    when(
      () => repo.updatePlan(
        planId: 'p1',
        name: 'Updated plan',
        startDate: DateTime(2026, 6),
        endDate: DateTime(2026, 8),
      ),
    ).thenAnswer((_) async => plan.copyWith(name: 'Updated plan'));
    when(
      () => repo.getPlans(pageNumber: 1, pageSize: 20),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [plan.copyWith(name: 'Updated plan')],
        pageNumber: 1,
        pageSize: 20,
        totalCount: 1,
        hasMore: false,
      ),
    );

    await tester.pumpWidget(
      _app(
        CreatePlanSheet(mode: PlanFormMode.edit, initialPlan: plan),
        repo: repo,
      ),
    );

    await tester.enterText(find.byType(TextFormField).first, 'Updated plan');
    await tester.tap(find.text('Save changes'));
    await tester.pump();

    verify(
      () => repo.updatePlan(
        planId: 'p1',
        name: 'Updated plan',
        startDate: DateTime(2026, 6),
        endDate: DateTime(2026, 8),
      ),
    ).called(1);
  });

  testWidgets('CreatePlanSheet duplicate mode initializes after localization', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    final source = _plan('p1');
    final duplicate = source.copyWith(id: 'p2', name: 'Plan p1 copy');
    when(
      () => repo.duplicatePlan(
        sourcePlanId: source.id,
        name: 'Plan p1 copy',
        startDate: DateTime(2026, 6),
        endDate: DateTime(2026, 8),
      ),
    ).thenAnswer((_) async => duplicate);
    when(
      () => repo.getPlans(pageNumber: 1, pageSize: 20),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [source, duplicate],
        pageNumber: 1,
        pageSize: 20,
        totalCount: 2,
        hasMore: false,
      ),
    );

    await tester.pumpWidget(
      _app(
        CreatePlanSheet(
          mode: PlanFormMode.duplicate,
          initialPlan: source,
        ),
        repo: repo,
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Plan p1 copy'), findsOneWidget);

    await tester.tap(find.text('Create copy'));
    await tester.pumpAndSettle();

    verify(
      () => repo.duplicatePlan(
        sourcePlanId: source.id,
        name: 'Plan p1 copy',
        startDate: DateTime(2026, 6),
        endDate: DateTime(2026, 8),
      ),
    ).called(1);
  });

  testWidgets('ExerciseTemplateFormSheet returns custom template input', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(800, 900)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    ExerciseTemplateFormResult? result;

    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              result = await showModalBottomSheet<ExerciseTemplateFormResult>(
                context: context,
                isScrollControlled: true,
                builder: (_) => const ExerciseTemplateFormSheet(
                  title: 'Custom exercise',
                  submitLabel: 'Create exercise',
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Pause squat');
    final submit = find.text('Create exercise', skipOffstage: false);
    await tester.ensureVisible(submit);
    await tester.pumpAndSettle();
    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(result?.name, 'Pause squat');
    expect(result?.primaryMuscleGroup, 'Chest');
    expect(result?.exerciseKind, 'Strength');
  });

  testWidgets('PlansScreen does not show CSV export action', (tester) async {
    final repo = MockTrainingRepository();
    final plan = _plan('p1');

    when(
      () => repo.getPlans(pageNumber: 1, pageSize: 20),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [plan],
        pageNumber: 1,
        pageSize: 20,
        totalCount: 1,
        hasMore: false,
      ),
    );

    await tester.pumpWidget(_app(const PlansScreen(), repo: repo));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Export plan'), findsNothing);
    expect(find.byType(SyncedBackgroundCard), findsOneWidget);
    expect(find.text('Plans'), findsWidgets);
    verifyNever(() => repo.exportPlanCsv('p1'));
  });

  testWidgets('exercise library renders every exercise as a separate card', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    const templates = [
      ExerciseTemplate(
        id: 'squat',
        name: 'Pause Squat',
        primaryMuscleGroup: 'Quadriceps',
        exerciseKind: 'Strength',
        isCustom: true,
        description: 'Two-second pause at the bottom',
      ),
      ExerciseTemplate(
        id: 'bench',
        name: 'Bench Press',
        primaryMuscleGroup: 'Chest',
        exerciseKind: 'Strength',
        isCustom: false,
        description: 'Barbell flat bench press',
      ),
    ];
    when(
      () => repo.getExerciseTemplates(muscleGroup: null, clientId: null),
    ).thenAnswer((_) async => templates);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_NoNetworkAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
          exercisePrsProvider.overrideWith((ref) async => []),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ExerciseLibraryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final squatCard = find.byKey(
      const ValueKey('exercise-template-card-squat'),
    );
    final benchCard = find.byKey(
      const ValueKey('exercise-template-card-bench'),
    );
    expect(squatCard, findsOneWidget);
    expect(benchCard, findsOneWidget);
    expect(
      tester.getTopLeft(benchCard).dy - tester.getBottomLeft(squatCard).dy,
      greaterThan(0),
    );
    final filterChips = tester.widgetList<ChoiceChip>(find.byType(ChoiceChip));
    final selectedChip = filterChips.singleWhere((chip) => chip.selected);
    final unselectedChip = filterChips.firstWhere((chip) => !chip.selected);
    expect(selectedChip.selectedColor, AppColors.sage100);
    expect(selectedChip.checkmarkColor, AppColors.sage700);
    expect(unselectedChip.backgroundColor, AppColors.bg2);
  });

  testWidgets('exercise picker renders every template as a card, no dividers', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    const templates = [
      ExerciseTemplate(
        id: 'squat',
        name: 'Pause Squat',
        primaryMuscleGroup: 'Quadriceps',
        exerciseKind: 'Strength',
        isCustom: true,
      ),
      ExerciseTemplate(
        id: 'bench',
        name: 'Bench Press',
        primaryMuscleGroup: 'Chest',
        exerciseKind: 'Strength',
        isCustom: false,
      ),
    ];
    when(
      () => repo.getExerciseTemplates(muscleGroup: null, clientId: null),
    ).thenAnswer((_) async => templates);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_NoNetworkAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: ExerciseTemplatePickerSheet()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final squatCard = find.byKey(
      const ValueKey('exercise-template-picker-card-squat'),
    );
    final benchCard = find.byKey(
      const ValueKey('exercise-template-picker-card-bench'),
    );
    expect(squatCard, findsOneWidget);
    expect(benchCard, findsOneWidget);
    expect(tester.widget(squatCard), isA<XnCard>());
    expect(tester.widget(benchCard), isA<XnCard>());
    // Rows are separated by whitespace between cards, never by a hairline.
    expect(find.byType(Divider), findsNothing);
    // The custom template keeps its overflow menu; the stock one keeps the
    // plain add affordance.
    expect(
      find.descendant(
        of: squatCard,
        matching: find.byIcon(Icons.more_vert_rounded),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: benchCard,
        matching: find.byIcon(Icons.add_circle_outline_rounded),
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Coach plan activation is separate from design analysis', (
    tester,
  ) async {
    var activationCount = 0;
    var reviewCount = 0;
    final coachPlan = _plan('coach-1').copyWith(planType: 'Coach');

    await tester.pumpWidget(
      _app(
        PlanCard(
          plan: coachPlan,
          onTap: () {},
          onReview: () => reviewCount++,
          onActivate: () => activationCount++,
          onDelete: () {},
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    expect(activationCount, 1);
    expect(reviewCount, 0);

    await tester.tap(find.byIcon(Icons.auto_fix_high_outlined));
    expect(reviewCount, 1);
  });

  testWidgets('WeekScreen carousel opens day actions without overflow', (
    tester,
  ) async {
    final repo = MockTrainingRepository();
    when(
      () => repo.getDays('w1', pageNumber: 1, pageSize: 100),
    ).thenAnswer(
      (_) async => PagedResult(
        items: [_day('d1', 8), _day('d2', 9)],
        pageNumber: 1,
        pageSize: 100,
        totalCount: 2,
        hasMore: false,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_NoNetworkAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
          cycleDayMarkersProvider.overrideWith((ref, arg) async => {}),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: WeekScreen(weekId: 'w1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.text('Analytics'), findsNothing);
    // The summary header shares the profile background card, falling back to
    // the clay surface when no background is set.
    final summaryCard = tester.widget<SyncedBackgroundCard>(
      find.byKey(const ValueKey('week-days-summary')),
    );
    expect(summaryCard.fallbackColor, AppColors.clay900);
    final dayPages = tester.widget<PageView>(find.byType(PageView));
    expect(dayPages.padEnds, isTrue);
    expect(dayPages.controller!.viewportFraction, 0.9);
    await tester.tap(find.byTooltip('Day actions').first);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Copy to day'), findsOneWidget);
  });
}
