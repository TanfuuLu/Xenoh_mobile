import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';

/// The user's current subscription (maps from `SubscriptionResponse`, API ref
/// §3.18). `tier` is a `PlanTier` name: `Free` | `ProIndividual` | `ProCoach`.
@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String tier,
    required bool isActive,
    required DateTime createdAt,
    required AiQuota aiQuota,
    DateTime? expiresAt,
  }) = _Subscription;

  const Subscription._();

  bool get isPro => isActive && (tier == 'ProIndividual' || tier == 'ProCoach');
  bool get isProCoach => isActive && tier == 'ProCoach';
  bool get isFree => !isPro;
}

/// Server-side AI request quota for the current period (maps from
/// `AiQuotaResponse`). `periodStart` is a `DateOnly`.
@freezed
abstract class AiQuota with _$AiQuota {
  const factory AiQuota({
    required int monthlyLimit,
    required int usedRequests,
    required int remainingRequests,
    required DateTime periodStart,
  }) = _AiQuota;

  const AiQuota._();

  /// Fraction of the monthly limit consumed (0–1). 0 when the tier has no AI.
  double get usedFraction =>
      monthlyLimit <= 0 ? 0 : (usedRequests / monthlyLimit).clamp(0.0, 1.0);
}
