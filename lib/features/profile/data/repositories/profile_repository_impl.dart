import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/bodyweight_log.dart';
import '../../domain/entities/training_activity.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remote);

  final ProfileRemoteDataSource _remote;

  @override
  Future<UserProfile> getMe() async {
    try {
      final dto = await _remote.getMe();
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<TrainingActivity> getTrainingActivity({
    required int year,
    required int month,
  }) async {
    try {
      final dto = await _remote.getTrainingActivity(year: year, month: month);
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
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
  }) async {
    try {
      final dto = await _remote.updateProfile(
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        height: height,
        gender: gender,
        dateOfBirth: dateOfBirth,
        developmentDirection: developmentDirection,
        trainingDiscipline: trainingDiscipline,
        facebookUrl: facebookUrl,
        instagramUrl: instagramUrl,
        zaloUrl: zaloUrl,
      );
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> logBodyweight(double weight) async {
    try {
      await _remote.logBodyweight(weight);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<List<BodyweightLog>> getBodyweightHistory() async {
    try {
      final dtos = await _remote.getBodyweightHistory();
      final logs = dtos.map((e) => e.toEntity()).toList()
        ..sort((a, b) => a.date.compareTo(b.date));
      return logs;
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> deleteBodyweightLog(String id) async {
    try {
      await _remote.deleteBodyweightLog(id);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<UserProfile> uploadAvatar(String filePath) async {
    try {
      final dto = await _remote.uploadAvatar(filePath);
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
