import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/error/result.dart';
import 'package:xenoh_mobile/core/network/cookie_jar_provider.dart';
import 'package:xenoh_mobile/features/auth/data/repositories/auth_repository_provider.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';
import 'package:xenoh_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/social_callback_screen.dart';
import 'package:xenoh_mobile/features/auth/presentation/services/external_auth_launcher.dart';
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
  for (final testCase in const [
    (
      provider: ExternalAuthProvider.google,
      buttonLabel: 'Continue with Google',
    ),
    (
      provider: ExternalAuthProvider.facebook,
      buttonLabel: 'Continue with Facebook',
    ),
  ]) {
    testWidgets(
      '${testCase.provider.wireValue} callback authenticates once and opens Dashboard',
      (tester) async {
        final repo = _MockAuthRepository();
        when(
          repo.restoreSession,
        ).thenAnswer((_) async => const Err(AuthFailure()));
        when(
          () => repo.exchangeExternalTicket('one-time-ticket'),
        ).thenAnswer((_) async => const Ok(_session));

        Uri? authorizationUri;
        final launcher = ExternalAuthLauncher(
          apiBaseUrl: 'https://api.xenoh.online/api',
          authenticate: (uri) async {
            authorizationUri = uri;
            return Uri.parse(
              'xenoh://auth/social-callback?ticket=one-time-ticket',
            );
          },
        );
        final router = await _pumpFlow(
          tester,
          repo: repo,
          launcher: launcher,
        );

        await tester.tap(find.text(testCase.buttonLabel));
        await tester.pumpAndSettle();

        expect(
          authorizationUri.toString(),
          'https://api.xenoh.online/api/auth/external/'
          '${testCase.provider.wireValue}?client=mobile',
        );
        expect(find.text('Dashboard reached'), findsOneWidget);
        verify(
          () => repo.exchangeExternalTicket('one-time-ticket'),
        ).called(1);

        router.go('/auth/social-callback?ticket=one-time-ticket');
        await tester.pumpAndSettle();

        expect(find.text('Dashboard reached'), findsOneWidget);
        verifyNever(
          () => repo.exchangeExternalTicket('one-time-ticket'),
        );
      },
    );
  }
}

Future<GoRouter> _pumpFlow(
  WidgetTester tester, {
  required AuthRepository repo,
  required ExternalAuthLauncher launcher,
}) async {
  await tester.binding.setSurfaceSize(const Size(400, 800));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, _) => LoginScreen(externalAuthLauncher: launcher),
      ),
      GoRoute(
        path: '/auth/social-callback',
        builder: (_, state) => SocialCallbackScreen(
          ticket: state.uri.queryParameters['ticket'],
          errorCode: state.uri.queryParameters['error'],
        ),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (_, _) => const Scaffold(body: Text('Dashboard reached')),
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
        theme: AppTheme.light(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}
