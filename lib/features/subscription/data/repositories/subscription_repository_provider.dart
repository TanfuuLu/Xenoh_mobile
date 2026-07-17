import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_data_source.dart';
import 'subscription_repository_impl.dart';

part 'subscription_repository_provider.g.dart';

@riverpod
SubscriptionRepository subscriptionRepository(Ref ref) =>
    SubscriptionRepositoryImpl(
      SubscriptionRemoteDataSource(ref.watch(dioProvider)),
    );
