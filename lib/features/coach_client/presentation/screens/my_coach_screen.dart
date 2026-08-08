import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/safe_external_url.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../providers/chat_unread_controller.dart';

final myCoachProvider = FutureProvider.autoDispose<JsonMap?>((ref) {
  return ref
      .watch(xenohApiProvider)
      .getNullableObject('/coach-client/my-coach');
});

/// Full coach profile (email/bio/avatar) — `GET /users/{coachId}` is only
/// authorized while an active coach-client relationship exists, so this is
/// fetched alongside the relationship rather than being part of it.
final coachProfileProvider = FutureProvider.autoDispose.family<JsonMap, String>(
  (
    ref,
    coachId,
  ) {
    return ref.watch(xenohApiProvider).getObject('/users/$coachId');
  },
);

class MyCoachScreen extends ConsumerWidget {
  const MyCoachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final coach = ref.watch(myCoachProvider);
    return FeatureScreenFrame(
      title: l10n.coachMyCoachTitle,
      onRefresh: () => ref.refresh(myCoachProvider.future),
      children: [
        FeatureHeader(
          title: l10n.coachProfileTitle,
          subtitle: l10n.coachProfileSubtitle,
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (coach) {
          AsyncData(:final value) when value == null => EmptyFeatureState(
            title: l10n.coachNoCoachConnectedTitle,
            message: l10n.coachNoCoachConnectedMessage,
            icon: Icons.vpn_key_outlined,
          ),
          AsyncData(:final value?) => _CoachProfileBody(relationship: value),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(myCoachProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}

class _CoachProfileBody extends ConsumerWidget {
  const _CoachProfileBody({required this.relationship});

  final JsonMap relationship;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coachId = textOf(relationship, ['coachId'], fallback: '');
    // Enrichment only — keep showing the relationship card even if this
    // secondary call is still loading or fails (async rendering convention).
    final profile = coachId.isEmpty
        ? null
        : ref.watch(coachProfileProvider(coachId)).value;
    final bio = profile == null ? null : optionalTextOf(profile, ['bio']);
    final l10n = AppLocalizations.of(context);
    final relationshipId = textOf(
      relationship,
      ['id', 'relationshipId'],
      fallback: '',
    );
    final unreadCount =
        ref.watch(chatUnreadControllerProvider).value?[relationshipId] ?? 0;

    return Column(
      children: [
        _CoachCard(
          relationship: relationship,
          profile: profile,
          unreadCount: unreadCount,
          onMessage: () => context.push(
            relationshipChatLocation(
              coachInbox: false,
              relationshipId: textOf(
                relationship,
                ['id', 'relationshipId'],
                fallback: '',
              ),
              peerName: textOf(
                relationship,
                ['coachName'],
                fallback: l10n.coachDefaultName,
              ),
            ),
          ),
          onDisconnect: () => _confirmDisconnect(context, ref, relationship),
          onLifecycleAction: (action) =>
              _runAction(context, ref, relationship, action),
        ),
        if (bio != null && bio.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _IntroductionCard(bio: bio),
        ],
        const SizedBox(height: AppSpacing.md),
        _ConnectedSinceNote(relationship: relationship),
      ],
    );
  }

  Future<void> _confirmDisconnect(
    BuildContext context,
    WidgetRef ref,
    JsonMap relationship,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.coachDisconnectConfirmTitle),
        content: Text(l10n.coachDisconnectConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.coachDisconnectAction),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    await _runAction(context, ref, relationship, _CoachAction.disconnect);
  }

  Future<void> _runAction(
    BuildContext context,
    WidgetRef ref,
    JsonMap relationship,
    _CoachAction action,
  ) async {
    final id = textOf(relationship, ['id', 'relationshipId'], fallback: '');
    if (id.isEmpty) return;
    try {
      final api = ref.read(xenohApiProvider);
      switch (action) {
        case _CoachAction.disconnect:
          await api.delete('/coach-client/$id');
        case _CoachAction.requestTermination:
          await api.postVoid('/coach-client/$id/request-termination');
        case _CoachAction.acceptTermination:
          await api.postVoid('/coach-client/$id/accept-termination');
        case _CoachAction.rejectTermination:
          await api.postVoid('/coach-client/$id/reject-termination');
        case _CoachAction.requestRenewal:
          await api.postVoid('/coach-client/$id/request-renewal');
        case _CoachAction.acceptRenewal:
          await api.postVoid('/coach-client/$id/accept-renewal');
        case _CoachAction.rejectRenewal:
          await api.postVoid('/coach-client/$id/reject-renewal');
      }
      ref.invalidate(myCoachProvider);
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    }
  }
}

class _CoachCard extends StatelessWidget {
  const _CoachCard({
    required this.relationship,
    required this.onMessage,
    required this.onDisconnect,
    required this.onLifecycleAction,
    required this.unreadCount,
    this.profile,
  });

  final JsonMap relationship;
  final JsonMap? profile;
  final VoidCallback onMessage;
  final VoidCallback onDisconnect;
  final ValueChanged<_CoachAction> onLifecycleAction;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final coachName = textOf(
      relationship,
      ['coachName'],
      fallback: l10n.coachDefaultName,
    );
    final status = textOf(
      relationship,
      ['status'],
      fallback: l10n.coachActiveStatusFallback,
    );
    final email = profile == null ? null : optionalTextOf(profile!, ['email']);
    final avatarUrl = profile == null
        ? null
        : optionalTextOf(profile!, ['avatarUrl']);
    final socialLinks = profile == null
        ? const <({String label, IconData icon, Uri uri})>[]
        : _coachSocialLinks(profile!);
    final startDate = _parseDate(relationship['startDate']);
    final endDate = _parseDate(relationship['endDate']);

    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.accentSoft,
                backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl != null && avatarUrl.isNotEmpty
                    ? null
                    : Text(
                        _initials(coachName),
                        style: const TextStyle(
                          color: AppColors.clay900,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coachName,
                      style: AppTypography.display(20, letterSpacing: 0),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        if (email != null && email.isNotEmpty)
                          XnChip(
                            label: email,
                            tone: XnChipTone.neutral,
                            icon: Icons.mail_outline_rounded,
                            compact: true,
                          ),
                        XnChip(
                          label: status,
                          tone: _statusTone(status),
                          compact: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 18,
                color: AppColors.fg3,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${startDate == null ? '-' : _fmtDate(startDate, locale)} - '
                      '${endDate == null ? l10n.coachOpenEndedDate : _fmtDate(endDate, locale)}',
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      l10n.coachCoachingPeriodLabel,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (socialLinks.isNotEmpty) ...[
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final link in socialLinks)
                  OutlinedButton.icon(
                    onPressed: () => launchUrl(
                      link.uri,
                      mode: LaunchMode.externalApplication,
                    ),
                    icon: Icon(link.icon, size: 16),
                    label: Text(link.label),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onMessage,
              icon: Badge(
                isLabelVisible: unreadCount > 0,
                label: Text(unreadCount.toString()),
                child: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
              ),
              label: Text(l10n.coachMessageCoachButton),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Spacer(),
              PopupMenuButton<_CoachAction>(
                tooltip: l10n.coachMoreActionsTooltip,
                onSelected: onLifecycleAction,
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: _CoachAction.requestTermination,
                    child: Text(l10n.coachRequestTerminationAction),
                  ),
                  PopupMenuItem(
                    value: _CoachAction.acceptTermination,
                    child: Text(l10n.coachAcceptTerminationAction),
                  ),
                  PopupMenuItem(
                    value: _CoachAction.rejectTermination,
                    child: Text(l10n.coachRejectTerminationAction),
                  ),
                  PopupMenuItem(
                    value: _CoachAction.requestRenewal,
                    child: Text(l10n.coachRequestRenewalAction),
                  ),
                  PopupMenuItem(
                    value: _CoachAction.acceptRenewal,
                    child: Text(l10n.coachAcceptRenewalAction),
                  ),
                  PopupMenuItem(
                    value: _CoachAction.rejectRenewal,
                    child: Text(l10n.coachRejectRenewalAction),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: onDisconnect,
                  icon: const Icon(
                    Icons.person_remove_alt_1_outlined,
                    size: 18,
                  ),
                  label: Text(l10n.coachDisconnectAction),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<({String label, IconData icon, Uri uri})> _coachSocialLinks(
  JsonMap profile,
) {
  final links = <({String label, IconData icon, Uri uri})>[];
  void add(String label, IconData icon, String key, Set<String> hosts) {
    final value = optionalTextOf(profile, [key]);
    if (value == null) {
      return;
    }
    final uri = safeExternalUri(value, allowedHosts: hosts);
    if (uri != null) {
      links.add((label: label, icon: icon, uri: uri));
    }
  }

  add('Facebook', Icons.facebook_rounded, 'facebookUrl', const {
    'facebook.com',
    'www.facebook.com',
  });
  add('Instagram', Icons.camera_alt_outlined, 'instagramUrl', const {
    'instagram.com',
    'www.instagram.com',
  });
  return links;
}

class _IntroductionCard extends StatelessWidget {
  const _IntroductionCard({required this.bio});

  final String bio;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSectionGroup(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 18,
                color: AppColors.clay900,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.coachIntroductionLabel.toUpperCase(),
                    style: _eyebrow,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bio,
                    style: const TextStyle(color: AppColors.fg2, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ConnectedSinceNote extends StatelessWidget {
  const _ConnectedSinceNote({required this.relationship});

  final JsonMap relationship;

  @override
  Widget build(BuildContext context) {
    final createdAt = _parseDate(relationship['createdAt']);
    if (createdAt == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return XnCard(
      color: AppColors.bg3,
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: AppColors.fg3,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.coachConnectedSinceLabel(_fmtDate(createdAt, locale)),
              style: const TextStyle(color: AppColors.fg2, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

enum _CoachAction {
  disconnect,
  requestTermination,
  acceptTermination,
  rejectTermination,
  requestRenewal,
  acceptRenewal,
  rejectRenewal,
}

XnChipTone _statusTone(String status) {
  switch (status) {
    case 'Active':
      return XnChipTone.sage;
    case 'Pending':
      return XnChipTone.info;
    case 'PendingTermination':
    case 'PendingRenewal':
      return XnChipTone.warn;
    case 'Expired':
      return XnChipTone.danger;
    default:
      return XnChipTone.neutral;
  }
}

String _initials(String fullName) {
  final parts = fullName.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

DateTime? _parseDate(Object? value) =>
    value is String ? DateTime.tryParse(value) : null;

String _fmtDate(DateTime d, String locale) =>
    DateFormat.yMMMd(locale).format(d.toLocal());

const _eyebrow = TextStyle(
  color: AppColors.fg3,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.7,
);
