import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/widgets/xn_button.dart';
import 'package:xenoh_mobile/features/subscription/data/repositories/subscription_repository_provider.dart';
import 'package:xenoh_mobile/features/subscription/domain/entities/billing.dart';
import 'package:xenoh_mobile/features/subscription/domain/entities/subscription.dart';
import 'package:xenoh_mobile/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:xenoh_mobile/features/subscription/presentation/screens/subscription_status_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockRepository extends Mock implements SubscriptionRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const CreatePaymentOrderInput(
        requestedTier: 'ProIndividual',
        durationMonths: 1,
        termsVersion: 'terms-v2',
      ),
    );
  });

  testWidgets('requires terms acceptance and displays payment instructions', (
    tester,
  ) async {
    final repository = _MockRepository();
    when(repository.getMySubscription).thenAnswer((_) async => _freePlan());
    when(repository.getCatalog).thenAnswer((_) async => _catalog());
    when(() => repository.createPaymentOrder(any())).thenAnswer(
      (_) async => _order(),
    );

    await _pump(tester, repository);

    expect(find.text('Pro Individual'), findsOneWidget);
    expect(find.textContaining('499,000'), findsOneWidget);
    final orderButton = find.byKey(
      const ValueKey('subscription-order-ProIndividual-6'),
    );
    expect(tester.widget<FilledButton>(orderButton).onPressed, isNull);

    await tester.ensureVisible(
      find.byKey(SubscriptionStatusScreen.termsCheckboxKey),
    );
    await tester.tap(find.byKey(SubscriptionStatusScreen.termsCheckboxKey));
    await tester.pump();
    expect(tester.widget<FilledButton>(orderButton).onPressed, isNotNull);

    await tester.ensureVisible(orderButton);
    await tester.tap(orderButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('XENOH-ABC'), findsWidgets);
    expect(find.text('0123456789'), findsOneWidget);
    expect(find.text('Demo Bank'), findsOneWidget);
  });

  testWidgets('applies promotion against the selected offer', (tester) async {
    final repository = _MockRepository();
    when(repository.getMySubscription).thenAnswer((_) async => _freePlan());
    when(repository.getCatalog).thenAnswer((_) async => _catalog());
    when(
      () => repository.validatePromotion(
        code: 'SAVE20',
        requestedTier: 'ProIndividual',
        durationMonths: 6,
      ),
    ).thenAnswer(
      (_) async => const PromotionValidation(
        valid: true,
        code: 'SAVE20',
        discountType: 'Percent',
        discountValue: 20,
        originalAmount: 499000,
        discountAmount: 100000,
        finalAmount: 399000,
      ),
    );

    await _pump(tester, repository);
    final promotionField = find.descendant(
      of: find.byKey(SubscriptionStatusScreen.promotionInputKey),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(promotionField, 'save20');
    await tester.pump();
    final applyButton = find.byKey(
      SubscriptionStatusScreen.applyPromotionKey,
    );
    expect(tester.widget<XnButton>(applyButton).onPressed, isNotNull);
    await tester.ensureVisible(applyButton);
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();

    verify(
      () => repository.validatePromotion(
        code: 'SAVE20',
        requestedTier: 'ProIndividual',
        durationMonths: 6,
      ),
    ).called(1);

    expect(find.textContaining('SAVE20'), findsOneWidget);
    expect(find.textContaining('399,000'), findsOneWidget);
  });
}

Future<void> _pump(
  WidgetTester tester,
  SubscriptionRepository repository,
) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        subscriptionRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SubscriptionStatusScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Subscription _freePlan() => Subscription(
  id: 'free',
  tier: 'Free',
  isActive: true,
  createdAt: DateTime(2026),
  aiQuota: AiQuota(
    monthlyLimit: 0,
    usedRequests: 0,
    remainingRequests: 0,
    periodStart: DateTime(2026, 8),
  ),
);

const SubscriptionCatalog _catalogValue = SubscriptionCatalog(
  termsVersion: 'terms-v2',
  offers: [
    SubscriptionOffer(
      tier: 'ProIndividual',
      durationMonths: 6,
      price: 499000,
      currency: 'VND',
      isPrepaid: true,
      automaticallyRenews: false,
      hasUnlimitedClients: false,
    ),
  ],
);

SubscriptionCatalog _catalog() => _catalogValue;

PaymentOrder _order() => PaymentOrder(
  orderId: 'order-1',
  transferCode: 'XENOH-ABC',
  amount: 399000,
  originalAmount: 499000,
  discountAmount: 100000,
  promotionCode: 'SAVE20',
  durationMonths: 6,
  requestedTier: 'ProIndividual',
  expiresAt: DateTime(2026, 8, 3, 12, 30),
  bankAccountNumber: '0123456789',
  bankAccountName: 'XENOH',
  bankName: 'Demo Bank',
  transferDescription: 'XENOH-ABC',
);
