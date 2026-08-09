import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/billing.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_data_source.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._remote);

  final SubscriptionRemoteDataSource _remote;

  @override
  Future<Subscription> getMySubscription() =>
      _guard(() async => (await _remote.getMySubscription()).toEntity());

  @override
  Future<SubscriptionCatalog> getCatalog() => _guard(_remote.getCatalog);

  @override
  Future<PromotionValidation> validatePromotion({
    required String code,
    String? requestedTier,
    int? durationMonths,
  }) => _guard(
    () => _remote.validatePromotion(
      code: code,
      requestedTier: requestedTier,
      durationMonths: durationMonths,
    ),
  );

  @override
  Future<PaymentOrder> createPaymentOrder(CreatePaymentOrderInput input) =>
      _guard(() => _remote.createPaymentOrder(input));

  Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
