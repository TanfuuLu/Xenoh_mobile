import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_pr.freezed.dart';

/// A personal record for one exercise template (maps from `ExercisePrResponse`,
/// API ref §2 users/me/exercise-prs).
@freezed
abstract class ExercisePr with _$ExercisePr {
  const factory ExercisePr({
    required String exerciseTemplateId,
    required String exerciseName,
    required double currentWeight,
    required int reps,
    required DateTime achievedAt,
  }) = _ExercisePr;
}

/// One point in an exercise's PR progression (maps from
/// `ExercisePrHistoryPointResponse`). Sorted oldest → newest by the repository.
@freezed
abstract class ExercisePrPoint with _$ExercisePrPoint {
  const factory ExercisePrPoint({
    required double weight,
    required int reps,
    required DateTime achievedAt,
  }) = _ExercisePrPoint;
}
