import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_controller.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_state.dart';
import 'package:xenoh_mobile/features/challenges/domain/challenge_models.dart';
import 'package:xenoh_mobile/features/challenges/domain/challenge_repository.dart';
import 'package:xenoh_mobile/features/challenges/presentation/challenge_detail_screen.dart';
import 'package:xenoh_mobile/features/challenges/presentation/challenge_providers.dart';
import 'package:xenoh_mobile/features/challenges/presentation/create_challenge_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('prefills and updates an existing challenge', (tester) async {
    final repository = _ChallengeRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [challengeRepositoryProvider.overrideWithValue(repository)],
        child: _TestApp(home: CreateChallengeScreen(challenge: _challenge())),
      ),
    );

    expect(find.text('Edit challenge'), findsOneWidget);
    expect(
      find.widgetWithText(TextFormField, 'August consistency'),
      findsOneWidget,
    );

    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await tester.pumpAndSettle();
    final save = find.text('Save changes');
    await tester.tap(save);
    await tester.pumpAndSettle();

    expect(repository.updatedId, 'c1');
    expect(repository.updatedInput?.title, 'August consistency');
  });

  testWidgets('shows edit action when the challenge is manageable', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          challengeDetailProvider.overrideWith(
            (ref, id) async => _challenge(canManage: true),
          ),
          authControllerProvider.overrideWith(_TestAuthController.new),
        ],
        child: const _TestApp(
          home: ChallengeDetailScreen(challengeId: 'c1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
  });

  testWidgets('hides edit action when the challenge is not manageable', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          challengeDetailProvider.overrideWith(
            (ref, id) async => _challenge(canManage: false),
          ),
          authControllerProvider.overrideWith(_TestAuthController.new),
        ],
        child: const _TestApp(
          home: ChallengeDetailScreen(challengeId: 'c1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.edit_outlined), findsNothing);
  });

  testWidgets('blocks the edit route for a non-manageable challenge', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          challengeDetailProvider.overrideWith(
            (ref, id) async => _challenge(canManage: false),
          ),
        ],
        child: const _TestApp(home: EditChallengeScreen(challengeId: 'c1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('You do not have permission or the required subscription.'),
      findsOneWidget,
    );
    expect(find.byType(TextFormField), findsNothing);
  });

  testWidgets('shows a meaningful retry state when edit loading fails', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          challengeDetailProvider.overrideWith(
            (ref, id) => Future<Challenge>.error(StateError('network')),
          ),
        ],
        child: const _TestApp(home: EditChallengeScreen(challengeId: 'c1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Request failed'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}

class _TestAuthController extends AuthController {
  @override
  AuthState build() => const AuthState.unauthenticated();
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

Challenge _challenge({bool canManage = true}) => Challenge(
  id: 'c1',
  title: 'August consistency',
  description: 'Train together',
  creatorId: 'u1',
  creatorName: 'Ada',
  metricType: 'TrainingSessions',
  accessType: 'Community',
  capacity: 10,
  acceptedCount: 1,
  reservedCount: 1,
  timeZoneId: 'Asia/Ho_Chi_Minh',
  startsAtUtc: DateTime.utc(2026, 8, 10, 2),
  endsAtUtc: DateTime.utc(2026, 8, 19, 2),
  status: 'Upcoming',
  canJoin: false,
  targetSessionsPerWeek: 3,
  selectedLifts: const [],
  canManage: canManage,
  joinClosed: false,
  members: const [],
);

class _ChallengeRepository implements ChallengeRepository {
  String? updatedId;
  ChallengeInput? updatedInput;

  @override
  Future<Challenge> update(String id, ChallengeInput input) async {
    updatedId = id;
    updatedInput = input;
    return _challenge();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
