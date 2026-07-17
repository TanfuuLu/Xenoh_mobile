// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_template_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseTemplateDto _$ExerciseTemplateDtoFromJson(Map<String, dynamic> json) =>
    _ExerciseTemplateDto(
      id: json['id'] as String,
      name: json['name'] as String,
      primaryMuscleGroup: json['primaryMuscleGroup'] as String,
      exerciseKind: json['exerciseKind'] as String,
      isCustom: json['isCustom'] as bool,
      secondaryMuscleGroups:
          (json['secondaryMuscleGroups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
      ownerId: json['ownerId'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ExerciseTemplateDtoToJson(
  _ExerciseTemplateDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'primaryMuscleGroup': instance.primaryMuscleGroup,
  'exerciseKind': instance.exerciseKind,
  'isCustom': instance.isCustom,
  'secondaryMuscleGroups': instance.secondaryMuscleGroups,
  'description': instance.description,
  'ownerId': instance.ownerId,
  'imageUrl': instance.imageUrl,
};
