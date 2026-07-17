import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_template.freezed.dart';

/// A reusable exercise definition picked when adding an exercise to a day
/// (maps from `ExerciseTemplateResponse`, §3.7).
@freezed
abstract class ExerciseTemplate with _$ExerciseTemplate {
  const factory ExerciseTemplate({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required String exerciseKind, // "Strength" | "Cardio"
    required bool isCustom,
    @Default(<String>[]) List<String> secondaryMuscleGroups,
    String? description,
    String? ownerId,
    String? imageUrl,
  }) = _ExerciseTemplate;
}
