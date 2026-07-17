import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/paged_result.dart';
import '../../data/repositories/community_repository_provider.dart';
import '../../domain/entities/community_models.dart';

part 'community_controllers.g.dart';

@riverpod
Future<PagedResult<CommunityUserSummary>> communityUserSearch(
  Ref ref,
  String query,
) {
  return ref.watch(communityRepositoryProvider).searchUsers(query: query);
}

@riverpod
Future<CommunityUserProfile> communityProfile(Ref ref, String userId) {
  return ref.watch(communityRepositoryProvider).getProfile(userId);
}

@riverpod
Future<List<TrainingDayShare>> userTrainingDayShares(
  Ref ref,
  String userId, {
  required bool enabled,
}) {
  if (!enabled) return Future.value(const []);
  return ref.watch(communityRepositoryProvider).getUserShares(userId);
}

@riverpod
class CommunityFeedController extends _$CommunityFeedController {
  @override
  Future<List<TrainingDayShare>> build() =>
      ref.watch(communityRepositoryProvider).getFeed();

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).getFeed(),
    );
  }

  Future<void> toggleLove(TrainingDayShare share) async {
    final repo = ref.read(communityRepositoryProvider);
    if (share.lovedByCurrentUser) {
      await repo.unloveShare(share.id);
    } else {
      await repo.loveShare(share.id);
    }
    ref.invalidateSelf();
  }

  Future<void> deleteShare(String shareId) async {
    await ref.read(communityRepositoryProvider).deleteShare(shareId);
    ref.invalidateSelf();
  }
}

@riverpod
class FriendsController extends _$FriendsController {
  @override
  Future<List<Friend>> build() =>
      ref.watch(communityRepositoryProvider).getFriends();

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).getFriends(),
    );
  }

  Future<void> removeFriend(String userId) async {
    await ref.read(communityRepositoryProvider).removeFriend(userId);
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<FriendRequest>> friendRequests(
  Ref ref,
  RequestDirection direction,
) {
  return ref.watch(communityRepositoryProvider).getFriendRequests(direction);
}

@riverpod
class FriendActionController extends _$FriendActionController {
  @override
  FutureOr<void> build() {}

  Future<void> send(String targetUserId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () =>
          ref.read(communityRepositoryProvider).sendFriendRequest(targetUserId),
    );
    _invalidateCommunity();
  }

  Future<void> accept(String requestId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () =>
          ref.read(communityRepositoryProvider).acceptFriendRequest(requestId),
    );
    _invalidateCommunity();
  }

  Future<void> reject(String requestId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () =>
          ref.read(communityRepositoryProvider).rejectFriendRequest(requestId),
    );
    _invalidateCommunity();
  }

  Future<void> remove(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).removeFriend(userId),
    );
    _invalidateCommunity();
  }

  void _invalidateCommunity() {
    ref
      ..invalidate(communityRepositoryProvider)
      ..invalidate(friendsControllerProvider)
      ..invalidate(friendRequestsProvider)
      ..invalidate(communityProfileProvider)
      ..invalidate(communityUserSearchProvider);
  }
}

@riverpod
class ShareActionController extends _$ShareActionController {
  @override
  FutureOr<void> build() {}

  Future<void> toggleLove(TrainingDayShare share) async {
    state = const AsyncValue.loading();
    final repo = ref.read(communityRepositoryProvider);
    state = await AsyncValue.guard(() async {
      if (share.lovedByCurrentUser) {
        await repo.unloveShare(share.id);
      } else {
        await repo.loveShare(share.id);
      }
    });
    _invalidateShares();
  }

  Future<void> deleteShare(String shareId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).deleteShare(shareId),
    );
    _invalidateShares();
  }

  void _invalidateShares() {
    ref
      ..invalidate(communityFeedControllerProvider)
      ..invalidate(userTrainingDaySharesProvider);
  }
}
