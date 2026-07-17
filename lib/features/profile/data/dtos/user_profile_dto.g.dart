// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) =>
    _UserProfileDto(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      currentStreak: (json['currentStreak'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      totalXp: (json['totalXp'] as num).toInt(),
      xpToNextLevel: (json['xpToNextLevel'] as num).toInt(),
      title: json['title'] as String,
      big3Prs: json['big3Prs'] == null
          ? null
          : Big3PrsDto.fromJson(json['big3Prs'] as Map<String, dynamic>),
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      developmentDirection: json['developmentDirection'] as String?,
      trainingDiscipline: json['trainingDiscipline'] as String?,
      latestBodyweight: (json['latestBodyweight'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      bmiCategory: json['bmiCategory'] as String?,
      dotsScore: (json['dotsScore'] as num?)?.toDouble(),
      facebookUrl: json['facebookUrl'] as String?,
      instagramUrl: json['instagramUrl'] as String?,
      zaloUrl: json['zaloUrl'] as String?,
    );

Map<String, dynamic> _$UserProfileDtoToJson(_UserProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'currentStreak': instance.currentStreak,
      'level': instance.level,
      'totalXp': instance.totalXp,
      'xpToNextLevel': instance.xpToNextLevel,
      'title': instance.title,
      'big3Prs': instance.big3Prs,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'height': instance.height,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'developmentDirection': instance.developmentDirection,
      'trainingDiscipline': instance.trainingDiscipline,
      'latestBodyweight': instance.latestBodyweight,
      'bmi': instance.bmi,
      'bmiCategory': instance.bmiCategory,
      'dotsScore': instance.dotsScore,
      'facebookUrl': instance.facebookUrl,
      'instagramUrl': instance.instagramUrl,
      'zaloUrl': instance.zaloUrl,
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
