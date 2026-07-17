import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/subscription_repository_provider.dart';
import '../../domain/entities/subscription.dart';

part 'subscription_controllers.g.dart';

/// The current user's server-authoritative subscription state.
@riverpod
Future<Subscription> subscription(Ref ref) =>
    ref.watch(subscriptionRepositoryProvider).getMySubscription();

/// Convenience gate other features can watch synchronously: `true` only once
/// the subscription has loaded and is an active Pro tier.
@riverpod
bool isPro(Ref ref) => ref.watch(subscriptionProvider).value?.isPro ?? false;
