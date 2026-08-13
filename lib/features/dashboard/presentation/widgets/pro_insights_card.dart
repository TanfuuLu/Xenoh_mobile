import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/personal_dashboard.dart';
import '../utils/dashboard_localization.dart';

/// Pro insights: a list of AI insight items when unlocked, or an upsell teaser.
class ProInsightsCard extends StatelessWidget {
  const ProInsightsCard({required this.insights, super.key});

  final ProInsights insights;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!insights.isUnlocked) {
      return XnSection(
        child: Row(
          children: [
            const Icon(Icons.auto_awesome_rounded, color: AppColors.accent),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dashboardUnlockAiInsightsTitle,
                    style: AppTypography.display(16, letterSpacing: 0),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    insights.ctaLabel ?? l10n.dashboardUnlockAiInsightsMessage,
                    style: const TextStyle(color: AppColors.fg2, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.fg3),
          ],
        ),
      );
    }

    if (insights.items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.accent,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              l10n.dashboardInsightsTitle,
              style: AppTypography.display(16, letterSpacing: 0),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          children: [
            for (final item in insights.items) _InsightRow(item: item),
          ],
        ),
      ],
    );
  }
}

class _InsightRow extends StatelessWidget {
  const _InsightRow({required this.item});

  final ProInsightItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localized = localizeDashboardInsight(
      item,
      l10n,
      Localizations.localeOf(context).languageCode,
    );
    final tone = switch (item.severity.toLowerCase()) {
      'warning' || 'warn' => XnChipTone.warn,
      'danger' || 'critical' || 'high' => XnChipTone.danger,
      'success' || 'positive' => XnChipTone.sage,
      _ => XnChipTone.info,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                localized.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.fg1,
                ),
              ),
            ),
            XnChip(label: _severityLabel(item.severity, l10n), tone: tone),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          localized.message,
          style: const TextStyle(color: AppColors.fg2, fontSize: 13),
        ),
      ],
    );
  }
}

String _severityLabel(String value, AppLocalizations l10n) =>
    switch (value.toLowerCase()) {
      'warning' || 'warn' => l10n.commonSeverityWarning,
      'danger' || 'critical' || 'high' => l10n.commonSeverityCritical,
      'success' || 'positive' => l10n.commonSeveritySuccess,
      'info' => l10n.commonSeverityInfo,
      _ => value,
    };
