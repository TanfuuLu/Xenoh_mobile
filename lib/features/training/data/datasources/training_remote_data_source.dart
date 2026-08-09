import 'package:dio/dio.dart';

import '../../../../core/models/paged_result.dart';
import '../../../../core/network/paged_response.dart';
import '../../../../core/utils/date_only.dart';
import '../../domain/entities/last_exercise_performance.dart';
import '../dtos/daily_workout_dto.dart';
import '../dtos/exercise_dto.dart';
import '../dtos/exercise_template_dto.dart';
import '../dtos/plan_dto.dart';
import '../dtos/weekly_workout_dto.dart';

/// Thin wrapper over the training endpoints. Throws [DioException]; the
/// repository maps to domain failures.
class TrainingRemoteDataSource {
  TrainingRemoteDataSource(this._dio);

  final Dio _dio;

  Future<PagedResult<PlanDto>> getPlans({
    required int pageNumber,
    required int pageSize,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/plans',
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    return parsePagedResponse(res.data!, PlanDto.fromJson);
  }

  Future<PlanDto> getPlan(String planId) async {
    final res = await _dio.get<Map<String, dynamic>>('/plans/$planId');
    return PlanDto.fromJson(res.data!);
  }

  Future<PlanDto> createPlan({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/plans',
      data: {
        'name': name,
        'startDate': DateOnly.format(startDate),
        'endDate': DateOnly.format(endDate),
      },
    );
    return PlanDto.fromJson(res.data!);
  }

  Future<PlanDto> updatePlan({
    required String planId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/plans/$planId',
      data: {
        'name': name,
        'startDate': DateOnly.format(startDate),
        'endDate': DateOnly.format(endDate),
      },
    );
    return PlanDto.fromJson(res.data!);
  }

  Future<void> deletePlan(String planId) async {
    await _dio.delete<void>('/plans/$planId');
  }

  Future<PlanDto> activatePlan(String planId) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/plans/$planId/activate',
    );
    return PlanDto.fromJson(res.data!);
  }

  Future<PlanDto> deactivatePlan(String planId) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/plans/$planId/deactivate',
    );
    return PlanDto.fromJson(res.data!);
  }

  Future<PlanDto> duplicatePlan({
    required String sourcePlanId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/plans/$sourcePlanId/duplicate',
      data: {
        'name': name,
        'startDate': DateOnly.format(startDate),
        'endDate': DateOnly.format(endDate),
      },
    );
    return PlanDto.fromJson(res.data!);
  }

  Future<String> exportPlanCsv(String planId) async {
    final res = await _dio.get<String>(
      '/plans/$planId/export',
      options: Options(
        responseType: ResponseType.plain,
        headers: {'Accept': 'text/csv'},
      ),
    );
    return res.data ?? '';
  }

  Future<PagedResult<WeeklyWorkoutDto>> getWeeks(
    String planId, {
    required int pageNumber,
    required int pageSize,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/plans/$planId/weeks',
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    return parsePagedResponse(res.data!, WeeklyWorkoutDto.fromJson);
  }

  Future<WeeklyWorkoutDto> renameWeek({
    required String planId,
    required String weeklyWorkoutId,
    required String name,
  }) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/plans/$planId/weeks/$weeklyWorkoutId',
      data: {'weeklyWorkoutId': weeklyWorkoutId, 'name': name},
    );
    return WeeklyWorkoutDto.fromJson(res.data!);
  }

  Future<PagedResult<DailyWorkoutDto>> getDays(
    String weeklyWorkoutId, {
    required int pageNumber,
    required int pageSize,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/weeks/$weeklyWorkoutId/days',
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    return parsePagedResponse(res.data!, DailyWorkoutDto.fromJson);
  }

  Future<void> setDayStatus(String dailyWorkoutId, String status) async {
    await _dio.patch<void>(
      '/days/$dailyWorkoutId/status',
      data: {'status': status},
    );
  }

  Future<void> completeDay(String dailyWorkoutId) async {
    await _dio.patch<void>('/days/$dailyWorkoutId/complete-all');
  }

  Future<CopyDailyWorkoutDto> copyDay({
    required String sourceDailyWorkoutId,
    required String targetDailyWorkoutId,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/days/$sourceDailyWorkoutId/copy',
      data: {'targetDailyWorkoutId': targetDailyWorkoutId},
    );
    return CopyDailyWorkoutDto.fromJson(res.data!);
  }

  Future<List<ExerciseDto>> getExercisesByDay(String dailyWorkoutId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/exercises/by-day/$dailyWorkoutId',
      queryParameters: {'pageNumber': 1, 'pageSize': 100},
    );
    final page = parsePagedResponse(res.data!, ExerciseDto.fromJson);
    return page.items;
  }

  Future<List<ExerciseDto>> getExercisesByWeek(String weeklyWorkoutId) async {
    final res = await _dio.get<dynamic>(
      '/exercises/by-week/$weeklyWorkoutId',
      queryParameters: {'pageNumber': 1, 'pageSize': 500},
    );
    final data = res.data;
    if (data is Map<String, dynamic>) {
      final page = parsePagedResponse(data, ExerciseDto.fromJson);
      return page.items;
    }
    if (data is List<dynamic>) {
      return data
          .map((e) => ExerciseDto.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    }
    return const [];
  }

  Future<List<ExerciseDto>> reorderExercises({
    required String dailyWorkoutId,
    required List<String> exerciseIds,
  }) async {
    final res = await _dio.patch<List<dynamic>>(
      '/exercises/by-day/$dailyWorkoutId/reorder',
      data: {'dailyWorkoutId': dailyWorkoutId, 'exerciseIds': exerciseIds},
    );
    return (res.data ?? const [])
        .map((e) => ExerciseDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ExerciseDto> markSetComplete(
    String setId, {
    int? actualReps,
    double? actualWeight,
    double? rpe,
  }) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/exercises/sets/$setId/complete',
      data: {
        'actualReps': ?actualReps,
        'actualWeight': ?actualWeight,
        'rpe': ?rpe,
      },
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<ExerciseDto> updateSetPlan(
    String setId, {
    int? plannedReps,
    double? plannedWeight,
  }) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/exercises/sets/$setId',
      data: {'plannedReps': ?plannedReps, 'plannedWeight': ?plannedWeight},
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<LastExercisePerformance> getLastExercisePerformance({
    required String exerciseTemplateId,
    required String dailyWorkoutId,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/exercise-templates/$exerciseTemplateId/last-performance',
      queryParameters: {'dailyWorkoutId': dailyWorkoutId},
    );
    return LastExercisePerformance.fromJson(res.data!);
  }

  Future<ExerciseDto> startExerciseTimer(String exerciseId) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/exercises/$exerciseId/timer/start',
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<ExerciseDto> finishExerciseTimer(String exerciseId) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/exercises/$exerciseId/timer/finish',
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<ExerciseDto> setExerciseTimerDuration({
    required String exerciseId,
    required int durationSeconds,
  }) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/exercises/$exerciseId/timer/set-duration',
      data: {'exerciseId': exerciseId, 'durationSeconds': durationSeconds},
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<ExerciseDto> createExercise({
    required String dailyWorkoutId,
    required String exerciseTemplateId,
    required int plannedSets,
    required int plannedReps,
    double? plannedWeight,
    String? notes,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/exercises',
      data: {
        'dailyWorkoutId': dailyWorkoutId,
        'exerciseTemplateId': exerciseTemplateId,
        'plannedSets': plannedSets,
        'plannedReps': plannedReps,
        'plannedWeight': ?plannedWeight,
        'notes': ?notes,
      },
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<ExerciseDto> updateExercise(
    String exerciseId, {
    int? plannedSets,
    int? plannedReps,
    double? plannedWeight,
    String? notes,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/exercises/$exerciseId',
      data: {
        'exerciseId': exerciseId,
        'plannedSets': ?plannedSets,
        'plannedReps': ?plannedReps,
        'plannedWeight': ?plannedWeight,
        'notes': notes,
      },
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<ExerciseDto> updateExerciseNotes(
    String exerciseId, {
    String? notes,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/exercises/$exerciseId',
      data: {'exerciseId': exerciseId, 'notes': notes},
    );
    return ExerciseDto.fromJson(res.data!);
  }

  Future<void> deleteExercise(String exerciseId) async {
    await _dio.delete<void>('/exercises/$exerciseId');
  }

  Future<ExerciseDto> skipExercise(
    String exerciseId, {
    required bool isSkipped,
  }) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/exercises/$exerciseId/skip',
      data: {
        'exerciseId': exerciseId,
        'isSkipped': isSkipped,
      },
    );
    return ExerciseDto.fromJson(res.data!);
  }

  /// Backend returns a bare `ExerciseTemplateResponse[]` (no pagination —
  /// the route doesn't accept pageNumber/pageSize at all), unlike most other
  /// list endpoints in this API.
  Future<List<ExerciseTemplateDto>> getExerciseTemplates({
    String? muscleGroup,
    String? clientId,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      clientId == null
          ? '/exercise-templates'
          : '/exercise-templates/for-client/$clientId',
      queryParameters: {'muscleGroup': ?muscleGroup},
    );
    return (res.data ?? const [])
        .map((e) => ExerciseTemplateDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ExerciseTemplateDto> createCustomExerciseTemplate({
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
    String? clientId,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      clientId == null
          ? '/exercise-templates/custom'
          : '/exercise-templates/custom/for-client/$clientId',
      data: {
        'clientId': ?clientId,
        'name': name,
        'description': ?description,
        'primaryMuscleGroup': primaryMuscleGroup,
        'secondaryMuscleGroups': secondaryMuscleGroups,
        'exerciseKind': exerciseKind,
      },
    );
    return ExerciseTemplateDto.fromJson(res.data!);
  }

  Future<ExerciseTemplateDto> updateCustomExerciseTemplate({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/exercise-templates/custom/$id',
      data: {
        'id': id,
        'name': name,
        'description': ?description,
        'primaryMuscleGroup': primaryMuscleGroup,
        'secondaryMuscleGroups': secondaryMuscleGroups,
        'exerciseKind': exerciseKind,
      },
    );
    return ExerciseTemplateDto.fromJson(res.data!);
  }

  Future<void> deleteCustomExerciseTemplate(String id) async {
    await _dio.delete<void>('/exercise-templates/custom/$id');
  }
}
