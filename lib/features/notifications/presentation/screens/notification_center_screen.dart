import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/realtime/realtime_service.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../domain/notification_destination.dart';

final notificationsProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  return ref.watch(xenohApiProvider).getList('/notifications');
});

/// Maps a notification to the screen it's about, reusing existing routes —
/// no per-notification detail screens exist, so coach/relationship types land
/// on the relevant hub and let the user pick from there. Returns null when
/// there's nowhere to go yet (e.g. `TrainingDayShare` has no viewer screen).
class NotificationCenterScreen extends ConsumerWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(realtimeEventsProvider, (_, next) {
      final event = next.value;
      if (event == null) return;
      if (event.name == 'ReceiveNotification') {
        ref.invalidate(notificationsProvider);
      }
    });

    final l10n = AppLocalizations.of(context);
    final notifications = ref.watch(notificationsProvider);
    final isCoach =
        ref.watch(authControllerProvider).sessionOrNull?.user.isCoach ?? false;
    return FeatureScreenFrame(
      title: l10n.notificationsTitle,
      actions: [
        IconButton(
          tooltip: l10n.notificationsMarkAllReadTooltip,
          icon: const Icon(Icons.done_all_rounded),
          onPressed: () async {
            await ref
                .read(xenohApiProvider)
                .patchVoid('/notifications/read-all');
            ref.invalidate(notificationsProvider);
          },
        ),
      ],
      onRefresh: () => ref.refresh(notificationsProvider.future),
      children: [
        FeatureHeader(
          title: l10n.notificationsCenterTitle,
          subtitle: l10n.notificationsCenterSubtitle,
          icon: Icons.notifications_active_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (notifications) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.notificationsEmptyTitle,
            message: l10n.notificationsEmptyMessage,
          ),
          AsyncData(:final value) => XnCardStack(
            children: [
              for (final item in value)
                DataCard(
                  title: textOf(item, ['message', 'type']),
                  subtitle: optionalTextOf(
                    item,
                    ['relatedEntityType', 'createdAt'],
                  ),
                  meta: [
                    if (item['type'] != null) item['type'].toString(),
                    if (item['isRead'] == true)
                      l10n.commonRead
                    else
                      l10n.commonUnread,
                  ],
                  trailing: item['isRead'] == true
                      ? null
                      : IconButton(
                          tooltip: l10n.notificationsMarkReadTooltip,
                          icon: const Icon(Icons.check_circle_outline),
                          onPressed: () async {
                            await ref
                                .read(xenohApiProvider)
                                .patchVoid('/notifications/${item['id']}/read');
                            ref.invalidate(notificationsProvider);
                          },
                        ),
                  onTap: () => _openNotification(context, ref, item, isCoach),
                ),
            ],
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(notificationsProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }

  Future<void> _openNotification(
    BuildContext context,
    WidgetRef ref,
    JsonMap item,
    bool isCoach,
  ) async {
    if (item['isRead'] != true) {
      await ref
          .read(xenohApiProvider)
          .patchVoid('/notifications/${item['id']}/read');
      ref.invalidate(notificationsProvider);
    }
    if (!context.mounted) return;
    final destination = notificationDestination(item, isCoach: isCoach);
    if (destination.route case final route?) {
      unawaited(context.push<void>(route));
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          AppLocalizations.of(dialogContext).notificationsUnavailableTitle,
        ),
        content: Text(
          AppLocalizations.of(dialogContext).notificationsUnavailableMessage,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppLocalizations.of(dialogContext).commonClose),
          ),
        ],
      ),
    );
  }
}
