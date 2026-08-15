import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:xenoh_mobile/features/auth/presentation/services/external_auth_launcher.dart';
import 'package:xenoh_mobile/features/auth/presentation/widgets/auth_layout.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('login uses the featured layout without overflow', (
    tester,
  ) async {
    await _pumpLogin(tester, const Size(320, 700));

    expect(find.byKey(AuthLayout.featuredKey), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Facebook'), findsOneWidget);
    final headerRect = tester.getRect(find.byKey(AuthLayout.headerKey));
    final formRect = tester.getRect(find.byKey(AuthLayout.formKey));
    expect(formRect.top, greaterThanOrEqualTo(headerRect.bottom));
    expect(tester.takeException(), isNull);

    await _pumpLogin(tester, const Size(1000, 800));
    expect(find.byKey(AuthLayout.wideKey), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('social buttons launch the fixed mobile backend flow', (
    tester,
  ) async {
    Uri? openedUri;
    final launcher = ExternalAuthLauncher(
      apiBaseUrl: 'https://api.xenoh.online/api',
      openUrl: (uri) async {
        openedUri = uri;
        return true;
      },
    );
    await _pumpLogin(tester, const Size(400, 800), launcher: launcher);

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(
      openedUri.toString(),
      'https://api.xenoh.online/api/auth/external/google?client=mobile',
    );
  });

  testWidgets('browser launch failure is retryable and user friendly', (
    tester,
  ) async {
    final launcher = ExternalAuthLauncher(
      apiBaseUrl: 'https://api.xenoh.online/api',
      openUrl: (_) async => false,
    );
    await _pumpLogin(tester, const Size(400, 800), launcher: launcher);

    await tester.tap(find.text('Continue with Facebook'));
    await tester.pumpAndSettle();

    expect(
      find.text('Could not open social sign-in. Please try again.'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<OutlinedButton>(
            find.widgetWithText(OutlinedButton, 'Continue with Facebook'),
          )
          .onPressed,
      isNotNull,
    );
  });
}

Future<void> _pumpLogin(
  WidgetTester tester,
  Size size, {
  ExternalAuthLauncher? launcher,
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginScreen(externalAuthLauncher: launcher),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
