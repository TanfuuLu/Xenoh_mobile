import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/error/result.dart';
import 'package:xenoh_mobile/core/network/cookie_jar_provider.dart';
import 'package:xenoh_mobile/features/auth/data/repositories/auth_repository_provider.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';
import 'package:xenoh_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/social_callback_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

const _session = AuthSession(
  accessToken: 'access-token',
  user: User(
    id: 'user-id',
    email: 'member@example.test',
    fullName: 'Member',
    roles: ['Individual'],
  ),
);

void main() {
  testWidgets('provider error does not attempt ticket exchange', (
    tester,
  ) async {
    final repo = _MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));

    await _pumpCallback(
      tester,
      repo: repo,
      ticket: null,
      errorCode: 'external_login_failed',
    );

    expect(find.text('Social sign-in failed.'), findsOneWidget);
    verifyNever(() => repo.exchangeExternalTicket(any()));
  });

  testWidgets('invalid ticket shows a localized retryable error', (
    tester,
  ) async {
    final repo = _MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));
    when(
      () => repo.exchangeExternalTicket('expired-ticket'),
    ).thenAnswer((_) async => const Err(AuthFailure()));

    await _pumpCallback(
      tester,
      repo: repo,
      ticket: 'expired-ticket',
      errorCode: null,
    );

    expect(
      find.text(
        'This social sign-in link is invalid or expired. Please try again.',
      ),
      findsOneWidget,
    );
    expect(find.text('Back to login'), findsOneWidget);
  });

  testWidgets('valid ticket authenticates once and opens dashboard', (
    tester,
  ) async {
    final repo = _MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));
    when(
      () => repo.exchangeExternalTicket('valid-ticket'),
    ).thenAnswer((_) async => const Ok(_session));

    await _pumpCallback(
      tester,
      repo: repo,
      ticket: 'valid-ticket',
      errorCode: null,
    );

    expect(find.text('Dashboard reached'), findsOneWidget);
    verify(() => repo.exchangeExternalTicket('valid-ticket')).called(1);
  });
}

Future<void> _pumpCallback(
  WidgetTester tester, {
  required AuthRepository repo,
  required String? ticket,
  required String? errorCode,
}) async {
  final router = GoRouter(
    initialLocation: '/callback',
    routes: [
      GoRoute(
        path: '/callback',
        builder: (_, _) => SocialCallbackScreen(
          ticket: ticket,
          errorCode: errorCode,
        ),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (_, _) => const Scaffold(body: Text('Dashboard reached')),
      ),
      GoRoute(
        path: '/login',
        builder: (_, _) => const Scaffold(body: Text('Login reached')),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        cookieJarProvider.overrideWithValue(CookieJar()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
  await tester.pumpAndSettle();
}
