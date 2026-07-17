import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/exercise_pr.dart';

part 'exercise_pr_dto.freezed.dart';
part 'exercise_pr_dto.g.dart';

/// `ExercisePrResponse` (API ref §2). `AchievedAt` is ISO 8601 DateTime.
@freezed
abstract class ExercisePrDto with _$ExercisePrDto {
  const factory ExercisePrDto({
    required String exerciseTemplateId,
    required String exerciseName,
    required double currentWeight,
    required int reps,
    required DateTime achievedAt,
  }) = _ExercisePrDto;

  const ExercisePrDto._();

  factory ExercisePrDto.fromJson(Map<String, dynamic> json) =>
      _$ExercisePrDtoFromJson(json);

  ExercisePr toEntity() => ExercisePr(
    exerciseTemplateId: exerciseTemplateId,
    exerciseName: exerciseName,
    currentWeight: currentWeight,
    reps: reps,
    achievedAt: achievedAt,
  );
}

/// `ExercisePrHistoryPointResponse` (API ref §2).
@freezed
abstract class ExercisePrPointDto with _$ExercisePrPointDto {
  const factory ExercisePrPointDto({
    required double weight,
    required int reps,
    required DateTime achievedAt,
  }) = _ExercisePrPointDto;

  const ExercisePrPointDto._();

  factory ExercisePrPointDto.fromJson(Map<String, dynamic> json) =>
      _$ExercisePrPointDtoFromJson(json);

  ExercisePrPoint toEntity() =>
      ExercisePrPoint(weight: weight, reps: reps, achievedAt: achievedAt);
}
