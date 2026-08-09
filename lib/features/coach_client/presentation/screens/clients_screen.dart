import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../core/widgets/xn_user_avatar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final coachClientsProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  return ref.watch(xenohApiProvider).getList('/coach-client/my-clients');
});

final coachPendingRequestsProvider = FutureProvider.autoDispose<List<JsonMap>>(
  (ref) {
    return ref
        .watch(xenohApiProvider)
        .getList('/coach-client/pending-requests');
  },
);

final coachDashboardProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  return ref.watch(xenohApiProvider).getList('/coach-client/dashboard');
});

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final clients = ref.watch(coachClientsProvider);
    final pending = ref.watch(coachPendingRequestsProvider);
    final dashboard = ref.watch(coachDashboardProvider);

    return FeatureScreenFrame(
      title: l10n.coachClientsTitle,
      leading: const HomeShellMenuButton(),
      onRefresh: () async {
        ref
          ..invalidate(coachDashboardProvider)
          ..invalidate(coachPendingRequestsProvider)
          ..invalidate(coachClientsProvider);
      },
      children: [
        _ManageClientsPanel(
          dashboard: dashboard,
          clients: clients,
          pending: pending,
          onOpenVault: () => unawaited(context.push('/coach/key-vault')),
        ),
        const SizedBox(height: AppSpacing.lg),
        _SchedulePanel(dashboard: dashboard),
        const SizedBox(height: AppSpacing.xl),
        _PendingRequestsSection(
          pending: pending,
          onAction: (item, action) => _runAction(context, ref, item, action),
          onOpenClient: (item) => _openClient(context, item),
        ),
        _ClientRosterSection(
          clients: clients,
          dashboard: dashboard,
          onAction: (item, action) => _runAction(context, ref, item, action),
          onOpenClient: (item) => _openClient(context, item),
        ),
      ],
    );
  }

  Future<void> _runAction(
    BuildContext context,
    WidgetRef ref,
    JsonMap item,
    _RelationshipAction action,
  ) async {
    final id = textOf(item, ['relationshipId', 'id'], fallback: '');
    if (id.isEmpty) return;
    try {
      final api = ref.read(xenohApiProvider);
      switch (action) {
        case _RelationshipAction.accept:
          await api.putObject('/coach-client/accept/$id', {});
        case _RelationshipAction.disconnect:
          await api.delete('/coach-client/$id');
        case _RelationshipAction.requestTermination:
          await api.postVoid('/coach-client/$id/request-termination');
        case _RelationshipAction.acceptTermination:
          await api.postVoid('/coach-client/$id/accept-termination');
        case _RelationshipAction.rejectTermination:
          await api.postVoid('/coach-client/$id/reject-termination');
        case _RelationshipAction.requestRenewal:
          await api.postVoid('/coach-client/$id/request-renewal');
        case _RelationshipAction.acceptRenewal:
          await api.postVoid('/coach-client/$id/accept-renewal');
        case _RelationshipAction.rejectRenewal:
          await api.postVoid('/coach-client/$id/reject-renewal');
      }
      ref
        ..invalidate(coachDashboardProvider)
        ..invalidate(coachPendingRequestsProvider)
        ..invalidate(coachClientsProvider);
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    }
  }

  void _openClient(BuildContext context, JsonMap item) {
    final clientId = _clientIdOf(item);
    if (clientId.isEmpty) return;
    unawaited(context.push('/coach/clients/$clientId'));
  }
}

class _ManageClientsPanel extends StatelessWidget {
  const _ManageClientsPanel({
    required this.dashboard,
    required this.clients,
    required this.pending,
    required this.onOpenVault,
  });

  final AsyncValue<List<JsonMap>> dashboard;
  final AsyncValue<List<JsonMap>> clients;
  final AsyncValue<List<JsonMap>> pending;
  final VoidCallback onOpenVault;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final activeCount = clients.asData?.value.length;
    final pendingCount = pending.asData?.value.length;

    return XnSectionGroup(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.coachManageClientsTitle,
                        style: AppTypography.display(
                          24,
                          weight: FontWeight.w500,
                          height: 1.05,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        activeCount == null
                            ? l10n.coachClientRosterSubtitle
                            : l10n.coachActiveClientCount(activeCount),
                        style: const TextStyle(
                          color: AppColors.fg2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const _RoundIconBadge(
                  icon: Icons.lightbulb_outline_rounded,
                  color: AppColors.warningBg,
                  fg: AppColors.warning,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _VaultButton(onTap: onOpenVault),
            const SizedBox(height: AppSpacing.lg),
            _DashboardMetricList(
              items: _dashboardMetrics(
                l10n,
                dashboard.asData?.value,
                clients.asData?.value,
                activeFallback: activeCount,
                pendingFallback: pendingCount,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DashboardMetricList extends StatelessWidget {
  const _DashboardMetricList({required this.items});

  final List<_BoardMetric> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items) ...[
          if (item != items.first) const XnSectionDivider(),
          _BoardMetricTile(item: item),
        ],
      ],
    );
  }
}

class _BoardMetricTile extends StatelessWidget {
  const _BoardMetricTile({required this.item});

  final _BoardMetric item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: AppTypography.mono(
                    22,
                    weight: FontWeight.w500,
                    color: AppColors.fg1,
                  ),
                ),
              ],
            ),
          ),
          _RoundIconBadge(icon: item.icon, color: item.bg, fg: item.fg),
        ],
      ),
    );
  }
}

class _SchedulePanel extends StatelessWidget {
  const _SchedulePanel({required this.dashboard});

  final AsyncValue<List<JsonMap>> dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      color: AppColors.bg2,
      padding: EdgeInsets.zero,
      border: Border.all(color: AppColors.surfaceBorderSoft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                const _RoundIconBadge(
                  icon: Icons.calendar_month_outlined,
                  color: AppColors.bg3,
                  fg: AppColors.clay900,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    l10n.coachScheduleTitle,
                    style: AppTypography.display(
                      18,
                      weight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                XnChip(label: l10n.coachSixMonthsLabel, compact: true),
              ],
            ),
          ),
          switch (dashboard) {
            AsyncData(:final value) when value.isEmpty => Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Text(
                l10n.coachActivePlansAppearMessage,
                style: const TextStyle(color: AppColors.fg3),
              ),
            ),
            AsyncData(:final value) => _ClientMonitoringList(items: value),
            AsyncError(:final error) => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: FeatureError(error: error),
            ),
            _ => const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: _SkeletonBox(width: double.infinity, height: 92),
            ),
          },
        ],
      ),
    );
  }
}

class _ClientMonitoringList extends StatelessWidget {
  const _ClientMonitoringList({required this.items});

  final List<JsonMap> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items.take(5)) _ClientMonitoringRow(item: item),
      ],
    );
  }
}

class _ClientMonitoringRow extends StatelessWidget {
  const _ClientMonitoringRow({required this.item});

  final JsonMap item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progress =
        (item['activePlanProgressPercent'] as num?)?.toInt() ??
        (item['planProgressPercent'] as num?)?.toInt();
    final completed = (item['activePlanCompletedWorkoutCount'] as num?)
        ?.toInt();
    final total = (item['activePlanTotalWorkoutCount'] as num?)?.toInt();
    final planName = optionalTextOf(item, ['activePlanName']);
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorderSoft)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    textOf(item, ['fullName'], fallback: '-'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if (completed != null && total != null)
                  Text(
                    '$completed/$total',
                    style: AppTypography.mono(12, weight: FontWeight.w500),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              planName ?? l10n.coachMetricNoActivePlan,
              style: const TextStyle(color: AppColors.fg3, fontSize: 12),
            ),
            if (progress != null) ...[
              const SizedBox(height: AppSpacing.sm),
              LinearProgressIndicator(value: (progress / 100).clamp(0, 1)),
            ],
          ],
        ),
      ),
    );
  }
}

class _PendingRequestsSection extends StatelessWidget {
  const _PendingRequestsSection({
    required this.pending,
    required this.onAction,
    required this.onOpenClient,
  });

  final AsyncValue<List<JsonMap>> pending;
  final void Function(JsonMap item, _RelationshipAction action) onAction;
  final ValueChanged<JsonMap> onOpenClient;

  @override
  Widget build(BuildContext context) {
    return switch (pending) {
      AsyncData(:final value) when value.isEmpty => const SizedBox.shrink(),
      AsyncData(:final value) => _RosterGroup(
        title: AppLocalizations.of(context).coachPendingRequestsTitle,
        count: value.length,
        children: [
          for (final item in value)
            _RelationshipCard(
              item: item,
              pending: true,
              onTap: () => onOpenClient(item),
              onAction: (action) => onAction(item, action),
            ),
        ],
      ),
      AsyncError(:final error) => FeatureError(error: error),
      _ => const LoadingList(),
    };
  }
}

class _ClientRosterSection extends StatelessWidget {
  const _ClientRosterSection({
    required this.clients,
    required this.dashboard,
    required this.onAction,
    required this.onOpenClient,
  });

  final AsyncValue<List<JsonMap>> clients;
  final AsyncValue<List<JsonMap>> dashboard;
  final void Function(JsonMap item, _RelationshipAction action) onAction;
  final ValueChanged<JsonMap> onOpenClient;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (clients) {
      AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
        title: l10n.coachNoActiveClientsTitle,
        message: l10n.coachNoActiveClientsMessage,
        icon: Icons.person_add_alt_1_outlined,
      ),
      AsyncData(:final value) => _RosterGroup(
        title: l10n.coachActiveClientsTitle,
        count: value.length,
        children: [
          for (final item in value)
            _RelationshipCard(
              item: {
                ...item,
                ...?_dashboardForClient(dashboard.value, _clientIdOf(item)),
              },
              onTap: () => onOpenClient(item),
              onAction: (action) => onAction(item, action),
            ),
        ],
      ),
      AsyncError(:final error) => FeatureError(error: error),
      _ => const LoadingList(),
    };
  }
}

class _RosterGroup extends StatelessWidget {
  const _RosterGroup({
    required this.title,
    required this.count,
    required this.children,
  });

  final String title;
  final int count;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTypography.display(
                  17,
                  weight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
            ),
            XnChip(label: count.toString(), compact: true),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        XnSectionList(children: children),
      ],
    );
  }
}

class _RelationshipCard extends ConsumerWidget {
  const _RelationshipCard({
    required this.item,
    required this.onAction,
    this.onTap,
    this.pending = false,
  });

  final JsonMap item;
  final bool pending;
  final VoidCallback? onTap;
  final ValueChanged<_RelationshipAction> onAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unit = ref.watch(weightUnitProvider);
    final status = textOf(
      item,
      [
        'status',
      ],
      fallback: pending
          ? l10n.coachPendingStatusFallback
          : l10n.coachActiveStatusFallback,
    );
    final name = textOf(item, ['clientName', 'userName', 'fullName', 'name']);
    final email = optionalTextOf(item, ['clientEmail', 'userEmail', 'email']);
    final avatarUrl = optionalTextOf(item, [
      'clientAvatarUrl',
      'userAvatarUrl',
      'avatarUrl',
      'profilePictureUrl',
      'photoUrl',
    ]);
    final attentionLevel = textOf(
      item,
      ['attentionLevel'],
      fallback: 'None',
    );
    final attention =
        item['needsAttention'] == true || attentionLevel != 'None';
    final plan = optionalTextOf(item, [
      'activePlanName',
      'planName',
      'currentPlanName',
    ]);
    final weightKg = double.tryParse(
      optionalTextOf(item, [
            'latestBodyweightKg',
            'latestBodyweight',
            'bodyweight',
            'weightKg',
          ]) ??
          '',
    );
    final progress =
        (item['activePlanProgressPercent'] as num?)?.toInt() ??
        (item['planProgressPercent'] as num?)?.toInt();
    final completedToday = item['completedWorkoutToday'] == true;
    final clientId = _clientIdOf(item);
    final relationshipKey = clientId.isNotEmpty
        ? clientId
        : textOf(item, ['relationshipId', 'id'], fallback: name);
    final statusActive = status.toLowerCase() == 'active';

    return XnSection(
      key: ValueKey('client-relationship-$relationshipKey'),
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AvatarMark(
                name: name,
                imageUrl: avatarUrl,
                attention: attention,
              ),
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
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        height: 1.15,
                      ),
                    ),
                    if (email != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.fg3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    _ClientStatusLabel(
                      label: status,
                      active: statusActive,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              PopupMenuButton<_RelationshipAction>(
                tooltip: l10n.coachRelationshipActionsTooltip,
                icon: const Icon(Icons.more_horiz_rounded),
                onSelected: onAction,
                itemBuilder: (_) => [
                  if (pending || status == 'Pending')
                    PopupMenuItem(
                      value: _RelationshipAction.accept,
                      child: Text(l10n.coachAcceptAction),
                    ),
                  PopupMenuItem(
                    value: _RelationshipAction.requestTermination,
                    child: Text(l10n.coachRequestTerminationAction),
                  ),
                  PopupMenuItem(
                    value: _RelationshipAction.acceptTermination,
                    child: Text(l10n.coachAcceptTerminationAction),
                  ),
                  PopupMenuItem(
                    value: _RelationshipAction.rejectTermination,
                    child: Text(l10n.coachRejectTerminationAction),
                  ),
                  PopupMenuItem(
                    value: _RelationshipAction.requestRenewal,
                    child: Text(l10n.coachRequestRenewalAction),
                  ),
                  PopupMenuItem(
                    value: _RelationshipAction.acceptRenewal,
                    child: Text(l10n.coachAcceptRenewalAction),
                  ),
                  PopupMenuItem(
                    value: _RelationshipAction.rejectRenewal,
                    child: Text(l10n.coachRejectRenewalAction),
                  ),
                  PopupMenuItem(
                    value: _RelationshipAction.disconnect,
                    child: Text(l10n.coachDisconnectAction),
                  ),
                ],
              ),
            ],
          ),
          if (plan != null || progress != null) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.bg3.withValues(alpha: 0.42),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.surfaceBorderSoft.withValues(alpha: 0.75),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.assignment_outlined,
                        size: 17,
                        color: AppColors.clay800,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          plan ?? l10n.coachMetricNoActivePlan,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.fg1,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                      ),
                      if (progress != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          '$progress%',
                          style: AppTypography.mono(
                            13,
                            weight: FontWeight.w600,
                            color: AppColors.clay800,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (progress != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: LinearProgressIndicator(
                        minHeight: 5,
                        value: (progress / 100).clamp(0, 1).toDouble(),
                        backgroundColor: AppColors.bg2,
                        color: attention
                            ? AppColors.warning
                            : AppColors.sage700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          if (completedToday || weightKg != null || attention) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                if (weightKg != null)
                  _ClientMetaLabel(
                    icon: Icons.monitor_weight_outlined,
                    label:
                        '${formatWeight(unit.fromKg(weightKg))} ${unit.suffix}',
                  ),
                if (completedToday)
                  _ClientMetaLabel(
                    icon: Icons.check_circle_outline_rounded,
                    label: l10n.commonDone,
                    color: AppColors.success,
                  ),
                if (attention)
                  _ClientMetaLabel(
                    icon: Icons.error_outline_rounded,
                    label: l10n.coachNeedsAttentionLabel,
                    color: AppColors.warning,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ClientStatusLabel extends StatelessWidget {
  const _ClientStatusLabel({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.success : AppColors.fg3;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ClientMetaLabel extends StatelessWidget {
  const _ClientMetaLabel({
    required this.icon,
    required this.label,
    this.color = AppColors.fg3,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _VaultButton extends StatelessWidget {
  const _VaultButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: AppColors.accent,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 9,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.key_rounded,
                color: AppColors.fgOnClay,
                size: 16,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                l10n.coachKeyVaultTitle,
                style: const TextStyle(
                  color: AppColors.fgOnClay,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconBadge extends StatelessWidget {
  const _RoundIconBadge({
    required this.icon,
    required this.color,
    required this.fg,
  });

  final IconData icon;
  final Color color;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: fg.withValues(alpha: 0.16)),
      ),
      child: Icon(icon, color: fg, size: 20),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );
  }
}

class _AvatarMark extends StatelessWidget {
  const _AvatarMark({
    required this.name,
    required this.attention,
    this.imageUrl,
  });

  final String name;
  final String? imageUrl;
  final bool attention;

  @override
  Widget build(BuildContext context) {
    return XnUserAvatar(
      name: name,
      imageUrl: imageUrl,
      size: 46,
      backgroundColor: attention ? AppColors.warningBg : AppColors.accentSoft,
      foregroundColor: attention ? AppColors.warning : AppColors.clay900,
      borderColor: attention
          ? AppColors.warning.withValues(alpha: 0.22)
          : AppColors.surfaceBorderSoft,
      borderRadius: AppRadius.lg,
    );
  }
}

class _BoardMetric {
  const _BoardMetric(this.label, this.value, this.icon, this.bg, this.fg);

  final String label;
  final String value;
  final IconData icon;
  final Color bg;
  final Color fg;
}

String _clientIdOf(JsonMap item) {
  final direct = textOf(
    item,
    ['clientId', 'clientUserId', 'userId'],
    fallback: '',
  );
  if (direct.isNotEmpty) return direct;

  for (final key in const ['client', 'user']) {
    final nested = item[key];
    if (nested is JsonMap) {
      final id = textOf(nested, ['id', 'userId'], fallback: '');
      if (id.isNotEmpty) return id;
    }
  }

  return '';
}

List<_BoardMetric> _dashboardMetrics(
  AppLocalizations l10n,
  List<JsonMap>? dashboard,
  List<JsonMap>? clients, {
  int? activeFallback,
  int? pendingFallback,
}) {
  final activeCount = clients?.length ?? activeFallback;
  final attentionCount = dashboard
      ?.where((client) => textOf(client, ['attentionLevel']) != 'None')
      .length;
  final noActivePlanCount = dashboard
      ?.where(
        (client) => !_hasAnyText(client, const [
          'activePlanId',
          'activePlanName',
          'currentPlanId',
          'currentPlanName',
          'planId',
          'planName',
        ]),
      )
      .length;
  final inactiveCount = dashboard
      ?.where(
        (client) =>
            client['daysSinceLastWorkout'] == null ||
            ((client['daysSinceLastWorkout'] as num?)?.toInt() ?? 0) > 5,
      )
      .length;

  return [
    _BoardMetric(
      l10n.coachMetricActiveClients,
      (dashboard?.length ?? activeCount)?.toString() ?? '-',
      Icons.groups_2_outlined,
      AppColors.accentSoft,
      AppColors.clay900,
    ),
    _BoardMetric(
      l10n.coachMetricNeedAttention,
      attentionCount?.toString() ?? '0',
      Icons.warning_amber_rounded,
      AppColors.warningBg,
      AppColors.warning,
    ),
    _BoardMetric(
      l10n.coachMetricNoActivePlan,
      noActivePlanCount?.toString() ?? '0',
      Icons.assignment_outlined,
      AppColors.infoBg,
      AppColors.info,
    ),
    _BoardMetric(
      l10n.coachMetricInactive,
      inactiveCount?.toString() ?? '0',
      Icons.calendar_month_outlined,
      AppColors.dangerBg,
      AppColors.danger,
    ),
  ];
}

bool _hasAnyText(JsonMap item, List<String> keys) {
  return optionalTextOf(item, keys) != null;
}

JsonMap? _dashboardForClient(List<JsonMap>? dashboard, String clientId) {
  if (dashboard == null || clientId.isEmpty) {
    return null;
  }
  for (final item in dashboard) {
    if (textOf(item, ['clientId'], fallback: '') == clientId) {
      return item;
    }
  }
  return null;
}

enum _RelationshipAction {
  accept,
  disconnect,
  requestTermination,
  acceptTermination,
  rejectTermination,
  requestRenewal,
  acceptRenewal,
  rejectRenewal,
}
