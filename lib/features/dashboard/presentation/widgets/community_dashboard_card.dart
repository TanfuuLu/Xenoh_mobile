import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';

class CommunityDashboardCard extends StatelessWidget {
  const CommunityDashboardCard({
    required this.incomingRequestCount,
    required this.onOpenCommunity,
    required this.onOpenFriends,
    required this.onOpenChallenges,
    super.key,
  });

  final int incomingRequestCount;
  final VoidCallback onOpenCommunity;
  final VoidCallback onOpenFriends;
  final VoidCallback onOpenChallenges;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnSection(
          onTap: onOpenCommunity,
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.bg3,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.communityTitle,
                      style: AppTypography.display(20, letterSpacing: 0),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.dashboardCommunitySubtitle,
                      style: const TextStyle(color: AppColors.fg2),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.fg3),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onOpenFriends,
                icon: Badge.count(
                  count: incomingRequestCount,
                  isLabelVisible: incomingRequestCount > 0,
                  child: const Icon(Icons.people_alt_outlined),
                ),
                label: Text(l10n.communityFriendsTitle),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onOpenChallenges,
                icon: const Icon(Icons.flag_outlined),
                label: Text(l10n.challengesTitle),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
