import 'package:dio/dio.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/error/api_exception.dart';
import '../../../../core/models/paged_result.dart';
import '../../domain/entities/daily_workout.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_template.dart';
import '../../domain/entities/plan.dart';
import '../../domain/entities/weekly_workout.dart';
import '../../domain/repositories/training_repository.dart';
import '../datasources/training_remote_data_source.dart';
import '../dtos/exercise_dto.dart';

class TrainingRepositoryImpl implements TrainingRepository {
  TrainingRepositoryImpl(this._remote);

  final TrainingRemoteDataSource _remote;

  @override
  Future<PagedResult<Plan>> getPlans({
    int pageNumber = 1,
    int pageSize = 20,
  }) => _guard(() async {
    final page = await _remote.getPlans(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    return _mapPage(page, (dto) => dto.toEntity());
  });

  @override
  Future<Plan> getPlan(String planId) =>
      _guard(() async => (await _remote.getPlan(planId)).toEntity());

  @override
  Future<Plan> createPlan({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) => _guard(
    () async => (await _remote.createPlan(
      name: name,
      startDate: startDate,
      endDate: endDate,
    )).toEntity(),
  );

  @override
  Future<Plan> updatePlan({
    required String planId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) => _guard(
    () async => (await _remote.updatePlan(
      planId: planId,
      name: name,
      startDate: startDate,
      endDate: endDate,
    )).toEntity(),
  );

  @override
  Future<void> deletePlan(String planId) =>
      _guard(() => _remote.deletePlan(planId));

  @override
  Future<Plan> activatePlan(String planId) =>
      _guard(() async => (await _remote.activatePlan(planId)).toEntity());

  @override
  Future<Plan> deactivatePlan(String planId) =>
      _guard(() async => (await _remote.deactivatePlan(planId)).toEntity());

  @override
  Future<Plan> duplicatePlan({
    required String sourcePlanId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) => _guard(
    () async => (await _remote.duplicatePlan(
      sourcePlanId: sourcePlanId,
      name: name,
      startDate: startDate,
      endDate: endDate,
    )).toEntity(),
  );

  @override
  Future<String> exportPlanCsv(String planId) =>
      _guard(() => _remote.exportPlanCsv(planId));

  @override
  Future<PagedResult<WeeklyWorkout>> getWeeks(
    String planId, {
    int pageNumber = 1,
    int pageSize = 20,
  }) => _guard(() async {
    final page = await _remote.getWeeks(
      planId,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    return _mapPage(page, (dto) => dto.toEntity());
  });

  @override
  Future<WeeklyWorkout> renameWeek({
    required String planId,
    required String weeklyWorkoutId,
    required String name,
  }) => _guard(
    () async => (await _remote.renameWeek(
      planId: planId,
      weeklyWorkoutId: weeklyWorkoutId,
      name: name,
    )).toEntity(),
  );

  @override
  Future<PagedResult<DailyWorkout>> getDays(
    String weeklyWorkoutId, {
    int pageNumber = 1,
    int pageSize = 20,
  }) => _guard(() async {
    final page = await _remote.getDays(
      weeklyWorkoutId,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    return _mapPage(page, (dto) => dto.toEntity());
  });

  @override
  Future<void> setDayStatus(String dailyWorkoutId, String status) =>
      _guard(() => _remote.setDayStatus(dailyWorkoutId, status));

  @override
  Future<void> completeDay(String dailyWorkoutId) =>
      _guard(() => _remote.completeDay(dailyWorkoutId));

  @override
  Future<int> copyDay({
    required String sourceDailyWorkoutId,
    required String targetDailyWorkoutId,
  }) => _guard(
    () async => (await _remote.copyDay(
      sourceDailyWorkoutId: sourceDailyWorkoutId,
      targetDailyWorkoutId: targetDailyWorkoutId,
    )).exercisesCopied,
  );

  @override
  Future<List<Exercise>> getExercisesByDay(String dailyWorkoutId) =>
      _guard(() async {
        final dtos = await _remote.getExercisesByDay(dailyWorkoutId);
        return _mapExercises(dtos);
      });

  @override
  Future<List<Exercise>> getExercisesByWeek(String weeklyWorkoutId) =>
      _guard(() async {
        final dtos = await _remote.getExercisesByWeek(weeklyWorkoutId);
        return _mapExercises(dtos);
      });

  @override
  Future<List<Exercise>> reorderExercises({
    required String dailyWorkoutId,
    required List<String> exerciseIds,
  }) => _guard(() async {
    final dtos = await _remote.reorderExercises(
      dailyWorkoutId: dailyWorkoutId,
      exerciseIds: exerciseIds,
    );
    return _mapExercises(dtos);
  });

  @override
  Future<Exercise> markSetComplete(
    String setId, {
    int? actualReps,
    double? actualWeight,
    double? rpe,
  }) => _guard(() async {
    final dto = await _remote.markSetComplete(
      setId,
      actualReps: actualReps,
      actualWeight: actualWeight,
      rpe: rpe,
    );
    return _mapExercise(dto);
  });

  @override
  Future<Exercise> startExerciseTimer(String exerciseId) => _guard(
    () async => _mapExercise(await _remote.startExerciseTimer(exerciseId)),
  );

  @override
  Future<Exercise> finishExerciseTimer(String exerciseId) => _guard(
    () async => _mapExercise(await _remote.finishExerciseTimer(exerciseId)),
  );

  @override
  Future<Exercise> setExerciseTimerDuration({
    required String exerciseId,
    required int durationSeconds,
  }) => _guard(() async {
    final dto = await _remote.setExerciseTimerDuration(
      exerciseId: exerciseId,
      durationSeconds: durationSeconds,
    );
    return _mapExercise(dto);
  });

  @override
  Future<Exercise> createExercise({
    required String dailyWorkoutId,
    required String exerciseTemplateId,
    required int plannedSets,
    required int plannedReps,
    double? plannedWeight,
    String? notes,
  }) => _guard(() async {
    final dto = await _remote.createExercise(
      dailyWorkoutId: dailyWorkoutId,
      exerciseTemplateId: exerciseTemplateId,
      plannedSets: plannedSets,
      plannedReps: plannedReps,
      plannedWeight: plannedWeight,
      notes: notes,
    );
    return _mapExercise(dto);
  });

  @override
  Future<Exercise> updateExercise(
    String exerciseId, {
    int? plannedSets,
    int? plannedReps,
    double? plannedWeight,
    String? notes,
  }) => _guard(() async {
    final dto = await _remote.updateExercise(
      exerciseId,
      plannedSets: plannedSets,
      plannedReps: plannedReps,
      plannedWeight: plannedWeight,
      notes: notes,
    );
    return _mapExercise(dto);
  });

  @override
  Future<Exercise> updateExerciseNotes(
    String exerciseId, {
    String? notes,
  }) => _guard(() async {
    final dto = await _remote.updateExerciseNotes(exerciseId, notes: notes);
    return _mapExercise(dto);
  });

  @override
  Future<void> deleteExercise(String exerciseId) =>
      _guard(() => _remote.deleteExercise(exerciseId));

  @override
  Future<Exercise> skipExercise(
    String exerciseId, {
    required bool isSkipped,
  }) => _guard(
    () async => _mapExercise(
      await _remote.skipExercise(exerciseId, isSkipped: isSkipped),
    ),
  );

  @override
  Future<List<ExerciseTemplate>> getExerciseTemplates({
    String? muscleGroup,
  }) => _guard(() async {
    final templates = await _remote.getExerciseTemplates(
      muscleGroup: muscleGroup,
    );
    return [
      for (final dto in templates)
        dto.toEntity().copyWith(imageUrl: _normalizeImageUrl(dto.imageUrl)),
    ];
  });

  @override
  Future<ExerciseTemplate> createCustomExerciseTemplate({
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
  }) => _guard(
    () async => (await _remote.createCustomExerciseTemplate(
      name: name,
      primaryMuscleGroup: primaryMuscleGroup,
      secondaryMuscleGroups: secondaryMuscleGroups,
      exerciseKind: exerciseKind,
      description: description,
    )).toEntity(),
  );

  @override
  Future<ExerciseTemplate> updateCustomExerciseTemplate({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
  }) => _guard(
    () async => (await _remote.updateCustomExerciseTemplate(
      id: id,
      name: name,
      primaryMuscleGroup: primaryMuscleGroup,
      secondaryMuscleGroups: secondaryMuscleGroups,
      exerciseKind: exerciseKind,
      description: description,
    )).toEntity(),
  );

  @override
  Future<void> deleteCustomExerciseTemplate(String id) =>
      _guard(() => _remote.deleteCustomExerciseTemplate(id));

  // Maps a DTO page to an entity page, preserving pagination metadata.
  PagedResult<E> _mapPage<D, E>(
    PagedResult<D> page,
    E Function(D dto) map,
  ) => PagedResult<E>(
    items: page.items.map(map).toList(),
    pageNumber: page.pageNumber,
    pageSize: page.pageSize,
    totalCount: page.totalCount,
    hasMore: page.hasMore,
  );

  Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  Future<Map<String, String>> _getTemplateImageUrls() async {
    final templates = await _remote.getExerciseTemplates();
    return {
      for (final template in templates)
        if (_hasValue(template.imageUrl))
          template.id: _normalizeImageUrl(template.imageUrl)!,
    };
  }

  Future<List<Exercise>> _mapExercises(List<ExerciseDto> dtos) async {
    final exercises = dtos.map(_normalizeExerciseImage).toList();
    if (exercises.every((e) => _hasValue(e.imageUrl))) return exercises;

    final templateImages = await _getTemplateImageUrls();
    return [
      for (final exercise in exercises)
        if (_hasValue(exercise.imageUrl))
          exercise
        else
          exercise.copyWith(
            imageUrl: templateImages[exercise.exerciseTemplateId],
          ),
    ];
  }

  Future<Exercise> _mapExercise(ExerciseDto dto) async {
    final exercise = _normalizeExerciseImage(dto);
    if (_hasValue(exercise.imageUrl)) return exercise;

    final templateImages = await _getTemplateImageUrls();
    return exercise.copyWith(
      imageUrl: templateImages[exercise.exerciseTemplateId],
    );
  }

  Exercise _normalizeExerciseImage(ExerciseDto dto) {
    final exercise = dto.toEntity();
    return exercise.copyWith(imageUrl: _normalizeImageUrl(exercise.imageUrl));
  }

  String? _normalizeImageUrl(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;

    final uri = Uri.tryParse(trimmed);
    if (uri != null && uri.hasScheme) return trimmed;

    final assetsUri = Uri.parse(AppConfig.assetsBaseUrl);
    final assetsBase = assetsUri.path.endsWith('/')
        ? assetsUri
        : assetsUri.replace(path: '${assetsUri.path}/');
    final objectKey = trimmed.replaceFirst(RegExp('^/+'), '');
    return assetsBase.resolve(objectKey).toString();
  }

  bool _hasValue(String? value) => value != null && value.trim().isNotEmpty;
}
