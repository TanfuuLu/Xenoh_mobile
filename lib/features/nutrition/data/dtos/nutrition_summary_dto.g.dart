// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NutritionSummaryDto _$NutritionSummaryDtoFromJson(Map<String, dynamic> json) =>
    _NutritionSummaryDto(
      profile: NutritionProfileDto.fromJson(
        json['profile'] as Map<String, dynamic>,
      ),
      calculation: NutritionCalculationDto.fromJson(
        json['calculation'] as Map<String, dynamic>,
      ),
      canUseAdvancedAnalysis: json['canUseAdvancedAnalysis'] as bool,
      todayLog: json['todayLog'] == null
          ? null
          : NutritionDailyLogDto.fromJson(
              json['todayLog'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$NutritionSummaryDtoToJson(
  _NutritionSummaryDto instance,
) => <String, dynamic>{
  'profile': instance.profile,
  'calculation': instance.calculation,
  'canUseAdvancedAnalysis': instance.canUseAdvancedAnalysis,
  'todayLog': instance.todayLog,
};

_NutritionProfileDto _$NutritionProfileDtoFromJson(Map<String, dynamic> json) =>
    _NutritionProfileDto(
      activityLevel: json['activityLevel'] as String,
      goal: json['goal'] as String,
      targetWeightKg: (json['targetWeightKg'] as num?)?.toDouble(),
      customCalorieTarget: (json['customCalorieTarget'] as num?)?.toInt(),
      proteinPerKg: (json['proteinPerKg'] as num?)?.toDouble(),
      fatPerKg: (json['fatPerKg'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NutritionProfileDtoToJson(
  _NutritionProfileDto instance,
) => <String, dynamic>{
  'activityLevel': instance.activityLevel,
  'goal': instance.goal,
  'targetWeightKg': instance.targetWeightKg,
  'customCalorieTarget': instance.customCalorieTarget,
  'proteinPerKg': instance.proteinPerKg,
  'fatPerKg': instance.fatPerKg,
};

_NutritionCalculationDto _$NutritionCalculationDtoFromJson(
  Map<String, dynamic> json,
) => _NutritionCalculationDto(
  missingFields:
      (json['missingFields'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  bodyweightKg: (json['bodyweightKg'] as num?)?.toDouble(),
  age: (json['age'] as num?)?.toInt(),
  bmr: (json['bmr'] as num?)?.toInt(),
  tdee: (json['tdee'] as num?)?.toInt(),
  recommendedCalories: (json['recommendedCalories'] as num?)?.toInt(),
  calorieTarget: (json['calorieTarget'] as num?)?.toInt(),
  proteinG: (json['proteinG'] as num?)?.toDouble(),
  carbsG: (json['carbsG'] as num?)?.toDouble(),
  fatG: (json['fatG'] as num?)?.toDouble(),
);

Map<String, dynamic> _$NutritionCalculationDtoToJson(
  _NutritionCalculationDto instance,
) => <String, dynamic>{
  'missingFields': instance.missingFields,
  'bodyweightKg': instance.bodyweightKg,
  'age': instance.age,
  'bmr': instance.bmr,
  'tdee': instance.tdee,
  'recommendedCalories': instance.recommendedCalories,
  'calorieTarget': instance.calorieTarget,
  'proteinG': instance.proteinG,
  'carbsG': instance.carbsG,
  'fatG': instance.fatG,
};

_NutritionDailyLogDto _$NutritionDailyLogDtoFromJson(
  Map<String, dynamic> json,
) => _NutritionDailyLogDto(
  date: json['date'] as String,
  calories: (json['calories'] as num).toInt(),
  proteinG: (json['proteinG'] as num).toDouble(),
  carbsG: (json['carbsG'] as num).toDouble(),
  fatG: (json['fatG'] as num).toDouble(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$NutritionDailyLogDtoToJson(
  _NutritionDailyLogDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'calories': instance.calories,
  'proteinG': instance.proteinG,
  'carbsG': instance.carbsG,
  'fatG': instance.fatG,
  'notes': instance.notes,
};
