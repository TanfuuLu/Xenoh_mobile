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
class CommunitySettingsController extends _$CommunitySettingsController {
  @override
  Future<CommunitySettings> build() {
    return ref.watch(communityRepositoryProvider).getSettings();
  }

  Future<bool> save(CommunityStatsVisibility visibility) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).updateSettings(visibility),
    );
    return !state.hasError;
  }
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
  static const _pageSize = 20;
  var _requestGeneration = 0;

  @override
  Future<CommunityFeedState> build() => _fetchFirstPage();

  Future<CommunityFeedState> _fetchFirstPage() async {
    final page = await ref
        .watch(communityRepositoryProvider)
        .getFeed(
          pageSize: _pageSize,
        );
    return CommunityFeedState(
      items: page.items,
      nextCursor: page.nextCursor,
    );
  }

  Future<void> refresh() async {
    final generation = ++_requestGeneration;
    state = const AsyncValue.loading();
    try {
      final page = await ref
          .read(communityRepositoryProvider)
          .getFeed(pageSize: _pageSize);
      if (generation != _requestGeneration) return;
      state = AsyncValue.data(
        CommunityFeedState(items: page.items, nextCursor: page.nextCursor),
      );
    } catch (error, stackTrace) {
      if (generation != _requestGeneration) return;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncValue.data(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );
    final generation = _requestGeneration;
    try {
      final page = await ref
          .read(communityRepositoryProvider)
          .getFeed(cursor: current.nextCursor, pageSize: _pageSize);
      if (generation != _requestGeneration) return;
      final byId = <String, TrainingDayShare>{
        for (final item in current.items) item.id: item,
        for (final item in page.items) item.id: item,
      };
      state = AsyncValue.data(
        CommunityFeedState(
          items: byId.values.toList(growable: false),
          nextCursor: page.nextCursor,
        ),
      );
    } catch (error, stackTrace) {
      if (generation != _requestGeneration) return;
      state = AsyncValue.data(
        current.copyWith(
          isLoadingMore: false,
          loadMoreError: error,
          loadMoreStackTrace: stackTrace,
        ),
      );
    }
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

class CommunityFeedState {
  const CommunityFeedState({
    required this.items,
    required this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
    this.loadMoreStackTrace,
  });

  final List<TrainingDayShare> items;
  final String? nextCursor;
  final bool isLoadingMore;
  final Object? loadMoreError;
  final StackTrace? loadMoreStackTrace;

  bool get hasMore => nextCursor != null;

  CommunityFeedState copyWith({
    List<TrainingDayShare>? items,
    String? nextCursor,
    bool? isLoadingMore,
    Object? loadMoreError,
    StackTrace? loadMoreStackTrace,
    bool clearLoadMoreError = false,
  }) {
    return CommunityFeedState(
      items: items ?? this.items,
      nextCursor: nextCursor ?? this.nextCursor,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: clearLoadMoreError
          ? null
          : loadMoreError ?? this.loadMoreError,
      loadMoreStackTrace: clearLoadMoreError
          ? null
          : loadMoreStackTrace ?? this.loadMoreStackTrace,
    );
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

  Future<void> reportShare({
    required String shareId,
    required String reason,
    required String details,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(communityRepositoryProvider)
          .reportShare(
            shareId: shareId,
            reason: reason,
            details: details,
          ),
    );
  }

  Future<int> copyShare({
    required String shareId,
    required String targetDailyWorkoutId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final copied = await ref
          .read(communityRepositoryProvider)
          .copyShare(
            shareId: shareId,
            targetDailyWorkoutId: targetDailyWorkoutId,
          );
      state = const AsyncValue.data(null);
      return copied;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  void _invalidateShares() {
    ref
      ..invalidate(communityFeedControllerProvider)
      ..invalidate(userTrainingDaySharesProvider);
  }
}
