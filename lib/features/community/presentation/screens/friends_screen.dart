import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/community_models.dart';
import '../providers/community_controllers.dart';
import '../widgets/community_widgets.dart';

class FriendsScreen extends ConsumerWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final friends = ref.watch(friendsControllerProvider);
    final incoming = ref.watch(
      friendRequestsProvider(RequestDirection.incoming),
    );
    final outgoing = ref.watch(
      friendRequestsProvider(RequestDirection.outgoing),
    );
    final actionPending = ref.watch(friendActionControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.communityFriendsTitle),
        actions: [
          IconButton(
            tooltip: l10n.communityFindFriendsTooltip,
            onPressed: () => unawaited(context.push('/community')),
            icon: const Icon(Icons.person_search_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          await ref.read(friendsControllerProvider.notifier).refresh();
          ref
            ..invalidate(friendRequestsProvider(RequestDirection.incoming))
            ..invalidate(friendRequestsProvider(RequestDirection.outgoing));
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            96,
          ),
          children: [
            Text(
              l10n.communityIncomingRequestsTitle,
              style: AppTypography.display(22, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.md),
            AsyncValueView(
              value: incoming,
              onRetry: () => ref.invalidate(
                friendRequestsProvider(RequestDirection.incoming),
              ),
              data: (requests) {
                if (requests.isEmpty) {
                  return _EmptyLine(l10n.communityNoIncomingRequestsMessage);
                }
                return XnCardStack(
                  children: [
                    for (final request in requests)
                      _FriendRequestCard(
                        request: request,
                        pending: actionPending,
                        onOpen: () => unawaited(
                          context.push('/community/users/${request.userId}'),
                        ),
                        onAccept: () => unawaited(
                          ref
                              .read(friendActionControllerProvider.notifier)
                              .accept(request.id),
                        ),
                        onReject: () => unawaited(
                          ref
                              .read(friendActionControllerProvider.notifier)
                              .reject(request.id),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.communityFriendsTitle,
              style: AppTypography.display(22, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.md),
            AsyncValueView(
              value: friends,
              onRetry: () => ref.invalidate(friendsControllerProvider),
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyLine(l10n.communityNoFriendsMessage);
                }
                return XnCardStack(
                  children: [
                    for (final friend in items)
                      XnSection(
                        onTap: () => unawaited(
                          context.push('/community/users/${friend.userId}'),
                        ),
                        child: Row(
                          children: [
                            CommunityAvatar(
                              name: friend.fullName,
                              imageUrl: friend.avatarUrl,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    friend.fullName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.fg1,
                                    ),
                                  ),
                                  if (friend.email != null)
                                    Text(
                                      friend.email!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.fg3,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            IconButton(
                              tooltip: l10n.communityRemoveFriendTooltip,
                              onPressed: actionPending
                                  ? null
                                  : () => unawaited(
                                      ref
                                          .read(
                                            friendActionControllerProvider
                                                .notifier,
                                          )
                                          .remove(friend.userId),
                                    ),
                              icon: const Icon(Icons.person_remove_outlined),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.communitySentRequestsTitle,
              style: AppTypography.display(22, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.md),
            AsyncValueView(
              value: outgoing,
              onRetry: () => ref.invalidate(
                friendRequestsProvider(RequestDirection.outgoing),
              ),
              data: (requests) {
                if (requests.isEmpty) {
                  return _EmptyLine(l10n.communityNoOutgoingRequestsMessage);
                }
                return XnCardStack(
                  children: [
                    for (final request in requests)
                      XnSection(
                        onTap: () => unawaited(
                          context.push('/community/users/${request.userId}'),
                        ),
                        child: Row(
                          children: [
                            CommunityAvatar(
                              name: request.fullName,
                              imageUrl: request.avatarUrl,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                request.fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            XnChip(
                              label: l10n.communityPendingLabel,
                              tone: XnChipTone.warn,
                            ),
                          ],
                        ),
                      ),
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

class _FriendRequestCard extends StatelessWidget {
  const _FriendRequestCard({
    required this.request,
    required this.pending,
    required this.onOpen,
    required this.onAccept,
    required this.onReject,
  });

  final FriendRequest request;
  final bool pending;
  final VoidCallback onOpen;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      onTap: onOpen,
      child: Row(
        children: [
          CommunityAvatar(name: request.fullName, imageUrl: request.avatarUrl),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (request.email != null)
                  Text(
                    request.email!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          XnButton(
            label: l10n.communityAcceptButton,
            icon: Icons.check_rounded,
            loading: pending,
            onPressed: onAccept,
          ),
          IconButton(
            tooltip: l10n.communityRejectTooltip,
            onPressed: pending ? null : onReject,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}

class _EmptyLine extends StatelessWidget {
  const _EmptyLine(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.fg2),
        ),
      ),
    );
  }
}
