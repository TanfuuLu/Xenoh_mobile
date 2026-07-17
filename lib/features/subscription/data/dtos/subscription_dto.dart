import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/subscription.dart';

part 'subscription_dto.freezed.dart';
part 'subscription_dto.g.dart';

/// `SubscriptionResponse` (API ref §3.18).
@freezed
abstract class SubscriptionDto with _$SubscriptionDto {
  const factory SubscriptionDto({
    required String id,
    required String tier,
    required bool isActive,
    required DateTime createdAt,
    required AiQuotaDto aiQuota,
    DateTime? expiresAt,
  }) = _SubscriptionDto;

  const SubscriptionDto._();

  factory SubscriptionDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDtoFromJson(json);

  Subscription toEntity() => Subscription(
    id: id,
    tier: tier,
    isActive: isActive,
    createdAt: createdAt,
    expiresAt: expiresAt,
    aiQuota: aiQuota.toEntity(),
  );
}

/// `AiQuotaResponse` — `periodStart` is a `DateOnly` string.
@freezed
abstract class AiQuotaDto with _$AiQuotaDto {
  const factory AiQuotaDto({
    required int monthlyLimit,
    required int usedRequests,
    required int remainingRequests,
    required String periodStart,
  }) = _AiQuotaDto;

  const AiQuotaDto._();

  factory AiQuotaDto.fromJson(Map<String, dynamic> json) =>
      _$AiQuotaDtoFromJson(json);

  AiQuota toEntity() => AiQuota(
    monthlyLimit: monthlyLimit,
    usedRequests: usedRequests,
    remainingRequests: remainingRequests,
    periodStart: DateOnly.tryParse(periodStart) ?? DateTime(1970),
  );
}
