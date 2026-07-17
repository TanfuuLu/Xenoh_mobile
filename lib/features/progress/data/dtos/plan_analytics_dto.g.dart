// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_analytics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanAnalyticsDto _$PlanAnalyticsDtoFromJson(
  Map<String, dynamic> json,
) => _PlanAnalyticsDto(
  totalWorkoutsCompleted: (json['totalWorkoutsCompleted'] as num).toInt(),
  totalVolume: (json['totalVolume'] as num).toDouble(),
  consistencyPercent: (json['consistencyPercent'] as num).toDouble(),
  avgSessionsPerWeek: (json['avgSessionsPerWeek'] as num).toDouble(),
  completedSets: (json['completedSets'] as num).toInt(),
  highRpeSets: (json['highRpeSets'] as num).toInt(),
  warningDays: (json['warningDays'] as num).toInt(),
  totalDurationSeconds: (json['totalDurationSeconds'] as num).toInt(),
  trainingScore: (json['trainingScore'] as num).toInt(),
  insights:
      (json['insights'] as List<dynamic>?)
          ?.map((e) => TrainingInsightDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TrainingInsightDto>[],
  weeklyCompliance:
      (json['weeklyCompliance'] as List<dynamic>?)
          ?.map(
            (e) => WeekCompliancePointDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <WeekCompliancePointDto>[],
  weeklyVolume:
      (json['weeklyVolume'] as List<dynamic>?)
          ?.map((e) => WeekVolumePointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WeekVolumePointDto>[],
  muscleGroupVolume:
      (json['muscleGroupVolume'] as List<dynamic>?)
          ?.map((e) => MuscleGroupPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MuscleGroupPointDto>[],
  avgRpe: (json['avgRpe'] as num?)?.toDouble(),
  powerlifting: json['powerlifting'] == null
      ? null
      : PowerliftingSectionDto.fromJson(
          json['powerlifting'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PlanAnalyticsDtoToJson(_PlanAnalyticsDto instance) =>
    <String, dynamic>{
      'totalWorkoutsCompleted': instance.totalWorkoutsCompleted,
      'totalVolume': instance.totalVolume,
      'consistencyPercent': instance.consistencyPercent,
      'avgSessionsPerWeek': instance.avgSessionsPerWeek,
      'completedSets': instance.completedSets,
      'highRpeSets': instance.highRpeSets,
      'warningDays': instance.warningDays,
      'totalDurationSeconds': instance.totalDurationSeconds,
      'trainingScore': instance.trainingScore,
      'insights': instance.insights,
      'weeklyCompliance': instance.weeklyCompliance,
      'weeklyVolume': instance.weeklyVolume,
      'muscleGroupVolume': instance.muscleGroupVolume,
      'avgRpe': instance.avgRpe,
      'powerlifting': instance.powerlifting,
    };

_TrainingInsightDto _$TrainingInsightDtoFromJson(Map<String, dynamic> json) =>
    _TrainingInsightDto(
      type: json['type'] as String? ?? '',
      severity: json['severity'] as String? ?? 'Info',
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      metricLabel: json['metricLabel'] as String? ?? '',
      metricValue: json['metricValue'] as String? ?? '',
    );

Map<String, dynamic> _$TrainingInsightDtoToJson(_TrainingInsightDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'title': instance.title,
      'message': instance.message,
      'metricLabel': instance.metricLabel,
      'metricValue': instance.metricValue,
    };

_WeekCompliancePointDto _$WeekCompliancePointDtoFromJson(
  Map<String, dynamic> json,
) => _WeekCompliancePointDto(
  weekNumber: (json['weekNumber'] as num).toInt(),
  completedDays: (json['completedDays'] as num).toInt(),
  totalDays: (json['totalDays'] as num).toInt(),
  weekName: json['weekName'] as String? ?? '',
);

Map<String, dynamic> _$WeekCompliancePointDtoToJson(
  _WeekCompliancePointDto instance,
) => <String, dynamic>{
  'weekNumber': instance.weekNumber,
  'completedDays': instance.completedDays,
  'totalDays': instance.totalDays,
  'weekName': instance.weekName,
};

_WeekVolumePointDto _$WeekVolumePointDtoFromJson(Map<String, dynamic> json) =>
    _WeekVolumePointDto(
      weekNumber: (json['weekNumber'] as num).toInt(),
      totalVolume: (json['totalVolume'] as num).toDouble(),
      weekName: json['weekName'] as String? ?? '',
    );

Map<String, dynamic> _$WeekVolumePointDtoToJson(_WeekVolumePointDto instance) =>
    <String, dynamic>{
      'weekNumber': instance.weekNumber,
      'totalVolume': instance.totalVolume,
      'weekName': instance.weekName,
    };

_MuscleGroupPointDto _$MuscleGroupPointDtoFromJson(Map<String, dynamic> json) =>
    _MuscleGroupPointDto(
      muscleGroup: json['muscleGroup'] as String? ?? '',
      completedSets: (json['completedSets'] as num?)?.toInt() ?? 0,
      totalVolume: (json['totalVolume'] as num?)?.toDouble() ?? 0.0,
      percentOfTotal: (json['percentOfTotal'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$MuscleGroupPointDtoToJson(
  _MuscleGroupPointDto instance,
) => <String, dynamic>{
  'muscleGroup': instance.muscleGroup,
  'completedSets': instance.completedSets,
  'totalVolume': instance.totalVolume,
  'percentOfTotal': instance.percentOfTotal,
};

_PowerliftingSectionDto _$PowerliftingSectionDtoFromJson(
  Map<String, dynamic> json,
) => _PowerliftingSectionDto(
  squat: LiftSeriesDto.fromJson(json['squat'] as Map<String, dynamic>),
  bench: LiftSeriesDto.fromJson(json['bench'] as Map<String, dynamic>),
  deadlift: LiftSeriesDto.fromJson(json['deadlift'] as Map<String, dynamic>),
  dots:
      (json['dots'] as List<dynamic>?)
          ?.map((e) => DotsPointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DotsPointDto>[],
);

Map<String, dynamic> _$PowerliftingSectionDtoToJson(
  _PowerliftingSectionDto instance,
) => <String, dynamic>{
  'squat': instance.squat,
  'bench': instance.bench,
  'deadlift': instance.deadlift,
  'dots': instance.dots,
};

_LiftSeriesDto _$LiftSeriesDtoFromJson(Map<String, dynamic> json) =>
    _LiftSeriesDto(
      lift: json['lift'] as String? ?? '',
      e1Rm:
          (json['e1Rm'] as List<dynamic>?)
              ?.map((e) => LiftE1RmPointDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LiftE1RmPointDto>[],
      prTimeline:
          (json['prTimeline'] as List<dynamic>?)
              ?.map((e) => LiftPrEventDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LiftPrEventDto>[],
      currentE1Rm: (json['currentE1Rm'] as num?)?.toDouble(),
      currentTrainingMax: (json['currentTrainingMax'] as num?)?.toDouble(),
      isPlateau: json['isPlateau'] as bool? ?? false,
    );

Map<String, dynamic> _$LiftSeriesDtoToJson(_LiftSeriesDto instance) =>
    <String, dynamic>{
      'lift': instance.lift,
      'e1Rm': instance.e1Rm,
      'prTimeline': instance.prTimeline,
      'currentE1Rm': instance.currentE1Rm,
      'currentTrainingMax': instance.currentTrainingMax,
      'isPlateau': instance.isPlateau,
    };

_LiftE1RmPointDto _$LiftE1RmPointDtoFromJson(Map<String, dynamic> json) =>
    _LiftE1RmPointDto(
      weekStart: json['weekStart'] as String? ?? '',
      e1Rm: (json['e1Rm'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LiftE1RmPointDtoToJson(_LiftE1RmPointDto instance) =>
    <String, dynamic>{'weekStart': instance.weekStart, 'e1Rm': instance.e1Rm};

_LiftPrEventDto _$LiftPrEventDtoFromJson(Map<String, dynamic> json) =>
    _LiftPrEventDto(
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      reps: (json['reps'] as num?)?.toInt() ?? 0,
      e1Rm: (json['e1Rm'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LiftPrEventDtoToJson(_LiftPrEventDto instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'weight': instance.weight,
      'reps': instance.reps,
      'e1Rm': instance.e1Rm,
    };

_DotsPointDto _$DotsPointDtoFromJson(Map<String, dynamic> json) =>
    _DotsPointDto(
      weekStart: json['weekStart'] as String? ?? '',
      dots: (json['dots'] as num?)?.toDouble() ?? 0.0,
      bodyweightKg: (json['bodyweightKg'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$DotsPointDtoToJson(_DotsPointDto instance) =>
    <String, dynamic>{
      'weekStart': instance.weekStart,
      'dots': instance.dots,
      'bodyweightKg': instance.bodyweightKg,
    };
