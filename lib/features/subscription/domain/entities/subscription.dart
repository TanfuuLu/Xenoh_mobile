import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';

/// The user's current subscription. Tier is one of `Free`, `ProIndividual`,
/// `ProCoach`, or `Organizer`.
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

  /// Tier names are matched case- and whitespace-insensitively.
  ///
  /// Entitlements are granted outside the app (website checkout), so a paying
  /// customer whose tier string arrives in an unexpected casing would silently
  /// read as Free with no error surfaced anywhere. Normalising costs nothing
  /// and removes that failure mode. The server remains authoritative — it
  /// enforces access with 403s regardless of what these getters say.
  String get _tierKey => tier.trim().toLowerCase();

  bool get isPro => isActive && _proTierKeys.contains(_tierKey);
  bool get isProCoach => isActive && _tierKey == 'procoach';
  bool get isOrganizer => isActive && _tierKey == 'organizer';
  bool get isFree => !isPro;
}

const _proTierKeys = {'proindividual', 'procoach', 'organizer'};

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
