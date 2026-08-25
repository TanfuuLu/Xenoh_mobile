import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/utils/current_date_provider.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/pro_locked_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../shared_api/api_widgets.dart';
import '../../data/repositories/nutrition_repository_provider.dart';
import '../../domain/entities/nutrition_summary.dart';
import '../../domain/nutrition_insight.dart';

typedef NutritionInsightArgs = ({String? clientId, DateTime from, DateTime to});

class NutritionInsightData {
  const NutritionInsightData({required this.summary, required this.history});

  final NutritionSummary summary;
  final List<NutritionDailyLog> history;
}

final nutritionInsightDataProvider = FutureProvider.autoDispose
    .family<NutritionInsightData, NutritionInsightArgs>((ref, args) async {
      final repository = ref.watch(nutritionRepositoryProvider);
      final summary = args.clientId == null
          ? await repository.getSummary()
          : await repository.getClientSummary(args.clientId!);
      if (!summary.canUseAdvancedAnalysis) {
        return NutritionInsightData(summary: summary, history: const []);
      }
      final history = args.clientId == null
          ? await repository.getHistory(from: args.from, to: args.to)
          : await repository.getClientHistory(
              args.clientId!,
              from: args.from,
              to: args.to,
            );
      return NutritionInsightData(summary: summary, history: history);
    });

class NutritionInsightScreen extends ConsumerWidget {
  const NutritionInsightScreen({this.clientId, super.key});

  static const contentKey = ValueKey('nutrition-insight-content');

  final String? clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(currentDateProvider);
    final args = (
      clientId: clientId,
      from: now.subtract(const Duration(days: 13)),
      to: now,
    );
    final value = ref.watch(nutritionInsightDataProvider(args));
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nutritionInsightTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async =>
            ref.invalidate(nutritionInsightDataProvider(args)),
        child: switch (value) {
          AsyncData(:final value) when !value.summary.canUseAdvancedAnalysis =>
            ListView(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  child: ProLockedView(
                    title: l10n.nutritionInsightLockedTitle,
                    message: l10n.nutritionInsightLockedMessage,
                    onUpgrade: clientId == null
                        ? () => context.push('/subscription')
                        : null,
                  ),
                ),
              ],
            ),
          AsyncData(:final value) => _InsightContent(data: value),
          AsyncError(:final error) => ListView(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.7,
                child: ErrorView.from(
                  error,
                  context,
                  onRetry: () => ref.invalidate(
                    nutritionInsightDataProvider(args),
                  ),
                ),
              ),
            ],
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _InsightContent extends StatelessWidget {
  const _InsightContent({required this.data});

  final NutritionInsightData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final insight = buildNutritionInsight(
      summary: data.summary,
      history: data.history,
    );
    return ListView(
      key: NutritionInsightScreen.contentKey,
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        FeatureHeader(
          title: l10n.nutritionInsightTitle,
          subtitle: l10n.nutritionInsightSubtitle,
          icon: Icons.auto_awesome_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            l10n.nutritionInsightLast14Days,
            style: const TextStyle(color: AppColors.fg3, fontSize: 12),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (!insight.hasMeaningfulData) ...[
          XnCard(
            child: Text(
              l10n.nutritionInsightInsufficientMessage,
              style: const TextStyle(color: AppColors.fg2, height: 1.45),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        _SignalGrid(insight: insight),
        const SizedBox(height: AppSpacing.md),
        _ActionsCard(insight: insight),
        const SizedBox(height: AppSpacing.md),
        _AverageMacrosCard(insight: insight),
        const SizedBox(height: AppSpacing.md),
        _StrategiesCard(insight: insight),
      ],
    );
  }
}

class _SignalGrid extends ConsumerWidget {
  const _SignalGrid({required this.insight});

  final NutritionInsight insight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unit = ref.watch(weightUnitProvider);
    final signals = [
      (
        l10n.nutritionInsightWeightGap,
        insight.weightGapKg == null
            ? l10n.nutritionInsightMissing
            : '${insight.weightGapKg! > 0 ? '+' : ''}'
                  '${formatWeight(unit.fromKg(insight.weightGapKg!))} '
                  '${unit.suffix}',
      ),
      (
        l10n.nutritionInsightCalorieConsistency,
        insight.calorieDelta == null
            ? l10n.nutritionInsightMissing
            : '${insight.calorieDelta! > 0 ? '+' : ''}${insight.calorieDelta} kcal',
      ),
      (
        l10n.nutritionInsightMacroBalance,
        insight.macroBalancePercent == null
            ? l10n.nutritionInsightMissing
            : '${insight.macroBalancePercent}%',
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth >= 700
            ? (constraints.maxWidth - AppSpacing.md * 2) / 3
            : constraints.maxWidth;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final signal in signals)
              SizedBox(
                width: width,
                child: XnCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        signal.$1,
                        style: const TextStyle(color: AppColors.fg3),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        signal.$2,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ActionsCard extends StatelessWidget {
  const _ActionsCard({required this.insight});

  final NutritionInsight insight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final actions = [
      _calorieAction(insight.calorieAction, l10n),
      if (insight.proteinAction == NutritionProteinAction.prioritizeProtein)
        (l10n.nutritionInsightProteinTitle, l10n.nutritionInsightProteinBody)
      else
        (l10n.nutritionInsightTimingTitle, l10n.nutritionInsightTimingBody),
      if (insight.weightGapKg == null)
        (
          l10n.nutritionInsightTargetWeightTitle,
          l10n.nutritionInsightTargetWeightBody,
        )
      else
        (
          l10n.nutritionInsightWeightDirectionTitle,
          l10n.nutritionInsightWeightDirectionBody,
        ),
    ];
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.nutritionInsightNextMove,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          for (var index = 0; index < actions.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 15, child: Text('${index + 1}')),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          actions[index].$1,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          actions[index].$2,
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
            ),
        ],
      ),
    );
  }
}

class _AverageMacrosCard extends StatelessWidget {
  const _AverageMacrosCard({required this.insight});

  final NutritionInsight insight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.nutritionInsightAverageMacros,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xl,
            runSpacing: AppSpacing.md,
            children: [
              _macro(l10n.coachProteinLabel, insight.averageProteinG),
              _macro(l10n.coachCarbsLabel, insight.averageCarbsG),
              _macro(l10n.coachFatLabel, insight.averageFatG),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macro(String label, double value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: AppColors.fg3, fontSize: 12)),
      Text(
        '${value.round()} g',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ],
  );
}

class _StrategiesCard extends StatelessWidget {
  const _StrategiesCard({required this.insight});

  final NutritionInsight insight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.nutritionInsightStrategies,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final strategy in insight.strategies)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: strategy.recommended
                    ? AppColors.successBg
                    : AppColors.bg3,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${strategy.proteinPercent}% P · ${strategy.carbsPercent}% C · ${strategy.fatPercent}% F\n'
                      '${strategy.proteinG ?? '—'}g · ${strategy.carbsG ?? '—'}g · ${strategy.fatG ?? '—'}g',
                    ),
                  ),
                  if (strategy.recommended)
                    Text(
                      l10n.nutritionInsightRecommended,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
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

(String, String) _calorieAction(
  NutritionCalorieAction action,
  AppLocalizations l10n,
) => switch (action) {
  NutritionCalorieAction.hold => (
    l10n.nutritionInsightCaloriesHoldTitle,
    l10n.nutritionInsightCaloriesHoldBody,
  ),
  NutritionCalorieAction.reduce => (
    l10n.nutritionInsightCaloriesReduceTitle,
    l10n.nutritionInsightCaloriesReduceBody,
  ),
  NutritionCalorieAction.add => (
    l10n.nutritionInsightCaloriesAddTitle,
    l10n.nutritionInsightCaloriesAddBody,
  ),
  NutritionCalorieAction.setTarget => (
    l10n.nutritionInsightCaloriesSetTitle,
    l10n.nutritionInsightCaloriesSetBody,
  ),
};
