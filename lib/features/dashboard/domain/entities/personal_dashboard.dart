import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_dashboard.freezed.dart';

/// Aggregate for `GET /api/dashboard/personal` (API ref §3.11). Pure entities —
/// `DateOnly` fields are real [DateTime]s here (parsed in the data layer).
@freezed
abstract class PersonalDashboard with _$PersonalDashboard {
  const factory PersonalDashboard({
    required DashboardProfile profile,
    required NutritionToday nutritionToday,
    required ProInsights proInsights,
    @Default(<NextAction>[]) List<NextAction> nextActions,
    DashboardPlan? activePlan,
    TodayWorkout? todayWorkout,
  }) = _PersonalDashboard;
}

@freezed
abstract class DashboardProfile with _$DashboardProfile {
  const factory DashboardProfile({
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
  }) = _DashboardProfile;
}

@freezed
abstract class DashboardPlan with _$DashboardPlan {
  const factory DashboardPlan({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required int totalDays,
    required int completedDays,
    required int progressPercent,
    DashboardWeek? currentWeek,
  }) = _DashboardPlan;
}

@freezed
abstract class DashboardWeek with _$DashboardWeek {
  const factory DashboardWeek({
    required String id,
    required String name,
    required int totalDays,
    required int completedDays,
    required int progressPercent,
  }) = _DashboardWeek;
}

@freezed
abstract class TodayWorkout with _$TodayWorkout {
  const factory TodayWorkout({
    required String id,
    required String weeklyWorkoutId,
    required String dayOfWeek,
    required DateTime date,
    required String status,
    required bool isCompleted,
    required int totalExercises,
    required int completedExercises,
    required int totalSets,
    required int completedSets,
    required double plannedVolume,
    required String route,
    @Default(<String>[]) List<String> muscleGroups,
  }) = _TodayWorkout;
}

@freezed
abstract class NutritionToday with _$NutritionToday {
  const factory NutritionToday({
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
  }) = _NutritionToday;
}

@freezed
abstract class NextAction with _$NextAction {
  const factory NextAction({
    required String type,
    required String label,
    required String description,
    required String route,
    required int priority,
  }) = _NextAction;
}

@freezed
abstract class ProInsights with _$ProInsights {
  const factory ProInsights({
    required bool isUnlocked,
    String? ctaLabel,
    String? ctaRoute,
    @Default(<ProInsightItem>[]) List<ProInsightItem> items,
  }) = _ProInsights;
}

@freezed
abstract class ProInsightItem with _$ProInsightItem {
  const factory ProInsightItem({
    required String type,
    required String severity,
    required String title,
    required String message,
  }) = _ProInsightItem;
}
