// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionDto _$SubscriptionDtoFromJson(Map<String, dynamic> json) =>
    _SubscriptionDto(
      id: json['id'] as String,
      tier: json['tier'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      aiQuota: AiQuotaDto.fromJson(json['aiQuota'] as Map<String, dynamic>),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$SubscriptionDtoToJson(_SubscriptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tier': instance.tier,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'aiQuota': instance.aiQuota,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

_AiQuotaDto _$AiQuotaDtoFromJson(Map<String, dynamic> json) => _AiQuotaDto(
  monthlyLimit: (json['monthlyLimit'] as num).toInt(),
  usedRequests: (json['usedRequests'] as num).toInt(),
  remainingRequests: (json['remainingRequests'] as num).toInt(),
  periodStart: json['periodStart'] as String,
);

Map<String, dynamic> _$AiQuotaDtoToJson(_AiQuotaDto instance) =>
    <String, dynamic>{
      'monthlyLimit': instance.monthlyLimit,
      'usedRequests': instance.usedRequests,
      'remainingRequests': instance.remainingRequests,
      'periodStart': instance.periodStart,
    };
