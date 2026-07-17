import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/plan.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    required this.plan,
    required this.onTap,
    required this.onAnalytics,
    required this.onReview,
    required this.onActivate,
    required this.onDelete,
    this.manageAsCoach = false,
    super.key,
  });

  final Plan plan;
  final VoidCallback onTap;
  final VoidCallback onAnalytics;
  final VoidCallback onReview;
  final VoidCallback onActivate;
  final VoidCallback onDelete;

  /// A coach managing a client plan can activate it. A client only sees the
  /// plan's coach origin instead of an activation control.
  final bool manageAsCoach;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final showCoachBadge = plan.planType == 'Coach' && !manageAsCoach;
    final statusLabel = showCoachBadge
        ? l10n.trainingCoachBadge
        : plan.isActive
        ? l10n.trainingPlanActive
        : l10n.trainingPlanInactive;
    final statusColor = showCoachBadge
        ? AppColors.warningBg
        : plan.isActive
        ? AppColors.successBg
        : AppColors.bg3;
    final statusTextColor = showCoachBadge
        ? AppColors.warning
        : plan.isActive
        ? AppColors.success
        : AppColors.fg2;
    final accent = showCoachBadge
        ? AppColors.warning
        : plan.isActive
        ? AppColors.success
        : AppColors.border1;
    final progress = plan.totalDays == 0
        ? 0.0
        : (plan.completedDays / plan.totalDays).clamp(0.0, 1.0);
    final progressColor = plan.isActive ? AppColors.success : AppColors.accent;
    final surface = plan.isActive
        ? AppColors.successBg.withValues(alpha: 0.32)
        : AppColors.bg2;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: plan.isActive
                  ? AppColors.success.withValues(alpha: 0.24)
                  : AppColors.surfaceBorderSoft,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PlanIdentityMark(
                    icon: showCoachBadge
                        ? Icons.workspace_premium_outlined
                        : Icons.calendar_month_rounded,
                    color: accent,
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.display(
                            20,
                            weight: FontWeight.w500,
                            letterSpacing: 0,
                            height: 1.08,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            const Icon(
                              Icons.event_outlined,
                              size: 14,
                              color: AppColors.fg3,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                '${DateOnly.format(plan.startDate)} - '
                                '${DateOnly.format(plan.endDate)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.fg2,
                                  fontSize: 12.5,
                                  height: 1.2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _StatusPill(
                    label: statusLabel,
                    backgroundColor: statusColor,
                    foregroundColor: statusTextColor,
                    tooltip: showCoachBadge
                        ? l10n.trainingCoachPlanTooltip
                        : plan.isActive
                        ? l10n.trainingDeactivatePlanTooltip
                        : l10n.trainingActivatePlanTooltip,
                    onTap: showCoachBadge ? null : onActivate,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              _PlanProgressBand(
                value: progress,
                color: progressColor,
                progressLabel: l10n.trainingPlanCardProgress(
                  plan.completedWeeks,
                  plan.totalWeeks,
                  plan.completedDays,
                  plan.totalDays,
                ),
                percent: '${plan.progressPercent}%',
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _PlanActivationButton(
                      isActive: plan.isActive,
                      activateLabel: l10n.commonActivate,
                      deactivateLabel: l10n.commonDeactivate,
                      onPressed: onActivate,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  _PlanActionToolbar(
                    analyticsTooltip: l10n.commonAnalytics,
                    reviewTooltip: l10n.trainingReviewPlanTooltip,
                    deleteTooltip: l10n.trainingDeletePlanTooltip,
                    reviewIcon: Icons.auto_fix_high_outlined,
                    onAnalytics: onAnalytics,
                    onReview: onReview,
                    onDelete: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanIdentityMark extends StatelessWidget {
  const _PlanIdentityMark({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}

class _PlanProgressBand extends StatelessWidget {
  const _PlanProgressBand({
    required this.value,
    required this.color,
    required this.progressLabel,
    required this.percent,
  });

  final double value;
  final Color color;
  final String progressLabel;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg2.withValues(alpha: 0.64),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context).commonProgress,
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                percent,
                style: AppTypography.mono(
                  13,
                  weight: FontWeight.w500,
                  color: AppColors.fg1,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _ProgressBar(value: value, color: color),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              progressLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.mono(
                10.5,
                weight: FontWeight.w500,
                color: AppColors.fg3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 5,
        backgroundColor: AppColors.bg3,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.tooltip,
    this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final String? tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final pill = Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          child: Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ),
    );
    final tooltip = this.tooltip;
    return tooltip == null ? pill : Tooltip(message: tooltip, child: pill);
  }
}

class _PlanActionToolbar extends StatelessWidget {
  const _PlanActionToolbar({
    required this.analyticsTooltip,
    required this.reviewTooltip,
    required this.deleteTooltip,
    required this.reviewIcon,
    required this.onAnalytics,
    required this.onReview,
    required this.onDelete,
  });

  final String analyticsTooltip;
  final String reviewTooltip;
  final String deleteTooltip;
  final IconData reviewIcon;
  final VoidCallback onAnalytics;
  final VoidCallback onReview;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.buttonBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PlanIconButton(
            tooltip: analyticsTooltip,
            icon: Icons.bar_chart_rounded,
            onPressed: onAnalytics,
          ),
          const _ToolbarDivider(),
          _PlanIconButton(
            tooltip: reviewTooltip,
            icon: reviewIcon,
            onPressed: onReview,
          ),
          const _ToolbarDivider(),
          _PlanIconButton(
            tooltip: deleteTooltip,
            icon: Icons.delete_outline_rounded,
            color: AppColors.danger,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _PlanActivationButton extends StatelessWidget {
  const _PlanActivationButton({
    required this.isActive,
    required this.activateLabel,
    required this.deactivateLabel,
    required this.onPressed,
  });

  final bool isActive;
  final String activateLabel;
  final String deactivateLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final background = isActive ? AppColors.successBg : AppColors.accent;
    final foreground = isActive ? AppColors.success : AppColors.fgOnClay;
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(
        isActive
            ? Icons.pause_circle_outline_rounded
            : Icons.play_arrow_rounded,
        size: 20,
      ),
      label: Text(isActive ? deactivateLabel : activateLabel),
      style: FilledButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        side: BorderSide(color: foreground.withValues(alpha: 0.18)),
        elevation: 0,
        minimumSize: const Size.fromHeight(44),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class _ToolbarDivider extends StatelessWidget {
  const _ToolbarDivider();

  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 28,
    color: AppColors.surfaceBorderSoft,
  );
}

class _PlanIconButton extends StatelessWidget {
  const _PlanIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.color = AppColors.fg1,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
      iconSize: 21,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints.tightFor(width: 46, height: 44),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
