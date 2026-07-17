// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MealPlanTotalsDto _$MealPlanTotalsDtoFromJson(Map<String, dynamic> json) =>
    _MealPlanTotalsDto(
      calories: (json['calories'] as num).toInt(),
      proteinG: (json['proteinG'] as num).toDouble(),
      carbsG: (json['carbsG'] as num).toDouble(),
      fatG: (json['fatG'] as num).toDouble(),
    );

Map<String, dynamic> _$MealPlanTotalsDtoToJson(_MealPlanTotalsDto instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'proteinG': instance.proteinG,
      'carbsG': instance.carbsG,
      'fatG': instance.fatG,
    };

_MealPlanItemDto _$MealPlanItemDtoFromJson(Map<String, dynamic> json) =>
    _MealPlanItemDto(
      id: json['id'] as String,
      foodItemId: json['foodItemId'] as String,
      nameVi: json['nameVi'] as String,
      nameEn: json['nameEn'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
      grams: (json['grams'] as num).toDouble(),
      plannedCalories: (json['plannedCalories'] as num).toInt(),
      plannedProteinG: (json['plannedProteinG'] as num).toDouble(),
      plannedCarbsG: (json['plannedCarbsG'] as num).toDouble(),
      plannedFatG: (json['plannedFatG'] as num).toDouble(),
      isChecked: json['isChecked'] as bool,
      servingLabelVi: json['servingLabelVi'] as String?,
      servingLabelEn: json['servingLabelEn'] as String?,
      servingCount: (json['servingCount'] as num?)?.toDouble(),
      checkedAt: json['checkedAt'] as String?,
      foodLogId: json['foodLogId'] as String?,
    );

Map<String, dynamic> _$MealPlanItemDtoToJson(_MealPlanItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foodItemId': instance.foodItemId,
      'nameVi': instance.nameVi,
      'nameEn': instance.nameEn,
      'sortOrder': instance.sortOrder,
      'grams': instance.grams,
      'plannedCalories': instance.plannedCalories,
      'plannedProteinG': instance.plannedProteinG,
      'plannedCarbsG': instance.plannedCarbsG,
      'plannedFatG': instance.plannedFatG,
      'isChecked': instance.isChecked,
      'servingLabelVi': instance.servingLabelVi,
      'servingLabelEn': instance.servingLabelEn,
      'servingCount': instance.servingCount,
      'checkedAt': instance.checkedAt,
      'foodLogId': instance.foodLogId,
    };

_MealPlanMealDto _$MealPlanMealDtoFromJson(Map<String, dynamic> json) =>
    _MealPlanMealDto(
      id: json['id'] as String,
      name: json['name'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
      plannedTotals: MealPlanTotalsDto.fromJson(
        json['plannedTotals'] as Map<String, dynamic>,
      ),
      checkedTotals: MealPlanTotalsDto.fromJson(
        json['checkedTotals'] as Map<String, dynamic>,
      ),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MealPlanItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MealPlanItemDto>[],
    );

Map<String, dynamic> _$MealPlanMealDtoToJson(_MealPlanMealDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sortOrder': instance.sortOrder,
      'plannedTotals': instance.plannedTotals,
      'checkedTotals': instance.checkedTotals,
      'items': instance.items,
    };

_MealPlanDayDto _$MealPlanDayDtoFromJson(Map<String, dynamic> json) =>
    _MealPlanDayDto(
      userId: json['userId'] as String,
      date: json['date'] as String,
      plannedTotals: MealPlanTotalsDto.fromJson(
        json['plannedTotals'] as Map<String, dynamic>,
      ),
      checkedTotals: MealPlanTotalsDto.fromJson(
        json['checkedTotals'] as Map<String, dynamic>,
      ),
      totalItemCount: (json['totalItemCount'] as num).toInt(),
      checkedItemCount: (json['checkedItemCount'] as num).toInt(),
      meals:
          (json['meals'] as List<dynamic>?)
              ?.map((e) => MealPlanMealDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MealPlanMealDto>[],
      id: json['id'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$MealPlanDayDtoToJson(_MealPlanDayDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'date': instance.date,
      'plannedTotals': instance.plannedTotals,
      'checkedTotals': instance.checkedTotals,
      'totalItemCount': instance.totalItemCount,
      'checkedItemCount': instance.checkedItemCount,
      'meals': instance.meals,
      'id': instance.id,
      'notes': instance.notes,
    };
