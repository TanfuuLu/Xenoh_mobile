import 'package:dio/dio.dart';

import '../../../../core/utils/date_only.dart';
import '../dtos/bodyweight_log_dto.dart';
import '../dtos/training_activity_dto.dart';
import '../dtos/user_profile_dto.dart';
import '../dtos/volume_history_point_dto.dart';

/// Thin wrapper over the `/users/me` profile endpoints. Throws [DioException];
/// the repository maps to domain failures.
class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this._dio);

  final Dio _dio;

  Future<UserProfileDto> getMe() async {
    final res = await _dio.get<Map<String, dynamic>>('/users/me');
    return UserProfileDto.fromJson(res.data!);
  }

  Future<TrainingActivityDto> getTrainingActivity({
    required int year,
    required int month,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/users/me/training-activity',
      queryParameters: {'year': year, 'month': month},
    );
    return TrainingActivityDto.fromJson(res.data!);
  }

  Future<List<VolumeHistoryPointDto>> getVolumeHistory({
    required int months,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      '/users/me/volume-history',
      queryParameters: {'months': months},
    );
    return (res.data ?? const [])
        .map(
          (item) => VolumeHistoryPointDto.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  /// `PUT /users/me` (`UpdateMyProfileCommand`). All fields optional — null
  /// values are omitted so they aren't changed on the server.
  Future<UserProfileDto> updateProfile({
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
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/users/me',
      data: {
        'firstName': ?firstName,
        'lastName': ?lastName,
        'bio': ?bio,
        'height': ?height,
        'gender': ?gender,
        if (dateOfBirth != null) 'dateOfBirth': DateOnly.format(dateOfBirth),
        'developmentDirection': ?developmentDirection,
        'trainingDiscipline': ?trainingDiscipline,
        'facebookUrl': ?facebookUrl,
        'instagramUrl': ?instagramUrl,
        'zaloUrl': ?zaloUrl,
      },
    );
    return UserProfileDto.fromJson(res.data!);
  }

  /// `POST /users/me/bodyweight` — logs a new bodyweight entry (20–500 kg).
  Future<void> logBodyweight(double weight) async {
    await _dio.post<Map<String, dynamic>>(
      '/users/me/bodyweight',
      data: {'weight': weight},
    );
  }

  /// `GET /users/me/bodyweight` — full bodyweight history.
  Future<List<BodyweightLogDto>> getBodyweightHistory() async {
    final res = await _dio.get<List<dynamic>>('/users/me/bodyweight');
    return (res.data ?? const [])
        .map((e) => BodyweightLogDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteBodyweightLog(String id) async {
    await _dio.delete<void>('/users/me/bodyweight/$id');
  }

  Future<UserProfileDto> uploadAvatar(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    final res = await _dio.post<Map<String, dynamic>>(
      '/users/me/avatar',
      data: formData,
    );
    return UserProfileDto.fromJson(res.data!);
  }
}
