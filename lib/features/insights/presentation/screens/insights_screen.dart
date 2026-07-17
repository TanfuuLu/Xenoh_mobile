import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/text_bullets.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/bullet_list.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/domain/entities/bodyweight_log.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../profile/presentation/widgets/bodyweight_chart.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final personalInsightsProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, lang) {
      return ref.watch(xenohApiProvider).getObject('/insights/me?lang=$lang');
    });

final coachTipProvider = FutureProvider.autoDispose.family<JsonMap, String>((
  ref,
  lang,
) {
  return ref
      .watch(xenohApiProvider)
      .getObject('/insights/me/coach-tip?lang=$lang');
});

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  Future<void> _refresh(WidgetRef ref, String lang) async {
    ref
      ..invalidate(personalInsightsProvider(lang))
      ..invalidate(coachTipProvider(lang));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lang = ref.watch(appLocaleProvider)?.languageCode ?? 'en';
    final insight = ref.watch(personalInsightsProvider(lang));
    final tip = ref.watch(coachTipProvider(lang));
    final unit = ref.watch(weightUnitProvider);
    return FeatureScreenFrame(
      title: l10n.insightsTitle,
      actions: [
        IconButton(
          tooltip: l10n.insightsRefreshTooltip,
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () => unawaited(_refresh(ref, lang)),
        ),
      ],
      onRefresh: () => _refresh(ref, lang),
      children: [
        FeatureHeader(
          title: l10n.insightsHeaderTitle,
          subtitle: l10n.insightsHeaderSubtitle,
          icon: Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.insightsCoachTipTitle, style: AppTypography.display(18)),
        const SizedBox(height: AppSpacing.sm),
        switch (tip) {
          AsyncData(:final value) => _InsightCard(
            icon: Icons.emoji_objects_outlined,
            title: textOf(value, [
              'headline',
              'title',
              'message',
            ], fallback: l10n.insightsTipFallback),
            detail: optionalTextOf(value, ['detail', 'content', 'message']),
          ),
          AsyncError(:final error) => FeatureError(error: error),
          _ => const LoadingList(),
        },
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.insightsPersonalAnalysisTitle,
          style: AppTypography.display(18),
        ),
        const SizedBox(height: AppSpacing.sm),
        switch (insight) {
          AsyncData(:final value) => _InsightBody(value, unit: unit),
          AsyncError(:final error) => FeatureError(error: error),
          _ => const LoadingList(),
        },
      ],
    );
  }
}

List<(String key, String label, IconData icon)> _sections(
  AppLocalizations l10n,
) => [
  (
    'trainingAdherence',
    l10n.insightsSectionTrainingAdherence,
    Icons.event_available_outlined,
  ),
  (
    'bodyMetrics',
    l10n.insightsSectionBodyMetrics,
    Icons.monitor_weight_outlined,
  ),
  (
    'volumeStrength',
    l10n.insightsSectionVolumeStrength,
    Icons.fitness_center_outlined,
  ),
  ('muscleBalance', l10n.insightsSectionMuscleBalance, Icons.balance_outlined),
  ('effortGap', l10n.insightsSectionEffortGap, Icons.speed_outlined),
];

class _InsightBody extends StatelessWidget {
  const _InsightBody(this.value, {required this.unit});

  final JsonMap value;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final content = value['content'];
    if (content is! JsonMap) {
      return _InsightCard(
        icon: Icons.auto_awesome_outlined,
        title: textOf(value, [
          'headline',
          'message',
        ], fallback: l10n.insightsAnalysisReadyFallback),
        detail: value.toString(),
      );
    }
    final recommendation = content['recommendation'];
    final planReview = content['planReview'];
    final metrics = value['metrics'];
    final generatedAt = value['generatedAt'] is String
        ? DateTime.tryParse(value['generatedAt'] as String)?.toLocal()
        : null;
    final cached = value['cached'] == true;

    return Column(
      children: [
        XnSectionList(
          children: [
            for (final (key, label, icon) in _sections(l10n))
              if (content[key] is JsonMap)
                _InsightCard(
                  icon: icon,
                  label: label,
                  title: textOf(content[key] as JsonMap, ['headline']),
                  detail: optionalTextOf(content[key] as JsonMap, ['detail']),
                ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (recommendation is JsonMap) ...[
          _RecommendationCard(
            title: textOf(recommendation, ['headline']),
            actions:
                (recommendation['actions'] as List<dynamic>?)
                    ?.whereType<String>()
                    .toList() ??
                const [],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (planReview is JsonMap)
          _PlanReviewCard(
            title: textOf(planReview, ['headline']),
            mistakes:
                (planReview['mistakes'] as List<dynamic>?)
                    ?.whereType<String>()
                    .toList() ??
                const [],
            suggestions:
                (planReview['suggestions'] as List<dynamic>?)
                    ?.whereType<String>()
                    .toList() ??
                const [],
          ),
        if (generatedAt != null) ...[
          const SizedBox(height: AppSpacing.md),
          _GeneratedAtRow(generatedAt: generatedAt, cached: cached),
        ],
        if (metrics is JsonMap) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.insightsTrainingSnapshotTitle,
            style: AppTypography.display(18),
          ),
          const SizedBox(height: AppSpacing.sm),
          _MetricsSection(metrics: metrics, unit: unit),
        ],
      ],
    );
  }
}

/// Renders a full, untruncated AI response — headline plus the complete
/// detail text, split into sentence bullets since the analysis can run to
/// several paragraphs and reads easier scannable than one solid block.
class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.icon,
    required this.title,
    this.label,
    this.detail,
  });

  final IconData icon;
  final String? label;
  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, size: 18, color: AppColors.clay900),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (label != null)
                      Text(label!.toUpperCase(), style: _eyebrow),
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (detail != null && detail!.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            BulletList(items: splitIntoSentences(detail)),
          ],
        ],
      ),
    );
  }
}

/// Numbered next-step checklist, matching the "what to do next" ordering the
/// AI response implies (actions are sequential, not independent checkboxes).
class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.title, required this.actions});

  final String title;
  final List<String> actions;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      color: AppColors.bg3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.checklist_rounded, color: AppColors.accent),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (actions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < actions.length; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${i + 1}',
                      style: AppTypography.mono(
                        12,
                        weight: FontWeight.w500,
                        color: AppColors.fgOnClay,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      actions[i],
                      style: const TextStyle(
                        color: AppColors.fg2,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              if (i != actions.length - 1)
                const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ],
      ),
    );
  }
}

/// Plan-level errors the AI flagged vs. the coach's fix suggestions.
class _PlanReviewCard extends StatelessWidget {
  const _PlanReviewCard({
    required this.title,
    required this.mistakes,
    required this.suggestions,
  });

  final String title;
  final List<String> mistakes;
  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      color: AppColors.warningBg,
      border: Border.all(color: AppColors.warning.withValues(alpha: 0.22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (mistakes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(l10n.insightsWhatWentWrongLabel, style: _eyebrow),
            const SizedBox(height: AppSpacing.sm),
            for (final item in mistakes)
              _BulletLine(
                icon: Icons.error_outline_rounded,
                color: AppColors.danger,
                text: item,
              ),
          ],
          if (suggestions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(l10n.insightsCoachSuggestionsLabel, style: _eyebrow),
            const SizedBox(height: AppSpacing.sm),
            for (final item in suggestions)
              _BulletLine(
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.success,
                text: item,
              ),
          ],
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.fg2, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _GeneratedAtRow extends StatelessWidget {
  const _GeneratedAtRow({required this.generatedAt, required this.cached});

  final DateTime generatedAt;
  final bool cached;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.insightsLastAnalyzedAtLabel, style: _eyebrow),
              const SizedBox(height: 2),
              Text(
                _fmtDateTime(generatedAt),
                style: AppTypography.mono(13, color: AppColors.fg2),
              ),
            ],
          ),
        ),
        if (cached)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.bg3,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.surfaceBorderSoft),
            ),
            child: Text(
              l10n.insightsFromCacheLabel,
              style: const TextStyle(
                color: AppColors.fg3,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

/// The quantitative half of the response: plan/volume/bodyweight stats,
/// weight trend, a week-over-week comparison, muscle balance, effort-gap
/// hits/misses, and recent PRs.
class _MetricsSection extends StatelessWidget {
  const _MetricsSection({required this.metrics, required this.unit});

  final JsonMap metrics;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final adherence = metrics['adherence'];
    final bodyweight = metrics['bodyweight'];
    final volume = metrics['volume'];
    final muscleBalance = metrics['muscleBalance'];
    final effortGap = metrics['effortGap'];
    final recentPrs = metrics['recentPrs'];

    final planCompletionPercent = adherence is JsonMap
        ? (adherence['planCompletionPercent'] as num?)?.toInt()
        : null;
    final recentTotalVolume = volume is JsonMap
        ? (volume['recentTotalVolume'] as num?)?.toDouble()
        : null;
    final recentSetCount = volume is JsonMap
        ? (volume['recentSetCount'] as num?)?.toInt()
        : null;
    final latestWeight = bodyweight is JsonMap
        ? (bodyweight['latestWeight'] as num?)?.toDouble()
        : null;
    final weightDelta = bodyweight is JsonMap
        ? (bodyweight['delta'] as num?)?.toDouble()
        : null;
    final weightTrend = bodyweight is JsonMap
        ? bodyweight['trend'] as String?
        : null;

    return Column(
      children: [
        _StatsGrid(
          planCompletionPercent: planCompletionPercent,
          recentTotalVolume: recentTotalVolume,
          recentSetCount: recentSetCount,
          latestWeight: latestWeight,
          weightDelta: weightDelta,
          weightTrend: weightTrend,
          unit: unit,
        ),
        if (bodyweight is JsonMap && bodyweight['points'] is List) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.insightsWeightTrendTitle, style: AppTypography.display(16)),
          const SizedBox(height: AppSpacing.sm),
          _WeightTrendCard(
            points: (bodyweight['points'] as List)
                .whereType<JsonMap>()
                .toList(),
            unit: unit,
          ),
        ],
        if (adherence is JsonMap &&
            adherence['currentWeek'] is JsonMap &&
            adherence['previousWeek'] is JsonMap) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.insightsWeekComparisonTitle,
            style: AppTypography.display(16),
          ),
          const SizedBox(height: AppSpacing.sm),
          _WeekComparisonCard(
            currentWeek: adherence['currentWeek'] as JsonMap,
            previousWeek: adherence['previousWeek'] as JsonMap,
            unit: unit,
          ),
        ],
        if (muscleBalance is List && muscleBalance.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.insightsMuscleBalanceTitle,
            style: AppTypography.display(16),
          ),
          const SizedBox(height: AppSpacing.sm),
          _MuscleBalanceCard(
            points: muscleBalance.whereType<JsonMap>().toList(),
            unit: unit,
          ),
        ],
        if (effortGap is JsonMap) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.insightsEffortGapTitle, style: AppTypography.display(16)),
          const SizedBox(height: AppSpacing.sm),
          _EffortGapCard(
            highRpeMisses:
                (effortGap['highRpeMisses'] as List<dynamic>?)
                    ?.whereType<JsonMap>()
                    .toList() ??
                const [],
            lowRpeWins:
                (effortGap['lowRpeWins'] as List<dynamic>?)
                    ?.whereType<JsonMap>()
                    .toList() ??
                const [],
          ),
        ],
        if (recentPrs is List && recentPrs.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.insightsRecentPrsTitle, style: AppTypography.display(16)),
          const SizedBox(height: AppSpacing.sm),
          _RecentPrsGrid(
            items: recentPrs.whereType<JsonMap>().toList(),
            unit: unit,
          ),
        ],
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({
    required this.unit,
    this.planCompletionPercent,
    this.recentTotalVolume,
    this.recentSetCount,
    this.latestWeight,
    this.weightDelta,
    this.weightTrend,
  });

  final int? planCompletionPercent;
  final double? recentTotalVolume;
  final int? recentSetCount;
  final double? latestWeight;
  final double? weightDelta;
  final String? weightTrend;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tiles = <(String, String)>[
      if (planCompletionPercent != null)
        (l10n.insightsPlanCompletionLabel, '$planCompletionPercent%'),
      if (recentTotalVolume != null)
        (
          l10n.insightsRecentVolumeLabel,
          '${_thousands(unit.fromKg(recentTotalVolume!).round())} ${unit.suffix}',
        ),
      if (recentSetCount != null)
        (l10n.insightsSetsCompletedLabel, '$recentSetCount'),
      if (latestWeight != null)
        (
          l10n.insightsBodyweightLabel,
          weightDelta == null || weightDelta == 0
              ? '${formatWeight(unit.fromKg(latestWeight!))} ${unit.suffix}'
              : '${formatWeight(unit.fromKg(latestWeight!))} ${unit.suffix} '
                    '(${weightTrend == 'Down' ? '-' : '+'}'
                    '${formatWeight(unit.fromKg(weightDelta!.abs()))})',
        ),
    ];
    if (tiles.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.md;
        final width = (constraints.maxWidth - spacing) / 2;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final (label, value) in tiles)
              SizedBox(
                width: width,
                child: _StatTile(label: label, value: value),
              ),
          ],
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
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
            style: AppTypography.display(20, letterSpacing: 0),
          ),
        ],
      ),
    );
  }
}

class _WeightTrendCard extends StatelessWidget {
  const _WeightTrendCard({required this.points, required this.unit});

  final List<JsonMap> points;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final logs = [
      for (final p in points)
        if (p['date'] is String && p['weight'] is num)
          BodyweightLog(
            id: '',
            date: DateTime.parse(p['date'] as String),
            weight: (p['weight'] as num).toDouble(),
          ),
    ];
    if (logs.isEmpty) {
      final l10n = AppLocalizations.of(context);
      return XnSectionGroup(
        children: [
          SizedBox(
            height: 80,
            child: Center(
              child: Text(
                l10n.insightsNoBodyweightDataMessage,
                style: const TextStyle(color: AppColors.fg3),
              ),
            ),
          ),
        ],
      );
    }
    return XnSectionGroup(
      children: [BodyweightChart(logs: logs, unit: unit)],
    );
  }
}

class _WeekComparisonCard extends StatelessWidget {
  const _WeekComparisonCard({
    required this.currentWeek,
    required this.previousWeek,
    required this.unit,
  });

  final JsonMap currentWeek;
  final JsonMap previousWeek;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentVolume = (currentWeek['volume'] as num?)?.toDouble() ?? 0;
    final previousVolume = (previousWeek['volume'] as num?)?.toDouble() ?? 0;
    final maxVolume = [
      currentVolume,
      previousVolume,
      1.0,
    ].reduce((a, b) => a > b ? a : b);

    return XnSectionGroup(
      children: [
        _WeekBar(
          label: l10n.insightsPreviousWeekLabel,
          volume: previousVolume,
          ratio: previousVolume / maxVolume,
          color: AppColors.bg4,
          unit: unit,
        ),
        const SizedBox(height: AppSpacing.md),
        _WeekBar(
          label: l10n.insightsCurrentWeekLabel,
          volume: currentVolume,
          ratio: currentVolume / maxVolume,
          color: AppColors.accent,
          unit: unit,
        ),
      ],
    );
  }
}

class _WeekBar extends StatelessWidget {
  const _WeekBar({
    required this.label,
    required this.volume,
    required this.ratio,
    required this.color,
    required this.unit,
  });

  final String label;
  final double volume;
  final double ratio;
  final Color color;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              '${_thousands(unit.fromKg(volume).round())} ${unit.suffix}',
              style: AppTypography.mono(12, color: AppColors.fg3),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 10,
            backgroundColor: AppColors.bg3,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

class _MuscleBalanceCard extends StatelessWidget {
  const _MuscleBalanceCard({required this.points, required this.unit});

  final List<JsonMap> points;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final sorted = [...points]
      ..sort(
        (a, b) => ((b['sharePercent'] as num?) ?? 0).compareTo(
          (a['sharePercent'] as num?) ?? 0,
        ),
      );
    return XnSectionGroup(
      children: [
        for (var i = 0; i < sorted.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          _MuscleBalanceRow(point: sorted[i], unit: unit),
        ],
      ],
    );
  }
}

class _MuscleBalanceRow extends StatelessWidget {
  const _MuscleBalanceRow({required this.point, required this.unit});

  final JsonMap point;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final muscle = textOf(point, ['muscle'], fallback: '-');
    final sets = (point['sets'] as num?)?.toInt() ?? 0;
    final volume = (point['volume'] as num?)?.toDouble() ?? 0;
    final sharePercent = (point['sharePercent'] as num?)?.toInt() ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                muscle,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              l10n.insightsMuscleBalanceStats(
                sets,
                sharePercent,
                _thousands(unit.fromKg(volume).round()),
                unit.suffix,
              ),
              style: AppTypography.mono(11, color: AppColors.fg3),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: (sharePercent / 100).clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: AppColors.bg3,
            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
          ),
        ),
      ],
    );
  }
}

class _EffortGapCard extends StatelessWidget {
  const _EffortGapCard({
    required this.highRpeMisses,
    required this.lowRpeWins,
  });

  final List<JsonMap> highRpeMisses;
  final List<JsonMap> lowRpeWins;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _EffortGapColumn(
            label: l10n.insightsHighRpeMissesLabel,
            color: AppColors.danger,
            icon: Icons.trending_down_rounded,
            items: highRpeMisses,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _EffortGapColumn(
            label: l10n.insightsLowRpeWinsLabel,
            color: AppColors.success,
            icon: Icons.trending_up_rounded,
            items: lowRpeWins,
          ),
        ),
      ],
    );
  }
}

class _EffortGapColumn extends StatelessWidget {
  const _EffortGapColumn({
    required this.label,
    required this.color,
    required this.icon,
    required this.items,
  });

  final String label;
  final Color color;
  final IconData icon;
  final List<JsonMap> items;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (items.isEmpty)
            const Text('—', style: TextStyle(color: AppColors.fg3))
          else
            for (final item in items) ...[
              Row(
                children: [
                  Icon(icon, size: 14, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      textOf(item, ['exercise'], fallback: '-'),
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 2,
                  bottom: AppSpacing.sm,
                ),
                child: Text(
                  l10n.insightsEffortGapStats(
                    (item['sets'] as num?)?.toInt() ?? 0,
                    ((item['averageRpe'] as num?)?.toDouble() ?? 0)
                        .toStringAsFixed(1),
                  ),
                  style: AppTypography.mono(11, color: AppColors.fg3),
                ),
              ),
            ],
        ],
      ),
    );
  }
}

class _RecentPrsGrid extends StatelessWidget {
  const _RecentPrsGrid({required this.items, required this.unit});

  final List<JsonMap> items;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.sm;
        final width = (constraints.maxWidth - spacing) / 2;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: _PrTile(item: item, unit: unit),
              ),
          ],
        );
      },
    );
  }
}

class _PrTile extends StatelessWidget {
  const _PrTile({required this.item, required this.unit});

  final JsonMap item;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final weight = (item['weight'] as num?)?.toDouble();
    final reps = (item['reps'] as num?)?.toInt();
    final achievedAt = item['achievedAt'] is String
        ? DateTime.tryParse(item['achievedAt'] as String)?.toLocal()
        : null;

    return XnCard(
      color: AppColors.bg3,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textOf(item, ['exercise'], fallback: '-'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            weight == null
                ? '-'
                : '${formatWeight(unit.fromKg(weight))} ${unit.suffix}'
                      '${reps == null ? '' : ' × $reps'}',
            style: AppTypography.display(18, letterSpacing: 0),
          ),
          if (achievedAt != null) ...[
            const SizedBox(height: 2),
            Text(
              _fmtDate(achievedAt),
              style: AppTypography.mono(11, color: AppColors.fg3),
            ),
          ],
        ],
      ),
    );
  }
}

const _eyebrow = TextStyle(
  color: AppColors.fg3,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.7,
);

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _fmtDate(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

String _fmtDateTime(DateTime d) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '${_fmtDate(d)}, ${two(d.hour)}:${two(d.minute)}';
}

String _thousands(int v) {
  final s = v.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}
