import '../../../../core/models/paged_result.dart';
import '../entities/daily_workout.dart';
import '../entities/exercise.dart';
import '../entities/exercise_template.dart';
import '../entities/last_exercise_performance.dart';
import '../entities/plan.dart';
import '../entities/weekly_workout.dart';

/// Aggregate repository for the training loop (plans → weeks → days →
/// exercises). Methods throw a domain `Failure` on error.
abstract interface class TrainingRepository {
  Future<PagedResult<Plan>> getPlans({int pageNumber = 1, int pageSize = 20});

  Future<Plan> getPlan(String planId);

  Future<Plan> createPlan({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<Plan> updatePlan({
    required String planId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<void> deletePlan(String planId);

  Future<Plan> activatePlan(String planId);

  Future<Plan> deactivatePlan(String planId);

  Future<Plan> duplicatePlan({
    required String sourcePlanId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<String> exportPlanCsv(String planId);

  Future<PagedResult<WeeklyWorkout>> getWeeks(
    String planId, {
    int pageNumber = 1,
    int pageSize = 20,
  });

  Future<WeeklyWorkout> renameWeek({
    required String planId,
    required String weeklyWorkoutId,
    required String name,
  });

  Future<PagedResult<DailyWorkout>> getDays(
    String weeklyWorkoutId, {
    int pageNumber = 1,
    int pageSize = 20,
  });

  Future<void> setDayStatus(String dailyWorkoutId, String status);

  Future<void> completeDay(String dailyWorkoutId);

  Future<int> copyDay({
    required String sourceDailyWorkoutId,
    required String targetDailyWorkoutId,
  });

  Future<List<Exercise>> getExercisesByDay(String dailyWorkoutId);

  Future<List<Exercise>> getExercisesByWeek(String weeklyWorkoutId);

  Future<List<Exercise>> reorderExercises({
    required String dailyWorkoutId,
    required List<String> exerciseIds,
  });

  /// Mark a set complete; returns the updated parent exercise.
  Future<Exercise> markSetComplete(
    String setId, {
    int? actualReps,
    double? actualWeight,
    double? rpe,
  });

  Future<Exercise> updateSetPlan(
    String setId, {
    int? plannedReps,
    double? plannedWeight,
  });

  Future<LastExercisePerformance> getLastExercisePerformance({
    required String exerciseTemplateId,
    required String dailyWorkoutId,
  });

  Future<Exercise> startExerciseTimer(String exerciseId);

  Future<Exercise> finishExerciseTimer(String exerciseId);

  Future<Exercise> setExerciseTimerDuration({
    required String exerciseId,
    required int durationSeconds,
  });

  /// Add an exercise (from a template) to a daily workout.
  Future<Exercise> createExercise({
    required String dailyWorkoutId,
    required String exerciseTemplateId,
    required int plannedSets,
    required int plannedReps,
    double? plannedWeight,
    String? notes,
  });

  /// Update an exercise's planned metrics; returns the updated exercise.
  Future<Exercise> updateExercise(
    String exerciseId, {
    int? plannedSets,
    int? plannedReps,
    double? plannedWeight,
    String? notes,
  });

  Future<Exercise> updateExerciseNotes(String exerciseId, {String? notes});

  Future<void> deleteExercise(String exerciseId);

  Future<Exercise> skipExercise(String exerciseId, {required bool isSkipped});

  /// Exercise templates to pick from when adding an exercise. The backend
  /// returns the full list unpaginated.
  Future<List<ExerciseTemplate>> getExerciseTemplates({
    String? muscleGroup,
    String? clientId,
  });

  Future<ExerciseTemplate> createCustomExerciseTemplate({
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
    String? clientId,
  });

  Future<ExerciseTemplate> updateCustomExerciseTemplate({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
  });

  Future<void> deleteCustomExerciseTemplate(String id);
}
