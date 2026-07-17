import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../domain/entities/community_models.dart';
import '../providers/community_controllers.dart';
import '../widgets/community_widgets.dart';

class CommunityProfileScreen extends ConsumerWidget {
  const CommunityProfileScreen({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unit = ref.watch(weightUnitProvider);
    final profile = ref.watch(communityProfileProvider(userId));
    final actionPending = ref.watch(friendActionControllerProvider).isLoading;
    final sharePending = ref.watch(shareActionControllerProvider).isLoading;
    final currentUserId = ref
        .watch(authControllerProvider)
        .sessionOrNull
        ?.user
        .id;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.communityAthleteTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          ref
            ..invalidate(communityProfileProvider(userId))
            ..invalidate(userTrainingDaySharesProvider);
        },
        child: AsyncValueView(
          value: profile,
          onRetry: () => ref.invalidate(communityProfileProvider(userId)),
          data: (data) {
            final shares = ref.watch(
              userTrainingDaySharesProvider(
                userId,
                enabled: data.canViewStats,
              ),
            );

            return ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                96,
              ),
              children: [
                XnCard(
                  color: AppColors.bg3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommunityAvatar(
                            name: data.fullName,
                            imageUrl: data.avatarUrl,
                            size: 72,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.fullName,
                                  style: AppTypography.display(
                                    26,
                                    letterSpacing: 0,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  data.bio?.isNotEmpty == true
                                      ? data.bio!
                                      : l10n.communityXenohAthleteFallback,
                                  style: const TextStyle(color: AppColors.fg2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          XnChip(
                            label:
                                data.trainingDiscipline ??
                                l10n.communityTrainingChipFallback,
                            icon: Icons.fitness_center_rounded,
                          ),
                          XnChip(
                            label: l10n.communityLevelChipLabel(
                              '${data.level}',
                            ),
                            tone: XnChipTone.sage,
                          ),
                          if (data.friendStatus == FriendStatus.accepted)
                            XnChip(
                              label: l10n.communityFriendChipLabel,
                              tone: XnChipTone.sage,
                              icon: Icons.check_rounded,
                            ),
                        ],
                      ),
                      if (data.id != currentUserId) ...[
                        const SizedBox(height: AppSpacing.md),
                        FriendActionButton(
                          user: data.summary,
                          pending: actionPending,
                          onSend: () => unawaited(
                            ref
                                .read(friendActionControllerProvider.notifier)
                                .send(data.id),
                          ),
                          onAccept: () => unawaited(
                            _acceptFriendRequest(ref, data.friendshipId),
                          ),
                          onReject: () => unawaited(
                            _rejectFriendRequest(ref, data.friendshipId),
                          ),
                          onRemove: () => unawaited(
                            ref
                                .read(friendActionControllerProvider.notifier)
                                .remove(data.id),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (data.canViewStats) ...[
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.sm,
                    mainAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 1.55,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ProfileMetricCard(
                        icon: Icons.local_fire_department_outlined,
                        label: l10n.communityStreakLabel,
                        value: data.currentStreak == null
                            ? '-'
                            : l10n.communityStreakDaysValue(
                                data.currentStreak!,
                              ),
                      ),
                      ProfileMetricCard(
                        icon: Icons.monitor_weight_outlined,
                        label: l10n.communityBodyweightLabel,
                        value: data.latestBodyweight == null
                            ? '-'
                            : '${formatWeight(unit.fromKg(data.latestBodyweight!))} ${unit.suffix}',
                      ),
                      ProfileMetricCard(
                        icon: Icons.speed_outlined,
                        label: l10n.communityDotsLabel,
                        value: data.dotsScore?.toStringAsFixed(1) ?? '-',
                      ),
                      ProfileMetricCard(
                        icon: Icons.timer_outlined,
                        label: l10n.communityTimeTrainedLabel,
                        value: _duration(data.totalTrainingDurationSeconds),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _Big3Card(profile: data, unit: unit),
                ] else
                  XnCard(
                    child: Text(
                      l10n.communityAddFriendHintMessage,
                      style: const TextStyle(color: AppColors.fg2),
                    ),
                  ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  l10n.communitySharedTrainingDaysTitle,
                  style: AppTypography.display(22, letterSpacing: 0),
                ),
                const SizedBox(height: AppSpacing.md),
                if (!data.canViewStats)
                  const SizedBox.shrink()
                else
                  AsyncValueView(
                    value: shares,
                    onRetry: () => ref.invalidate(
                      userTrainingDaySharesProvider(
                        userId,
                        enabled: data.canViewStats,
                      ),
                    ),
                    data: (items) {
                      if (items.isEmpty) {
                        return XnCard(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.xl,
                            ),
                            child: Text(
                              l10n.communityNoSharedDaysMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.fg2),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          for (final share in items) ...[
                            TrainingDayShareCard(
                              share: share,
                              pending: sharePending,
                              canDelete: share.userId == currentUserId,
                              onUserTap: () => unawaited(
                                context.push(
                                  '/community/users/${share.userId}',
                                ),
                              ),
                              onLoveToggle: () => unawaited(
                                ref
                                    .read(
                                      shareActionControllerProvider.notifier,
                                    )
                                    .toggleLove(share),
                              ),
                              onDelete: () => unawaited(
                                ref
                                    .read(
                                      shareActionControllerProvider.notifier,
                                    )
                                    .deleteShare(share.id),
                              ),
                            ),
                            if (share != items.last)
                              const SizedBox(height: AppSpacing.md),
                          ],
                        ],
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<void> _acceptFriendRequest(WidgetRef ref, String? requestId) async {
  if (requestId == null) return;
  await ref.read(friendActionControllerProvider.notifier).accept(requestId);
}

Future<void> _rejectFriendRequest(WidgetRef ref, String? requestId) async {
  if (requestId == null) return;
  await ref.read(friendActionControllerProvider.notifier).reject(requestId);
}

class _Big3Card extends StatelessWidget {
  const _Big3Card({required this.profile, required this.unit});

  final CommunityUserProfile profile;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.communityBig3Title,
                style: AppTypography.display(22, letterSpacing: 0),
              ),
              const Spacer(),
              XnChip(
                label: profile.big3Total == null
                    ? '-'
                    : '${formatWeight(unit.fromKg(profile.big3Total!))} ${unit.suffix}',
                tone: XnChipTone.warn,
                icon: Icons.emoji_events_rounded,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _LiftLine(
            label: l10n.powerliftingLiftSquat,
            value: profile.big3Prs.squat,
            unit: unit,
          ),
          _LiftLine(
            label: l10n.powerliftingLiftBench,
            value: profile.big3Prs.bench,
            unit: unit,
          ),
          _LiftLine(
            label: l10n.powerliftingLiftDeadlift,
            value: profile.big3Prs.deadlift,
            unit: unit,
          ),
        ],
      ),
    );
  }
}

class _LiftLine extends StatelessWidget {
  const _LiftLine({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final double? value;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.fg2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value == null
                ? '-'
                : '${formatWeight(unit.fromKg(value!))} ${unit.suffix}',
            style: const TextStyle(
              color: AppColors.fg1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

String _duration(int seconds) {
  if (seconds <= 0) return '0m';
  final minutes = (seconds / 60).round();
  if (minutes < 60) return '${minutes}m';
  final hours = minutes ~/ 60;
  final remaining = minutes % 60;
  return remaining == 0 ? '${hours}h' : '${hours}h ${remaining}m';
}
