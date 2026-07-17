import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/plan_analytics.dart';

part 'plan_analytics_dto.freezed.dart';
part 'plan_analytics_dto.g.dart';

/// `PlanAnalyticsResponse` (API ref §4) — the rendered subset. Extra JSON keys
/// (muscle-group heatmap) are ignored by json_serializable.
@freezed
abstract class PlanAnalyticsDto with _$PlanAnalyticsDto {
  const factory PlanAnalyticsDto({
    required int totalWorkoutsCompleted,
    required double totalVolume,
    required double consistencyPercent,
    required double avgSessionsPerWeek,
    required int completedSets,
    required int highRpeSets,
    required int warningDays,
    required int totalDurationSeconds,
    required int trainingScore,
    @Default(<TrainingInsightDto>[]) List<TrainingInsightDto> insights,
    @Default(<WeekCompliancePointDto>[])
    List<WeekCompliancePointDto> weeklyCompliance,
    @Default(<WeekVolumePointDto>[]) List<WeekVolumePointDto> weeklyVolume,
    @Default(<MuscleGroupPointDto>[])
    List<MuscleGroupPointDto> muscleGroupVolume,
    double? avgRpe,
    PowerliftingSectionDto? powerlifting,
  }) = _PlanAnalyticsDto;

  const PlanAnalyticsDto._();

  factory PlanAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$PlanAnalyticsDtoFromJson(json);

  PlanAnalytics toEntity() => PlanAnalytics(
    totalWorkoutsCompleted: totalWorkoutsCompleted,
    totalVolume: totalVolume,
    consistencyPercent: consistencyPercent,
    avgSessionsPerWeek: avgSessionsPerWeek,
    completedSets: completedSets,
    highRpeSets: highRpeSets,
    warningDays: warningDays,
    totalDurationSeconds: totalDurationSeconds,
    trainingScore: trainingScore,
    avgRpe: avgRpe,
    insights: insights.map((e) => e.toEntity()).toList(),
    weeklyCompliance: weeklyCompliance.map((e) => e.toEntity()).toList(),
    weeklyVolume: weeklyVolume.map((e) => e.toEntity()).toList(),
    muscleGroupVolume: muscleGroupVolume.map((e) => e.toEntity()).toList(),
    powerlifting: powerlifting?.toEntity(),
  );
}

@freezed
abstract class TrainingInsightDto with _$TrainingInsightDto {
  const factory TrainingInsightDto({
    @Default('') String type,
    @Default('Info') String severity,
    @Default('') String title,
    @Default('') String message,
    @Default('') String metricLabel,
    @Default('') String metricValue,
  }) = _TrainingInsightDto;

  const TrainingInsightDto._();

  factory TrainingInsightDto.fromJson(Map<String, dynamic> json) =>
      _$TrainingInsightDtoFromJson(json);

  TrainingInsight toEntity() => TrainingInsight(
    type: type,
    severity: severity,
    title: title,
    message: message,
    metricLabel: metricLabel,
    metricValue: metricValue,
  );
}

@freezed
abstract class WeekCompliancePointDto with _$WeekCompliancePointDto {
  const factory WeekCompliancePointDto({
    required int weekNumber,
    required int completedDays,
    required int totalDays,
    @Default('') String weekName,
  }) = _WeekCompliancePointDto;

  const WeekCompliancePointDto._();

  factory WeekCompliancePointDto.fromJson(Map<String, dynamic> json) =>
      _$WeekCompliancePointDtoFromJson(json);

  WeekCompliancePoint toEntity() => WeekCompliancePoint(
    weekNumber: weekNumber,
    weekName: weekName,
    completedDays: completedDays,
    totalDays: totalDays,
  );
}

@freezed
abstract class WeekVolumePointDto with _$WeekVolumePointDto {
  const factory WeekVolumePointDto({
    required int weekNumber,
    required double totalVolume,
    @Default('') String weekName,
  }) = _WeekVolumePointDto;

  const WeekVolumePointDto._();

  factory WeekVolumePointDto.fromJson(Map<String, dynamic> json) =>
      _$WeekVolumePointDtoFromJson(json);

  WeekVolumePoint toEntity() => WeekVolumePoint(
    weekNumber: weekNumber,
    weekName: weekName,
    totalVolume: totalVolume,
  );
}

@freezed
abstract class MuscleGroupPointDto with _$MuscleGroupPointDto {
  const factory MuscleGroupPointDto({
    @Default('') String muscleGroup,
    @Default(0) int completedSets,
    @Default(0.0) double totalVolume,
    @Default(0.0) double percentOfTotal,
  }) = _MuscleGroupPointDto;

  const MuscleGroupPointDto._();

  factory MuscleGroupPointDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupPointDtoFromJson(json);

  MuscleGroupVolumePoint toEntity() => MuscleGroupVolumePoint(
    muscleGroup: muscleGroup,
    completedSets: completedSets,
    totalVolume: totalVolume,
    percentOfTotal: percentOfTotal,
  );
}

@freezed
abstract class PowerliftingSectionDto with _$PowerliftingSectionDto {
  const factory PowerliftingSectionDto({
    required LiftSeriesDto squat,
    required LiftSeriesDto bench,
    required LiftSeriesDto deadlift,
    @Default(<DotsPointDto>[]) List<DotsPointDto> dots,
  }) = _PowerliftingSectionDto;

  const PowerliftingSectionDto._();

  factory PowerliftingSectionDto.fromJson(Map<String, dynamic> json) =>
      _$PowerliftingSectionDtoFromJson(json);

  PowerliftingSection toEntity() => PowerliftingSection(
    squat: squat.toEntity(),
    bench: bench.toEntity(),
    deadlift: deadlift.toEntity(),
    dots: dots.map((e) => e.toEntity()).toList(),
  );
}

@freezed
abstract class LiftSeriesDto with _$LiftSeriesDto {
  const factory LiftSeriesDto({
    @Default('') String lift,
    @Default(<LiftE1RmPointDto>[]) List<LiftE1RmPointDto> e1Rm,
    @Default(<LiftPrEventDto>[]) List<LiftPrEventDto> prTimeline,
    double? currentE1Rm,
    double? currentTrainingMax,
    @Default(false) bool isPlateau,
  }) = _LiftSeriesDto;

  const LiftSeriesDto._();

  factory LiftSeriesDto.fromJson(Map<String, dynamic> json) =>
      _$LiftSeriesDtoFromJson(json);

  LiftSeries toEntity() => LiftSeries(
    lift: _liftFromString(lift),
    e1Rm: e1Rm.map((e) => e.toEntity()).toList(),
    prTimeline: prTimeline.map((e) => e.toEntity()).toList(),
    currentE1Rm: currentE1Rm,
    currentTrainingMax: currentTrainingMax,
    isPlateau: isPlateau,
  );
}

@freezed
abstract class LiftE1RmPointDto with _$LiftE1RmPointDto {
  const factory LiftE1RmPointDto({
    @Default('') String weekStart,
    @Default(0.0) double e1Rm,
  }) = _LiftE1RmPointDto;

  const LiftE1RmPointDto._();

  factory LiftE1RmPointDto.fromJson(Map<String, dynamic> json) =>
      _$LiftE1RmPointDtoFromJson(json);

  LiftE1RmPoint toEntity() => LiftE1RmPoint(weekStart: weekStart, e1Rm: e1Rm);
}

@freezed
abstract class LiftPrEventDto with _$LiftPrEventDto {
  const factory LiftPrEventDto({
    required DateTime date,
    @Default(0.0) double weight,
    @Default(0) int reps,
    @Default(0.0) double e1Rm,
  }) = _LiftPrEventDto;

  const LiftPrEventDto._();

  factory LiftPrEventDto.fromJson(Map<String, dynamic> json) =>
      _$LiftPrEventDtoFromJson(json);

  LiftPrEvent toEntity() =>
      LiftPrEvent(date: date, weight: weight, reps: reps, e1Rm: e1Rm);
}

@freezed
abstract class DotsPointDto with _$DotsPointDto {
  const factory DotsPointDto({
    @Default('') String weekStart,
    @Default(0.0) double dots,
    @Default(0.0) double bodyweightKg,
  }) = _DotsPointDto;

  const DotsPointDto._();

  factory DotsPointDto.fromJson(Map<String, dynamic> json) =>
      _$DotsPointDtoFromJson(json);

  DotsPoint toEntity() =>
      DotsPoint(weekStart: weekStart, dots: dots, bodyweightKg: bodyweightKg);
}

CompetitionLift _liftFromString(String value) {
  switch (value.toLowerCase()) {
    case 'bench':
      return CompetitionLift.bench;
    case 'deadlift':
      return CompetitionLift.deadlift;
    default:
      return CompetitionLift.squat;
  }
}
