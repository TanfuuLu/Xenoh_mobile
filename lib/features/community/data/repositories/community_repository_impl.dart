import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/models/paged_result.dart';
import '../../domain/entities/community_models.dart';
import '../../domain/repositories/community_repository.dart';
import '../datasources/community_remote_data_source.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  CommunityRepositoryImpl(this._remote);

  final CommunityRemoteDataSource _remote;

  @override
  Future<PagedResult<CommunityUserSummary>> searchUsers({
    required String query,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    if (query.trim().length < 2) {
      return const PagedResult(
        items: [],
        pageNumber: 1,
        pageSize: 20,
        totalCount: 0,
        hasMore: false,
      );
    }
    try {
      final page = await _remote.searchUsers(
        query: query.trim(),
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return PagedResult(
        items: page.items.map((e) => e.toEntity()).toList(growable: false),
        pageNumber: page.pageNumber,
        pageSize: page.pageSize,
        totalCount: page.totalCount,
        hasMore: page.hasMore,
      );
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<CommunityUserProfile> getProfile(String userId) async {
    try {
      final dto = await _remote.getProfile(userId);
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<List<Friend>> getFriends() async {
    try {
      final dtos = await _remote.getFriends();
      return dtos.map((e) => e.toEntity()).toList(growable: false);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<List<FriendRequest>> getFriendRequests(
    RequestDirection direction,
  ) async {
    try {
      final dtos = await _remote.getFriendRequests(direction);
      return dtos.map((e) => e.toEntity()).toList(growable: false);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<FriendRequest> sendFriendRequest(String targetUserId) async {
    try {
      return (await _remote.sendFriendRequest(targetUserId)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<FriendRequest> acceptFriendRequest(String requestId) async {
    try {
      return (await _remote.acceptFriendRequest(requestId)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> rejectFriendRequest(String requestId) async {
    try {
      await _remote.rejectFriendRequest(requestId);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> removeFriend(String userId) async {
    try {
      await _remote.removeFriend(userId);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<TrainingDayFeedPage> getFeed({
    String scope = 'friends',
    String? cursor,
    int pageSize = 20,
  }) async {
    try {
      final page = await _remote.getFeed(
        scope: scope,
        cursor: cursor,
        pageSize: pageSize,
      );
      return TrainingDayFeedPage(
        items: page.items.map((e) => e.toEntity()).toList(growable: false),
        nextCursor: page.nextCursor,
      );
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<CommunitySettings> getSettings() async {
    try {
      return (await _remote.getSettings()).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<CommunitySettings> updateSettings(
    CommunityStatsVisibility visibility,
  ) async {
    try {
      return (await _remote.updateSettings(visibility)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<List<TrainingDayShare>> getUserShares(String userId) async {
    try {
      final dtos = await _remote.getUserShares(userId);
      return dtos.map((e) => e.toEntity()).toList(growable: false);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<TrainingDayShare> shareTrainingDay({
    required String dailyWorkoutId,
    String? caption,
  }) async {
    try {
      return (await _remote.shareTrainingDay(
        dailyWorkoutId: dailyWorkoutId,
        caption: caption,
      )).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<TrainingDayShare> loveShare(String shareId) async {
    try {
      return (await _remote.loveShare(shareId)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<TrainingDayShare> unloveShare(String shareId) async {
    try {
      return (await _remote.unloveShare(shareId)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> deleteShare(String shareId) async {
    try {
      await _remote.deleteShare(shareId);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> reportShare({
    required String shareId,
    required String reason,
    required String details,
  }) async {
    try {
      await _remote.reportShare(
        shareId: shareId,
        reason: reason,
        details: details,
      );
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<int> copyShare({
    required String shareId,
    required String targetDailyWorkoutId,
  }) async {
    try {
      return await _remote.copyShare(
        shareId: shareId,
        targetDailyWorkoutId: targetDailyWorkoutId,
      );
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
