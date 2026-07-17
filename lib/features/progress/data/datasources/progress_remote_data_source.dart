import 'package:dio/dio.dart';

import '../../../../core/network/api_language.dart';
import '../dtos/exercise_pr_dto.dart';
import '../dtos/plan_analytics_dto.dart';

/// Thin wrapper over the progress/analytics endpoints. Throws [DioException];
/// the repository maps to domain failures.
class ProgressRemoteDataSource {
  ProgressRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<ExercisePrDto>> getExercisePrs() async {
    final res = await _dio.get<List<dynamic>>('/users/me/exercise-prs');
    return (res.data ?? const [])
        .map((e) => ExercisePrDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ExercisePrPointDto>> getExercisePrHistory(
    String exerciseTemplateId,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      '/users/me/exercise-prs/$exerciseTemplateId/history',
    );
    return (res.data ?? const [])
        .map((e) => ExercisePrPointDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PlanAnalyticsDto> getPlanAnalytics(String planId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/plans/$planId/analytics',
      queryParameters: {'lang': apiLanguageCode},
    );
    return PlanAnalyticsDto.fromJson(res.data!);
  }
}
