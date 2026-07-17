import '../entities/subscription.dart';

/// Subscription status + bank-transfer payment orders. Methods throw a domain
/// `Failure` on error.
abstract interface class SubscriptionRepository {
  /// The current user's subscription (tier, expiry, AI quota).
  Future<Subscription> getMySubscription();

  /// Create a pending payment order for [requestedTier] over [durationMonths]
  /// (1–12). Returns bank-transfer instructions.
  /// Dev-only shortcut that activates Pro without payment. Throws
  /// `NotFoundFailure` in production. Returns the server message.
}
