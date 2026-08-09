import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_models.freezed.dart';

enum FriendStatus { none, pending, accepted, rejected }

enum RequestDirection { incoming, outgoing }

enum CommunityStatsVisibility { friends, onlyMe }

class CommunitySettings {
  const CommunitySettings({required this.statsVisibility});

  final CommunityStatsVisibility statsVisibility;
}

class TrainingDayFeedPage {
  const TrainingDayFeedPage({required this.items, required this.nextCursor});

  final List<TrainingDayShare> items;
  final String? nextCursor;
}

@freezed
abstract class CommunityUserSummary with _$CommunityUserSummary {
  const factory CommunityUserSummary({
    required String id,
    required String fullName,
    String? email,
    String? avatarUrl,
    String? bio,
    String? gender,
    @Default(FriendStatus.none) FriendStatus friendStatus,
    String? friendshipId,
    RequestDirection? requestDirection,
  }) = _CommunityUserSummary;

  const CommunityUserSummary._();

  String get initials {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'X';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

@freezed
abstract class CommunityUserProfile with _$CommunityUserProfile {
  const factory CommunityUserProfile({
    required String id,
    required String fullName,
    required int level,
    required bool canViewStats,
    required Big3Prs big3Prs,
    required int totalTrainingDurationSeconds,
    required double totalTrainingVolume,
    String? email,
    String? avatarUrl,
    String? bio,
    String? gender,
    String? friendshipId,
    String? developmentDirection,
    String? trainingDiscipline,
    @Default(FriendStatus.none) FriendStatus friendStatus,
    RequestDirection? requestDirection,
    double? height,
    double? latestBodyweight,
    double? bmi,
    String? bmiCategory,
    int? currentStreak,
    double? dotsScore,
    double? big3Total,
  }) = _CommunityUserProfile;

  const CommunityUserProfile._();

  CommunityUserSummary get summary => CommunityUserSummary(
    id: id,
    fullName: fullName,
    email: email,
    avatarUrl: avatarUrl,
    bio: bio,
    gender: gender,
    friendStatus: friendStatus,
    friendshipId: friendshipId,
    requestDirection: requestDirection,
  );
}

@freezed
abstract class Big3Prs with _$Big3Prs {
  const factory Big3Prs({double? squat, double? bench, double? deadlift}) =
      _Big3Prs;
}

@freezed
abstract class Friend with _$Friend {
  const factory Friend({
    required String userId,
    required String fullName,
    required DateTime friendsSince,
    String? email,
    String? avatarUrl,
    String? bio,
  }) = _Friend;
}

@freezed
abstract class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required String id,
    required String userId,
    required String fullName,
    required RequestDirection direction,
    required FriendStatus status,
    required DateTime createdAt,
    String? email,
    String? avatarUrl,
    DateTime? respondedAt,
  }) = _FriendRequest;
}

@freezed
abstract class TrainingDayShare with _$TrainingDayShare {
  const factory TrainingDayShare({
    required String id,
    required String userId,
    required String userFullName,
    required String sourceDailyWorkoutId,
    required DateTime workoutDate,
    required String dayOfWeek,
    required String dayStatus,
    required int exerciseCount,
    required int completedSets,
    required double totalVolume,
    required int totalDurationSeconds,
    required bool hasPersonalRecord,
    required int loveCount,
    required bool lovedByCurrentUser,
    required DateTime createdAt,
    required List<TrainingDayShareExercise> exercises,
    @Default(false) bool isReusable,
    String? userAvatarUrl,
    double? averageRpe,
    String? caption,
  }) = _TrainingDayShare;
}

@freezed
abstract class TrainingDayShareExercise with _$TrainingDayShareExercise {
  const factory TrainingDayShareExercise({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required String exerciseKind,
    required int sortOrder,
    required bool isSkipped,
    required bool isPersonalRecord,
    required List<TrainingDayShareSet> sets,
    int? durationSeconds,
    String? notes,
  }) = _TrainingDayShareExercise;
}

@freezed
abstract class TrainingDayShareSet with _$TrainingDayShareSet {
  const factory TrainingDayShareSet({
    required String id,
    required int setNumber,
    required bool isCompleted,
    int? actualReps,
    double? actualWeight,
    double? rpe,
  }) = _TrainingDayShareSet;
}
