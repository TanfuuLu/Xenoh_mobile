import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/login_screen.dart';
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
    final headerRect = tester.getRect(find.byKey(AuthLayout.headerKey));
    final formRect = tester.getRect(find.byKey(AuthLayout.formKey));
    expect(formRect.top, greaterThanOrEqualTo(headerRect.bottom));
    expect(tester.takeException(), isNull);

    await _pumpLogin(tester, const Size(1000, 800));
    expect(find.byKey(AuthLayout.wideKey), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpLogin(WidgetTester tester, Size size) async {
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
        home: const LoginScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
