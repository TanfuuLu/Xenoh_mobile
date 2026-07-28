import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/subscription/data/repositories/subscription_repository_provider.dart';
import 'package:xenoh_mobile/features/subscription/domain/entities/subscription.dart';
import 'package:xenoh_mobile/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:xenoh_mobile/features/subscription/presentation/providers/subscription_controllers.dart';
import 'package:xenoh_mobile/features/subscription/presentation/providers/tier_labels.dart';
import 'package:xenoh_mobile/l10n/app_localizations_en.dart';

class MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

Subscription _sub({required String tier, required bool active}) => Subscription(
  id: 's1',
  tier: tier,
  isActive: active,
  createdAt: DateTime(2026, 1),
  expiresAt: active ? DateTime(2026, 12) : null,
  aiQuota: AiQuota(
    monthlyLimit: 100,
    usedRequests: 10,
    remainingRequests: 90,
    periodStart: DateTime(2026, 6),
  ),
);

ProviderContainer _container(SubscriptionRepository repo) {
  final container = ProviderContainer(
    overrides: [subscriptionRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('providers', () {
    test('subscriptionProvider loads the current subscription', () async {
      final repo = MockSubscriptionRepository();
      when(repo.getMySubscription).thenAnswer(
        (_) async => _sub(tier: 'ProIndividual', active: true),
      );

      final container = _container(repo);
      final sub = await container.read(subscriptionProvider.future);

      expect(sub.tier, 'ProIndividual');
      expect(sub.isPro, isTrue);
    });

    test('isProProvider is true only for an active Pro tier', () async {
      final repo = MockSubscriptionRepository();
      when(repo.getMySubscription).thenAnswer(
        (_) async => _sub(tier: 'Free', active: false),
      );

      final container = _container(repo);
      final sub = container.listen(subscriptionProvider, (_, _) {});
      addTearDown(sub.close);
      await container.read(subscriptionProvider.future);

      expect(container.read(isProProvider), isFalse);
    });
  });

  group('tier labels', () {
    test('tierLabel humanises the API tier name', () {
      final l10n = AppLocalizationsEn();
      expect(tierLabel('ProIndividual', l10n), 'Pro Individual');
      expect(tierLabel('ProCoach', l10n), 'Pro Coach');
      expect(tierLabel('Free', l10n), 'Free');
    });
  });
}
