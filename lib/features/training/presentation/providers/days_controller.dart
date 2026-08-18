import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/daily_workout.dart';

part 'days_controller.g.dart';

/// Days within a week.
@riverpod
class DaysController extends _$DaysController {
  @override
  Future<List<DailyWorkout>> build(String weeklyWorkoutId) async {
    ref.syncOn(const [DataTopic.training]);
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
    return copied;
  }
}
