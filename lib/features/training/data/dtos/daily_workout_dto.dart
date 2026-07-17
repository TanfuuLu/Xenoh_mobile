import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/daily_workout.dart';

part 'daily_workout_dto.freezed.dart';
part 'daily_workout_dto.g.dart';

@freezed
abstract class CopyDailyWorkoutDto with _$CopyDailyWorkoutDto {
  const factory CopyDailyWorkoutDto({
    required String targetDailyWorkoutId,
    required int exercisesCopied,
  }) = _CopyDailyWorkoutDto;

  factory CopyDailyWorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$CopyDailyWorkoutDtoFromJson(json);
}

/// `DailyWorkoutResponse` (API ref §3.5).
@freezed
abstract class DailyWorkoutDto with _$DailyWorkoutDto {
  const factory DailyWorkoutDto({
    required String id,
    required String date,
    required String dayOfWeek,
    required bool isCompleted,
    required String weeklyWorkoutId,
    required int totalExercises,
    required int completedExercises,
    required bool hasWarning,
    required String status,
  }) = _DailyWorkoutDto;

  const DailyWorkoutDto._();

  factory DailyWorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$DailyWorkoutDtoFromJson(json);

  DailyWorkout toEntity() => DailyWorkout(
    id: id,
    date: DateOnly.tryParse(date)!,
    dayOfWeek: dayOfWeek,
    isCompleted: isCompleted,
    weeklyWorkoutId: weeklyWorkoutId,
    totalExercises: totalExercises,
    completedExercises: completedExercises,
    hasWarning: hasWarning,
    status: status,
  );
}
