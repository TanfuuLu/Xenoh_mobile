import '../../../../core/models/paged_result.dart';
import '../entities/community_models.dart';

abstract interface class CommunityRepository {
  Future<PagedResult<CommunityUserSummary>> searchUsers({
    required String query,
    int pageNumber = 1,
    int pageSize = 20,
  });

  Future<CommunityUserProfile> getProfile(String userId);

  Future<List<Friend>> getFriends();

  Future<List<FriendRequest>> getFriendRequests(RequestDirection direction);

  Future<FriendRequest> sendFriendRequest(String targetUserId);

  Future<FriendRequest> acceptFriendRequest(String requestId);

  Future<void> rejectFriendRequest(String requestId);

  Future<void> removeFriend(String userId);

  Future<TrainingDayFeedPage> getFeed({
    String scope = 'friends',
    String? cursor,
    int pageSize = 20,
  });

  Future<CommunitySettings> getSettings();

  Future<CommunitySettings> updateSettings(
    CommunityStatsVisibility visibility,
  );

  Future<List<TrainingDayShare>> getUserShares(String userId);

  Future<TrainingDayShare> shareTrainingDay({
    required String dailyWorkoutId,
    String? caption,
  });

  Future<TrainingDayShare> loveShare(String shareId);

  Future<TrainingDayShare> unloveShare(String shareId);

  Future<void> deleteShare(String shareId);

  Future<void> reportShare({
    required String shareId,
    required String reason,
    required String details,
  });

  Future<int> copyShare({
    required String shareId,
    required String targetDailyWorkoutId,
  });
}
