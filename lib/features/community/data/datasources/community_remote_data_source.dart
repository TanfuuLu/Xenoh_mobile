import 'package:dio/dio.dart';

import '../../../../core/models/paged_result.dart';
import '../../../../core/network/paged_response.dart';
import '../../domain/entities/community_models.dart';
import '../dtos/community_dtos.dart';

class CommunityRemoteDataSource {
  CommunityRemoteDataSource(this._dio);

  final Dio _dio;

  Future<PagedResult<CommunityUserSummaryDto>> searchUsers({
    required String query,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/community/users',
      queryParameters: {
        'query': query,
        'page': pageNumber,
        'pageSize': pageSize,
      },
    );
    return parsePagedResponse(
      res.data ?? <String, dynamic>{},
      CommunityUserSummaryDto.fromJson,
    );
  }

  Future<CommunityUserProfileDto> getProfile(String userId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/community/users/$userId',
    );
    return CommunityUserProfileDto.fromJson(res.data!);
  }

  Future<List<FriendDto>> getFriends() async {
    final res = await _dio.get<List<dynamic>>('/friends');
    return (res.data ?? const [])
        .map((e) => FriendDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<List<FriendRequestDto>> getFriendRequests(
    RequestDirection direction,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      '/friends/requests',
      queryParameters: {'direction': requestDirectionApiValue(direction)},
    );
    return (res.data ?? const [])
        .map((e) => FriendRequestDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<FriendRequestDto> sendFriendRequest(String targetUserId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/friends/requests',
      data: {'targetUserId': targetUserId},
    );
    return FriendRequestDto.fromJson(res.data!);
  }

  Future<FriendRequestDto> acceptFriendRequest(String requestId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/friends/requests/$requestId/accept',
    );
    return FriendRequestDto.fromJson(res.data!);
  }

  Future<void> rejectFriendRequest(String requestId) async {
    await _dio.post<void>('/friends/requests/$requestId/reject');
  }

  Future<void> removeFriend(String userId) async {
    await _dio.delete<void>('/friends/$userId');
  }

  Future<TrainingDayFeedPageDto> getFeed({
    String scope = 'friends',
    String? cursor,
    int pageSize = 20,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/training-day-shares/feed',
      queryParameters: {
        'scope': scope,
        'cursor': ?cursor,
        'pageSize': pageSize,
      },
    );
    return TrainingDayFeedPageDto.fromJson(res.data ?? const {});
  }

  Future<CommunitySettingsDto> getSettings() async {
    final res = await _dio.get<Map<String, dynamic>>('/community/settings');
    return CommunitySettingsDto.fromJson(res.data ?? const {});
  }

  Future<CommunitySettingsDto> updateSettings(
    CommunityStatsVisibility visibility,
  ) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/community/settings',
      data: {'statsVisibility': communityStatsVisibilityApiValue(visibility)},
    );
    return CommunitySettingsDto.fromJson(res.data ?? const {});
  }

  Future<List<TrainingDayShareDto>> getUserShares(String userId) async {
    final res = await _dio.get<List<dynamic>>(
      '/community/users/$userId/training-day-shares',
    );
    return (res.data ?? const [])
        .map((e) => TrainingDayShareDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<TrainingDayShareDto> shareTrainingDay({
    required String dailyWorkoutId,
    String? caption,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/training-day-shares',
      data: {'dailyWorkoutId': dailyWorkoutId, 'caption': ?caption},
    );
    return TrainingDayShareDto.fromJson(res.data!);
  }

  Future<TrainingDayShareDto> loveShare(String shareId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/training-day-shares/$shareId/kudos',
    );
    return TrainingDayShareDto.fromJson(res.data!);
  }

  Future<TrainingDayShareDto> unloveShare(String shareId) async {
    final res = await _dio.delete<Map<String, dynamic>>(
      '/training-day-shares/$shareId/kudos',
    );
    return TrainingDayShareDto.fromJson(res.data!);
  }

  Future<void> deleteShare(String shareId) async {
    await _dio.delete<void>('/training-day-shares/$shareId');
  }

  Future<void> reportShare({
    required String shareId,
    required String reason,
    required String details,
  }) async {
    await _dio.post<void>(
      '/training-day-shares/$shareId/reports',
      data: {'reason': reason, 'details': details},
    );
  }

  Future<int> copyShare({
    required String shareId,
    required String targetDailyWorkoutId,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/training-day-shares/$shareId/copy',
      data: {'targetDailyWorkoutId': targetDailyWorkoutId},
    );
    return (res.data?['exercisesCopied'] as num?)?.toInt() ?? 0;
  }
}
