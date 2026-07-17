import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_workout.freezed.dart';

/// A day within a week (maps from `DailyWorkoutResponse`, API ref §3.5).
/// `status` is a DayStatus: "Normal" | "Rest" | "Missed".
@freezed
abstract class DailyWorkout with _$DailyWorkout {
  const factory DailyWorkout({
    required String id,
    required DateTime date,
    required String dayOfWeek,
    required bool isCompleted,
    required String weeklyWorkoutId,
    required int totalExercises,
    required int completedExercises,
    required bool hasWarning,
    required String status,
  }) = _DailyWorkout;

  const DailyWorkout._();

  bool get isRest => status == 'Rest';
  bool get isMissed => status == 'Missed';
}
