import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// The signed-in user's full profile (`UserProfileResponse`, API ref §3.2).
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required int currentStreak,
    required int level,
    required int totalXp,
    required int xpToNextLevel,
    required String title,
    required Big3Prs big3Prs,
    String? avatarUrl,
    String? bio,
    double? height,
    String? gender,
    DateTime? dateOfBirth,
    String? developmentDirection,
    String? trainingDiscipline,
    double? latestBodyweight,
    double? bmi,
    String? bmiCategory,
    double? dotsScore,
    String? facebookUrl,
    String? instagramUrl,
    String? zaloUrl,
  }) = _UserProfile;

  const UserProfile._();

  String get fullName => '$firstName $lastName'.trim();

  /// Progress toward the next level, 0..1. `totalXp` is cumulative within the
  /// current level band; `xpToNextLevel` is the band size.
  double get levelProgress {
    final span = totalXp + xpToNextLevel;
    if (span <= 0) return 0;
    return (totalXp / span).clamp(0.0, 1.0);
  }

  int? get age {
    final dob = dateOfBirth;
    if (dob == null) return null;
    final now = DateTime.now();
    var years = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      years--;
    }
    return years;
  }
}

@freezed
abstract class Big3Prs with _$Big3Prs {
  const factory Big3Prs({double? squat, double? bench, double? deadlift}) =
      _Big3Prs;
}
