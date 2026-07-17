import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_data_source.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._remote);

  final SubscriptionRemoteDataSource _remote;

  @override
  Future<Subscription> getMySubscription() =>
      _guard(() async => (await _remote.getMySubscription()).toEntity());

  Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
