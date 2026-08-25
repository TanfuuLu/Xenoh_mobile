import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../insights/domain/ai_response_models.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../shared_api/ai_widgets.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

/// `POST /plans/{id}/balance-check?lang=` (Pro, rate:ai) → `PlanBalanceReviewResponse`.
final planBalanceCheckProvider = FutureProvider.autoDispose
    .family<JsonMap, ({String planId, String lang})>((ref, args) {
      return ref
          .watch(xenohApiProvider)
          .postObject(
            '/plans/${args.planId}/balance-check?lang=${args.lang}',
            {},
          );
    });

/// `GET /plans/{id}/design-analysis` (Pro) → `PlanDesignAnalysisResponse`.
final planDesignAnalysisProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, planId) {
      final lang = ref.watch(appLocaleProvider)?.languageCode ?? 'en';
      return ref
          .watch(xenohApiProvider)
          .getObject(
            '/plans/$planId/design-analysis?lang=$lang',
          );
    });

final planProgressInsightProvider = FutureProvider.autoDispose
    .family<PlanProgressInsightResponse, ({String planId, String lang})>((
      ref,
      args,
    ) async {
      final json = await ref
          .watch(xenohApiProvider)
          .getObject(
            '/insights/plan/${args.planId}/progress?lang=${args.lang}',
          );
      return PlanProgressInsightResponse.fromJson(json);
    });

XnChipTone _severityTone(String severity) {
  switch (severity.toLowerCase()) {
    case 'critical':
    case 'high':
    case 'danger':
      return XnChipTone.danger;
    case 'warning':
    case 'medium':
    case 'moderate':
      return XnChipTone.warn;
    case 'good':
    case 'ok':
    case 'low':
    case 'info':
      return XnChipTone.sage;
    default:
      return XnChipTone.neutral;
  }
}

/// AI muscle-balance review for a plan.
class PlanBalanceCheckScreen extends ConsumerWidget {
  const PlanBalanceCheckScreen({required this.planId, super.key});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lang = ref.watch(appLocaleProvider)?.languageCode ?? 'en';
    final args = (planId: planId, lang: lang);
    final review = ref.watch(planBalanceCheckProvider(args));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.trainingBalanceCheckTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async => ref.invalidate(planBalanceCheckProvider(args)),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            FeatureHeader(
              title: l10n.trainingAiBalanceCheckTitle,
              subtitle: l10n.trainingAiBalanceCheckSubtitle,
              icon: Icons.balance_rounded,
            ),
            const SizedBox(height: AppSpacing.lg),
            switch (review) {
              AsyncData(:final value) => _BalanceBody(value),
              AsyncError(:final error) => AiErrorView(
                error: error,
                onRetry: () => ref.invalidate(planBalanceCheckProvider(args)),
              ),
              _ => _Thinking(l10n.trainingReviewingPlanMessage),
            },
          ],
        ),
      ),
    );
  }
}

class _BalanceBody extends StatelessWidget {
  const _BalanceBody(this.value);

  final JsonMap value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final severity = textOf(value, ['severity'], fallback: '');
    final warnings = _stringList(value['warnings']);
    final suggestions = _stringList(value['suggestions']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _BalanceVerdictCard(
          headline: textOf(
            value,
            ['headline'],
            fallback: l10n.trainingBalanceReviewFallback,
          ),
          summary: optionalTextOf(value, ['summary']),
          severity: severity,
        ),
        if (warnings.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _BalanceInsightCard(
            key: const ValueKey('balance-warnings'),
            title: l10n.commonWarnings,
            icon: Icons.warning_amber_rounded,
            color: AppColors.warning,
            backgroundColor: AppColors.warningBg,
            items: warnings,
          ),
        ],
        if (suggestions.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _BalanceInsightCard(
            key: const ValueKey('balance-suggestions'),
            title: l10n.commonSuggestions,
            icon: Icons.lightbulb_outline_rounded,
            color: AppColors.accent,
            backgroundColor: AppColors.accentSoft,
            items: suggestions,
          ),
        ],
        if (warnings.isEmpty && suggestions.isEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          EmptyFeatureState(
            title: l10n.trainingLookingBalancedTitle,
            message: l10n.trainingNoWarningsMessage,
            icon: Icons.check_circle_outline_rounded,
          ),
        ],
      ],
    );
  }
}

class _BalanceVerdictCard extends StatelessWidget {
  const _BalanceVerdictCard({
    required this.headline,
    required this.summary,
    required this.severity,
  });

  final String headline;
  final String? summary;
  final String severity;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('balance-verdict'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(
                  Icons.balance_rounded,
                  color: AppColors.accent,
                  size: 17,
                ),
              ),
              const Spacer(),
              if (severity.isNotEmpty)
                XnChip(
                  label: severity,
                  tone: _severityTone(severity),
                  compact: true,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            headline,
            style: AppTypography.display(
              20,
              weight: FontWeight.w700,
              letterSpacing: -0.15,
              height: 1.18,
            ),
          ),
          if (summary != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              summary!,
              style: const TextStyle(
                color: AppColors.fg2,
                fontSize: 13,
                height: 1.48,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BalanceInsightCard extends StatelessWidget {
  const _BalanceInsightCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.items,
    super.key,
  });

  final String title;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnCard(
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, color: color, size: 17),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.display(
                    16,
                    weight: FontWeight.w700,
                    color: AppColors.fg1,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Text(
                '${items.length}',
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          children: [
            for (var index = 0; index < items.length; index++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        color: AppColors.fg2,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

class PlanProgressInsightScreen extends ConsumerWidget {
  const PlanProgressInsightScreen({required this.planId, super.key});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lang = ref.watch(appLocaleProvider)?.languageCode ?? 'en';
    final args = (planId: planId, lang: lang);
    final insight = ref.watch(planProgressInsightProvider(args));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.trainingPlanProgressInsightTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async =>
            ref.invalidate(planProgressInsightProvider(args)),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            FeatureHeader(
              title: l10n.trainingPlanProgressInsightTitle,
              subtitle: l10n.trainingPlanProgressInsightSubtitle,
              icon: Icons.auto_graph_rounded,
            ),
            const SizedBox(height: AppSpacing.lg),
            switch (insight) {
              AsyncData(:final value) => _ProgressInsightBody(value: value),
              AsyncError(:final error) => AiErrorView(
                error: error,
                onRetry: () =>
                    ref.invalidate(planProgressInsightProvider(args)),
              ),
              _ => _Thinking(l10n.trainingAnalyzingProgressMessage),
            },
          ],
        ),
      ),
    );
  }
}

class _ProgressInsightBody extends StatelessWidget {
  const _ProgressInsightBody({required this.value});

  final PlanProgressInsightResponse value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCardStack(
      children: [
        XnSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  if (value.planName.isNotEmpty)
                    XnChip(label: value.planName, compact: true),
                  if (value.trajectory.isNotEmpty)
                    XnChip(
                      label: value.trajectory,
                      tone: _trajectoryTone(value.trajectory),
                      compact: true,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                value.headline,
                style: AppTypography.display(22, letterSpacing: 0),
              ),
              if (value.summary.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  value.summary,
                  style: const TextStyle(color: AppColors.fg2, height: 1.4),
                ),
              ],
            ],
          ),
        ),
        if (value.whatsWorking.isNotEmpty)
          _BulletCard(
            title: l10n.trainingWhatsWorkingTitle,
            icon: Icons.check_circle_outline_rounded,
            iconColor: AppColors.success,
            items: value.whatsWorking,
          ),
        if (value.focusAreas.isNotEmpty)
          _BulletCard(
            title: l10n.trainingFocusAreasTitle,
            icon: Icons.center_focus_strong_outlined,
            iconColor: AppColors.warning,
            items: value.focusAreas,
          ),
        if (value.nextBlock.isNotEmpty)
          _BulletCard(
            title: l10n.trainingNextBlockTitle,
            icon: Icons.arrow_forward_rounded,
            iconColor: AppColors.accent,
            items: value.nextBlock,
          ),
      ],
    );
  }
}

XnChipTone _trajectoryTone(String trajectory) {
  switch (trajectory.toLowerCase()) {
    case 'improving':
      return XnChipTone.sage;
    case 'declining':
      return XnChipTone.danger;
    case 'plateauing':
      return XnChipTone.warn;
    default:
      return XnChipTone.neutral;
  }
}

/// AI structural design analysis for a plan (non-AI Pro endpoint).
class PlanDesignAnalysisScreen extends ConsumerWidget {
  const PlanDesignAnalysisScreen({required this.planId, super.key});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final analysis = ref.watch(planDesignAnalysisProvider(planId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.trainingDesignAnalysisTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async =>
            ref.invalidate(planDesignAnalysisProvider(planId)),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _DesignHeroHeader(
              title: l10n.trainingPlanDesignAnalysisTitle,
              subtitle: l10n.trainingPlanDesignAnalysisSubtitle,
            ),
            const SizedBox(height: AppSpacing.lg),
            switch (analysis) {
              AsyncData(:final value) => _DesignBody(value),
              AsyncError(:final error) => AiErrorView(
                error: error,
                onRetry: () =>
                    ref.invalidate(planDesignAnalysisProvider(planId)),
              ),
              _ => _Thinking(l10n.trainingAnalyzingDesignMessage),
            },
          ],
        ),
      ),
    );
  }
}

class _DesignBody extends StatelessWidget {
  const _DesignBody(this.value);

  final JsonMap value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final structure = value['structure'];
    final workload = value['workload'];
    final muscleGroups = (value['muscleGroups'] as List<dynamic>? ?? const [])
        .whereType<JsonMap>()
        .toList();
    final recoveryRisks = (value['recoveryRisks'] as List<dynamic>? ?? const [])
        .whereType<JsonMap>()
        .toList();
    final movementPatterns =
        (value['movementPatterns'] as List<dynamic>? ?? const [])
            .whereType<JsonMap>()
            .toList();
    final variety = value['variety'];
    final balance = value['balance'];
    final dominant = balance is JsonMap
        ? _stringList(balance['dominantMuscleGroups'])
        : const <String>[];
    final undertrained = balance is JsonMap
        ? _stringList(balance['undertrainedMajorMuscleGroups'])
        : const <String>[];
    final totalWeeks = structure is JsonMap
        ? textOf(structure, ['totalWeeks'], fallback: '-')
        : '-';
    final trainingDays = structure is JsonMap
        ? textOf(structure, ['plannedTrainingDays'], fallback: '-')
        : '-';
    final avgDays = structure is JsonMap
        ? textOf(structure, ['avgTrainingDaysPerWeek'], fallback: '-')
        : '-';
    final plannedSets = workload is JsonMap
        ? textOf(workload, ['plannedSets'], fallback: '-')
        : '-';
    final tonnage = workload is JsonMap
        ? textOf(workload, ['plannedTonnage'], fallback: '-')
        : '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DesignSummaryCard(
          totalWeeks: totalWeeks,
          trainingDays: trainingDays,
          avgDays: avgDays,
          plannedSets: plannedSets,
          tonnage: tonnage,
          riskCount: recoveryRisks.length,
          dominantCount: dominant.length,
          undertrainedCount: undertrained.length,
        ),
        const SizedBox(height: AppSpacing.lg),
        if (structure is JsonMap) ...[
          _DesignMetricSection(
            title: l10n.trainingStructureLabel,
            icon: Icons.calendar_month_rounded,
            items: [
              _MetricData(
                l10n.trainingTotalWeeksLabel,
                textOf(structure, ['totalWeeks']),
              ),
              _MetricData(
                l10n.trainingTrainingDaysLabel,
                textOf(structure, ['plannedTrainingDays']),
              ),
              _MetricData(
                l10n.trainingRestDaysLabel,
                textOf(structure, ['plannedRestDays']),
              ),
              _MetricData(
                l10n.trainingAvgDaysPerWeekLabel,
                textOf(structure, ['avgTrainingDaysPerWeek']),
              ),
              _MetricData(
                l10n.trainingLongestTrainingStreakLabel,
                textOf(structure, ['longestTrainingStreak']),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (workload is JsonMap) ...[
          _DesignMetricSection(
            title: l10n.trainingWorkloadLabel,
            icon: Icons.fitness_center_rounded,
            items: [
              _MetricData(
                l10n.trainingExercisesLabel,
                textOf(workload, ['plannedExercises']),
              ),
              _MetricData(
                l10n.trainingSetsCountLabel,
                textOf(workload, ['plannedSets']),
              ),
              _MetricData(
                l10n.trainingRepVolumeLabel,
                textOf(workload, ['plannedRepVolume']),
              ),
              _MetricData(
                l10n.trainingTonnageLabel,
                textOf(workload, ['plannedTonnage']),
              ),
              _MetricData(
                l10n.trainingAvgExercisesPerDayLabel,
                textOf(workload, ['avgExercisesPerTrainingDay']),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (muscleGroups.isNotEmpty) ...[
          _MuscleCoverageCard(
            title: l10n.trainingMuscleCoverageLabel,
            muscleGroups: muscleGroups,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (balance is JsonMap) ...[
          _BalanceChips(balance),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (movementPatterns.isNotEmpty) ...[
          _MovementCoverageCard(patterns: movementPatterns),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (variety is JsonMap) ...[
          _VarietyCard(variety: variety),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (recoveryRisks.isNotEmpty) ...[
          _AnalysisInsightsPanel(
            title: l10n.trainingRecoveryRisksTitle,
            icon: Icons.health_and_safety_outlined,
            iconColor: AppColors.warning,
            items: [
              for (final r in recoveryRisks) _recoveryRiskText(r),
            ],
          ),
        ],
      ],
    );
  }
}

String _recoveryRiskText(JsonMap risk) {
  final message = textOf(risk, ['message', 'type']);
  final metric = optionalTextOf(risk, ['metric']);
  return metric == null ? message : '$message · $metric';
}

class _DesignHeroHeader extends StatelessWidget {
  const _DesignHeroHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.surfaceBorderSoft),
            ),
            child: const Icon(
              Icons.insights_outlined,
              color: AppColors.accent,
              size: 21,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.display(
                    24,
                    color: AppColors.fg1,
                    weight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalysisPanel extends StatelessWidget {
  const _AnalysisPanel({
    required this.child,
    this.color = AppColors.bg2,
    this.borderColor = AppColors.surfaceBorderSoft,
  });

  final Widget child;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: borderColor.withValues(alpha: 0.82)),
      ),
      child: child,
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({required this.title, required this.icon, this.color});

  final String title;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? AppColors.accent;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text(title, style: AppTypography.display(18))),
      ],
    );
  }
}

class _MetricData {
  const _MetricData(this.label, this.value);

  final String label;
  final String value;
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.items});

  final List<_MetricData> items;

  @override
  Widget build(BuildContext context) {
    return XnCardStack(
      children: [
        for (final item in items) _MetricCell(item: item),
      ],
    );
  }
}

class _MetricCell extends StatelessWidget {
  const _MetricCell({required this.item});

  final _MetricData item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.fg3,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              item.value,
              style: AppTypography.mono(21, weight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

class _DesignSummaryCard extends StatelessWidget {
  const _DesignSummaryCard({
    required this.totalWeeks,
    required this.trainingDays,
    required this.avgDays,
    required this.plannedSets,
    required this.tonnage,
    required this.riskCount,
    required this.dominantCount,
    required this.undertrainedCount,
  });

  final String totalWeeks;
  final String trainingDays;
  final String avgDays;
  final String plannedSets;
  final String tonnage;
  final int riskCount;
  final int dominantCount;
  final int undertrainedCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final riskTone = riskCount > 0 ? XnChipTone.warn : XnChipTone.sage;
    final balanceTone = undertrainedCount > 0
        ? XnChipTone.warn
        : XnChipTone.sage;

    return _AnalysisPanel(
      color: AppColors.bg3,
      borderColor: AppColors.border1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.insights_rounded,
                  color: AppColors.fgOnClay,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$totalWeeks weeks / $trainingDays training days',
                      style: AppTypography.display(20, height: 1.2),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '$avgDays days/wk / $plannedSets sets / $tonnage tonnage',
                      style: const TextStyle(
                        color: AppColors.fg2,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              XnChip(
                label: riskCount == 0
                    ? l10n.trainingDesignNoRecoveryRisksChip
                    : l10n.trainingDesignRisksChip(riskCount),
                tone: riskTone,
                compact: true,
              ),
              XnChip(
                label: undertrainedCount == 0
                    ? l10n.trainingDesignBalancedCoverageChip
                    : l10n.trainingDesignUndertrainedChip(undertrainedCount),
                tone: balanceTone,
                compact: true,
              ),
              if (dominantCount > 0)
                XnChip(
                  label: l10n.trainingDesignDominantChip(dominantCount),
                  tone: XnChipTone.accent,
                  compact: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DesignMetricSection extends StatelessWidget {
  const _DesignMetricSection({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<_MetricData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PanelHeader(title: title, icon: icon),
        const SizedBox(height: AppSpacing.md),
        _MetricGrid(items: items),
      ],
    );
  }
}

class _MuscleCoverageCard extends StatelessWidget {
  const _MuscleCoverageCard({
    required this.title,
    required this.muscleGroups,
  });

  final String title;
  final List<JsonMap> muscleGroups;

  @override
  Widget build(BuildContext context) {
    return _AnalysisPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelHeader(title: title, icon: Icons.donut_large_rounded),
          const SizedBox(height: AppSpacing.xl),
          for (final mg in muscleGroups)
            _MuscleRow(
              name: textOf(mg, ['muscleGroup']),
              percent: _toDouble(mg['percentOfTotal']),
              status: optionalTextOf(mg, ['status']),
            ),
        ],
      ),
    );
  }
}

class _BalanceChips extends StatelessWidget {
  const _BalanceChips(this.balance);

  final JsonMap balance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dominant = _stringList(balance['dominantMuscleGroups']);
    final under = _stringList(balance['undertrainedMajorMuscleGroups']);
    if (dominant.isEmpty && under.isEmpty) return const SizedBox.shrink();
    return _AnalysisPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelHeader(
            title: l10n.trainingBalanceCheckTitle,
            icon: Icons.balance_rounded,
          ),
          const SizedBox(height: AppSpacing.xl),
          if (dominant.isNotEmpty) ...[
            Text(
              l10n.trainingDominantLabel,
              style: const TextStyle(color: AppColors.fg3, fontSize: 12),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final m in dominant)
                  XnChip(label: m, tone: XnChipTone.accent, compact: true),
              ],
            ),
          ],
          if (under.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.trainingUndertrainedLabel,
              style: const TextStyle(color: AppColors.fg3, fontSize: 12),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final m in under)
                  XnChip(label: m, tone: XnChipTone.warn, compact: true),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _MuscleRow extends StatelessWidget {
  const _MuscleRow({required this.name, required this.percent, this.status});

  final String name;
  final double percent;
  final String? status;

  @override
  Widget build(BuildContext context) {
    final tone = _statusColor(status);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.fg1, fontSize: 13),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: (percent / 100).clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: AppColors.bg3.withValues(alpha: 0.72),
                valueColor: AlwaysStoppedAnimation(tone),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 40,
            child: Text(
              '${percent.toStringAsFixed(0)}%',
              textAlign: TextAlign.right,
              style: AppTypography.mono(12, color: AppColors.fg3),
            ),
          ),
        ],
      ),
    );
  }
}

Color _statusColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'dominant':
    case 'high':
    case 'overtrained':
      return AppColors.warning;
    case 'undertrained':
    case 'low':
      return AppColors.danger;
    case 'balanced':
    case 'good':
      return AppColors.success;
    default:
      return AppColors.accent;
  }
}

class _AnalysisInsightsPanel extends StatelessWidget {
  const _AnalysisInsightsPanel({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PanelHeader(title: title, icon: icon, color: iconColor),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          children: [
            for (final item in items)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: iconColor,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.fg2,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

class _MovementCoverageCard extends StatelessWidget {
  const _MovementCoverageCard({required this.patterns});

  final List<JsonMap> patterns;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PanelHeader(
          title: l10n.trainingMovementPatternsTitle,
          icon: Icons.route_outlined,
        ),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          children: [
            for (final pattern in patterns)
              Builder(
                builder: (context) {
                  final covered = pattern['isCovered'] == true;
                  return Row(
                    children: [
                      Icon(
                        covered
                            ? Icons.check_circle_rounded
                            : Icons.cancel_outlined,
                        size: 19,
                        color: covered ? AppColors.success : AppColors.danger,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          textOf(pattern, ['pattern']),
                          style: const TextStyle(
                            color: AppColors.fg1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        l10n.trainingPatternCoverageStats(
                          textOf(pattern, ['exerciseCount'], fallback: '0'),
                          textOf(pattern, ['plannedSets'], fallback: '0'),
                        ),
                        style: const TextStyle(
                          color: AppColors.fg3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _VarietyCard extends StatelessWidget {
  const _VarietyCard({required this.variety});

  final JsonMap variety;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repeated =
        (variety['topRepeatedExercises'] as List<dynamic>? ?? const [])
            .whereType<JsonMap>()
            .toList();
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelHeader(
            title: l10n.trainingExerciseVarietyTitle,
            icon: Icons.shuffle_rounded,
          ),
          const SizedBox(height: AppSpacing.md),
          _MetricGrid(
            items: [
              _MetricData(
                l10n.trainingUniqueExercisesLabel,
                textOf(variety, ['uniqueExercises'], fallback: '0'),
              ),
              _MetricData(
                l10n.trainingRepeatedExercisesLabel,
                textOf(variety, ['repeatedExerciseCount'], fallback: '0'),
              ),
            ],
          ),
          if (repeated.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            for (final exercise in repeated)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    const Icon(
                      Icons.replay_rounded,
                      size: 17,
                      color: AppColors.fg3,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        textOf(exercise, ['exerciseName']),
                        style: const TextStyle(color: AppColors.fg1),
                      ),
                    ),
                    XnChip(
                      label: '×${textOf(exercise, ['count'], fallback: '0')}',
                      compact: true,
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _BulletCard extends StatelessWidget {
  const _BulletCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: AppColors.fg3)),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.fg2,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Thinking extends StatelessWidget {
  const _Thinking(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        children: [
          const CircularProgressIndicator(color: AppColors.accent),
          const SizedBox(height: AppSpacing.md),
          Text(
            label,
            style: const TextStyle(color: AppColors.fg3),
          ),
        ],
      ),
    );
  }
}

List<String> _stringList(Object? value) => (value as List<dynamic>? ?? const [])
    .whereType<Object>()
    .map((e) => e.toString())
    .where((e) => e.trim().isNotEmpty)
    .toList();

double _toDouble(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse('$value') ?? 0;
}
