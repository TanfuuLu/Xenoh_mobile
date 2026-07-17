import 'package:dio/dio.dart';

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
}
