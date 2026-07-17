import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/personal_dashboard.dart';

part 'personal_dashboard_dto.freezed.dart';
part 'personal_dashboard_dto.g.dart';

/// DTOs for `PersonalDashboardResponse` (API ref §3.11). `DateOnly` fields are
/// carried as `String` ("yyyy-MM-dd") and parsed to [DateTime] in `toEntity`.
@freezed
abstract class PersonalDashboardDto with _$PersonalDashboardDto {
  const factory PersonalDashboardDto({
    required DashboardProfileDto profile,
    required NutritionTodayDto nutritionToday,
    required ProInsightsDto proInsights,
    @Default(<NextActionDto>[]) List<NextActionDto> nextActions,
    DashboardPlanDto? activePlan,
    TodayWorkoutDto? todayWorkout,
  }) = _PersonalDashboardDto;

  const PersonalDashboardDto._();

  factory PersonalDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalDashboardDtoFromJson(json);

  PersonalDashboard toEntity() => PersonalDashboard(
    profile: profile.toEntity(),
    nutritionToday: nutritionToday.toEntity(),
    proInsights: proInsights.toEntity(),
    nextActions: nextActions.map((e) => e.toEntity()).toList(),
    activePlan: activePlan?.toEntity(),
    todayWorkout: todayWorkout?.toEntity(),
  );
}

@freezed
abstract class DashboardProfileDto with _$DashboardProfileDto {
  const factory DashboardProfileDto({
    required String firstName,
    required int currentStreak,
    required int level,
    required int totalXp,
    required int xpToNextLevel,
    required String title,
    String? avatarUrl,
    double? latestBodyweight,
    double? bmi,
    String? bmiCategory,
    double? dotsScore,
  }) = _DashboardProfileDto;

  const DashboardProfileDto._();

  factory DashboardProfileDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardProfileDtoFromJson(json);

  DashboardProfile toEntity() => DashboardProfile(
    firstName: firstName,
    currentStreak: currentStreak,
    level: level,
    totalXp: totalXp,
    xpToNextLevel: xpToNextLevel,
    title: title,
    avatarUrl: avatarUrl,
    latestBodyweight: latestBodyweight,
    bmi: bmi,
    bmiCategory: bmiCategory,
    dotsScore: dotsScore,
  );
}

@freezed
abstract class DashboardPlanDto with _$DashboardPlanDto {
  const factory DashboardPlanDto({
    required String id,
    required String name,
    required String startDate,
    required String endDate,
    required int totalDays,
    required int completedDays,
    required int progressPercent,
    DashboardWeekDto? currentWeek,
  }) = _DashboardPlanDto;

  const DashboardPlanDto._();

  factory DashboardPlanDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardPlanDtoFromJson(json);

  DashboardPlan toEntity() => DashboardPlan(
    id: id,
    name: name,
    startDate: DateOnly.tryParse(startDate)!,
    endDate: DateOnly.tryParse(endDate)!,
    totalDays: totalDays,
    completedDays: completedDays,
    progressPercent: progressPercent,
    currentWeek: currentWeek?.toEntity(),
  );
}

@freezed
abstract class DashboardWeekDto with _$DashboardWeekDto {
  const factory DashboardWeekDto({
    required String id,
    required String name,
    required int totalDays,
    required int completedDays,
    required int progressPercent,
  }) = _DashboardWeekDto;

  const DashboardWeekDto._();

  factory DashboardWeekDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardWeekDtoFromJson(json);

  DashboardWeek toEntity() => DashboardWeek(
    id: id,
    name: name,
    totalDays: totalDays,
    completedDays: completedDays,
    progressPercent: progressPercent,
  );
}

@freezed
abstract class TodayWorkoutDto with _$TodayWorkoutDto {
  const factory TodayWorkoutDto({
    required String id,
    required String weeklyWorkoutId,
    required String dayOfWeek,
    required String date,
    required String status,
    required bool isCompleted,
    required int totalExercises,
    required int completedExercises,
    required int totalSets,
    required int completedSets,
    required double plannedVolume,
    required String route,
    @Default(<String>[]) List<String> muscleGroups,
  }) = _TodayWorkoutDto;

  const TodayWorkoutDto._();

  factory TodayWorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$TodayWorkoutDtoFromJson(json);

  TodayWorkout toEntity() => TodayWorkout(
    id: id,
    weeklyWorkoutId: weeklyWorkoutId,
    dayOfWeek: dayOfWeek,
    date: DateOnly.tryParse(date)!,
    status: status,
    isCompleted: isCompleted,
    totalExercises: totalExercises,
    completedExercises: completedExercises,
    totalSets: totalSets,
    completedSets: completedSets,
    plannedVolume: plannedVolume,
    route: route,
    muscleGroups: muscleGroups,
  );
}

@freezed
abstract class NutritionTodayDto with _$NutritionTodayDto {
  const factory NutritionTodayDto({
    required int loggedCalories,
    required double loggedProteinG,
    required double loggedCarbsG,
    required double loggedFatG,
    int? calorieTarget,
    double? proteinTargetG,
    double? carbsTargetG,
    double? fatTargetG,
    int? remainingCalories,
    double? remainingProteinG,
    double? remainingCarbsG,
    double? remainingFatG,
    @Default(<String>[]) List<String> missingProfileFields,
  }) = _NutritionTodayDto;

  const NutritionTodayDto._();

  factory NutritionTodayDto.fromJson(Map<String, dynamic> json) =>
      _$NutritionTodayDtoFromJson(json);

  NutritionToday toEntity() => NutritionToday(
    loggedCalories: loggedCalories,
    loggedProteinG: loggedProteinG,
    loggedCarbsG: loggedCarbsG,
    loggedFatG: loggedFatG,
    calorieTarget: calorieTarget,
    proteinTargetG: proteinTargetG,
    carbsTargetG: carbsTargetG,
    fatTargetG: fatTargetG,
    remainingCalories: remainingCalories,
    remainingProteinG: remainingProteinG,
    remainingCarbsG: remainingCarbsG,
    remainingFatG: remainingFatG,
    missingProfileFields: missingProfileFields,
  );
}

@freezed
abstract class NextActionDto with _$NextActionDto {
  const factory NextActionDto({
    required String type,
    required String label,
    required String description,
    required String route,
    required int priority,
  }) = _NextActionDto;

  const NextActionDto._();

  factory NextActionDto.fromJson(Map<String, dynamic> json) =>
      _$NextActionDtoFromJson(json);

  NextAction toEntity() => NextAction(
    type: type,
    label: label,
    description: description,
    route: route,
    priority: priority,
  );
}

@freezed
abstract class ProInsightsDto with _$ProInsightsDto {
  const factory ProInsightsDto({
    required bool isUnlocked,
    String? ctaLabel,
    String? ctaRoute,
    @Default(<ProInsightItemDto>[]) List<ProInsightItemDto> items,
  }) = _ProInsightsDto;

  const ProInsightsDto._();

  factory ProInsightsDto.fromJson(Map<String, dynamic> json) =>
      _$ProInsightsDtoFromJson(json);

  ProInsights toEntity() => ProInsights(
    isUnlocked: isUnlocked,
    ctaLabel: ctaLabel,
    ctaRoute: ctaRoute,
    items: items.map((e) => e.toEntity()).toList(),
  );
}

@freezed
abstract class ProInsightItemDto with _$ProInsightItemDto {
  const factory ProInsightItemDto({
    required String type,
    required String severity,
    required String title,
    required String message,
  }) = _ProInsightItemDto;

  const ProInsightItemDto._();

  factory ProInsightItemDto.fromJson(Map<String, dynamic> json) =>
      _$ProInsightItemDtoFromJson(json);

  ProInsightItem toEntity() => ProInsightItem(
    type: type,
    severity: severity,
    title: title,
    message: message,
  );
}
