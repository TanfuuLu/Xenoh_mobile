import '../entities/subscription.dart';

/// Subscription status. Methods throw a domain `Failure` on error.
abstract interface class SubscriptionRepository {
  /// The current user's subscription (tier, expiry, AI quota).
  Future<Subscription> getMySubscription();
}
