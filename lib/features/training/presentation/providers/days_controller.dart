import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/daily_workout.dart';
import 'week_analysis_provider.dart';

part 'days_controller.g.dart';

/// Days within a week.
@riverpod
class DaysController extends _$DaysController {
  @override
  Future<List<DailyWorkout>> build(String weeklyWorkoutId) async {
    final result = await ref
        .watch(trainingRepositoryProvider)
        .getDays(weeklyWorkoutId, pageNumber: 1, pageSize: 100);
    return result.items;
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(trainingRepositoryProvider)
          .getDays(weeklyWorkoutId, pageNumber: 1, pageSize: 100);
      return result.items;
    });
  }

  Future<void> setStatus(String dailyWorkoutId, String status) async {
    await ref
        .read(trainingRepositoryProvider)
        .setDayStatus(dailyWorkoutId, status);
    await refresh();
    ref.invalidate(weekAnalysisProvider(weeklyWorkoutId));
  }

  Future<int> copyDay({
    required String sourceDailyWorkoutId,
    required String targetDailyWorkoutId,
  }) async {
    final copied = await ref
        .read(trainingRepositoryProvider)
        .copyDay(
          sourceDailyWorkoutId: sourceDailyWorkoutId,
          targetDailyWorkoutId: targetDailyWorkoutId,
        );
    await refresh();
    ref.invalidate(weekAnalysisProvider(weeklyWorkoutId));
    return copied;
  }
}
