import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/models/paged_result.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_controller.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_state.dart';
import 'package:xenoh_mobile/features/training/data/repositories/training_repository_provider.dart';
import 'package:xenoh_mobile/features/training/domain/entities/daily_workout.dart';
import 'package:xenoh_mobile/features/training/domain/entities/plan.dart';
import 'package:xenoh_mobile/features/training/domain/entities/weekly_workout.dart';
import 'package:xenoh_mobile/features/training/domain/repositories/training_repository.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/cycle_day_markers_provider.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/plan_detail_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/plans_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/week_screen.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/create_plan_sheet.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/exercise_template_form_sheet.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/plan_card.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockTrainingRepository extends Mock implements TrainingRepository {}

/// Auth controller that resolves to unauthenticated without any network call,
/// so widgets that watch auth don't hit the real session restore in tests.
class _NoNetworkAuthController extends AuthController {
  @override
  AuthState build() => const AuthState.unauthenticated();
}

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
  testWidgets('week card fits a narrow phone with larger text', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
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
    expect(find.text('Foundation and technique week'), findsOneWidget);
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
    verifyNever(() => repo.exportPlanCsv('p1'));
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
          onAnalytics: () {},
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

  testWidgets('WeekScreen opens day action menu without layout exception', (
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

    await tester.tap(find.byTooltip('Day actions').first);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Copy to day'), findsOneWidget);
  });
}
