import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/cycle_models.dart';

part 'cycle_dtos.freezed.dart';
part 'cycle_dtos.g.dart';

@freezed
abstract class CycleDailyLogDto with _$CycleDailyLogDto {
  const factory CycleDailyLogDto({
    required String date,
    @Default(<String>[]) List<String> symptoms,
    String? flow,
    String? mood,
    int? energyLevel,
    String? notes,
  }) = _CycleDailyLogDto;

  const CycleDailyLogDto._();

  factory CycleDailyLogDto.fromJson(Map<String, dynamic> json) =>
      _$CycleDailyLogDtoFromJson(json);

  CycleDailyLog toEntity() => CycleDailyLog(
    date: DateOnly.tryParse(date) ?? DateTime(1970),
    flow: flow,
    symptoms: symptoms,
    mood: mood,
    energyLevel: energyLevel,
    notes: notes,
  );
}

@freezed
abstract class CycleOverviewDto with _$CycleOverviewDto {
  const factory CycleOverviewDto({
    required String currentPhase,
    required int effectiveCycleLengthDays,
    required int effectivePeriodLengthDays,
    required bool isRegular,
    required String confidence,
    required bool needsData,
    @Default(<PredictedPeriodDto>[]) List<PredictedPeriodDto> predictedPeriods,
    @Default(<String>[]) List<String> ovulationDates,
    @Default(<FertileWindowDto>[]) List<FertileWindowDto> fertileWindows,
    int? cycleDay,
    int? daysUntilNextPeriod,
    int? daysLate,
    String? lastPeriodStart,
    String? nextPeriodStart,
    String? currentPeriodPredictedEnd,
    int? avgCycleLengthDays,
    int? avgPeriodLengthDays,
    int? cycleVariabilityDays,
  }) = _CycleOverviewDto;

  const CycleOverviewDto._();

  factory CycleOverviewDto.fromJson(Map<String, dynamic> json) =>
      _$CycleOverviewDtoFromJson(json);

  CycleOverview toEntity() => CycleOverview(
    currentPhase: currentPhase,
    cycleDay: cycleDay,
    daysUntilNextPeriod: daysUntilNextPeriod,
    daysLate: daysLate,
    lastPeriodStart: DateOnly.tryParse(lastPeriodStart),
    nextPeriodStart: DateOnly.tryParse(nextPeriodStart),
    currentPeriodPredictedEnd: DateOnly.tryParse(currentPeriodPredictedEnd),
    predictedPeriods: predictedPeriods.map((e) => e.toEntity()).toList(),
    ovulationDates: ovulationDates
        .map(DateOnly.tryParse)
        .whereType<DateTime>()
        .toList(),
    fertileWindows: fertileWindows.map((e) => e.toEntity()).toList(),
    effectiveCycleLengthDays: effectiveCycleLengthDays,
    effectivePeriodLengthDays: effectivePeriodLengthDays,
    avgCycleLengthDays: avgCycleLengthDays,
    avgPeriodLengthDays: avgPeriodLengthDays,
    isRegular: isRegular,
    cycleVariabilityDays: cycleVariabilityDays,
    confidence: confidence,
    needsData: needsData,
  );
}

@freezed
abstract class PredictedPeriodDto with _$PredictedPeriodDto {
  const factory PredictedPeriodDto({
    required String start,
    required String end,
  }) = _PredictedPeriodDto;

  const PredictedPeriodDto._();

  factory PredictedPeriodDto.fromJson(Map<String, dynamic> json) =>
      _$PredictedPeriodDtoFromJson(json);

  PredictedPeriod toEntity() => PredictedPeriod(
    start: DateOnly.tryParse(start) ?? DateTime(1970),
    end: DateOnly.tryParse(end) ?? DateTime(1970),
  );
}

@freezed
abstract class FertileWindowDto with _$FertileWindowDto {
  const factory FertileWindowDto({
    required String start,
    required String end,
  }) = _FertileWindowDto;

  const FertileWindowDto._();

  factory FertileWindowDto.fromJson(Map<String, dynamic> json) =>
      _$FertileWindowDtoFromJson(json);

  FertileWindow toEntity() => FertileWindow(
    start: DateOnly.tryParse(start) ?? DateTime(1970),
    end: DateOnly.tryParse(end) ?? DateTime(1970),
  );
}

@freezed
abstract class CycleSettingsDto with _$CycleSettingsDto {
  const factory CycleSettingsDto({
    required bool shareWithCoach,
    int? averageCycleLengthOverride,
    int? averagePeriodLengthOverride,
  }) = _CycleSettingsDto;

  const CycleSettingsDto._();

  factory CycleSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$CycleSettingsDtoFromJson(json);

  CycleSettings toEntity() => CycleSettings(
    averageCycleLengthOverride: averageCycleLengthOverride,
    averagePeriodLengthOverride: averagePeriodLengthOverride,
    shareWithCoach: shareWithCoach,
  );
}

@freezed
abstract class CycleInsightDto with _$CycleInsightDto {
  const factory CycleInsightDto({
    required String language,
    required String generatedAt,
    required bool cached,
    required CycleInsightContentDto content,
  }) = _CycleInsightDto;

  const CycleInsightDto._();

  factory CycleInsightDto.fromJson(Map<String, dynamic> json) =>
      _$CycleInsightDtoFromJson(json);

  CycleInsight toEntity() => CycleInsight(
    language: language,
    generatedAt: DateTime.tryParse(generatedAt) ?? DateTime(1970),
    cached: cached,
    content: content.toEntity(),
  );
}

@freezed
abstract class CycleInsightContentDto with _$CycleInsightContentDto {
  const factory CycleInsightContentDto({
    required String summary,
    required String disclaimer,
    @Default(<String>[]) List<String> cyclePatterns,
    @Default(<String>[]) List<String> symptomPatterns,
    @Default(<String>[]) List<String> trainingCorrelations,
    @Default(<CyclePhaseRecommendationDto>[])
    List<CyclePhaseRecommendationDto> phaseRecommendations,
    @Default(<String>[]) List<String> cautions,
  }) = _CycleInsightContentDto;

  const CycleInsightContentDto._();

  factory CycleInsightContentDto.fromJson(Map<String, dynamic> json) =>
      _$CycleInsightContentDtoFromJson(json);

  CycleInsightContent toEntity() => CycleInsightContent(
    summary: summary,
    cyclePatterns: cyclePatterns,
    symptomPatterns: symptomPatterns,
    trainingCorrelations: trainingCorrelations,
    phaseRecommendations: phaseRecommendations
        .map((e) => e.toEntity())
        .toList(),
    cautions: cautions,
    disclaimer: disclaimer,
  );
}

@freezed
abstract class CyclePhaseRecommendationDto with _$CyclePhaseRecommendationDto {
  const factory CyclePhaseRecommendationDto({
    required String phase,
    required String training,
    required String nutrition,
  }) = _CyclePhaseRecommendationDto;

  const CyclePhaseRecommendationDto._();

  factory CyclePhaseRecommendationDto.fromJson(Map<String, dynamic> json) =>
      _$CyclePhaseRecommendationDtoFromJson(json);

  CyclePhaseRecommendation toEntity() => CyclePhaseRecommendation(
    phase: phase,
    training: training,
    nutrition: nutrition,
  );
}
