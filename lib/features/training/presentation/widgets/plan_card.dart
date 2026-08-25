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
    required this.onReview,
    required this.onActivate,
    required this.onDelete,
    this.manageAsCoach = false,
    super.key,
  });

  final Plan plan;
  final VoidCallback onTap;
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
    final borderColor = plan.isActive
        ? AppColors.success.withValues(alpha: 0.28)
        : AppColors.surfaceBorderSoft;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: plan.isActive
                ? AppColors.success.withValues(alpha: 0.08)
                : AppColors.shadow,
            blurRadius: plan.isActive ? 20 : 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: AppColors.bg2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: BorderSide(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
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
                              19,
                              weight: FontWeight.w600,
                              letterSpacing: -0.2,
                              height: 1.18,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
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
                const SizedBox(height: AppSpacing.xxl),
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
                const SizedBox(height: AppSpacing.xl),
                Container(height: 1, color: AppColors.surfaceBorderSoft),
                const SizedBox(height: AppSpacing.lg),
                _PlanActions(
                  isActive: plan.isActive,
                  activateLabel: l10n.commonActivate,
                  deactivateLabel: l10n.commonDeactivate,
                  reviewTooltip: l10n.trainingReviewPlanTooltip,
                  deleteTooltip: l10n.trainingDeletePlanTooltip,
                  onActivate: onActivate,
                  onReview: onReview,
                  onDelete: onDelete,
                ),
              ],
            ),
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
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(AppRadius.lg),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).commonProgress,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.25,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  percent,
                  style: AppTypography.mono(
                    22,
                    weight: FontWeight.w600,
                    color: AppColors.fg1,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  progressLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: AppTypography.mono(
                    10.5,
                    weight: FontWeight.w500,
                    color: AppColors.fg3,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _ProgressBar(value: value, color: color),
      ],
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
        minHeight: 7,
        backgroundColor: AppColors.bg3.withValues(alpha: 0.9),
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
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: foregroundColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    final tooltip = this.tooltip;
    return tooltip == null ? pill : Tooltip(message: tooltip, child: pill);
  }
}

class _PlanActions extends StatelessWidget {
  const _PlanActions({
    required this.isActive,
    required this.activateLabel,
    required this.deactivateLabel,
    required this.reviewTooltip,
    required this.deleteTooltip,
    required this.onActivate,
    required this.onReview,
    required this.onDelete,
  });

  final bool isActive;
  final String activateLabel;
  final String deactivateLabel;
  final String reviewTooltip;
  final String deleteTooltip;
  final VoidCallback onActivate;
  final VoidCallback onReview;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final activation = _PlanActivationButton(
      isActive: isActive,
      activateLabel: activateLabel,
      deactivateLabel: deactivateLabel,
      onPressed: onActivate,
    );
    final toolbar = _PlanActionToolbar(
      reviewTooltip: reviewTooltip,
      deleteTooltip: deleteTooltip,
      reviewIcon: Icons.auto_fix_high_outlined,
      onReview: onReview,
      onDelete: onDelete,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 340) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              activation,
              const SizedBox(height: AppSpacing.sm),
              toolbar,
            ],
          );
        }
        return Row(
          children: [
            Expanded(child: activation),
            const SizedBox(width: AppSpacing.md),
            toolbar,
          ],
        );
      },
    );
  }
}

class _PlanActionToolbar extends StatelessWidget {
  const _PlanActionToolbar({
    required this.reviewTooltip,
    required this.deleteTooltip,
    required this.reviewIcon,
    required this.onReview,
    required this.onDelete,
  });

  final String reviewTooltip;
  final String deleteTooltip;
  final IconData reviewIcon;
  final VoidCallback onReview;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _PlanIconButton(
          tooltip: reviewTooltip,
          icon: reviewIcon,
          onPressed: onReview,
        ),
        const SizedBox(width: AppSpacing.sm),
        _PlanIconButton(
          tooltip: deleteTooltip,
          icon: Icons.delete_outline_rounded,
          color: AppColors.danger,
          onPressed: onDelete,
        ),
      ],
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
    final background = isActive ? AppColors.successBg : AppColors.buttonPrimary;
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
      iconSize: 19,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints.tightFor(width: 42, height: 42),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        backgroundColor: color == AppColors.danger
            ? AppColors.dangerBg.withValues(alpha: 0.45)
            : AppColors.buttonBg,
        side: BorderSide(
          color: color == AppColors.danger
              ? AppColors.danger.withValues(alpha: 0.15)
              : AppColors.surfaceBorderSoft,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
