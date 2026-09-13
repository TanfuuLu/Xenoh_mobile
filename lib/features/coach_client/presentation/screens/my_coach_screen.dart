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
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../providers/chat_unread_controller.dart';
import '../providers/my_coach_provider.dart';

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
          onEndRelationship: () =>
              _confirmEndRelationship(context, ref, relationship),
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

  Future<void> _confirmEndRelationship(
    BuildContext context,
    WidgetRef ref,
    JsonMap relationship,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.coachEndRelationshipConfirmTitle),
        content: Text(l10n.coachEndRelationshipConfirmMessageClient),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.coachEndRelationshipAction),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    await _endRelationship(context, ref, relationship);
  }

  Future<void> _endRelationship(
    BuildContext context,
    WidgetRef ref,
    JsonMap relationship,
  ) async {
    final id = textOf(relationship, ['id', 'relationshipId'], fallback: '');
    if (id.isEmpty) return;
    try {
      final api = ref.read(xenohApiProvider);
      await api.postVoid('/coach-client/$id/end');
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
    required this.onEndRelationship,
    required this.unreadCount,
    this.profile,
  });

  final JsonMap relationship;
  final JsonMap? profile;
  final VoidCallback onMessage;
  final VoidCallback onEndRelationship;
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
      key: const ValueKey('coach-profile-hero'),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            decoration: const BoxDecoration(
              color: AppColors.clay050,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadius.lg),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _CoachAvatar(name: coachName, avatarUrl: avatarUrl),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coachName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.display(
                              25,
                              weight: FontWeight.w700,
                              letterSpacing: -0.35,
                              height: 1.08,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: _statusColor(status),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Flexible(
                                child: Text(
                                  status,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.fg2,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (email != null && email.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      const Icon(
                        Icons.mail_outline_rounded,
                        size: 17,
                        color: AppColors.fg3,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.fg2,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onMessage,
                    icon: Badge(
                      isLabelVisible: unreadCount > 0,
                      label: Text(unreadCount.toString()),
                      child: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 18,
                      ),
                    ),
                    label: Text(l10n.coachMessageCoachButton),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            key: const ValueKey('coach-relationship-period'),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.md,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.bg3,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.calendar_month_outlined,
                    size: 19,
                    color: AppColors.clay900,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.coachCoachingPeriodLabel,
                        style: const TextStyle(
                          color: AppColors.fg3,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${startDate == null ? '-' : _fmtDate(startDate, locale)} – '
                        '${endDate == null ? l10n.coachOpenEndedDate : _fmtDate(endDate, locale)}',
                        style: const TextStyle(
                          color: AppColors.fg1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (socialLinks.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
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
            ),
          ],
          if (status == 'Active')
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: TextButton.icon(
                  onPressed: onEndRelationship,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.danger,
                  ),
                  icon: const Icon(Icons.person_off_outlined, size: 18),
                  label: Text(l10n.coachEndRelationshipAction),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CoachAvatar extends StatelessWidget {
  const _CoachAvatar({required this.name, this.avatarUrl});

  final String name;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatarUrl != null && avatarUrl!.isNotEmpty;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: Container(
            width: 72,
            height: 72,
            color: AppColors.clay200,
            child: hasAvatar
                ? Image.network(avatarUrl!, fit: BoxFit.cover)
                : Center(
                    child: Text(
                      _initials(name),
                      style: AppTypography.display(
                        24,
                        weight: FontWeight.w700,
                        color: AppColors.clay900,
                      ),
                    ),
                  ),
          ),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.sage700,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.clay050, width: 3),
            ),
          ),
        ),
      ],
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

Color _statusColor(String status) {
  switch (status) {
    case 'Active':
      return AppColors.sage700;
    case 'Pending':
      return AppColors.info;
    case 'Expired':
      return AppColors.danger;
    default:
      return AppColors.fg4;
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
