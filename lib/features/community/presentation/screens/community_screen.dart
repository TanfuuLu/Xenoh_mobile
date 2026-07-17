import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/community_controllers.dart';
import '../widgets/community_widgets.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final feed = ref.watch(communityFeedControllerProvider);
    final search = ref.watch(communityUserSearchProvider(_query));
    final actionPending = ref.watch(friendActionControllerProvider).isLoading;
    final sharePending = ref.watch(shareActionControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: const HomeShellMenuButton(),
        title: Text(l10n.communityTitle),
        actions: [
          IconButton(
            tooltip: l10n.communityFriendsTitle,
            onPressed: () => unawaited(context.push('/community/friends')),
            icon: const Icon(Icons.people_alt_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          await ref.read(communityFeedControllerProvider.notifier).refresh();
          ref.invalidate(communityUserSearchProvider(_query));
        },
        child: ListView(
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
                  Text(
                    l10n.communityEyebrowLabel,
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.communityFindLiftersMessage,
                    style: AppTypography.display(24, letterSpacing: 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: l10n.communitySearchAthletesHint,
              ),
              textInputAction: TextInputAction.search,
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: AppSpacing.md),
            if (_query.trim().length >= 2)
              AsyncValueView(
                value: search,
                onRetry: () =>
                    ref.invalidate(communityUserSearchProvider(_query)),
                data: (page) {
                  if (page.items.isEmpty) {
                    return _EmptyCard(
                      icon: Icons.person_search_rounded,
                      message: l10n.communityNoAthletesMatchMessage,
                    );
                  }
                  return XnSectionList(
                    children: [
                      for (final user in page.items)
                        CommunityUserCard(
                          user: user,
                          onTap: () => unawaited(
                            context.push('/community/users/${user.id}'),
                          ),
                          trailing: FriendActionButton(
                            user: user,
                            pending: actionPending,
                            onSend: () => unawaited(
                              ref
                                  .read(friendActionControllerProvider.notifier)
                                  .send(user.id),
                            ),
                            onAccept: () => unawaited(
                              _acceptFriendRequest(ref, user.friendshipId),
                            ),
                            onReject: () => unawaited(
                              _rejectFriendRequest(ref, user.friendshipId),
                            ),
                            onRemove: () => unawaited(
                              ref
                                  .read(friendActionControllerProvider.notifier)
                                  .remove(user.id),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              )
            else
              const _SearchHint(),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Text(
                  l10n.communityFriendFeedTitle,
                  style: AppTypography.display(22, letterSpacing: 0),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () =>
                      unawaited(context.push('/community/friends')),
                  icon: const Icon(Icons.people_alt_outlined, size: 18),
                  label: Text(l10n.communityFriendsTitle),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AsyncValueView(
              value: feed,
              onRetry: () => ref.invalidate(communityFeedControllerProvider),
              data: (shares) {
                if (shares.isEmpty) {
                  return _EmptyCard(
                    icon: Icons.fitness_center_rounded,
                    message: l10n.communityNoFriendSharesMessage,
                  );
                }
                return Column(
                  children: [
                    for (final share in shares) ...[
                      TrainingDayShareCard(
                        share: share,
                        pending: sharePending,
                        onUserTap: () => unawaited(
                          context.push('/community/users/${share.userId}'),
                        ),
                        onLoveToggle: () => unawaited(
                          ref
                              .read(shareActionControllerProvider.notifier)
                              .toggleLove(share),
                        ),
                      ),
                      if (share != shares.last)
                        const SizedBox(height: AppSpacing.md),
                    ],
                  ],
                );
              },
            ),
          ],
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

class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.fg3),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.communityTypeAtLeast2CharsMessage,
              style: const TextStyle(color: AppColors.fg2),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Column(
          children: [
            Icon(icon, color: AppColors.fg3, size: 36),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.fg2),
            ),
          ],
        ),
      ),
    );
  }
}
