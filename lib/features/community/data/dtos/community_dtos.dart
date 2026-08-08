import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/community_models.dart';

part 'community_dtos.freezed.dart';
part 'community_dtos.g.dart';

@freezed
abstract class CommunityUserSummaryDto with _$CommunityUserSummaryDto {
  const factory CommunityUserSummaryDto({
    required String id,
    required String fullName,
    String? email,
    String? avatarUrl,
    String? bio,
    String? gender,
    String? friendStatus,
    String? friendshipId,
    String? requestDirection,
  }) = _CommunityUserSummaryDto;

  const CommunityUserSummaryDto._();

  factory CommunityUserSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityUserSummaryDtoFromJson(json);

  CommunityUserSummary toEntity() => CommunityUserSummary(
    id: id,
    fullName: fullName,
    email: email,
    avatarUrl: avatarUrl,
    bio: bio,
    gender: gender,
    friendStatus: _friendStatus(friendStatus),
    friendshipId: friendshipId,
    requestDirection: _requestDirection(requestDirection),
  );
}

@freezed
abstract class CommunityUserProfileDto with _$CommunityUserProfileDto {
  const factory CommunityUserProfileDto({
    required String id,
    required String fullName,
    @Default(1) int level,
    @Default(false) bool canViewStats,
    Big3PrsDto? big3Prs,
    @Default(0) int totalTrainingDurationSeconds,
    @Default(0) double totalTrainingVolume,
    String? email,
    String? avatarUrl,
    String? bio,
    String? gender,
    String? friendStatus,
    String? friendshipId,
    String? requestDirection,
    String? developmentDirection,
    String? trainingDiscipline,
    double? height,
    double? latestBodyweight,
    double? bmi,
    String? bmiCategory,
    int? currentStreak,
    double? dotsScore,
    double? big3Total,
  }) = _CommunityUserProfileDto;

  const CommunityUserProfileDto._();

  factory CommunityUserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityUserProfileDtoFromJson(json);

  CommunityUserProfile toEntity() => CommunityUserProfile(
    id: id,
    fullName: fullName,
    email: email,
    avatarUrl: avatarUrl,
    bio: bio,
    gender: gender,
    level: level,
    canViewStats: canViewStats,
    friendStatus: _friendStatus(friendStatus),
    friendshipId: friendshipId,
    requestDirection: _requestDirection(requestDirection),
    developmentDirection: developmentDirection,
    trainingDiscipline: trainingDiscipline,
    height: height,
    latestBodyweight: latestBodyweight,
    bmi: bmi,
    bmiCategory: bmiCategory,
    currentStreak: currentStreak,
    dotsScore: dotsScore,
    totalTrainingDurationSeconds: totalTrainingDurationSeconds,
    totalTrainingVolume: totalTrainingVolume,
    big3Prs: big3Prs?.toEntity() ?? const Big3Prs(),
    big3Total: big3Total,
  );
}

@freezed
abstract class Big3PrsDto with _$Big3PrsDto {
  const factory Big3PrsDto({double? squat, double? bench, double? deadlift}) =
      _Big3PrsDto;

  const Big3PrsDto._();

  factory Big3PrsDto.fromJson(Map<String, dynamic> json) =>
      _$Big3PrsDtoFromJson(json);

  Big3Prs toEntity() => Big3Prs(squat: squat, bench: bench, deadlift: deadlift);
}

@freezed
abstract class FriendDto with _$FriendDto {
  const factory FriendDto({
    required String userId,
    required String fullName,
    required String email,
    required String friendsSince,
    String? avatarUrl,
    String? bio,
  }) = _FriendDto;

  const FriendDto._();

  factory FriendDto.fromJson(Map<String, dynamic> json) =>
      _$FriendDtoFromJson(json);

  Friend toEntity() => Friend(
    userId: userId,
    fullName: fullName,
    email: email,
    avatarUrl: avatarUrl,
    bio: bio,
    friendsSince: DateTime.tryParse(friendsSince) ?? DateTime(1970),
  );
}

@freezed
abstract class FriendRequestDto with _$FriendRequestDto {
  const factory FriendRequestDto({
    required String id,
    required String userId,
    required String fullName,
    required String email,
    required String direction,
    required String status,
    required String createdAt,
    String? avatarUrl,
    String? respondedAt,
  }) = _FriendRequestDto;

  const FriendRequestDto._();

  factory FriendRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestDtoFromJson(json);

  FriendRequest toEntity() => FriendRequest(
    id: id,
    userId: userId,
    fullName: fullName,
    email: email,
    avatarUrl: avatarUrl,
    direction: _requestDirection(direction) ?? RequestDirection.incoming,
    status: _friendStatus(status),
    createdAt: DateTime.tryParse(createdAt) ?? DateTime(1970),
    respondedAt: respondedAt == null ? null : DateTime.tryParse(respondedAt!),
  );
}

@freezed
abstract class TrainingDayShareDto with _$TrainingDayShareDto {
  const factory TrainingDayShareDto({
    required String id,
    required String userId,
    required String userFullName,
    required String sourceDailyWorkoutId,
    required String workoutDate,
    required String dayOfWeek,
    required String dayStatus,
    required String createdAt,
    @Default(0) int exerciseCount,
    @Default(0) int completedSets,
    @Default(0) double totalVolume,
    @Default(0) int totalDurationSeconds,
    @Default(false) bool hasPersonalRecord,
    @Default(0) int loveCount,
    @Default(false) bool lovedByCurrentUser,
    @Default(<TrainingDayShareExerciseDto>[])
    List<TrainingDayShareExerciseDto> exercises,
    @Default(false) bool isReusable,
    String? userAvatarUrl,
    double? averageRpe,
    String? caption,
  }) = _TrainingDayShareDto;

  const TrainingDayShareDto._();

  factory TrainingDayShareDto.fromJson(Map<String, dynamic> json) =>
      _$TrainingDayShareDtoFromJson(json);

  TrainingDayShare toEntity() => TrainingDayShare(
    id: id,
    userId: userId,
    userFullName: userFullName,
    userAvatarUrl: userAvatarUrl,
    sourceDailyWorkoutId: sourceDailyWorkoutId,
    workoutDate: DateTime.tryParse(workoutDate) ?? DateTime(1970),
    dayOfWeek: dayOfWeek,
    dayStatus: dayStatus,
    exerciseCount: exerciseCount,
    completedSets: completedSets,
    totalVolume: totalVolume,
    totalDurationSeconds: totalDurationSeconds,
    averageRpe: averageRpe,
    hasPersonalRecord: hasPersonalRecord,
    caption: caption,
    loveCount: loveCount,
    lovedByCurrentUser: lovedByCurrentUser,
    isReusable: isReusable,
    createdAt: DateTime.tryParse(createdAt) ?? DateTime(1970),
    exercises: exercises.map((e) => e.toEntity()).toList(growable: false),
  );
}

@freezed
abstract class TrainingDayShareExerciseDto with _$TrainingDayShareExerciseDto {
  const factory TrainingDayShareExerciseDto({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required String exerciseKind,
    @Default(0) int sortOrder,
    @Default(false) bool isSkipped,
    @Default(false) bool isPersonalRecord,
    @Default(<TrainingDayShareSetDto>[]) List<TrainingDayShareSetDto> sets,
    int? durationSeconds,
    String? notes,
  }) = _TrainingDayShareExerciseDto;

  const TrainingDayShareExerciseDto._();

  factory TrainingDayShareExerciseDto.fromJson(Map<String, dynamic> json) =>
      _$TrainingDayShareExerciseDtoFromJson(json);

  TrainingDayShareExercise toEntity() => TrainingDayShareExercise(
    id: id,
    name: name,
    primaryMuscleGroup: primaryMuscleGroup,
    exerciseKind: exerciseKind,
    sortOrder: sortOrder,
    isSkipped: isSkipped,
    isPersonalRecord: isPersonalRecord,
    durationSeconds: durationSeconds,
    notes: notes,
    sets: sets.map((e) => e.toEntity()).toList(growable: false),
  );
}

@freezed
abstract class TrainingDayShareSetDto with _$TrainingDayShareSetDto {
  const factory TrainingDayShareSetDto({
    required String id,
    @Default(0) int setNumber,
    @Default(false) bool isCompleted,
    int? actualReps,
    double? actualWeight,
    double? rpe,
  }) = _TrainingDayShareSetDto;

  const TrainingDayShareSetDto._();

  factory TrainingDayShareSetDto.fromJson(Map<String, dynamic> json) =>
      _$TrainingDayShareSetDtoFromJson(json);

  TrainingDayShareSet toEntity() => TrainingDayShareSet(
    id: id,
    setNumber: setNumber,
    actualReps: actualReps,
    actualWeight: actualWeight,
    rpe: rpe,
    isCompleted: isCompleted,
  );
}

FriendStatus _friendStatus(String? value) {
  return switch (value) {
    'Pending' => FriendStatus.pending,
    'Accepted' => FriendStatus.accepted,
    'Rejected' => FriendStatus.rejected,
    _ => FriendStatus.none,
  };
}

RequestDirection? _requestDirection(String? value) {
  return switch (value) {
    'incoming' || 'Incoming' => RequestDirection.incoming,
    'outgoing' || 'Outgoing' => RequestDirection.outgoing,
    _ => null,
  };
}

String requestDirectionApiValue(RequestDirection direction) {
  return switch (direction) {
    RequestDirection.incoming => 'incoming',
    RequestDirection.outgoing => 'outgoing',
  };
}
