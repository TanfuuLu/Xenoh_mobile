import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/widgets/xn_chip.dart';
import 'package:xenoh_mobile/features/coach_client/domain/chat_unread_repository.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/providers/chat_unread_controller.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/providers/my_coach_provider.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/clients_screen.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/my_coach_screen.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/preferences_provider.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('client card gives plan progress its own readable section', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final client = <String, dynamic>{
      'clientId': 'client-1',
      'clientName': 'Demo Athlete',
      'clientEmail': 'demo@xenoh.app',
      'clientAvatarUrl': 'https://example.test/demo-athlete.png',
      'status': 'Active',
    };
    final dashboard = <String, dynamic>{
      'clientId': 'client-1',
      'activePlanName': 'Coach Plan – Squat Focus',
      'activePlanProgressPercent': 42,
      'latestBodyweightKg': 63.1,
      'needsAttention': true,
      'attentionLevel': 'Warning',
    };

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          coachClientsProvider.overrideWith((ref) async => [client]),
          coachPendingRequestsProvider.overrideWith((ref) async => const []),
          coachDashboardProvider.overrideWith((ref) async => [dashboard]),
          preferencesProvider.overrideWith(
            (ref) async => const {'weightUnit': 'lb'},
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ClientsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final card = find.byKey(const ValueKey('client-relationship-client-1'));
    expect(card, findsOneWidget);
    expect(
      find.descendant(of: card, matching: find.byType(LinearProgressIndicator)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: card, matching: find.text('42%')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: card, matching: find.byType(XnChip)),
      findsNothing,
    );
    expect(
      find.descendant(of: card, matching: find.byType(Image)),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('coach ends a relationship without the client approving', (
    tester,
  ) async {
    final api = _RelationshipApi();
    await _pumpCoachClients(
      tester,
      api: api,
      clients: const [
        {
          'id': 'relationship-1',
          'clientId': 'client-1',
          'clientName': 'Demo Athlete',
          'status': 'Active',
        },
      ],
    );

    await tester.tap(find.byIcon(Icons.more_horiz_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End coaching').last);
    await tester.pumpAndSettle();

    // Confirmation names the client and spells out that plans are deleted.
    expect(find.text('End the coaching relationship?'), findsOneWidget);
    expect(
      find.textContaining('The plans you wrote for them are deleted'),
      findsOneWidget,
    );
    expect(api.postedPaths, isEmpty);

    await tester.tap(find.text('End coaching').last);
    await tester.pumpAndSettle();

    expect(api.postedPaths, contains('/coach-client/relationship-1/end'));
  });

  testWidgets('coach can decline a request that was never accepted', (
    tester,
  ) async {
    final api = _RelationshipApi();
    await _pumpCoachClients(
      tester,
      api: api,
      clients: const [
        {
          'id': 'relationship-1',
          'clientId': 'client-1',
          'clientName': 'Demo Athlete',
          'status': 'Pending',
        },
      ],
    );

    await tester.tap(find.byIcon(Icons.more_horiz_rounded));
    await tester.pumpAndSettle();
    // A pending request offers both answers, not just accept.
    expect(find.text('Accept'), findsOneWidget);
    await tester.tap(find.text('Decline request').last);
    await tester.pumpAndSettle();

    // Declining touches no plans, so the copy must not threaten deletion.
    expect(find.text('Decline this request?'), findsOneWidget);
    expect(find.textContaining('are deleted'), findsNothing);
    expect(api.postedPaths, isEmpty);

    await tester.tap(find.text('Decline request').last);
    await tester.pumpAndSettle();

    // Declining and ending are the same one-sided call server-side.
    expect(api.postedPaths, contains('/coach-client/relationship-1/end'));
  });

  testWidgets('coach sees no accept or reject termination choice', (
    tester,
  ) async {
    await _pumpCoachClients(
      tester,
      api: _RelationshipApi(),
      clients: const [
        {
          'id': 'relationship-1',
          'clientId': 'client-1',
          'clientName': 'Demo Athlete',
          'status': 'Active',
        },
      ],
    );

    expect(find.text('End relationship'), findsNothing);
    expect(find.text('Keep relationship'), findsNothing);
    expect(find.text('Termination requested'), findsNothing);
    expect(find.text('Request renewal'), findsNothing);
  });

  testWidgets('client ends the relationship without the coach approving', (
    tester,
  ) async {
    final api = _RelationshipApi(
      myCoach: const {
        'id': 'relationship-1',
        'coachId': 'coach-1',
        'coachName': 'Demo Coach',
        'status': 'Active',
      },
    );
    await _pumpMyCoach(tester, api);

    expect(find.text('End coaching'), findsOneWidget);
    expect(find.text('Request termination'), findsNothing);
    expect(find.text('Request renewal'), findsNothing);

    await tester.tap(find.text('End coaching'));
    await tester.pumpAndSettle();

    expect(find.text('End the coaching relationship?'), findsOneWidget);
    expect(
      find.textContaining('the sessions you already logged against them'),
      findsOneWidget,
    );

    await tester.tap(find.text('End coaching').last);
    await tester.pumpAndSettle();

    expect(api.postedPaths, contains('/coach-client/relationship-1/end'));
  });

  testWidgets('client sees no waiting state, because ending is immediate', (
    tester,
  ) async {
    final api = _RelationshipApi(
      myCoach: const {
        'id': 'relationship-1',
        'coachId': 'coach-1',
        'coachName': 'Demo Coach',
        'status': 'Active',
      },
    );
    await _pumpMyCoach(tester, api);

    expect(
      find.text('Waiting for your coach to accept or reject the request.'),
      findsNothing,
    );
    expect(find.text('Termination requested'), findsNothing);
  });
}

Future<void> _pumpCoachClients(
  WidgetTester tester, {
  required _RelationshipApi api,
  required List<JsonMap> clients,
}) async {
  tester.view.physicalSize = const Size(390, 1100);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        xenohApiProvider.overrideWithValue(api),
        coachClientsProvider.overrideWith((ref) async => clients),
        coachPendingRequestsProvider.overrideWith((ref) async => const []),
        coachDashboardProvider.overrideWith((ref) async => const []),
        preferencesProvider.overrideWith(
          (ref) async => const {'weightUnit': 'kg'},
        ),
      ],
      child: const _TestApp(home: ClientsScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpMyCoach(WidgetTester tester, _RelationshipApi api) async {
  tester.view.physicalSize = const Size(390, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        xenohApiProvider.overrideWithValue(api),
        myCoachProvider.overrideWith((ref) async => api.myCoach),
        chatUnreadRepositoryProvider.overrideWithValue(
          const _EmptyUnreadRepository(),
        ),
      ],
      child: const _TestApp(home: MyCoachScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

class _RelationshipApi extends XenohApi {
  _RelationshipApi({this.myCoach}) : super(Dio());

  final JsonMap? myCoach;
  final postedPaths = <String>[];

  @override
  Future<JsonMap> getObject(String path) async => <String, dynamic>{};

  @override
  Future<void> postVoid(String path, [JsonMap? data]) async {
    postedPaths.add(path);
  }
}

class _EmptyUnreadRepository implements ChatUnreadRepository {
  const _EmptyUnreadRepository();

  @override
  Future<Map<String, int>> getUnreadCounts() async => const {};

  @override
  Future<void> markRead(String relationshipId) async {}
}
