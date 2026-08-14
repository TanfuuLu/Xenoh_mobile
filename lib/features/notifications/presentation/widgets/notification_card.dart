import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';

enum _NotificationCategory {
  coaching,
  community,
  competition,
  training,
  membership,
  general,
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    required this.onTap,
    this.onMarkRead,
    super.key,
  });

  final Map<String, dynamic> notification;
  final VoidCallback onTap;
  final VoidCallback? onMarkRead;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final category = _categoryOf(notification);
    final visual = _visualFor(category);
    final isRead = notification['isRead'] == true;
    final message = _displayMessage(notification, l10n);
    final timestamp = _displayTimestamp(context, notification['createdAt']);

    return Semantics(
      container: true,
      child: XnCard(
        color: isRead ? AppColors.bg2 : AppColors.clay050,
        border: Border.all(
          color: isRead ? AppColors.surfaceBorderSoft : AppColors.buttonBorder,
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryIcon(visual: visual, isRead: isRead),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NotificationMeta(
                    category: _categoryLabel(category, l10n),
                    timestamp: timestamp,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isRead ? AppColors.fg2 : AppColors.fg1,
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 15,
                      fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ReadState(isRead: isRead),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (!isRead && onMarkRead != null)
              IconButton(
                tooltip: l10n.notificationsMarkReadTooltip,
                onPressed: onMarkRead,
                icon: const Icon(Icons.done_rounded),
                color: AppColors.accent,
                iconSize: 21,
                constraints: const BoxConstraints.tightFor(
                  width: 44,
                  height: 44,
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(top: AppSpacing.md),
                child: ExcludeSemantics(
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.fg4,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.visual, required this.isRead});

  final ({IconData icon, Color foreground, Color background}) visual;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isRead ? AppColors.bg3 : visual.background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      alignment: Alignment.center,
      child: Icon(
        visual.icon,
        color: isRead ? AppColors.fg3 : visual.foreground,
        size: 22,
      ),
    );
  }
}

class _NotificationMeta extends StatelessWidget {
  const _NotificationMeta({required this.category, required this.timestamp});

  final String category;
  final String? timestamp;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: AppColors.fg3,
      fontFamily: AppTypography.fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
      height: 1.3,
    );
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(category, style: style),
        if (timestamp != null) ...[
          const Text('•', style: style),
          Text(timestamp!, style: style.copyWith(fontWeight: FontWeight.w400)),
        ],
      ],
    );
  }
}

class _ReadState extends StatelessWidget {
  const _ReadState({required this.isRead});

  final bool isRead;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final foreground = isRead ? AppColors.fg3 : AppColors.accentPress;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isRead ? AppColors.bg3 : AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isRead ? Icons.check_rounded : Icons.circle,
            size: isRead ? 13 : 7,
            color: foreground,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            isRead ? l10n.commonRead : l10n.commonUnread,
            style: TextStyle(
              color: foreground,
              fontFamily: AppTypography.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

String _displayMessage(
  Map<String, dynamic> notification,
  AppLocalizations l10n,
) {
  final message = notification['message']?.toString().trim();
  return message == null || message.isEmpty
      ? l10n.notificationsFallbackMessage
      : message;
}

String? _displayTimestamp(BuildContext context, dynamic rawValue) {
  if (rawValue == null) return null;
  final value = DateTime.tryParse(rawValue.toString());
  if (value == null) return null;
  final locale = Localizations.localeOf(context).toLanguageTag();
  return DateFormat.yMMMd(locale).add_Hm().format(value.toLocal());
}

_NotificationCategory _categoryOf(Map<String, dynamic> notification) {
  final type = notification['type']?.toString().toLowerCase() ?? '';
  final related =
      notification['relatedEntityType']?.toString().toLowerCase() ?? '';

  if (related == 'relationship' ||
      related == 'coachrequest' ||
      type.contains('coach') ||
      type.contains('message')) {
    return _NotificationCategory.coaching;
  }
  if (related == 'friendship' ||
      related == 'trainingdayshare' ||
      related == 'fitnesschallenge' ||
      type.contains('friend') ||
      type.contains('challenge') ||
      type.contains('share')) {
    return _NotificationCategory.community;
  }
  if (related == 'competitionevent' || type.contains('competition')) {
    return _NotificationCategory.competition;
  }
  if (related == 'subscription' || type.contains('subscription')) {
    return _NotificationCategory.membership;
  }
  if (related == 'day' ||
      related == 'plan' ||
      related.startsWith('week:') ||
      type.contains('comment') ||
      type.contains('workout') ||
      type.contains('plan')) {
    return _NotificationCategory.training;
  }
  return _NotificationCategory.general;
}

String _categoryLabel(
  _NotificationCategory category,
  AppLocalizations l10n,
) => switch (category) {
  _NotificationCategory.coaching => l10n.notificationsCategoryCoaching,
  _NotificationCategory.community => l10n.notificationsCategoryCommunity,
  _NotificationCategory.competition => l10n.notificationsCategoryCompetition,
  _NotificationCategory.training => l10n.notificationsCategoryTraining,
  _NotificationCategory.membership => l10n.notificationsCategoryMembership,
  _NotificationCategory.general => l10n.notificationsCategoryGeneral,
};

({IconData icon, Color foreground, Color background}) _visualFor(
  _NotificationCategory category,
) => switch (category) {
  _NotificationCategory.coaching => (
    icon: Icons.forum_outlined,
    foreground: AppColors.info,
    background: AppColors.infoBg,
  ),
  _NotificationCategory.community => (
    icon: Icons.people_alt_outlined,
    foreground: AppColors.sage700,
    background: AppColors.sage100,
  ),
  _NotificationCategory.competition => (
    icon: Icons.emoji_events_outlined,
    foreground: AppColors.warning,
    background: AppColors.warningBg,
  ),
  _NotificationCategory.training => (
    icon: Icons.fitness_center_rounded,
    foreground: AppColors.accentPress,
    background: AppColors.accentSoft,
  ),
  _NotificationCategory.membership => (
    icon: Icons.workspace_premium_outlined,
    foreground: AppColors.dataViolet,
    background: AppColors.clay100,
  ),
  _NotificationCategory.general => (
    icon: Icons.notifications_none_rounded,
    foreground: AppColors.fg3,
    background: AppColors.bg3,
  ),
};
