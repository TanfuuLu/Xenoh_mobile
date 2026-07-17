import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/exercise_pr.dart';
import '../../domain/entities/plan_analytics.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/progress_remote_data_source.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl(this._remote);

  final ProgressRemoteDataSource _remote;

  @override
  Future<List<ExercisePr>> getExercisePrs() => _guard(() async {
    final dtos = await _remote.getExercisePrs();
    return dtos.map((d) => d.toEntity()).toList();
  });

  @override
  Future<List<ExercisePrPoint>> getExercisePrHistory(
    String exerciseTemplateId,
  ) => _guard(() async {
    final dtos = await _remote.getExercisePrHistory(exerciseTemplateId);
    final points = dtos.map((d) => d.toEntity()).toList()
      ..sort((a, b) => a.achievedAt.compareTo(b.achievedAt));
    return points;
  });

  @override
  Future<PlanAnalytics> getPlanAnalytics(String planId) =>
      _guard(() async => (await _remote.getPlanAnalytics(planId)).toEntity());

  Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
