import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/weekly_workout.dart';

part 'weekly_workout_dto.freezed.dart';
part 'weekly_workout_dto.g.dart';

/// `WeeklyWorkoutResponse` (API ref §3.4).
@freezed
abstract class WeeklyWorkoutDto with _$WeeklyWorkoutDto {
  const factory WeeklyWorkoutDto({
    required String id,
    required int weekNumber,
    required String name,
    required String startDate,
    required String endDate,
    required String planId,
    required int totalDays,
    required int completedDays,
    required bool hasWarning,
    required bool isCompleted,
  }) = _WeeklyWorkoutDto;

  const WeeklyWorkoutDto._();

  factory WeeklyWorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$WeeklyWorkoutDtoFromJson(json);

  WeeklyWorkout toEntity() => WeeklyWorkout(
    id: id,
    weekNumber: weekNumber,
    name: name,
    startDate: DateOnly.tryParse(startDate)!,
    endDate: DateOnly.tryParse(endDate)!,
    planId: planId,
    totalDays: totalDays,
    completedDays: completedDays,
    hasWarning: hasWarning,
    isCompleted: isCompleted,
  );
}
