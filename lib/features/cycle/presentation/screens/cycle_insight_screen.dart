import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../profile/presentation/providers/profile_controller.dart';
import '../../domain/entities/cycle_models.dart';
import '../providers/cycle_controllers.dart';

class CycleInsightScreen extends ConsumerWidget {
  const CycleInsightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(myProfileControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cycleInsightTitle)),
      body: AsyncValueView(
        value: profile,
        onRetry: () => ref.invalidate(myProfileControllerProvider),
        data: (user) {
          if (user.gender != 'Female') {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  l10n.cycleInsightFemaleOnlyMessage,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final lang = ref.watch(appLocaleProvider)?.languageCode ?? 'en';
          final insight = ref.watch(cycleInsightProvider(lang: lang));
          return RefreshIndicator(
            color: AppColors.accent,
            onRefresh: () async => ref.invalidate(cycleInsightProvider),
            child: AsyncValueView(
              value: insight,
              onRetry: () => ref.invalidate(cycleInsightProvider),
              data: (data) => ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  96,
                ),
                children: [
                  XnCard(
                    color: AppColors.dangerBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.auto_awesome_rounded,
                              color: AppColors.danger,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.cycleAiInsightTitle,
                                style: AppTypography.display(26),
                              ),
                            ),
                            XnChip(
                              label: data.cached
                                  ? l10n.cycleCachedLabel
                                  : l10n.cycleFreshLabel,
                              tone: data.cached
                                  ? XnChipTone.info
                                  : XnChipTone.sage,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          data.content.summary,
                          style: const TextStyle(
                            color: AppColors.fg1,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  XnSectionList(
                    children: [
                      if (data.content.phaseRecommendations.isNotEmpty)
                        _RecommendationsCard(
                          recommendations: data.content.phaseRecommendations,
                        ),
                      if (data.content.cyclePatterns.isNotEmpty)
                        _ListCard(
                          title: l10n.cyclePatternsTitle,
                          icon: Icons.repeat_rounded,
                          items: data.content.cyclePatterns,
                        ),
                      if (data.content.symptomPatterns.isNotEmpty)
                        _ListCard(
                          title: l10n.cycleSymptomPatternsTitle,
                          icon: Icons.monitor_heart_outlined,
                          items: data.content.symptomPatterns,
                        ),
                      if (data.content.trainingCorrelations.isNotEmpty)
                        _ListCard(
                          title: l10n.cycleTrainingCorrelationsTitle,
                          icon: Icons.fitness_center_rounded,
                          items: data.content.trainingCorrelations,
                        ),
                      if (data.content.cautions.isNotEmpty)
                        _ListCard(
                          title: l10n.cycleCautionsTitle,
                          icon: Icons.warning_amber_rounded,
                          items: data.content.cautions,
                          tone: XnChipTone.warn,
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  XnCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            data.content.disclaimer,
                            style: const TextStyle(
                              color: AppColors.fg2,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  XnButton(
                    label: l10n.cycleRefreshInsightButton,
                    icon: Icons.refresh_rounded,
                    variant: XnButtonVariant.secondary,
                    onPressed: () => ref.invalidate(cycleInsightProvider),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RecommendationsCard extends StatelessWidget {
  const _RecommendationsCard({required this.recommendations});

  final List<CyclePhaseRecommendation> recommendations;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.cyclePhaseRecommendationsTitle,
            style: AppTypography.display(22),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final rec in recommendations) ...[
            XnChip(label: rec.phase),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.cycleTrainingRecommendationLabel(rec.training),
              style: const TextStyle(color: AppColors.fg1, height: 1.35),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.cycleNutritionRecommendationLabel(rec.nutrition),
              style: const TextStyle(color: AppColors.fg2, height: 1.35),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.title,
    required this.icon,
    required this.items,
    this.tone = XnChipTone.accent,
  });

  final String title;
  final IconData icon;
  final List<String> items;
  final XnChipTone tone;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnChip(label: title, icon: icon, tone: tone),
          const SizedBox(height: AppSpacing.md),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppColors.fg3)),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.fg1,
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
