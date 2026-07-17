// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunityUserSummaryDto _$CommunityUserSummaryDtoFromJson(
  Map<String, dynamic> json,
) => _CommunityUserSummaryDto(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  email: json['email'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  gender: json['gender'] as String?,
  friendStatus: json['friendStatus'] as String?,
  friendshipId: json['friendshipId'] as String?,
  requestDirection: json['requestDirection'] as String?,
);

Map<String, dynamic> _$CommunityUserSummaryDtoToJson(
  _CommunityUserSummaryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'email': instance.email,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'gender': instance.gender,
  'friendStatus': instance.friendStatus,
  'friendshipId': instance.friendshipId,
  'requestDirection': instance.requestDirection,
};

_CommunityUserProfileDto _$CommunityUserProfileDtoFromJson(
  Map<String, dynamic> json,
) => _CommunityUserProfileDto(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  level: (json['level'] as num?)?.toInt() ?? 1,
  canViewStats: json['canViewStats'] as bool? ?? false,
  big3Prs: json['big3Prs'] == null
      ? null
      : Big3PrsDto.fromJson(json['big3Prs'] as Map<String, dynamic>),
  totalTrainingDurationSeconds:
      (json['totalTrainingDurationSeconds'] as num?)?.toInt() ?? 0,
  totalTrainingVolume: (json['totalTrainingVolume'] as num?)?.toDouble() ?? 0,
  email: json['email'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  gender: json['gender'] as String?,
  friendStatus: json['friendStatus'] as String?,
  friendshipId: json['friendshipId'] as String?,
  requestDirection: json['requestDirection'] as String?,
  developmentDirection: json['developmentDirection'] as String?,
  trainingDiscipline: json['trainingDiscipline'] as String?,
  height: (json['height'] as num?)?.toDouble(),
  latestBodyweight: (json['latestBodyweight'] as num?)?.toDouble(),
  bmi: (json['bmi'] as num?)?.toDouble(),
  bmiCategory: json['bmiCategory'] as String?,
  currentStreak: (json['currentStreak'] as num?)?.toInt(),
  dotsScore: (json['dotsScore'] as num?)?.toDouble(),
  big3Total: (json['big3Total'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CommunityUserProfileDtoToJson(
  _CommunityUserProfileDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'level': instance.level,
  'canViewStats': instance.canViewStats,
  'big3Prs': instance.big3Prs,
  'totalTrainingDurationSeconds': instance.totalTrainingDurationSeconds,
  'totalTrainingVolume': instance.totalTrainingVolume,
  'email': instance.email,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'gender': instance.gender,
  'friendStatus': instance.friendStatus,
  'friendshipId': instance.friendshipId,
  'requestDirection': instance.requestDirection,
  'developmentDirection': instance.developmentDirection,
  'trainingDiscipline': instance.trainingDiscipline,
  'height': instance.height,
  'latestBodyweight': instance.latestBodyweight,
  'bmi': instance.bmi,
  'bmiCategory': instance.bmiCategory,
  'currentStreak': instance.currentStreak,
  'dotsScore': instance.dotsScore,
  'big3Total': instance.big3Total,
};

_Big3PrsDto _$Big3PrsDtoFromJson(Map<String, dynamic> json) => _Big3PrsDto(
  squat: (json['squat'] as num?)?.toDouble(),
  bench: (json['bench'] as num?)?.toDouble(),
  deadlift: (json['deadlift'] as num?)?.toDouble(),
);

Map<String, dynamic> _$Big3PrsDtoToJson(_Big3PrsDto instance) =>
    <String, dynamic>{
      'squat': instance.squat,
      'bench': instance.bench,
      'deadlift': instance.deadlift,
    };

_FriendDto _$FriendDtoFromJson(Map<String, dynamic> json) => _FriendDto(
  userId: json['userId'] as String,
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  friendsSince: json['friendsSince'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
);

Map<String, dynamic> _$FriendDtoToJson(_FriendDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'friendsSince': instance.friendsSince,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
    };

_FriendRequestDto _$FriendRequestDtoFromJson(Map<String, dynamic> json) =>
    _FriendRequestDto(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      direction: json['direction'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      respondedAt: json['respondedAt'] as String?,
    );

Map<String, dynamic> _$FriendRequestDtoToJson(_FriendRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'direction': instance.direction,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'avatarUrl': instance.avatarUrl,
      'respondedAt': instance.respondedAt,
    };

_TrainingDayShareDto _$TrainingDayShareDtoFromJson(
  Map<String, dynamic> json,
) => _TrainingDayShareDto(
  id: json['id'] as String,
  userId: json['userId'] as String,
  userFullName: json['userFullName'] as String,
  sourceDailyWorkoutId: json['sourceDailyWorkoutId'] as String,
  workoutDate: json['workoutDate'] as String,
  dayOfWeek: json['dayOfWeek'] as String,
  dayStatus: json['dayStatus'] as String,
  createdAt: json['createdAt'] as String,
  exerciseCount: (json['exerciseCount'] as num?)?.toInt() ?? 0,
  completedSets: (json['completedSets'] as num?)?.toInt() ?? 0,
  totalVolume: (json['totalVolume'] as num?)?.toDouble() ?? 0,
  totalDurationSeconds: (json['totalDurationSeconds'] as num?)?.toInt() ?? 0,
  hasPersonalRecord: json['hasPersonalRecord'] as bool? ?? false,
  loveCount: (json['loveCount'] as num?)?.toInt() ?? 0,
  lovedByCurrentUser: json['lovedByCurrentUser'] as bool? ?? false,
  exercises:
      (json['exercises'] as List<dynamic>?)
          ?.map(
            (e) =>
                TrainingDayShareExerciseDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <TrainingDayShareExerciseDto>[],
  userAvatarUrl: json['userAvatarUrl'] as String?,
  averageRpe: (json['averageRpe'] as num?)?.toDouble(),
  caption: json['caption'] as String?,
);

Map<String, dynamic> _$TrainingDayShareDtoToJson(
  _TrainingDayShareDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userFullName': instance.userFullName,
  'sourceDailyWorkoutId': instance.sourceDailyWorkoutId,
  'workoutDate': instance.workoutDate,
  'dayOfWeek': instance.dayOfWeek,
  'dayStatus': instance.dayStatus,
  'createdAt': instance.createdAt,
  'exerciseCount': instance.exerciseCount,
  'completedSets': instance.completedSets,
  'totalVolume': instance.totalVolume,
  'totalDurationSeconds': instance.totalDurationSeconds,
  'hasPersonalRecord': instance.hasPersonalRecord,
  'loveCount': instance.loveCount,
  'lovedByCurrentUser': instance.lovedByCurrentUser,
  'exercises': instance.exercises,
  'userAvatarUrl': instance.userAvatarUrl,
  'averageRpe': instance.averageRpe,
  'caption': instance.caption,
};

_TrainingDayShareExerciseDto _$TrainingDayShareExerciseDtoFromJson(
  Map<String, dynamic> json,
) => _TrainingDayShareExerciseDto(
  id: json['id'] as String,
  name: json['name'] as String,
  primaryMuscleGroup: json['primaryMuscleGroup'] as String,
  exerciseKind: json['exerciseKind'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  isSkipped: json['isSkipped'] as bool? ?? false,
  isPersonalRecord: json['isPersonalRecord'] as bool? ?? false,
  sets:
      (json['sets'] as List<dynamic>?)
          ?.map(
            (e) => TrainingDayShareSetDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <TrainingDayShareSetDto>[],
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$TrainingDayShareExerciseDtoToJson(
  _TrainingDayShareExerciseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'primaryMuscleGroup': instance.primaryMuscleGroup,
  'exerciseKind': instance.exerciseKind,
  'sortOrder': instance.sortOrder,
  'isSkipped': instance.isSkipped,
  'isPersonalRecord': instance.isPersonalRecord,
  'sets': instance.sets,
  'durationSeconds': instance.durationSeconds,
  'notes': instance.notes,
};

_TrainingDayShareSetDto _$TrainingDayShareSetDtoFromJson(
  Map<String, dynamic> json,
) => _TrainingDayShareSetDto(
  id: json['id'] as String,
  setNumber: (json['setNumber'] as num?)?.toInt() ?? 0,
  isCompleted: json['isCompleted'] as bool? ?? false,
  actualReps: (json['actualReps'] as num?)?.toInt(),
  actualWeight: (json['actualWeight'] as num?)?.toDouble(),
  rpe: (json['rpe'] as num?)?.toDouble(),
);

Map<String, dynamic> _$TrainingDayShareSetDtoToJson(
  _TrainingDayShareSetDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'setNumber': instance.setNumber,
  'isCompleted': instance.isCompleted,
  'actualReps': instance.actualReps,
  'actualWeight': instance.actualWeight,
  'rpe': instance.rpe,
};
