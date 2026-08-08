typedef AiJson = Map<String, dynamic>;

String _text(AiJson json, String key) => (json[key] as String?)?.trim() ?? '';

List<String> _strings(Object? value) => value is List
    ? value
          .whereType<String>()
          .map((item) => item.trim())
          .where((item) => item.isNotEmpty)
          .toList()
    : const [];

DateTime _date(Object? value) => value is String
    ? DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0)
    : DateTime.fromMillisecondsSinceEpoch(0);

class TrainingCoachTipResponse {
  const TrainingCoachTipResponse({
    required this.language,
    required this.generatedAt,
    required this.cached,
    required this.headline,
    required this.category,
    required this.insight,
    required this.evidence,
    required this.whyItMatters,
    required this.nextAction,
    required this.confidence,
  });

  factory TrainingCoachTipResponse.fromJson(AiJson json) =>
      TrainingCoachTipResponse(
        language: _text(json, 'language'),
        generatedAt: _date(json['generatedAt']),
        cached: json['cached'] == true,
        headline: _text(json, 'headline'),
        category: _text(json, 'category'),
        insight: _text(json, 'insight'),
        evidence: _strings(json['evidence']),
        whyItMatters: _text(json, 'whyItMatters'),
        nextAction: _text(json, 'nextAction'),
        confidence: _text(json, 'confidence'),
      );

  final String language;
  final DateTime generatedAt;
  final bool cached;
  final String headline;
  final String category;
  final String insight;
  final List<String> evidence;
  final String whyItMatters;
  final String nextAction;
  final String confidence;
}

class AnalysisTrainingDecision {
  const AnalysisTrainingDecision({
    required this.verdict,
    required this.rationale,
    required this.prescription,
  });

  factory AnalysisTrainingDecision.fromJson(AiJson json) =>
      AnalysisTrainingDecision(
        verdict: _text(json, 'verdict'),
        rationale: _text(json, 'rationale'),
        prescription: _text(json, 'prescription'),
      );

  final String verdict;
  final String rationale;
  final String prescription;
}

class AnalysisPlanReview {
  const AnalysisPlanReview({
    required this.headline,
    required this.dataSummary,
    required this.goalFit,
    required this.deload,
    required this.loadProgression,
    required this.rpeGuidance,
    required this.volumeGuidance,
    required this.priorities,
  });

  factory AnalysisPlanReview.fromJson(AiJson json) => AnalysisPlanReview(
    headline: _text(json, 'headline'),
    dataSummary: _text(json, 'dataSummary'),
    goalFit: _text(json, 'goalFit'),
    deload: AnalysisTrainingDecision.fromJson(
      json['deload'] is AiJson ? json['deload'] as AiJson : const {},
    ),
    loadProgression: AnalysisTrainingDecision.fromJson(
      json['loadProgression'] is AiJson
          ? json['loadProgression'] as AiJson
          : const {},
    ),
    rpeGuidance: _text(json, 'rpeGuidance'),
    volumeGuidance: _text(json, 'volumeGuidance'),
    priorities: _strings(json['priorities']),
  );

  final String headline;
  final String dataSummary;
  final String goalFit;
  final AnalysisTrainingDecision deload;
  final AnalysisTrainingDecision loadProgression;
  final String rpeGuidance;
  final String volumeGuidance;
  final List<String> priorities;
}

class PlanProgressInsightResponse {
  const PlanProgressInsightResponse({
    required this.language,
    required this.planName,
    required this.generatedAt,
    required this.headline,
    required this.trajectory,
    required this.summary,
    required this.whatsWorking,
    required this.focusAreas,
    required this.nextBlock,
  });

  factory PlanProgressInsightResponse.fromJson(AiJson json) =>
      PlanProgressInsightResponse(
        language: _text(json, 'language'),
        planName: _text(json, 'planName'),
        generatedAt: _date(json['generatedAt']),
        headline: _text(json, 'headline'),
        trajectory: _text(json, 'trajectory'),
        summary: _text(json, 'summary'),
        whatsWorking: _strings(json['whatsWorking']),
        focusAreas: _strings(json['focusAreas']),
        nextBlock: _strings(json['nextBlock']),
      );

  final String language;
  final String planName;
  final DateTime generatedAt;
  final String headline;
  final String trajectory;
  final String summary;
  final List<String> whatsWorking;
  final List<String> focusAreas;
  final List<String> nextBlock;
}

class CoachClientAiBriefResponse {
  const CoachClientAiBriefResponse({
    required this.language,
    required this.generatedAt,
    required this.cached,
    required this.headline,
    required this.attentionLevel,
    required this.progressSummary,
    required this.risks,
    required this.opportunities,
    required this.suggestedMessage,
  });

  factory CoachClientAiBriefResponse.fromJson(AiJson json) =>
      CoachClientAiBriefResponse(
        language: _text(json, 'language'),
        generatedAt: _date(json['generatedAt']),
        cached: json['cached'] == true,
        headline: _text(json, 'headline'),
        attentionLevel: _text(json, 'attentionLevel'),
        progressSummary: _text(json, 'progressSummary'),
        risks: _strings(json['risks']),
        opportunities: _strings(json['opportunities']),
        suggestedMessage: _text(json, 'suggestedMessage'),
      );

  final String language;
  final DateTime generatedAt;
  final bool cached;
  final String headline;
  final String attentionLevel;
  final String progressSummary;
  final List<String> risks;
  final List<String> opportunities;
  final String suggestedMessage;
}
