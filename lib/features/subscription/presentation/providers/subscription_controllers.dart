import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../data/repositories/subscription_repository_provider.dart';
import '../../domain/entities/subscription.dart';

part 'subscription_controllers.g.dart';

/// The current user's server-authoritative subscription state.
@riverpod
Future<Subscription> subscription(Ref ref) {
  ref.syncOn(const [DataTopic.subscription]);
  return ref.watch(subscriptionRepositoryProvider).getMySubscription();
}

/// Organizer is a distinct capability that changes navigation, so it is read
/// synchronously here.
///
/// Note there is deliberately no equivalent `isPro` gate: Pro access is
/// enforced server-side (403 responses, see `aiGate`), and a client-side
/// mirror would be a second source of truth that silently disagrees whenever
/// this cache is stale.
final isOrganizerProvider = Provider<bool>(
  (ref) => ref.watch(subscriptionProvider).value?.isOrganizer ?? false,
);
