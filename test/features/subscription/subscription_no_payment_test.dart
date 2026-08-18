import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/subscription/data/repositories/subscription_repository_provider.dart';
import 'package:xenoh_mobile/features/subscription/domain/entities/subscription.dart';
import 'package:xenoh_mobile/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:xenoh_mobile/features/subscription/presentation/screens/subscription_status_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

/// Google Play forbids selling in-app digital content outside Play Billing,
/// and forbids steering users to an outside purchase flow. Xenoh sells
/// subscriptions on the website only; the mobile client must stay read-only.
/// These tests fail loudly if a payment or steering surface comes back.

class _MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

void main() {
  testWidgets('subscription screen shows status only, no purchase UI', (
    tester,
  ) async {
    final repo = _MockSubscriptionRepository();
    when(repo.getMySubscription).thenAnswer(
      (_) async => Subscription(
        id: 's1',
        tier: 'Free',
        isActive: false,
        createdAt: DateTime(2026, 1),
        aiQuota: AiQuota(
          monthlyLimit: 10,
          usedRequests: 2,
          remainingRequests: 8,
          periodStart: DateTime(2026, 6),
        ),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [subscriptionRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SubscriptionStatusScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(SubscriptionStatusScreen.statusGridKey), findsOneWidget);
    expect(find.text('Free'), findsOneWidget);

    // No promotion field and no terms checkbox — both were checkout controls.
    expect(find.byType(TextField), findsNothing);
    expect(find.byType(CheckboxListTile), findsNothing);

    // Refresh is the only action on this screen. Asserting the count (rather
    // than the absence of some particular button type) is what actually keeps
    // a purchase or steering control from being added beside it.
    expect(
      find.byKey(SubscriptionStatusScreen.refreshButtonKey),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((w) => w is ButtonStyleButton),
      findsOneWidget,
    );
  });

  test('no client code references payment or catalog endpoints', () {
    const forbiddenPaths = [
      '/subscriptions/payment-orders',
      '/subscriptions/promotions/validate',
      '/subscriptions/catalog',
    ];

    final offenders = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      // Admin operations tooling may read payment records; it is gated behind
      // an admin role and is not a customer purchase flow.
      final normalized = entity.path.replaceAll(r'\', '/');
      if (normalized.contains('lib/features/admin/')) continue;

      final source = entity.readAsStringSync();
      for (final path in forbiddenPaths) {
        if (source.contains(path)) offenders.add('$normalized -> $path');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Customer-facing code must not call subscription purchase endpoints. '
          'Subscriptions are sold on the website only.',
    );
  });

  test('subscription repository exposes no purchase methods', () {
    final source = File(
      'lib/features/subscription/domain/repositories/'
      'subscription_repository.dart',
    ).readAsStringSync();

    expect(source, contains('getMySubscription'));
    expect(source, isNot(contains('createPaymentOrder')));
    expect(source, isNot(contains('validatePromotion')));
    expect(source, isNot(contains('getCatalog')));
  });
}
