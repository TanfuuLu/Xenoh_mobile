import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/hero_card_background.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/personal_dashboard.dart';

/// High-signal greeting panel with streak + level/XP progress.
class DashboardHero extends StatelessWidget {
  const DashboardHero({
    required this.profile,
    this.backgroundImagePath,
    this.backgroundAlignment = Alignment.center,
    this.onOpenPlateCalculator,
    super.key,
  });

  final DashboardProfile profile;
  final String? backgroundImagePath;
  final Alignment backgroundAlignment;
  final VoidCallback? onOpenPlateCalculator;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final xpTotal = profile.totalXp + profile.xpToNextLevel;
    final xpProgress = xpTotal <= 0
        ? 0.0
        : (profile.totalXp / xpTotal).clamp(0.0, 1.0);

    final backgroundFile = backgroundImagePath == null
        ? null
        : File(backgroundImagePath!);
    final hasCustomBackground =
        backgroundFile != null && backgroundFile.existsSync();

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDeep,
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (hasCustomBackground)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(backgroundFile),
                    fit: BoxFit.cover,
                    alignment: backgroundAlignment,
                  ),
                ),
              ),
            )
          else
            const Positioned.fill(child: HeroCardBackground()),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: hasCustomBackground
                      ? [
                          AppColors.clay900.withValues(alpha: 0.76),
                          AppColors.clay900.withValues(alpha: 0.54),
                        ]
                      : [
                          Colors.transparent,
                          AppColors.clay900.withValues(alpha: 0.06),
                        ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _Avatar(profile: profile),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.dashboardTodayInTraining,
                            style: TextStyle(
                              color: AppColors.fgOnClay.withValues(alpha: 0.72),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            profile.firstName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.display(
                              34,
                              weight: FontWeight.w500,
                              color: AppColors.fgOnClay,
                              height: 1.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StreakBadge(streak: profile.currentStreak),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.fgOnClay.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: AppColors.fgOnClay.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${l10n.dashboardLevelPrefix} ',
                                  style: const TextStyle(
                                    color: AppColors.fgOnClay,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                XnAnimatedNumber(
                                  value: profile.level.toDouble(),
                                  formatter: formatAnimatedInt,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.fgOnClay,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    ' / ${profile.title}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.fgOnClay,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          XnAnimatedNumber(
                            value: profile.xpToNextLevel.toDouble(),
                            formatter: (value) =>
                                '${formatAnimatedThousands(value)} XP',
                            style: AppTypography.mono(
                              12,
                              color: AppColors.fgOnClay.withValues(alpha: 0.85),
                              weight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: XnAnimatedLinearProgress(
                          value: xpProgress,
                          minHeight: 9,
                          backgroundColor: AppColors.fgOnClay.withValues(
                            alpha: 0.16,
                          ),
                          color: AppColors.clay200,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onOpenPlateCalculator != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  _HeroActionButton(onPressed: onOpenPlateCalculator!),
                ],
              ],
            ),
          ),
        ],
      ),
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
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.fgOnClay.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.fgOnClay.withValues(alpha: 0.18)),
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
                color: AppColors.fgOnClay,
                fontWeight: FontWeight.w500,
                fontSize: 26,
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
      color: AppColors.fgOnClay.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: AppColors.fgOnClay.withValues(alpha: 0.16),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.fgOnClay.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.fgOnClay,
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
                        color: AppColors.fgOnClay,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.dashboardPlateCalculatorSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.fgOnClay.withValues(alpha: 0.74),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.fgOnClay.withValues(alpha: 0.8),
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
        color: AppColors.fgOnClay.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.fgOnClay.withValues(alpha: 0.18)),
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
              color: AppColors.fgOnClay,
            ),
          ),
        ],
      ),
    );
  }
}
