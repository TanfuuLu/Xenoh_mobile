// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CycleDailyLogDto _$CycleDailyLogDtoFromJson(Map<String, dynamic> json) =>
    _CycleDailyLogDto(
      date: json['date'] as String,
      symptoms:
          (json['symptoms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      flow: json['flow'] as String?,
      mood: json['mood'] as String?,
      energyLevel: (json['energyLevel'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CycleDailyLogDtoToJson(_CycleDailyLogDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'symptoms': instance.symptoms,
      'flow': instance.flow,
      'mood': instance.mood,
      'energyLevel': instance.energyLevel,
      'notes': instance.notes,
    };

_CycleOverviewDto _$CycleOverviewDtoFromJson(
  Map<String, dynamic> json,
) => _CycleOverviewDto(
  currentPhase: json['currentPhase'] as String,
  effectiveCycleLengthDays: (json['effectiveCycleLengthDays'] as num).toInt(),
  effectivePeriodLengthDays: (json['effectivePeriodLengthDays'] as num).toInt(),
  isRegular: json['isRegular'] as bool,
  confidence: json['confidence'] as String,
  needsData: json['needsData'] as bool,
  predictedPeriods:
      (json['predictedPeriods'] as List<dynamic>?)
          ?.map((e) => PredictedPeriodDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PredictedPeriodDto>[],
  ovulationDates:
      (json['ovulationDates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  fertileWindows:
      (json['fertileWindows'] as List<dynamic>?)
          ?.map((e) => FertileWindowDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FertileWindowDto>[],
  cycleDay: (json['cycleDay'] as num?)?.toInt(),
  daysUntilNextPeriod: (json['daysUntilNextPeriod'] as num?)?.toInt(),
  daysLate: (json['daysLate'] as num?)?.toInt(),
  lastPeriodStart: json['lastPeriodStart'] as String?,
  nextPeriodStart: json['nextPeriodStart'] as String?,
  currentPeriodPredictedEnd: json['currentPeriodPredictedEnd'] as String?,
  avgCycleLengthDays: (json['avgCycleLengthDays'] as num?)?.toInt(),
  avgPeriodLengthDays: (json['avgPeriodLengthDays'] as num?)?.toInt(),
  cycleVariabilityDays: (json['cycleVariabilityDays'] as num?)?.toInt(),
);

Map<String, dynamic> _$CycleOverviewDtoToJson(_CycleOverviewDto instance) =>
    <String, dynamic>{
      'currentPhase': instance.currentPhase,
      'effectiveCycleLengthDays': instance.effectiveCycleLengthDays,
      'effectivePeriodLengthDays': instance.effectivePeriodLengthDays,
      'isRegular': instance.isRegular,
      'confidence': instance.confidence,
      'needsData': instance.needsData,
      'predictedPeriods': instance.predictedPeriods,
      'ovulationDates': instance.ovulationDates,
      'fertileWindows': instance.fertileWindows,
      'cycleDay': instance.cycleDay,
      'daysUntilNextPeriod': instance.daysUntilNextPeriod,
      'daysLate': instance.daysLate,
      'lastPeriodStart': instance.lastPeriodStart,
      'nextPeriodStart': instance.nextPeriodStart,
      'currentPeriodPredictedEnd': instance.currentPeriodPredictedEnd,
      'avgCycleLengthDays': instance.avgCycleLengthDays,
      'avgPeriodLengthDays': instance.avgPeriodLengthDays,
      'cycleVariabilityDays': instance.cycleVariabilityDays,
    };

_PredictedPeriodDto _$PredictedPeriodDtoFromJson(Map<String, dynamic> json) =>
    _PredictedPeriodDto(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$PredictedPeriodDtoToJson(_PredictedPeriodDto instance) =>
    <String, dynamic>{'start': instance.start, 'end': instance.end};

_FertileWindowDto _$FertileWindowDtoFromJson(Map<String, dynamic> json) =>
    _FertileWindowDto(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$FertileWindowDtoToJson(_FertileWindowDto instance) =>
    <String, dynamic>{'start': instance.start, 'end': instance.end};

_CycleSettingsDto _$CycleSettingsDtoFromJson(Map<String, dynamic> json) =>
    _CycleSettingsDto(
      shareWithCoach: json['shareWithCoach'] as bool,
      averageCycleLengthOverride: (json['averageCycleLengthOverride'] as num?)
          ?.toInt(),
      averagePeriodLengthOverride: (json['averagePeriodLengthOverride'] as num?)
          ?.toInt(),
    );

Map<String, dynamic> _$CycleSettingsDtoToJson(_CycleSettingsDto instance) =>
    <String, dynamic>{
      'shareWithCoach': instance.shareWithCoach,
      'averageCycleLengthOverride': instance.averageCycleLengthOverride,
      'averagePeriodLengthOverride': instance.averagePeriodLengthOverride,
    };

_CycleInsightDto _$CycleInsightDtoFromJson(Map<String, dynamic> json) =>
    _CycleInsightDto(
      language: json['language'] as String,
      generatedAt: json['generatedAt'] as String,
      cached: json['cached'] as bool,
      content: CycleInsightContentDto.fromJson(
        json['content'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CycleInsightDtoToJson(_CycleInsightDto instance) =>
    <String, dynamic>{
      'language': instance.language,
      'generatedAt': instance.generatedAt,
      'cached': instance.cached,
      'content': instance.content,
    };

_CycleInsightContentDto _$CycleInsightContentDtoFromJson(
  Map<String, dynamic> json,
) => _CycleInsightContentDto(
  summary: json['summary'] as String,
  disclaimer: json['disclaimer'] as String,
  cyclePatterns:
      (json['cyclePatterns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  symptomPatterns:
      (json['symptomPatterns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  trainingCorrelations:
      (json['trainingCorrelations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  phaseRecommendations:
      (json['phaseRecommendations'] as List<dynamic>?)
          ?.map(
            (e) =>
                CyclePhaseRecommendationDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <CyclePhaseRecommendationDto>[],
  cautions:
      (json['cautions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$CycleInsightContentDtoToJson(
  _CycleInsightContentDto instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'disclaimer': instance.disclaimer,
  'cyclePatterns': instance.cyclePatterns,
  'symptomPatterns': instance.symptomPatterns,
  'trainingCorrelations': instance.trainingCorrelations,
  'phaseRecommendations': instance.phaseRecommendations,
  'cautions': instance.cautions,
};

_CyclePhaseRecommendationDto _$CyclePhaseRecommendationDtoFromJson(
  Map<String, dynamic> json,
) => _CyclePhaseRecommendationDto(
  phase: json['phase'] as String,
  training: json['training'] as String,
  nutrition: json['nutrition'] as String,
);

Map<String, dynamic> _$CyclePhaseRecommendationDtoToJson(
  _CyclePhaseRecommendationDto instance,
) => <String, dynamic>{
  'phase': instance.phase,
  'training': instance.training,
  'nutrition': instance.nutrition,
};
