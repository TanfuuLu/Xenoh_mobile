import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/models/paged_result.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_controller.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_state.dart';
import 'package:xenoh_mobile/features/training/data/repositories/training_repository_provider.dart';
import 'package:xenoh_mobile/features/training/domain/entities/plan.dart';
import 'package:xenoh_mobile/features/training/domain/repositories/training_repository.dart';
import 'package:xenoh_mobile/features/training/presentation/providers/coach_client_plans_provider.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/plans_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockTrainingRepository extends Mock implements TrainingRepository {}

/// Auth controller fixed to a coach session (skips the network restore).
class _CoachAuthController extends AuthController {
  @override
  AuthState build() => const AuthState.authenticated(
    AuthSession(
      user: User(
        id: 'coach1',
        email: 'coach@example.com',
        fullName: 'Coach Carter',
        roles: ['Coach'],
      ),
      accessToken: 'token',
    ),
  );
}

Plan _clientPlan(String id, {required String client, bool active = false}) =>
    Plan(
      id: id,
      name: 'Plan $id',
      startDate: DateTime(2026, 6),
      endDate: DateTime(2026, 8),
      planType: 'Coach',
      ownerName: client,
      totalWeeks: 8,
      completedWeeks: 2,
      totalDays: 40,
      completedDays: 10,
      isActive: active,
    );

void main() {
  // The plans page is a scrolling list taller than the default 600px test
  // viewport; render tall so every client card is laid out (ListView builds
  // lazily and would otherwise skip off-screen cards).
  void useTallSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(1200, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('coach sees a Client plans section grouped by client', (
    tester,
  ) async {
    useTallSurface(tester);
    final repo = MockTrainingRepository();
    when(() => repo.getPlans(pageNumber: 1, pageSize: 20)).thenAnswer(
      (_) async => const PagedResult(
        items: [],
        pageNumber: 1,
        pageSize: 20,
        totalCount: 0,
        hasMore: false,
      ),
    );

    final groups = [
      CoachClientPlanGroup(
        clientId: 'a',
        clientName: 'Ada Client',
        plans: [_clientPlan('p1', client: 'Ada Client')],
      ),
      CoachClientPlanGroup(
        clientId: 'b',
        clientName: 'Ben Client',
        plans: [_clientPlan('p2', client: 'Ben Client', active: true)],
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_CoachAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
          coachClientPlansProvider.overrideWith((ref) async => groups),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlansScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Client plans'), findsOneWidget);
    expect(find.text('Ada Client'), findsOneWidget);
    expect(find.text('Ben Client'), findsOneWidget);
    expect(find.text('Plan p1'), findsOneWidget);
    expect(find.text('Plan p2'), findsOneWidget);
  });

  testWidgets('coach can activate a client plan from the section', (
    tester,
  ) async {
    useTallSurface(tester);
    final repo = MockTrainingRepository();
    when(() => repo.getPlans(pageNumber: 1, pageSize: 20)).thenAnswer(
      (_) async => const PagedResult(
        items: [],
        pageNumber: 1,
        pageSize: 20,
        totalCount: 0,
        hasMore: false,
      ),
    );
    final inactive = _clientPlan('p1', client: 'Ada Client');
    when(
      () => repo.activatePlan('p1'),
    ).thenAnswer((_) async => inactive.copyWith(isActive: true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_CoachAuthController.new),
          trainingRepositoryProvider.overrideWithValue(repo),
          coachClientPlansProvider.overrideWith(
            (ref) async => [
              CoachClientPlanGroup(
                clientId: 'a',
                clientName: 'Ada Client',
                plans: [inactive],
              ),
            ],
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlansScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The manage-as-coach pill shows the toggleable Inactive state.
    await tester.tap(find.text('Inactive'));
    await tester.pumpAndSettle();

    verify(() => repo.activatePlan('p1')).called(1);
  });
}
