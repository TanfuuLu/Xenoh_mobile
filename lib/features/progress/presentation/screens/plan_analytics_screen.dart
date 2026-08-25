import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_l10n.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/pro_locked_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../domain/entities/plan_analytics.dart';
import '../providers/progress_controllers.dart';
import '../widgets/line_series_chart.dart';
import '../widgets/weekly_completion_chart.dart';

/// Pro-gated plan analytics: training score, summary metrics, insights, the
/// weekly planned-vs-completed comparison and muscle-group distribution.
class PlanAnalyticsScreen extends ConsumerWidget {
  const PlanAnalyticsScreen({required this.planId, super.key});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final analytics = ref.watch(planAnalyticsProvider(planId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.progressAnalyticsTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref.refresh(planAnalyticsProvider(planId).future),
        child: _body(context, ref, analytics),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<PlanAnalytics> analytics,
  ) {
    // Pro gate: surface a clear upgrade prompt instead of a generic error.
    if (!analytics.hasValue && analytics.error is ForbiddenFailure) {
      final l10n = AppLocalizations.of(context);
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            child: ProLockedView(
              title: l10n.progressAnalyticsProFeatureTitle,
              message: localizedFailureMessage(
                analytics.error! as ForbiddenFailure,
                l10n,
              ),
              onUpgrade: () => context.push('/subscription'),
            ),
          ),
        ],
      );
    }

    return AsyncValueView(
      value: analytics,
      onRetry: () => ref.invalidate(planAnalyticsProvider(planId)),
      data: (a) => ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          PlanAnalyticsView(
            analytics: a,
            unit: ref.watch(weightUnitProvider),
            trackRpe: ref.watch(trackRpeProvider),
          ),
        ],
      ),
    );
  }
}

/// Renders the body of the plan analytics as the app's dashboard-style layout:
/// a training-score hero followed by a single translucent [XnSectionGroup]
/// panel whose divided sections hold the summary metrics, insights, weekly
/// compliance and muscle-group distribution — no standalone cards. Shared by
/// [PlanAnalyticsScreen] and the plan-progress screen.
class PlanAnalyticsView extends StatelessWidget {
  const PlanAnalyticsView({
    required this.analytics,
    required this.unit,
    this.trackRpe = true,
    super.key,
  });

  final PlanAnalytics analytics;
  final WeightUnit unit;

  /// The user's `trackRpe` preference. With RPE logging off there is nothing
  /// behind the average-RPE and high-RPE tiles, so they are left out.
  final bool trackRpe;

  @override
  Widget build(BuildContext context) {
    final a = analytics;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ScoreHero(score: a.trainingScore, consistency: a.consistencyPercent),
        const SizedBox(height: AppSpacing.md),
        _StatsSection(analytics: a, unit: unit, trackRpe: trackRpe),
        if (a.insights.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _InsightsSection(insights: a.insights),
        ],
        if (a.weeklyCompliance.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _AnalyticsPanel(
            child: _WeeklySection(weeks: a.weeklyCompliance),
          ),
        ],
        if (a.weeklyVolume.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _AnalyticsPanel(
            child: _WeeklyVolumeSection(weeks: a.weeklyVolume, unit: unit),
          ),
        ],
        if (a.muscleGroupVolume.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _MuscleSection(points: a.muscleGroupVolume),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _AnalyticsPanel extends StatelessWidget {
  const _AnalyticsPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: child,
    );
  }
}

class _ScoreHero extends StatelessWidget {
  const _ScoreHero({required this.score, required this.consistency});

  final int score;
  final double consistency;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.progressTrainingScoreLabel,
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$score',
                    style: AppTypography.display(
                      40,
                      color: AppColors.fg1,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    ' / 100',
                    style: TextStyle(color: AppColors.fg3, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${consistency.round()}%',
                style: AppTypography.mono(
                  22,
                  weight: FontWeight.w500,
                  color: AppColors.fg1,
                ),
              ),
              Text(
                l10n.progressConsistencyLabel,
                style: const TextStyle(color: AppColors.fg3, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The summary metrics as a two-column grid of plain label/value tiles inside
/// a divided section — replaces the former grid of individual metric cards.
class _StatsSection extends StatelessWidget {
  const _StatsSection({
    required this.analytics,
    required this.unit,
    required this.trackRpe,
  });

  final PlanAnalytics analytics;
  final WeightUnit unit;
  final bool trackRpe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final a = analytics;
    final tiles = <(String, String)>[
      (l10n.progressWorkoutsLabel, '${a.totalWorkoutsCompleted}'),
      (
        l10n.progressVolumeLabel,
        '${_compactVolume(unit.fromKg(a.totalVolume))} ${unit.suffix}',
      ),
      (l10n.progressCompletedSetsLabel, '${a.completedSets}'),
      (
        l10n.progressAvgSessionsPerWeekLabel,
        a.avgSessionsPerWeek.toStringAsFixed(1),
      ),
      if (trackRpe) ...[
        (
          l10n.progressAvgRpeLabel,
          a.avgRpe == null ? '-' : a.avgRpe!.toStringAsFixed(1),
        ),
        (l10n.progressHighRpeSetsLabel, '${a.highRpeSets}'),
      ],
      (l10n.progressWarningDaysLabel, '${a.warningDays}'),
      (
        l10n.progressTimeTrainedLabel,
        _formatDuration(a.totalDuration, l10n),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnSectionEyebrow(l10n.progressOverviewTab),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          children: [
            for (final (label, value) in tiles)
              _StatTile(label: label, value: value),
          ],
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.fg3,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.display(24, letterSpacing: 0),
        ),
      ],
    );
  }
}

/// Insights as icon + text rows inside a divided section — the severity now
/// reads from the coloured icon and metric line instead of a card background.
class _InsightsSection extends StatelessWidget {
  const _InsightsSection({required this.insights});

  final List<TrainingInsight> insights;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnSectionEyebrow(l10n.progressInsightsTitle),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          children: [
            for (final insight in insights) _InsightRow(insight: insight),
          ],
        ),
      ],
    );
  }
}

class _InsightRow extends StatelessWidget {
  const _InsightRow({required this.insight});

  final TrainingInsight insight;

  @override
  Widget build(BuildContext context) {
    final localized = _localizedInsight(
      insight,
      AppLocalizations.of(context),
      Localizations.localeOf(context).languageCode,
    );
    final (color, _, icon) = _severityStyle(insight.severity);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localized.title,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (localized.message.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  localized.message,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ],
              if (localized.metricLabel.isNotEmpty &&
                  localized.metricValue.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${localized.metricLabel}: ${localized.metricValue}',
                  style: AppTypography.mono(12, color: color),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Weekly planned-vs-completed progress rows inside a divided section.
class _WeeklySection extends StatelessWidget {
  const _WeeklySection({required this.weeks});

  final List<WeekCompliancePoint> weeks;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.progressWeeklyTrainingTitle),
          const SizedBox(height: AppSpacing.lg),
          WeeklyCompletionChart(
            data: [
              for (final week in weeks)
                WeeklyCompletionDatum(
                  label: l10n.progressWeekShortLabel(week.weekNumber),
                  completed: week.completedDays,
                  total: week.totalDays,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Weekly training volume (tonnage) as a single-series bar chart inside a
/// divided section.
class _WeeklyVolumeSection extends StatelessWidget {
  const _WeeklyVolumeSection({required this.weeks, required this.unit});

  final List<WeekVolumePoint> weeks;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.progressWeeklyVolumeTitle),
          const SizedBox(height: AppSpacing.lg),
          LineSeriesChart(
            yLabel: (v) => '${_compactVolume(unit.fromKg(v))} ${unit.suffix}',
            series: [
              LineSeries(
                name: l10n.progressWeeklyVolumeTitle,
                color: AppColors.accent,
                points: [
                  for (final w in weeks)
                    (
                      x: l10n.progressWeekShortLabel(w.weekNumber),
                      y: w.totalVolume,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Muscle-group volume distribution as labelled progress rows inside a divided
/// section.
class _MuscleSection extends StatelessWidget {
  const _MuscleSection({required this.points});

  final List<MuscleGroupVolumePoint> points;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sorted = [...points]
      ..sort((a, b) => b.totalVolume.compareTo(a.totalVolume));
    final maxPct = sorted
        .map((p) => p.percentOfTotal)
        .fold<double>(0, (a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnSectionEyebrow(l10n.progressMuscleGroupsTitle),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          children: [
            for (var i = 0; i < sorted.length; i++)
              _MuscleRow(
                point: sorted[i],
                maxPct: maxPct,
                color: AppColors.dataColor(i),
              ),
          ],
        ),
      ],
    );
  }
}

class _MuscleRow extends StatelessWidget {
  const _MuscleRow({
    required this.point,
    required this.maxPct,
    required this.color,
  });

  final MuscleGroupVolumePoint point;
  final double maxPct;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final ratio = maxPct <= 0 ? 0.0 : point.percentOfTotal / maxPct;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _localizedMuscleGroup(
                  point.muscleGroup,
                  l10n,
                  Localizations.localeOf(context).languageCode,
                ),
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              '${l10n.progressSetsValue(point.completedSets)} / '
              '${point.percentOfTotal.round()}%',
              style: AppTypography.mono(11, color: AppColors.fg3),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: AppColors.bg3,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

(Color, Color, IconData) _severityStyle(String severity) {
  switch (severity.toLowerCase()) {
    case 'critical':
    case 'danger':
      return (
        AppColors.danger,
        AppColors.dangerBg,
        Icons.error_outline_rounded,
      );
    case 'warning':
      return (
        AppColors.warning,
        AppColors.warningBg,
        Icons.warning_amber_rounded,
      );
    case 'success':
    case 'positive':
      return (
        AppColors.success,
        AppColors.successBg,
        Icons.check_circle_outline_rounded,
      );
    default:
      return (
        AppColors.info,
        AppColors.infoBg,
        Icons.lightbulb_outline_rounded,
      );
  }
}

/// Vietnamese copy for the insights the backend generates.
///
/// `TrainingInsightAnalyzer` and `PowerliftingInsightRules` on the server
/// always emit English, so every card is matched here on its exact English
/// title (plus the message where one title has two variants) and swapped for
/// localized copy. Anything unmatched falls back to the server text rather
/// than showing an empty card.
({String title, String message, String metricLabel, String metricValue})
_localizedInsight(
  TrainingInsight insight,
  AppLocalizations l10n,
  String languageCode,
) {
  final original = (
    title: insight.title,
    message: insight.message,
    metricLabel: insight.metricLabel,
    metricValue: insight.metricValue,
  );
  if (languageCode != 'vi') return original;

  final title = insight.title.trim();
  final message = insight.message.toLowerCase();
  final metricLabel = _localizedMetricLabel(insight.metricLabel, l10n);
  final metricValue = _localizedMetricValue(insight.metricValue, l10n);

  ({String title, String message}) copy;
  switch (title) {
    // Consistency.
    case 'No training days planned':
      copy = (
        title: l10n.progressInsightNoTrainingDaysTitle,
        message: l10n.progressInsightNoTrainingDaysMessage,
      );
    case 'Consistency needs attention':
      copy = (
        title: l10n.progressInsightConsistencyCriticalTitle,
        message: l10n.progressInsightConsistencyCriticalMessage,
      );
    case 'Consistency is uneven':
      copy = (
        title: l10n.progressInsightConsistencyTitle,
        message: l10n.progressInsightConsistencyMessage,
      );
    case 'Strong consistency':
      copy = (
        title: l10n.progressInsightConsistencyStrongTitle,
        message: l10n.progressInsightConsistencyStrongMessage,
      );

    // Volume trend and overload.
    case 'More volume history needed':
      copy = (
        title: l10n.progressInsightVolumeHistoryTitle,
        // Same title, two server messages: too few weeks vs. an unusable
        // baseline in the previous week.
        message: message.contains('baseline')
            ? l10n.progressInsightVolumeBaselineMessage
            : l10n.progressInsightVolumeHistoryMessage,
      );
    case 'Planned volume reduction':
      copy = (
        title: l10n.progressInsightPlannedReductionTitle,
        message: l10n.progressInsightPlannedReductionMessage,
      );
    case 'Volume dropped sharply':
      copy = (
        title: l10n.progressInsightVolumeDropTitle,
        message: l10n.progressInsightVolumeDropMessage,
      );
    case 'Volume is trending down':
      copy = (
        title: l10n.progressInsightVolumeTitle,
        message: l10n.progressInsightVolumeMessage,
      );
    case 'Large overload jump':
      copy = (
        title: l10n.progressInsightOverloadJumpTitle,
        message: l10n.progressInsightOverloadJumpMessage,
      );
    case 'Progressive overload is moving':
      copy = (
        title: l10n.progressInsightOverloadMovingTitle,
        message: l10n.progressInsightOverloadMovingMessage,
      );
    case 'Volume is stable':
      copy = (
        title: l10n.progressInsightVolumeStableTitle,
        message: l10n.progressInsightVolumeStableMessage,
      );

    // Fatigue.
    case 'Fatigue risk is elevated':
      copy = (
        title: l10n.progressInsightFatigueRiskTitle,
        message: l10n.progressInsightFatigueRiskMessage,
      );
    case 'Some sets missed target':
      copy = (
        title: l10n.progressInsightMissedTargetTitle,
        message: l10n.progressInsightMissedTargetMessage,
      );

    // Recommendations.
    case 'Prioritize recovery':
      copy = (
        title: l10n.progressInsightPrioritizeRecoveryTitle,
        message: l10n.progressInsightPrioritizeRecoveryMessage,
      );
    case 'Repeat or simplify the week':
      copy = (
        title: l10n.progressInsightRepeatWeekTitle,
        message: l10n.progressInsightRepeatWeekMessage,
      );
    case 'Progress gradually':
      copy = (
        title: l10n.progressInsightProgressGraduallyTitle,
        message: l10n.progressInsightProgressGraduallyMessage,
      );
    case 'Hold the plan steady':
      copy = (
        title: l10n.progressInsightHoldSteadyTitle,
        message: l10n.progressInsightHoldSteadyMessage,
      );

    // Powerlifting rules. The ratios are read back from the metric value so
    // the localized sentence always quotes the same number as the card.
    case 'Bench is lagging your squat':
      copy = (
        title: l10n.progressInsightBenchSquatTitle,
        message: l10n.progressInsightBenchSquatMessage(
          _percentOf(insight.metricValue),
        ),
      );
    case 'Deadlift is below your squat':
      copy = (
        title: l10n.progressInsightDeadliftSquatTitle,
        message: l10n.progressInsightDeadliftSquatMessage(
          _percentOf(insight.metricValue),
        ),
      );
    case 'Long stretch of high-RPE work':
      copy = (
        title: l10n.progressInsightHighRpeStreakTitle,
        message: l10n.progressInsightHighRpeStreakMessage(insight.metricValue),
      );

    // Muscle balance, and the per-lift plateau titles ("Squat is
    // plateauing"), which carry the lift name in the title itself.
    default:
      if (title.toLowerCase().contains('muscle') &&
          title.toLowerCase().contains('balance')) {
        copy = (
          title: l10n.progressInsightMuscleBalanceTitle,
          message: l10n.progressInsightMuscleBalanceMessage,
        );
        break;
      }
      final plateau = RegExp(r'^(.+) is plateauing$').firstMatch(title);
      if (plateau != null) {
        final lift = plateau.group(1)!;
        copy = (
          title: l10n.progressInsightPlateauTitle(lift),
          message: l10n.progressInsightPlateauMessage(lift),
        );
        break;
      }
      return (
        title: insight.title,
        message: insight.message,
        metricLabel: metricLabel,
        metricValue: metricValue,
      );
  }

  return (
    title: copy.title,
    message: copy.message,
    metricLabel: metricLabel,
    metricValue: metricValue,
  );
}

/// Metric labels are a small closed set shared across insights, so they are
/// translated by label instead of being repeated per insight.
String _localizedMetricLabel(String label, AppLocalizations l10n) {
  switch (label.trim()) {
    case 'Planned days':
      return l10n.progressInsightMetricPlannedDays;
    case 'Completion':
      return l10n.progressInsightMetricCompletion;
    case 'Weeks logged':
      return l10n.progressInsightMetricWeeksLogged;
    case 'Volume change':
      return l10n.progressInsightMetricVolumeChange;
    case 'Avg RPE':
      return l10n.progressInsightMetricAvgRpe;
    case 'Warning days':
      return l10n.progressInsightMetricWarningDays;
    case 'High-RPE sets':
      return l10n.progressInsightMetricHighRpeSets;
    case 'Training score':
      return l10n.progressInsightMetricTrainingScore;
    case 'Current e1RM':
      return l10n.progressInsightMetricCurrentE1Rm;
    case 'High-RPE weeks':
      return l10n.progressInsightMetricHighRpeWeeks;
    // 'Bench / Squat', 'Deadlift / Squat' and 'Top group' are lift names or
    // already-translated values, so they pass through unchanged.
    default:
      return label;
  }
}

/// Metric values are numeric except for the fatigue fallback, which the
/// server writes as `"N high-RPE sets"`.
String _localizedMetricValue(String value, AppLocalizations l10n) {
  final sets = RegExp(r'^(\d+) high-RPE sets$').firstMatch(value.trim());
  return sets == null
      ? value
      : l10n.progressInsightHighRpeSetsValue(sets.group(1)!);
}

/// `"63%"` -> `"63"`, so a localized sentence can place the unit itself.
String _percentOf(String metricValue) => metricValue.replaceAll('%', '').trim();

String _localizedMuscleGroup(
  String muscleGroup,
  AppLocalizations l10n,
  String languageCode,
) {
  if (languageCode != 'vi') return muscleGroup;
  switch (muscleGroup.toLowerCase().replaceAll(RegExp('[^a-z]'), '')) {
    case 'back':
      return l10n.progressMuscleBack;
    case 'abs':
    case 'abdominals':
      return l10n.progressMuscleAbs;
    case 'shoulders':
      return l10n.progressMuscleShoulders;
    case 'chest':
      return l10n.progressMuscleChest;
    case 'triceps':
      return l10n.progressMuscleTriceps;
    case 'hamstrings':
      return l10n.progressMuscleHamstrings;
    case 'quads':
    case 'quadriceps':
      return l10n.progressMuscleQuads;
    case 'biceps':
      return l10n.progressMuscleBiceps;
    case 'glutes':
    case 'gluteals':
      return l10n.progressMuscleGlutes;
    case 'forearms':
      return l10n.progressMuscleForearms;
    case 'calves':
      return l10n.progressMuscleCalves;
    default:
      return muscleGroup;
  }
}

String _compactVolume(double v) {
  if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
  if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}k';
  return v.toStringAsFixed(0);
}

String _formatDuration(Duration d, AppLocalizations l10n) {
  final hours = d.inHours;
  final minutes = d.inMinutes % 60;
  if (hours == 0) return l10n.progressDurationMinutes(minutes);
  return l10n.progressDurationHoursMinutes(hours, minutes);
}
