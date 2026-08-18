import '../entities/subscription.dart';

/// Subscription status. Methods throw a domain `Failure` on error.
///
/// Intentionally read-only: the mobile client observes entitlements, it never
/// sells or activates them.
abstract interface class SubscriptionRepository {
  /// The current user's subscription (tier, expiry, AI quota).
  Future<Subscription> getMySubscription();
}
