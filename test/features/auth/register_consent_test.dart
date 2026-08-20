import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

const _consentError =
    'Accept the Terms and Privacy Policy to create an account';

void main() {
  testWidgets('registration is blocked until the consent box is ticked', (
    tester,
  ) async {
    await _pumpRegister(tester);
    await _completeAccountStep(tester);

    expect(find.byType(Checkbox), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);
    expect(find.text(_consentError), findsNothing);

    await tester.ensureVisible(find.text('Register'));
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text(_consentError), findsOneWidget);

    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(find.text(_consentError), findsNothing);
  });

  testWidgets('consent label links out to the terms page', (tester) async {
    await _pumpRegister(tester);
    await _completeAccountStep(tester);

    await tester.ensureVisible(find.text('Terms'));
    await tester.tap(find.text('Terms'));
    await tester.pumpAndSettle();

    expect(find.text('terms page'), findsOneWidget);
  });

  testWidgets('consent label links out to the privacy page', (tester) async {
    await _pumpRegister(tester);
    await _completeAccountStep(tester);

    await tester.ensureVisible(find.text('Privacy Policy'));
    await tester.tap(find.text('Privacy Policy'));
    await tester.pumpAndSettle();

    expect(find.text('privacy page'), findsOneWidget);
  });
}

Future<void> _completeAccountStep(WidgetTester tester) async {
  final fields = find.byType(TextField);
  await tester.enterText(fields.at(0), 'Ada');
  await tester.enterText(fields.at(1), 'Lovelace');
  await tester.enterText(fields.at(2), 'ada@example.com');
  await tester.enterText(fields.at(3), 'sup3rsecret');
  await tester.ensureVisible(find.text('Continue'));
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
}

Future<void> _pumpRegister(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(420, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final router = GoRouter(
    initialLocation: '/register',
    routes: [
      GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
      GoRoute(
        path: '/terms',
        builder: (_, _) => const Scaffold(body: Text('terms page')),
      ),
      GoRoute(
        path: '/privacy',
        builder: (_, _) => const Scaffold(body: Text('privacy page')),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
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
}
