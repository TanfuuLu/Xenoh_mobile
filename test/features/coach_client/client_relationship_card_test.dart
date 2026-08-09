import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/widgets/xn_chip.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/clients_screen.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/preferences_provider.dart';
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
}
