import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/user_profile.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// `UserProfileResponse` (API ref §3.2). `dateOfBirth` is a `DateOnly` string.
@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required int currentStreak,
    required int level,
    required int totalXp,
    required int xpToNextLevel,
    required String title,
    Big3PrsDto? big3Prs,
    String? avatarUrl,
    String? bio,
    double? height,
    String? gender,
    String? dateOfBirth,
    String? developmentDirection,
    String? trainingDiscipline,
    double? latestBodyweight,
    double? bmi,
    String? bmiCategory,
    double? dotsScore,
    String? facebookUrl,
    String? instagramUrl,
    String? zaloUrl,
  }) = _UserProfileDto;

  const UserProfileDto._();

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  UserProfile toEntity() => UserProfile(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    currentStreak: currentStreak,
    level: level,
    totalXp: totalXp,
    xpToNextLevel: xpToNextLevel,
    title: title,
    big3Prs: big3Prs?.toEntity() ?? const Big3Prs(),
    avatarUrl: avatarUrl,
    bio: bio,
    height: height,
    gender: gender,
    dateOfBirth: DateOnly.tryParse(dateOfBirth),
    developmentDirection: developmentDirection,
    trainingDiscipline: trainingDiscipline,
    latestBodyweight: latestBodyweight,
    bmi: bmi,
    bmiCategory: bmiCategory,
    dotsScore: dotsScore,
    facebookUrl: facebookUrl,
    instagramUrl: instagramUrl,
    zaloUrl: zaloUrl,
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
