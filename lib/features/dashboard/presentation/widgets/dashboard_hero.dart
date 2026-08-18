import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/synced_background_card.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_user_avatar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/personal_dashboard.dart';

/// High-signal greeting panel with streak + level/XP progress.
class DashboardHero extends StatelessWidget {
  const DashboardHero({
    required this.profile,
    this.backgroundImagePath,
    this.backgroundAlignment = Alignment.center,
    super.key,
  });

  final DashboardProfile profile;
  final String? backgroundImagePath;
  final Alignment backgroundAlignment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final xpTotal = profile.totalXp + profile.xpToNextLevel;
    final xpProgress = xpTotal <= 0
        ? 0.0
        : (profile.totalXp / xpTotal).clamp(0.0, 1.0);

    return SyncedBackgroundCard(
      backgroundImagePath: backgroundImagePath,
      backgroundAlignment: backgroundAlignment,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
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
                      style: TextStyle(
                        color: AppColors.fgOnClay.withValues(alpha: 0.76),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      profile.firstName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.display(
                        30,
                        weight: FontWeight.w800,
                        color: AppColors.fgOnClay,
                        letterSpacing: -0.4,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _StreakBadge(streak: profile.currentStreak),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.fgOnClay.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: AppColors.fgOnClay.withValues(alpha: 0.14),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${l10n.dashboardLevelPrefix} ${profile.level}  ${profile.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.fgOnClay,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    XnAnimatedNumber(
                      value: profile.xpToNextLevel.toDouble(),
                      formatter: (value) =>
                          '${formatAnimatedThousands(value)} XP',
                      style: AppTypography.mono(
                        12,
                        color: AppColors.fgOnClay.withValues(alpha: 0.84),
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
                    backgroundColor: AppColors.fgOnClay.withValues(alpha: 0.18),
                    color: AppColors.clay200,
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.profile});

  final DashboardProfile profile;

  @override
  Widget build(BuildContext context) {
    return XnUserAvatar(
      name: profile.firstName,
      imageUrl: profile.avatarUrl,
      size: 56,
      backgroundColor: AppColors.fgOnClay.withValues(alpha: 0.14),
      foregroundColor: AppColors.fgOnClay,
      borderColor: AppColors.fgOnClay.withValues(alpha: 0.18),
      borderRadius: AppRadius.lg,
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
        color: AppColors.fgOnClay.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.fgOnClay.withValues(alpha: 0.16),
        ),
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
