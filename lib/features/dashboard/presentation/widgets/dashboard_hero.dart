import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/personal_dashboard.dart';

/// High-signal greeting panel with streak + level/XP progress.
class DashboardHero extends StatelessWidget {
  const DashboardHero({
    required this.profile,
    this.onOpenPlateCalculator,
    super.key,
  });

  final DashboardProfile profile;
  final VoidCallback? onOpenPlateCalculator;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final xpTotal = profile.totalXp + profile.xpToNextLevel;
    final xpProgress = xpTotal <= 0
        ? 0.0
        : (profile.totalXp / xpTotal).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Avatar(profile: profile),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dashboardTodayInTraining,
                    style: const TextStyle(
                      color: AppColors.fg2,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    profile.firstName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.display(
                      28,
                      weight: FontWeight.w700,
                      color: AppColors.fg1,
                      height: 1.05,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _StreakBadge(streak: profile.currentStreak),
          ],
        ),
        if (onOpenPlateCalculator != null) ...[
          const SizedBox(height: AppSpacing.lg),
          _HeroActionButton(onPressed: onOpenPlateCalculator!),
        ],
        const SizedBox(height: AppSpacing.lg),
        XnCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${l10n.dashboardLevelPrefix} ',
                          style: const TextStyle(
                            color: AppColors.fg2,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        XnAnimatedNumber(
                          value: profile.level.toDouble(),
                          formatter: formatAnimatedInt,
                          style: AppTypography.mono(
                            13,
                            weight: FontWeight.w700,
                            color: AppColors.fg1,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '  ${profile.title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.fg1,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  XnAnimatedNumber(
                    value: profile.xpToNextLevel.toDouble(),
                    formatter: (value) =>
                        '${formatAnimatedThousands(value)} XP',
                    style: AppTypography.mono(
                      12,
                      color: AppColors.fg2,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: XnAnimatedLinearProgress(
                  value: xpProgress,
                  minHeight: 7,
                  backgroundColor: AppColors.bg3,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.profile});

  final DashboardProfile profile;

  @override
  Widget build(BuildContext context) {
    final url = profile.avatarUrl;
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
        image: (url != null && url.isNotEmpty)
            ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
            : null,
      ),
      child: (url == null || url.isEmpty)
          ? Text(
              profile.firstName.isEmpty
                  ? '?'
                  : profile.firstName.characters.first.toUpperCase(),
              style: const TextStyle(
                color: AppColors.fg1,
                fontWeight: FontWeight.w700,
                fontSize: 19,
              ),
            )
          : null,
    );
  }
}

class _HeroActionButton extends StatelessWidget {
  const _HeroActionButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: AppColors.surfaceBorderSoft,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.dashboardPlateCalculatorTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.dashboardPlateCalculatorSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.fg2,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.fg3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warningBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: Color(0xFFF6B26B),
            size: 20,
          ),
          const SizedBox(width: 4),
          XnAnimatedNumber(
            value: streak.toDouble(),
            formatter: formatAnimatedInt,
            style: AppTypography.mono(
              16,
              weight: FontWeight.w500,
              color: AppColors.fg1,
            ),
          ),
        ],
      ),
    );
  }
}
