import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../blocks_reports/presentation/widgets/moderation_dialogs.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../domain/entities/community_models.dart';
import 'share_action_dialogs.dart';

class CommunityAvatar extends StatelessWidget {
  const CommunityAvatar({
    required this.name,
    this.imageUrl,
    this.size = 44,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(name);
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.accentSoft,
      backgroundImage: imageUrl == null || imageUrl!.isEmpty
          ? null
          : NetworkImage(imageUrl!),
      child: imageUrl == null || imageUrl!.isEmpty
          ? Text(
              initials,
              style: TextStyle(
                color: AppColors.clay900,
                fontWeight: FontWeight.w500,
                fontSize: size >= 64 ? 22 : 14,
              ),
            )
          : null,
    );
  }
}

class CommunityUserCard extends StatelessWidget {
  const CommunityUserCard({
    required this.user,
    required this.onTap,
    this.trailing,
    super.key,
  });

  final CommunityUserSummary user;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      onTap: onTap,
      child: Row(
        children: [
          CommunityAvatar(name: user.fullName, imageUrl: user.avatarUrl),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  user.bio?.isNotEmpty == true
                      ? user.bio!
                      : user.email ?? l10n.communityXenohAthleteFallback,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class FriendActionButton extends StatelessWidget {
  const FriendActionButton({
    required this.user,
    required this.pending,
    required this.onSend,
    required this.onAccept,
    required this.onReject,
    required this.onRemove,
    super.key,
  });

  final CommunityUserSummary user;
  final bool pending;
  final VoidCallback onSend;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (user.friendStatus) {
      // Unfriending is destructive and one tap away from a button that
      // otherwise just reads as a status, so it always confirms first.
      FriendStatus.accepted => XnButton(
        label: l10n.communityFriendsTitle,
        icon: Icons.check_rounded,
        variant: XnButtonVariant.secondary,
        loading: pending,
        onPressed: () => unawaited(_confirmRemove(context)),
      ),
      FriendStatus.pending
          when user.requestDirection == RequestDirection.incoming =>
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: l10n.communityAcceptButton,
              onPressed: pending ? null : onAccept,
              icon: const Icon(Icons.check_rounded),
            ),
            IconButton(
              tooltip: l10n.communityRejectTooltip,
              onPressed: pending ? null : onReject,
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
      FriendStatus.pending => XnChip(
        label: l10n.communityPendingLabel,
        tone: XnChipTone.warn,
        icon: Icons.schedule_rounded,
      ),
      _ => XnButton(
        label: l10n.communityAddButton,
        icon: Icons.person_add_alt_1_rounded,
        variant: XnButtonVariant.secondary,
        loading: pending,
        onPressed: onSend,
      ),
    };
  }

  Future<void> _confirmRemove(BuildContext context) async {
    if (await confirmRemoveFriend(context, user.fullName)) onRemove();
  }
}

/// Asks before dropping a friendship. Shared so every entry point — profile,
/// user cards, the friends list — warns with the same wording.
Future<bool> confirmRemoveFriend(BuildContext context, String name) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.communityRemoveFriendTitle),
      content: Text(l10n.communityRemoveFriendMessage(name)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.commonCancel),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.communityRemoveFriendAction),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

class TrainingDayShareCard extends ConsumerWidget {
  const TrainingDayShareCard({
    required this.share,
    required this.onUserTap,
    required this.onLoveToggle,
    this.canDelete = false,
    this.onDelete,
    this.pending = false,
    super.key,
  });

  final TrainingDayShare share;
  final VoidCallback onUserTap;
  final VoidCallback onLoveToggle;
  final bool canDelete;
  final VoidCallback? onDelete;
  final bool pending;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unit = ref.watch(weightUnitProvider);
    final prs = share.exercises.where((e) => e.isPersonalRecord).toList();
    final trainedExercises =
        share.exercises
            .where((exercise) => !exercise.isSkipped)
            .toList(growable: false)
          ..sort((left, right) => left.sortOrder.compareTo(right.sortOrder));

    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                onTap: onUserTap,
                child: CommunityAvatar(
                  name: share.userFullName,
                  imageUrl: share.userAvatarUrl,
                  size: 50,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: InkWell(
                  onTap: onUserTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Text(
                            share.userFullName,
                            style: const TextStyle(
                              color: AppColors.fg1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (share.hasPersonalRecord)
                            XnChip(
                              label: l10n.communityPrChipLabel,
                              tone: XnChipTone.warn,
                              icon: Icons.emoji_events_rounded,
                              compact: true,
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${DateFormat('dd MMM yyyy').format(share.workoutDate)} - ${share.dayOfWeek}',
                        style: const TextStyle(
                          color: AppColors.fg3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              XnChip(label: share.dayStatus, compact: true),
              if (!canDelete)
                PopupMenuButton<String>(
                  tooltip: l10n.communityShareActionsTooltip,
                  onSelected: (action) async {
                    switch (action) {
                      case 'report':
                        await showReportShareDialog(context, ref, share.id);
                      case 'copy':
                        await showCopyWorkoutSheet(context, ref, share.id);
                      case 'report_user':
                        await showReportUserDialog(
                          context,
                          ref,
                          userId: share.userId,
                          userName: share.userFullName,
                        );
                      case 'block_user':
                        await showBlockUserDialog(
                          context,
                          ref,
                          userId: share.userId,
                          userName: share.userFullName,
                        );
                    }
                  },
                  itemBuilder: (_) => [
                    if (share.isReusable)
                      PopupMenuItem(
                        value: 'copy',
                        child: ListTile(
                          leading: const Icon(Icons.copy_all_outlined),
                          title: Text(l10n.communityCopyWorkoutAction),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    PopupMenuItem(
                      value: 'report',
                      child: ListTile(
                        leading: const Icon(Icons.flag_outlined),
                        title: Text(l10n.communityReportSubmit),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    PopupMenuItem(
                      value: 'report_user',
                      child: ListTile(
                        leading: const Icon(Icons.person_off_outlined),
                        title: Text(l10n.moderationReportUserAction),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    PopupMenuItem(
                      value: 'block_user',
                      child: ListTile(
                        leading: const Icon(
                          Icons.block_outlined,
                          color: AppColors.danger,
                        ),
                        title: Text(
                          l10n.moderationBlockUserAction,
                          style: const TextStyle(color: AppColors.danger),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (share.caption?.isNotEmpty == true) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              share.caption!,
              style: const TextStyle(color: AppColors.fg1, height: 1.35),
            ),
          ],
          if (prs.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.warningBg,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.paperAlt),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      prs.map((e) => e.name).join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (trainedExercises.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            _TrainedExerciseList(exercises: trainedExercises),
          ],
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _Metric(
                icon: Icons.fitness_center_rounded,
                label: l10n.communityExercisesMetricLabel,
                value: '${share.exerciseCount}',
              ),
              _Metric(
                icon: Icons.monitor_weight_outlined,
                label: l10n.communityVolumeMetricLabel,
                value:
                    '${formatWeight(unit.fromKg(share.totalVolume))} ${unit.suffix}',
              ),
              _Metric(
                icon: Icons.timer_outlined,
                label: l10n.communityDurationMetricLabel,
                value: _duration(share.totalDurationSeconds),
              ),
              _Metric(
                icon: Icons.speed_rounded,
                label: l10n.communityAvgRpeMetricLabel,
                value: share.averageRpe?.toStringAsFixed(1) ?? '-',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              if (!canDelete)
                TextButton.icon(
                  onPressed: pending ? null : onLoveToggle,
                  icon: Icon(
                    share.lovedByCurrentUser
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: share.lovedByCurrentUser
                        ? AppColors.danger
                        : AppColors.fg2,
                  ),
                  label: Text(
                    share.lovedByCurrentUser
                        ? l10n.communityLovedLabel
                        : l10n.communityLoveLabel,
                  ),
                ),
              if (canDelete)
                TextButton.icon(
                  onPressed: pending ? null : onDelete,
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: Text(l10n.commonDelete),
                ),
              const Spacer(),
              Text(
                l10n.communityLoveCount(share.loveCount),
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrainedExerciseList extends StatelessWidget {
  const _TrainedExerciseList({required this.exercises});

  final List<TrainingDayShareExercise> exercises;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnSectionEyebrow(l10n.communityExercisesMetricLabel),
        const SizedBox(height: AppSpacing.sm),
        XnSectionGroup(
          padding: EdgeInsets.zero,
          children: [
            for (var index = 0; index < exercises.length; index++) ...[
              if (index > 0) const _RowDivider(),
              _TrainedExerciseRow(
                exercise: exercises[index],
                displayOrder: index + 1,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _TrainedExerciseRow extends StatelessWidget {
  const _TrainedExerciseRow({
    required this.exercise,
    required this.displayOrder,
  });

  final TrainingDayShareExercise exercise;
  final int displayOrder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final completedSets = exercise.sets.where((set) => set.isCompleted).length;

    final plannedSets = exercise.sets.length;
    final isComplete = plannedSets > 0 && completedSets == plannedSets;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: 13,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$displayOrder',
              style: AppTypography.mono(12, color: AppColors.fg4),
            ),
          ),
          Expanded(
            child: Text(
              exercise.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.fg1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Colour carries the completion state, so a finished exercise reads
          // differently from a partial one at a glance.
          XnChip(
            compact: true,
            tone: isComplete ? XnChipTone.sage : XnChipTone.neutral,
            icon: isComplete ? Icons.check_rounded : null,
            label: '$completedSets/$plannedSets ${l10n.trainingSetsLabel}',
          ),
        ],
      ),
    );
  }
}

/// Hairline between rows inside a panel, inset past the leading numeral.
class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: AppSpacing.lg),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.surfaceBorderSoft,
      ),
    );
  }
}

/// One headline number on [ProfileMetricPanel].
class ProfileMetric {
  const ProfileMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

/// Profile stats as a single panel of hairline-divided cells. Sized by its
/// content — the grid this replaced used a fixed aspect ratio, which left most
/// of every card empty.
class ProfileMetricPanel extends StatelessWidget {
  const ProfileMetricPanel({required this.metrics, super.key});

  final List<ProfileMetric> metrics;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var index = 0; index < metrics.length; index += 2) {
      if (index > 0) {
        rows.add(
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.surfaceBorderSoft,
          ),
        );
      }
      final right = index + 1 < metrics.length ? metrics[index + 1] : null;
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _MetricCell(metric: metrics[index])),
              Container(width: 1, color: AppColors.surfaceBorderSoft),
              Expanded(
                child: right == null
                    ? const SizedBox.shrink()
                    : _MetricCell(metric: right),
              ),
            ],
          ),
        ),
      );
    }

    return XnSectionGroup(padding: EdgeInsets.zero, children: rows);
  }
}

class _MetricCell extends StatelessWidget {
  const _MetricCell({required this.metric});

  final ProfileMetric metric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(metric.icon, size: 14, color: AppColors.fg4),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  metric.label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            metric.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.display(
              21,
              weight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 136,
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: AppColors.bg3,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, size: 17, color: AppColors.fg2),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 11),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
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

String _duration(int seconds) {
  if (seconds <= 0) return '0m';
  final minutes = (seconds / 60).round();
  if (minutes < 60) return '${minutes}m';
  final hours = minutes ~/ 60;
  final remaining = minutes % 60;
  return remaining == 0 ? '${hours}h' : '${hours}h ${remaining}m';
}

String _initials(String value) {
  final parts = value
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'X';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}
