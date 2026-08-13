import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/network/xenoh_api.dart';
import 'package:xenoh_mobile/features/marketing/presentation/screens/landing_screen.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/preferences_provider.dart';
import 'package:xenoh_mobile/features/settings/presentation/screens/settings_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockXenohApi extends Mock implements XenohApi {}

void main() {
  setUpAll(() => registerFallbackValue(<String, dynamic>{}));

  group('normalizeThemePreference', () {
    test('preserves the supported dark value', () {
      expect(normalizeThemePreference('dark'), 'dark');
      expect(normalizeThemePreference('DARK'), 'dark');
    });

    test('falls back to the supported light value', () {
      expect(normalizeThemePreference('system'), 'light');
      expect(normalizeThemePreference('light'), 'light');
      expect(normalizeThemePreference(null), 'light');
    });
  });

  testWidgets('Track RPE setting persists the same preference as website', (
    tester,
  ) async {
    final api = _MockXenohApi();
    when(
      () => api.putObject(any(), any()),
    ).thenAnswer((_) async => <String, dynamic>{});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          xenohApiProvider.overrideWithValue(api),
          preferencesProvider.overrideWith(
            (ref) async => <String, dynamic>{
              'language': 'en',
              'theme': 'light',
              'weightUnit': 'kg',
              'trackRpe': true,
            },
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Delete account', skipOffstage: false), findsNothing);
    expect(find.byIcon(Icons.delete_forever_outlined), findsNothing);
    expect(find.text('Track RPE'), findsOneWidget);
    expect(find.text('On'), findsOneWidget);

    await tester.tap(find.text('Track RPE'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Off'));
    await tester.pumpAndSettle();

    verify(
      () => api.putObject('/users/me/preferences', {
        'language': 'en',
        'theme': 'light',
        'weightUnit': 'kg',
        'trackRpe': false,
      }),
    ).called(1);
  });

  testWidgets('Landing screen does not expose account deletion', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LandingScreen(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();

    expect(find.text('Delete account'), findsNothing);
  });
}
