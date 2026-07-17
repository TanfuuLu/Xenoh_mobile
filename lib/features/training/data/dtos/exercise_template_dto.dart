import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/exercise_template.dart';

part 'exercise_template_dto.freezed.dart';
part 'exercise_template_dto.g.dart';

/// `ExerciseTemplateResponse` (API ref §3.7).
@freezed
abstract class ExerciseTemplateDto with _$ExerciseTemplateDto {
  const factory ExerciseTemplateDto({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required String exerciseKind,
    required bool isCustom,
    @Default(<String>[]) List<String> secondaryMuscleGroups,
    String? description,
    String? ownerId,
    String? imageUrl,
  }) = _ExerciseTemplateDto;

  const ExerciseTemplateDto._();

  factory ExerciseTemplateDto.fromJson(Map<String, dynamic> json) =>
      _$ExerciseTemplateDtoFromJson(json);

  ExerciseTemplate toEntity() => ExerciseTemplate(
    id: id,
    name: name,
    primaryMuscleGroup: primaryMuscleGroup,
    exerciseKind: exerciseKind,
    isCustom: isCustom,
    secondaryMuscleGroups: secondaryMuscleGroups,
    description: description,
    ownerId: ownerId,
    imageUrl: imageUrl,
  );
}
