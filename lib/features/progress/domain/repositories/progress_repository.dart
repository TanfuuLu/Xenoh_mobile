import '../entities/exercise_pr.dart';
import '../entities/plan_analytics.dart';

/// Read-only progress/analytics aggregate (personal records + plan analytics).
/// Methods throw a domain `Failure` on error.
abstract interface class ProgressRepository {
  /// Current personal records across all exercises, best first.
  Future<List<ExercisePr>> getExercisePrs();

  /// PR progression for one exercise template, sorted oldest → newest.
  Future<List<ExercisePrPoint>> getExercisePrHistory(String exerciseTemplateId);

  /// Pro-gated plan analytics. Throws `ForbiddenFailure` for non-Pro users.
  Future<PlanAnalytics> getPlanAnalytics(String planId);
}
