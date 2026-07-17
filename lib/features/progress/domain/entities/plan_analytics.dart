import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_analytics.freezed.dart';

/// Plan analytics (maps from `PlanAnalyticsResponse`, API ref §4). Only the
/// subset the mobile screen renders is modelled; the muscle-group heatmap is
/// intentionally omitted for this milestone (JSON keys ignored).
@freezed
abstract class PlanAnalytics with _$PlanAnalytics {
  const factory PlanAnalytics({
    required int totalWorkoutsCompleted,
    required double totalVolume,
    required double consistencyPercent,
    required double avgSessionsPerWeek,
    required int completedSets,
    required int highRpeSets,
    required int warningDays,
    required int totalDurationSeconds,
    required int trainingScore,
    required List<TrainingInsight> insights,
    required List<WeekCompliancePoint> weeklyCompliance,
    required List<WeekVolumePoint> weeklyVolume,
    required List<MuscleGroupVolumePoint> muscleGroupVolume,
    double? avgRpe,

    /// Present only when the plan contains competition-lift exercises.
    PowerliftingSection? powerlifting,
  }) = _PlanAnalytics;

  const PlanAnalytics._();

  Duration get totalDuration => Duration(seconds: totalDurationSeconds);
}

/// A generated coaching insight attached to the analytics.
@freezed
abstract class TrainingInsight with _$TrainingInsight {
  const factory TrainingInsight({
    required String type,
    required String severity, // "Info" | "Warning" | "Critical" | "Success"
    required String title,
    required String message,
    required String metricLabel,
    required String metricValue,
  }) = _TrainingInsight;
}

/// Completed vs. planned days for one week.
@freezed
abstract class WeekCompliancePoint with _$WeekCompliancePoint {
  const factory WeekCompliancePoint({
    required int weekNumber,
    required String weekName,
    required int completedDays,
    required int totalDays,
  }) = _WeekCompliancePoint;
}

/// Total tonnage lifted in one week.
@freezed
abstract class WeekVolumePoint with _$WeekVolumePoint {
  const factory WeekVolumePoint({
    required int weekNumber,
    required String weekName,
    required double totalVolume,
  }) = _WeekVolumePoint;
}

/// Completed sets / volume share for one muscle group.
@freezed
abstract class MuscleGroupVolumePoint with _$MuscleGroupVolumePoint {
  const factory MuscleGroupVolumePoint({
    required String muscleGroup,
    required int completedSets,
    required double totalVolume,
    required double percentOfTotal,
  }) = _MuscleGroupVolumePoint;
}

/// The three competition lifts tracked by the powerlifting view.
enum CompetitionLift { squat, bench, deadlift }

/// Powerlifting analysis for a plan (the Big 3 + DOTS-over-time). Present only
/// when the plan contains exercises flagged as competition lifts.
@freezed
abstract class PowerliftingSection with _$PowerliftingSection {
  const factory PowerliftingSection({
    required LiftSeries squat,
    required LiftSeries bench,
    required LiftSeries deadlift,
    required List<DotsPoint> dots,
  }) = _PowerliftingSection;

  const PowerliftingSection._();

  List<LiftSeries> get lifts => [squat, bench, deadlift];
}

/// Estimated 1RM trend + PR history for one competition lift.
@freezed
abstract class LiftSeries with _$LiftSeries {
  const factory LiftSeries({
    required CompetitionLift lift,
    required List<LiftE1RmPoint> e1Rm,
    required List<LiftPrEvent> prTimeline,
    double? currentE1Rm,
    double? currentTrainingMax,
    @Default(false) bool isPlateau,
  }) = _LiftSeries;
}

/// One weekly estimated-1RM sample for a lift.
@freezed
abstract class LiftE1RmPoint with _$LiftE1RmPoint {
  const factory LiftE1RmPoint({
    required String weekStart,
    required double e1Rm,
  }) = _LiftE1RmPoint;
}

/// A single personal-record event on a lift's timeline.
@freezed
abstract class LiftPrEvent with _$LiftPrEvent {
  const factory LiftPrEvent({
    required DateTime date,
    required double weight,
    required int reps,
    required double e1Rm,
  }) = _LiftPrEvent;
}

/// One weekly DOTS sample alongside the bodyweight it was computed from.
@freezed
abstract class DotsPoint with _$DotsPoint {
  const factory DotsPoint({
    required String weekStart,
    required double dots,
    required double bodyweightKg,
  }) = _DotsPoint;
}
