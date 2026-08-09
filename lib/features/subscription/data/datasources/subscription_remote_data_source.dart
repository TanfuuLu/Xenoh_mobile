import 'package:dio/dio.dart';

import '../../domain/entities/billing.dart';
import '../dtos/subscription_dto.dart';

/// Thin wrapper over `/subscriptions`. Throws [DioException]; the repository
/// maps to domain failures.
class SubscriptionRemoteDataSource {
  SubscriptionRemoteDataSource(this._dio);

  final Dio _dio;

  Future<SubscriptionDto> getMySubscription() async {
    final res = await _dio.get<Map<String, dynamic>>('/subscriptions/me');
    return SubscriptionDto.fromJson(res.data!);
  }

  Future<SubscriptionCatalog> getCatalog() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/subscriptions/catalog',
    );
    return SubscriptionCatalog.fromJson(res.data!);
  }

  Future<PromotionValidation> validatePromotion({
    required String code,
    String? requestedTier,
    int? durationMonths,
  }) async {
    final data = <String, dynamic>{'code': code};
    if (requestedTier != null) data['requestedTier'] = requestedTier;
    if (durationMonths != null) data['durationMonths'] = durationMonths;
    final res = await _dio.post<Map<String, dynamic>>(
      '/subscriptions/promotions/validate',
      data: data,
    );
    return PromotionValidation.fromJson(res.data!);
  }

  Future<PaymentOrder> createPaymentOrder(
    CreatePaymentOrderInput input,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/subscriptions/payment-orders',
      data: input.toJson(),
    );
    return PaymentOrder.fromJson(res.data!);
  }
}
