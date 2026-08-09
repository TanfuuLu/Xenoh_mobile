import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_button.dart';
import '../../../core/widgets/xn_section.dart';
import '../../../core/widgets/xn_user_avatar.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/providers/auth_controller.dart';
import '../../auth/presentation/providers/auth_state.dart';
import '../../shared_api/xenoh_api.dart';
import '../domain/challenge_models.dart';
import '../domain/challenge_repository.dart';
import 'challenge_providers.dart';

class ChallengeDetailScreen extends ConsumerWidget {
  const ChallengeDetailScreen({required this.challengeId, super.key});

  final String challengeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenge = ref.watch(challengeDetailProvider(challengeId));
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.challengeDetailTitle),
        actions: [
          if (challenge.value?.canManage == true)
            IconButton(
              tooltip: l10n.challengeEdit,
              onPressed: () => unawaited(
                context.push('/community/challenges/$challengeId/edit'),
              ),
              icon: const Icon(Icons.edit_outlined),
            ),
        ],
      ),
      body: AsyncValueView(
        value: challenge,
        onRetry: () => ref.invalidate(challengeDetailProvider(challengeId)),
        data: (item) => _ChallengeDetail(challenge: item),
      ),
    );
  }
}

class ChallengeStandings extends StatelessWidget {
  const ChallengeStandings({required this.members, super.key});

  final List<ChallengeMember> members;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accepted =
        members.where((member) => member.status == 'Accepted').toList()
          ..sort((a, b) => (a.rank ?? 1 << 30).compareTo(b.rank ?? 1 << 30));

    return Semantics(
      container: true,
      label: l10n.challengeStandings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: AppColors.dataAmber,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.challengeStandings,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          XnSectionList(
            children: [
              for (final member in accepted)
                XnSection(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 38,
                        child: Text(
                          member.rank == null ? '—' : '#${member.rank}',
                          style: TextStyle(
                            color: member.rank == null
                                ? AppColors.fg3
                                : AppColors.dataColor(member.rank! - 1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      XnUserAvatar(
                        name: member.fullName,
                        imageUrl: member.avatarUrl,
                        size: 38,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.isCreator
                                  ? '${member.fullName} · ${l10n.challengeCreator}'
                                  : member.fullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (!member.baselineReady)
                              Text(
                                l10n.challengeBaselineRequired,
                                style: const TextStyle(
                                  color: AppColors.warning,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        _challengeScore(member),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

String _challengeScore(ChallengeMember member) {
  final score = member.score;
  if (score == null) return '—';
  final value = score == score.roundToDouble()
      ? score.toInt().toString()
      : score.toStringAsFixed(1);
  return member.scoreUnit.isEmpty ? value : '$value ${member.scoreUnit}';
}

class _ChallengeDetail extends ConsumerWidget {
  const _ChallengeDetail({required this.challenge});

  final Challenge challenge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final userId = ref.watch(authControllerProvider).sessionOrNull?.user.id;
    final mine = challenge.members.where((member) => member.userId == userId);
    final membership = mine.isEmpty ? null : mine.first;
    final pending = ref.watch(challengeActionControllerProvider).isLoading;

    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () =>
          ref.refresh(challengeDetailProvider(challenge.id).future),
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          XnSectionGroup(
            children: [
              Text(
                challenge.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(challenge.description),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  Chip(label: Text(challenge.status)),
                  Chip(label: Text(challenge.metricType)),
                  Chip(label: Text(challenge.accessType)),
                ],
              ),
              Text(
                '${challenge.acceptedCount}/${challenge.capacity} · ${challenge.creatorName}',
                style: const TextStyle(color: AppColors.fg3),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              if (membership?.status == 'Invited') ...[
                XnButton(
                  label: l10n.challengeAccept,
                  loading: pending,
                  onPressed: () =>
                      _run(context, ref, (repo) => repo.accept(challenge.id)),
                ),
                XnButton(
                  label: l10n.challengeDecline,
                  variant: XnButtonVariant.secondary,
                  onPressed: pending
                      ? null
                      : () => _run(
                          context,
                          ref,
                          (repo) => repo.decline(challenge.id),
                        ),
                ),
              ] else if (challenge.canJoin)
                XnButton(
                  label: l10n.challengeJoin,
                  loading: pending,
                  onPressed: () =>
                      _run(context, ref, (repo) => repo.join(challenge.id)),
                ),
              if (membership?.status == 'Accepted' &&
                  !membership!.isCreator &&
                  challenge.status != 'Completed')
                XnButton(
                  label: l10n.challengeLeave,
                  variant: XnButtonVariant.secondary,
                  onPressed: pending
                      ? null
                      : () => _run(
                          context,
                          ref,
                          (repo) => repo.leave(challenge.id),
                        ),
                ),
              if (membership?.status == 'Accepted' &&
                  challenge.metricType == 'CustomCheckIns' &&
                  challenge.status == 'Active')
                XnButton(
                  label: membership!.checkedInToday
                      ? l10n.challengeUndoCheckIn
                      : l10n.challengeCheckIn,
                  onPressed: pending
                      ? null
                      : () => _run(
                          context,
                          ref,
                          (repo) => membership.checkedInToday
                              ? repo.undoCheckIn(challenge.id)
                              : repo.checkIn(challenge.id, null),
                        ),
                ),
              if (challenge.canManage) ...[
                XnButton(
                  label: l10n.challengeInvite,
                  variant: XnButtonVariant.secondary,
                  onPressed: pending ? null : () => _invite(context, ref),
                ),
                if (challenge.status == 'Upcoming' ||
                    challenge.status == 'Active')
                  XnButton(
                    label: l10n.challengeCancel,
                    variant: XnButtonVariant.danger,
                    onPressed: pending
                        ? null
                        : () => _confirmCancel(context, ref),
                  ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ChallengeStandings(members: challenge.members),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.challengeMembers,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          XnSectionList(
            children: [
              for (final member in challenge.members)
                XnSection(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(member.fullName),
                            Text(
                              '${member.status} · ${member.completedSessions}/${member.targetSessions}',
                              style: const TextStyle(
                                color: AppColors.fg3,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (challenge.canManage && !member.isCreator)
                        IconButton(
                          tooltip: l10n.challengeRemoveMember,
                          onPressed: pending
                              ? null
                              : () => _run(
                                  context,
                                  ref,
                                  (repo) => repo.removeMember(
                                    challenge.id,
                                    member.userId,
                                  ),
                                ),
                          icon: const Icon(Icons.person_remove_outlined),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function(ChallengeRepository repository) action,
  ) async {
    final success = await ref
        .read(challengeActionControllerProvider.notifier)
        .run(action);
    if (!success && context.mounted) {
      final error = ref.read(challengeActionControllerProvider).error!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    }
  }

  Future<void> _invite(BuildContext context, WidgetRef ref) async {
    final invitees = await ref.read(challengeInviteesProvider.future);
    if (!context.mounted) return;
    final selected = <String>{};
    final result = await showDialog<List<String>>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context).challengeInvite),
          content: SizedBox(
            width: 420,
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final invitee in invitees)
                  CheckboxListTile(
                    value: selected.contains(invitee.userId),
                    title: Text(invitee.fullName),
                    subtitle: Text(invitee.relationship),
                    onChanged: (checked) => setState(() {
                      checked == true
                          ? selected.add(invitee.userId)
                          : selected.remove(invitee.userId);
                    }),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).commonCancel),
            ),
            FilledButton(
              onPressed: selected.isEmpty
                  ? null
                  : () => Navigator.pop(context, selected.toList()),
              child: Text(AppLocalizations.of(context).challengeInvite),
            ),
          ],
        ),
      ),
    );
    if (result != null && context.mounted) {
      await _run(context, ref, (repo) => repo.invite(challenge.id, result));
    }
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context).challengeCancelConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).challengeCancel),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await _run(context, ref, (repo) => repo.cancel(challenge.id));
    }
  }
}
