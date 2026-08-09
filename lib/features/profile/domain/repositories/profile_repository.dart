import '../entities/bodyweight_log.dart';
import '../entities/training_activity.dart';
import '../entities/user_profile.dart';
import '../entities/volume_history_point.dart';

/// Profile + training-activity reads. Methods throw a domain `Failure`.
abstract interface class ProfileRepository {
  Future<UserProfile> getMe();

  Future<TrainingActivity> getTrainingActivity({
    required int year,
    required int month,
  });

  /// Completed monthly training volume, oldest to newest (1-24 months).
  Future<List<VolumeHistoryPoint>> getVolumeHistory({required int months});

  /// Update the signed-in user's profile. Null fields are left unchanged.
  Future<UserProfile> updateProfile({
    String? firstName,
    String? lastName,
    String? bio,
    double? height,
    String? gender,
    DateTime? dateOfBirth,
    String? developmentDirection,
    String? trainingDiscipline,
    String? facebookUrl,
    String? instagramUrl,
    String? zaloUrl,
  });

  /// Log a new bodyweight entry (kg). Must be 20–500.
  Future<void> logBodyweight(double weight);

  /// Full bodyweight history, sorted oldest → newest.
  Future<List<BodyweightLog>> getBodyweightHistory();

  Future<void> deleteBodyweightLog(String id);

  Future<UserProfile> uploadAvatar(String filePath);
}
