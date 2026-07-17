import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/plan.dart';
import '../../domain/entities/weekly_workout.dart';

part 'plan_detail_controller.g.dart';

/// Plan header detail (for the plan detail screen app bar / progress).
@riverpod
Future<Plan> planDetail(Ref ref, String planId) =>
    ref.watch(trainingRepositoryProvider).getPlan(planId);

/// Weeks within a plan.
@riverpod
class WeeksController extends _$WeeksController {
  @override
  Future<List<WeeklyWorkout>> build(String planId) async {
    final result = await ref
        .watch(trainingRepositoryProvider)
        .getWeeks(planId, pageNumber: 1, pageSize: 100);
    return result.items;
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(trainingRepositoryProvider)
          .getWeeks(planId, pageNumber: 1, pageSize: 100);
      return result.items;
    });
  }

  Future<void> renameWeek({
    required String weeklyWorkoutId,
    required String name,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .renameWeek(
          planId: planId,
          weeklyWorkoutId: weeklyWorkoutId,
          name: name,
        );
    final current = state.value;
    if (current == null) {
      await refresh();
      return;
    }
    state = AsyncValue.data([
      for (final week in current)
        if (week.id == updated.id) updated else week,
    ]);
  }
}
