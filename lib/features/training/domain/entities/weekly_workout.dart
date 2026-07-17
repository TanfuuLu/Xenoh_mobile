import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_workout.freezed.dart';

/// A week within a plan (maps from `WeeklyWorkoutResponse`, API ref §3.4).
@freezed
abstract class WeeklyWorkout with _$WeeklyWorkout {
  const factory WeeklyWorkout({
    required String id,
    required int weekNumber,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required String planId,
    required int totalDays,
    required int completedDays,
    required bool hasWarning,
    required bool isCompleted,
  }) = _WeeklyWorkout;

  const WeeklyWorkout._();

  int get progressPercent =>
      totalDays == 0 ? 0 : ((completedDays / totalDays) * 100).round();
}
