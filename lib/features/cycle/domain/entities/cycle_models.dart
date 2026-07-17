import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle_models.freezed.dart';

@freezed
abstract class CycleDailyLog with _$CycleDailyLog {
  const factory CycleDailyLog({
    required DateTime date,
    required List<String> symptoms,
    String? flow,
    String? mood,
    int? energyLevel,
    String? notes,
  }) = _CycleDailyLog;
}

@freezed
abstract class CycleOverview with _$CycleOverview {
  const factory CycleOverview({
    required String currentPhase,
    required int effectiveCycleLengthDays,
    required int effectivePeriodLengthDays,
    required bool isRegular,
    required String confidence,
    required bool needsData,
    required List<PredictedPeriod> predictedPeriods,
    required List<DateTime> ovulationDates,
    required List<FertileWindow> fertileWindows,
    int? cycleDay,
    int? daysUntilNextPeriod,
    int? daysLate,
    DateTime? lastPeriodStart,
    DateTime? nextPeriodStart,
    DateTime? currentPeriodPredictedEnd,
    int? avgCycleLengthDays,
    int? avgPeriodLengthDays,
    int? cycleVariabilityDays,
  }) = _CycleOverview;
}

@freezed
abstract class PredictedPeriod with _$PredictedPeriod {
  const factory PredictedPeriod({
    required DateTime start,
    required DateTime end,
  }) = _PredictedPeriod;
}

@freezed
abstract class FertileWindow with _$FertileWindow {
  const factory FertileWindow({
    required DateTime start,
    required DateTime end,
  }) = _FertileWindow;
}

@freezed
abstract class CycleSettings with _$CycleSettings {
  const factory CycleSettings({
    required bool shareWithCoach,
    int? averageCycleLengthOverride,
    int? averagePeriodLengthOverride,
  }) = _CycleSettings;
}

@freezed
abstract class CycleInsight with _$CycleInsight {
  const factory CycleInsight({
    required String language,
    required DateTime generatedAt,
    required bool cached,
    required CycleInsightContent content,
  }) = _CycleInsight;
}

@freezed
abstract class CycleInsightContent with _$CycleInsightContent {
  const factory CycleInsightContent({
    required String summary,
    required List<String> cyclePatterns,
    required List<String> symptomPatterns,
    required List<String> trainingCorrelations,
    required List<CyclePhaseRecommendation> phaseRecommendations,
    required List<String> cautions,
    required String disclaimer,
  }) = _CycleInsightContent;
}

@freezed
abstract class CyclePhaseRecommendation with _$CyclePhaseRecommendation {
  const factory CyclePhaseRecommendation({
    required String phase,
    required String training,
    required String nutrition,
  }) = _CyclePhaseRecommendation;
}
