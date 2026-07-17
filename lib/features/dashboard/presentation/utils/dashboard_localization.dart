import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/personal_dashboard.dart';

({String label, String description}) localizeDashboardNextAction(
  NextAction action,
  AppLocalizations l10n,
  String languageCode,
) {
  final original = (label: action.label, description: action.description);
  if (languageCode != 'vi') return original;

  final identity = '${action.type} ${action.label}'.toLowerCase();
  if (identity.contains('workout')) {
    final sets = _fraction(action.description);
    return (
      label: l10n.dashboardNextActionWorkoutLabel,
      description: sets == null
          ? l10n.dashboardNextActionWorkoutDescription
          : l10n.dashboardNextActionWorkoutProgress(sets.left, sets.right),
    );
  }
  if (identity.contains('nutrition')) {
    return (
      label: l10n.dashboardNextActionNutritionLabel,
      description: l10n.dashboardNextActionNutritionDescription,
    );
  }
  if (identity.contains('insight')) {
    return (
      label: l10n.dashboardNextActionInsightsLabel,
      description: l10n.dashboardNextActionInsightsDescription,
    );
  }
  return original;
}

({String title, String message}) localizeDashboardInsight(
  ProInsightItem insight,
  AppLocalizations l10n,
  String languageCode,
) {
  final original = (title: insight.title, message: insight.message);
  if (languageCode != 'vi') return original;

  final identity = '${insight.type} ${insight.title}'.toLowerCase();
  if (identity.contains('plan') && identity.contains('progress')) {
    final days = _fraction(insight.message);
    if (days == null) return original;
    return (
      title: l10n.dashboardInsightPlanProgressTitle,
      message: l10n.dashboardInsightPlanProgressMessage(days.left, days.right),
    );
  }
  if (identity.contains('today') && identity.contains('training')) {
    final percent = _percent(insight.message);
    if (percent == null) return original;
    return (
      title: l10n.dashboardInsightTodayTrainingTitle,
      message: l10n.dashboardInsightTodayTrainingMessage(percent),
    );
  }
  if (identity.contains('nutrition') && identity.contains('target')) {
    final calories = _fraction(insight.message);
    if (calories == null) return original;
    return (
      title: l10n.dashboardInsightNutritionTargetTitle,
      message: l10n.dashboardInsightNutritionTargetMessage(
        calories.left,
        calories.right,
      ),
    );
  }
  return original;
}

({String left, String right})? _fraction(String value) {
  final match = RegExp(
    r'(\d+(?:\.\d+)?)\s*/\s*(\d+(?:\.\d+)?)',
  ).firstMatch(value);
  return match == null ? null : (left: match.group(1)!, right: match.group(2)!);
}

String? _percent(String value) =>
    RegExp(r'(\d+(?:\.\d+)?)\s*%').firstMatch(value)?.group(1);
