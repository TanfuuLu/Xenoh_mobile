import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';

class CyclePhaseCard extends StatelessWidget {
  const CyclePhaseCard({
    required this.phase,
    required this.subtitle,
    required this.cycleDayLabel,
    required this.cycleDayValue,
    required this.untilPeriodLabel,
    required this.untilPeriodValue,
    required this.confidenceLabel,
    required this.confidenceValue,
    required this.logTodayLabel,
    required this.settingsTooltip,
    required this.onLogToday,
    required this.onSettings,
    this.lateLabel,
    this.needsData = false,
    super.key,
  });

  final String phase;
  final String subtitle;
  final String cycleDayLabel;
  final String cycleDayValue;
  final String untilPeriodLabel;
  final String untilPeriodValue;
  final String confidenceLabel;
  final String confidenceValue;
  final String logTodayLabel;
  final String settingsTooltip;
  final VoidCallback onLogToday;
  final VoidCallback onSettings;
  final String? lateLabel;
  final bool needsData;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      border: Border.all(color: AppColors.clay200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.clay100,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.water_drop_outlined,
                  size: 21,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    phase,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.display(
                      25,
                      weight: FontWeight.w600,
                      height: 1.15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton.outlined(
                tooltip: settingsTooltip,
                onPressed: onSettings,
                icon: const Icon(Icons.tune_rounded, size: 20),
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.fg2,
                  side: const BorderSide(color: AppColors.surfaceBorderSoft),
                  minimumSize: const Size(40, 40),
                  maximumSize: const Size(40, 40),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.event_outlined,
                size: 16,
                color: AppColors.fg3,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.fg3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _PhaseMetric(
                    label: cycleDayLabel,
                    value: cycleDayValue,
                  ),
                ),
                const _MetricDivider(),
                Expanded(
                  child: _PhaseMetric(
                    label: untilPeriodLabel,
                    value: untilPeriodValue,
                  ),
                ),
                const _MetricDivider(),
                Expanded(
                  child: _PhaseMetric(
                    label: confidenceLabel,
                    value: confidenceValue,
                    valueColor: needsData
                        ? AppColors.warning
                        : AppColors.sage700,
                  ),
                ),
              ],
            ),
          ),
          if (lateLabel != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.warningBg,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: 16,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      lateLabel!,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: XnButton(
              label: logTodayLabel,
              icon: Icons.add_rounded,
              onPressed: onLogToday,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseMetric extends StatelessWidget {
  const _PhaseMetric({
    required this.label,
    required this.value,
    this.valueColor = AppColors.fg1,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.fg3,
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.35,
              height: 1.25,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(
              14,
              weight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricDivider extends StatelessWidget {
  const _MetricDivider();

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      width: 1,
      thickness: 1,
      indent: AppSpacing.sm,
      endIndent: AppSpacing.sm,
      color: AppColors.surfaceBorderSoft,
    );
  }
}
