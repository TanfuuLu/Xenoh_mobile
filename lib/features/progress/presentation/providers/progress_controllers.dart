import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../data/repositories/progress_repository_provider.dart';
import '../../domain/entities/exercise_pr.dart';
import '../../domain/entities/plan_analytics.dart';

part 'progress_controllers.g.dart';

/// Current personal records across all exercises. Refresh by invalidating.
@riverpod
Future<List<ExercisePr>> exercisePrs(Ref ref) {
  ref.syncOn(const [DataTopic.training]);
  return ref.watch(progressRepositoryProvider).getExercisePrs();
}

/// PR progression for one exercise template (oldest → newest).
@riverpod
Future<List<ExercisePrPoint>> exercisePrHistory(
  Ref ref,
  String exerciseTemplateId,
) {
  ref.syncOn(const [DataTopic.training]);
  return ref
      .watch(progressRepositoryProvider)
      .getExercisePrHistory(exerciseTemplateId);
}

/// Pro-gated analytics for one plan. Emits `ForbiddenFailure` for non-Pro.
@riverpod
Future<PlanAnalytics> planAnalytics(Ref ref, String planId) {
  ref
    ..watch(appLocaleProvider)
    ..syncOn(const [DataTopic.training]);
  return ref.watch(progressRepositoryProvider).getPlanAnalytics(planId);
}
