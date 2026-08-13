import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../providers/chat_unread_controller.dart';
import 'clients_screen.dart';

final messagesProvider = FutureProvider.autoDispose
    .family<List<JsonMap>, String>((ref, relId) async {
      final page = await ref
          .watch(xenohApiProvider)
          .getObject('/messages/relationships/$relId?pageSize=50');
      final items = page['items'];
      return items is List<dynamic>
          ? items.whereType<JsonMap>().toList()
          : <JsonMap>[];
    });

/// Client picker for the coach's chat feature — selecting a client pushes
/// the shared `RelationshipChatScreen` thread (same bubbles/composer/
/// attachments UI the client side uses) rather than rendering messages here.
class ChatHubScreen extends ConsumerWidget {
  const ChatHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final clients = ref.watch(coachClientsProvider);
    final unreadCounts =
        ref.watch(chatUnreadControllerProvider).value ?? const {};
    return FeatureScreenFrame(
      title: l10n.coachChatTitle,
      onRefresh: () async => ref.invalidate(coachClientsProvider),
      children: [
        FeatureHeader(
          title: l10n.coachChatHeaderTitle,
          subtitle: l10n.coachChatHeaderSubtitle,
          icon: Icons.forum_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (clients) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.coachChatNoRelationshipsTitle,
            message: l10n.coachChatNoRelationshipsMessage,
          ),
          AsyncData(:final value) => XnCardStack(
            children: [
              for (final rel in value)
                _ChatClientCard(
                  relationship: rel,
                  unreadCount:
                      unreadCounts[textOf(rel, [
                        'id',
                        'relationshipId',
                      ], fallback: '')] ??
                      0,
                  onTap: () => _openThread(context, ref, rel),
                ),
            ],
          ),
          AsyncError(:final error) => FeatureError(error: error),
          _ => const LoadingList(),
        },
      ],
    );
  }

  Future<void> _openThread(
    BuildContext context,
    WidgetRef ref,
    JsonMap relationship,
  ) async {
    final relationshipId = textOf(relationship, ['id', 'relationshipId']);
    final clientName = textOf(relationship, ['clientName', 'fullName', 'name']);
    try {
      await ref
          .read(chatUnreadControllerProvider.notifier)
          .markRead(relationshipId);
    } catch (_) {
      // Read receipts are non-critical; the thread still opens.
    }
    if (!context.mounted) return;
    unawaited(
      context.push<void>(
        relationshipChatLocation(
          coachInbox: true,
          relationshipId: relationshipId,
          peerName: clientName,
        ),
      ),
    );
  }
}

class _ChatClientCard extends StatelessWidget {
  const _ChatClientCard({
    required this.relationship,
    required this.onTap,
    required this.unreadCount,
  });

  final JsonMap relationship;
  final VoidCallback onTap;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final name =
        _relationshipText(
          relationship,
          const ['clientName', 'userName', 'fullName', 'name'],
          fallback: '-',
        ) ??
        '-';
    final email = _relationshipText(
      relationship,
      const ['clientEmail', 'userEmail', 'email'],
    );
    final avatarUrl = _relationshipText(
      relationship,
      const [
        'clientAvatarUrl',
        'userAvatarUrl',
        'avatarUrl',
        'profilePictureUrl',
        'photoUrl',
      ],
    );

    return XnSection(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          _ClientAvatar(name: name, imageUrl: avatarUrl),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline_rounded,
                      size: 16,
                      color: AppColors.fg3,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        email ?? 'Email unavailable',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: email == null ? AppColors.fg4 : AppColors.fg2,
                          fontSize: 13,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          if (unreadCount > 0) ...[
            Badge.count(count: unreadCount),
            const SizedBox(width: AppSpacing.xs),
          ],
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.fg3,
            size: 24,
          ),
        ],
      ),
    );
  }
}

class _ClientAvatar extends StatelessWidget {
  const _ClientAvatar({required this.name, this.imageUrl});

  final String name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      color: AppColors.accentSoft,
      alignment: Alignment.center,
      child: Text(
        _initials(name),
        style: const TextStyle(
          color: AppColors.clay900,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return Semantics(
      image: true,
      label: '$name avatar',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: SizedBox.square(
          dimension: 48,
          child: imageUrl == null
              ? fallback
              : Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => fallback,
                ),
        ),
      ),
    );
  }
}

String? _relationshipText(
  JsonMap relationship,
  List<String> keys, {
  String? fallback,
}) {
  final direct = optionalTextOf(relationship, keys);
  if (direct != null) return direct;

  for (final containerKey in const ['client', 'user', 'profile']) {
    final nested = relationship[containerKey];
    if (nested is JsonMap) {
      final value = optionalTextOf(nested, keys);
      if (value != null) return value;
    }
  }
  return fallback;
}

String _initials(String name) {
  final words = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (words.isEmpty) return '?';
  if (words.length == 1) return words.first[0].toUpperCase();
  return '${words.first[0]}${words.last[0]}'.toUpperCase();
}
