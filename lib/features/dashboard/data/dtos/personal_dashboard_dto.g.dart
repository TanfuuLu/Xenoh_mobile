// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonalDashboardDto _$PersonalDashboardDtoFromJson(
  Map<String, dynamic> json,
) => _PersonalDashboardDto(
  profile: DashboardProfileDto.fromJson(
    json['profile'] as Map<String, dynamic>,
  ),
  nutritionToday: NutritionTodayDto.fromJson(
    json['nutritionToday'] as Map<String, dynamic>,
  ),
  proInsights: ProInsightsDto.fromJson(
    json['proInsights'] as Map<String, dynamic>,
  ),
  nextActions:
      (json['nextActions'] as List<dynamic>?)
          ?.map((e) => NextActionDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <NextActionDto>[],
  activePlan: json['activePlan'] == null
      ? null
      : DashboardPlanDto.fromJson(json['activePlan'] as Map<String, dynamic>),
  todayWorkout: json['todayWorkout'] == null
      ? null
      : TodayWorkoutDto.fromJson(json['todayWorkout'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PersonalDashboardDtoToJson(
  _PersonalDashboardDto instance,
) => <String, dynamic>{
  'profile': instance.profile,
  'nutritionToday': instance.nutritionToday,
  'proInsights': instance.proInsights,
  'nextActions': instance.nextActions,
  'activePlan': instance.activePlan,
  'todayWorkout': instance.todayWorkout,
};

_DashboardProfileDto _$DashboardProfileDtoFromJson(Map<String, dynamic> json) =>
    _DashboardProfileDto(
      firstName: json['firstName'] as String,
      currentStreak: (json['currentStreak'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      totalXp: (json['totalXp'] as num).toInt(),
      xpToNextLevel: (json['xpToNextLevel'] as num).toInt(),
      title: json['title'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      latestBodyweight: (json['latestBodyweight'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      bmiCategory: json['bmiCategory'] as String?,
      dotsScore: (json['dotsScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DashboardProfileDtoToJson(
  _DashboardProfileDto instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'currentStreak': instance.currentStreak,
  'level': instance.level,
  'totalXp': instance.totalXp,
  'xpToNextLevel': instance.xpToNextLevel,
  'title': instance.title,
  'avatarUrl': instance.avatarUrl,
  'latestBodyweight': instance.latestBodyweight,
  'bmi': instance.bmi,
  'bmiCategory': instance.bmiCategory,
  'dotsScore': instance.dotsScore,
};

_DashboardPlanDto _$DashboardPlanDtoFromJson(Map<String, dynamic> json) =>
    _DashboardPlanDto(
      id: json['id'] as String,
      name: json['name'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      totalDays: (json['totalDays'] as num).toInt(),
      completedDays: (json['completedDays'] as num).toInt(),
      progressPercent: (json['progressPercent'] as num).toInt(),
      currentWeek: json['currentWeek'] == null
          ? null
          : DashboardWeekDto.fromJson(
              json['currentWeek'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DashboardPlanDtoToJson(_DashboardPlanDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'totalDays': instance.totalDays,
      'completedDays': instance.completedDays,
      'progressPercent': instance.progressPercent,
      'currentWeek': instance.currentWeek,
    };

_DashboardWeekDto _$DashboardWeekDtoFromJson(Map<String, dynamic> json) =>
    _DashboardWeekDto(
      id: json['id'] as String,
      name: json['name'] as String,
      totalDays: (json['totalDays'] as num).toInt(),
      completedDays: (json['completedDays'] as num).toInt(),
      progressPercent: (json['progressPercent'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardWeekDtoToJson(_DashboardWeekDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'totalDays': instance.totalDays,
      'completedDays': instance.completedDays,
      'progressPercent': instance.progressPercent,
    };

_TodayWorkoutDto _$TodayWorkoutDtoFromJson(Map<String, dynamic> json) =>
    _TodayWorkoutDto(
      id: json['id'] as String,
      weeklyWorkoutId: json['weeklyWorkoutId'] as String,
      dayOfWeek: json['dayOfWeek'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      isCompleted: json['isCompleted'] as bool,
      totalExercises: (json['totalExercises'] as num).toInt(),
      completedExercises: (json['completedExercises'] as num).toInt(),
      totalSets: (json['totalSets'] as num).toInt(),
      completedSets: (json['completedSets'] as num).toInt(),
      plannedVolume: (json['plannedVolume'] as num).toDouble(),
      route: json['route'] as String,
      muscleGroups:
          (json['muscleGroups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$TodayWorkoutDtoToJson(_TodayWorkoutDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weeklyWorkoutId': instance.weeklyWorkoutId,
      'dayOfWeek': instance.dayOfWeek,
      'date': instance.date,
      'status': instance.status,
      'isCompleted': instance.isCompleted,
      'totalExercises': instance.totalExercises,
      'completedExercises': instance.completedExercises,
      'totalSets': instance.totalSets,
      'completedSets': instance.completedSets,
      'plannedVolume': instance.plannedVolume,
      'route': instance.route,
      'muscleGroups': instance.muscleGroups,
    };

_NutritionTodayDto _$NutritionTodayDtoFromJson(Map<String, dynamic> json) =>
    _NutritionTodayDto(
      loggedCalories: (json['loggedCalories'] as num).toInt(),
      loggedProteinG: (json['loggedProteinG'] as num).toDouble(),
      loggedCarbsG: (json['loggedCarbsG'] as num).toDouble(),
      loggedFatG: (json['loggedFatG'] as num).toDouble(),
      calorieTarget: (json['calorieTarget'] as num?)?.toInt(),
      proteinTargetG: (json['proteinTargetG'] as num?)?.toDouble(),
      carbsTargetG: (json['carbsTargetG'] as num?)?.toDouble(),
      fatTargetG: (json['fatTargetG'] as num?)?.toDouble(),
      remainingCalories: (json['remainingCalories'] as num?)?.toInt(),
      remainingProteinG: (json['remainingProteinG'] as num?)?.toDouble(),
      remainingCarbsG: (json['remainingCarbsG'] as num?)?.toDouble(),
      remainingFatG: (json['remainingFatG'] as num?)?.toDouble(),
      missingProfileFields:
          (json['missingProfileFields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$NutritionTodayDtoToJson(_NutritionTodayDto instance) =>
    <String, dynamic>{
      'loggedCalories': instance.loggedCalories,
      'loggedProteinG': instance.loggedProteinG,
      'loggedCarbsG': instance.loggedCarbsG,
      'loggedFatG': instance.loggedFatG,
      'calorieTarget': instance.calorieTarget,
      'proteinTargetG': instance.proteinTargetG,
      'carbsTargetG': instance.carbsTargetG,
      'fatTargetG': instance.fatTargetG,
      'remainingCalories': instance.remainingCalories,
      'remainingProteinG': instance.remainingProteinG,
      'remainingCarbsG': instance.remainingCarbsG,
      'remainingFatG': instance.remainingFatG,
      'missingProfileFields': instance.missingProfileFields,
    };

_NextActionDto _$NextActionDtoFromJson(Map<String, dynamic> json) =>
    _NextActionDto(
      type: json['type'] as String,
      label: json['label'] as String,
      description: json['description'] as String,
      route: json['route'] as String,
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$NextActionDtoToJson(_NextActionDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'description': instance.description,
      'route': instance.route,
      'priority': instance.priority,
    };

_ProInsightsDto _$ProInsightsDtoFromJson(Map<String, dynamic> json) =>
    _ProInsightsDto(
      isUnlocked: json['isUnlocked'] as bool,
      ctaLabel: json['ctaLabel'] as String?,
      ctaRoute: json['ctaRoute'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => ProInsightItemDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ProInsightItemDto>[],
    );

Map<String, dynamic> _$ProInsightsDtoToJson(_ProInsightsDto instance) =>
    <String, dynamic>{
      'isUnlocked': instance.isUnlocked,
      'ctaLabel': instance.ctaLabel,
      'ctaRoute': instance.ctaRoute,
      'items': instance.items,
    };

_ProInsightItemDto _$ProInsightItemDtoFromJson(Map<String, dynamic> json) =>
    _ProInsightItemDto(
      type: json['type'] as String,
      severity: json['severity'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ProInsightItemDtoToJson(_ProInsightItemDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'title': instance.title,
      'message': instance.message,
    };
