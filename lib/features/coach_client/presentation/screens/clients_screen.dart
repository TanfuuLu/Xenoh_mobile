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

final coachDashboardProvider = FutureProvider.autoDispose<JsonMap>((ref) {
  return ref.watch(xenohApiProvider).getObject('/coach-client/dashboard');
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
        _SchedulePanel(clients: clients),
        const SizedBox(height: AppSpacing.xl),
        _PendingRequestsSection(
          pending: pending,
          onAction: (item, action) => _runAction(context, ref, item, action),
          onOpenClient: (item) => _openClient(context, item),
        ),
        _ClientRosterSection(
          clients: clients,
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

  final AsyncValue<JsonMap> dashboard;
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
  const _SchedulePanel({required this.clients});

  final AsyncValue<List<JsonMap>> clients;

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
          switch (clients) {
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
            AsyncData(:final value) => _ScheduleGrid(clients: value),
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

class _ScheduleGrid extends StatelessWidget {
  const _ScheduleGrid({required this.clients});

  final List<JsonMap> clients;

  @override
  Widget build(BuildContext context) {
    final visible = clients.take(3).toList();
    final months = _monthLabels();

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.surfaceBorderSoft),
              bottom: BorderSide(color: AppColors.surfaceBorderSoft),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 88),
              for (final month in months)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: Text(
                      month,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        for (final item in visible)
          _ScheduleRow(
            name: textOf(item, ['clientName', 'userName', 'fullName', 'name']),
            capacity: _firstMetric(item, [
              'capacity',
              'planCount',
            ], fallback: 1),
          ),
      ],
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.name, required this.capacity});

  final String name;
  final String capacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorderSoft)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    for (var i = 0; i < 6; i++)
                      const Expanded(
                        child: SizedBox(
                          height: 44,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.surfaceBorderSoft,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 0.86,
                  child: Container(
                    height: 18,
                    margin: const EdgeInsets.only(left: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.sage500.withValues(alpha: 0.76),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              capacity,
              textAlign: TextAlign.center,
              style: AppTypography.mono(12, weight: FontWeight.w500),
            ),
          ),
        ],
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
    required this.onAction,
    required this.onOpenClient,
  });

  final AsyncValue<List<JsonMap>> clients;
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
              item: item,
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
    final attention = item['needsAttention'] == true;
    final plan = optionalTextOf(item, [
      'activePlanName',
      'planName',
      'currentPlanName',
    ]);
    final weightKg = double.tryParse(
      optionalTextOf(item, ['latestBodyweight', 'bodyweight', 'weightKg']) ??
          '',
    );

    return XnSection(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AvatarMark(name: name, attention: attention),
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
                    fontWeight: FontWeight.w500,
                    height: 1.15,
                  ),
                ),
                if (email != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.fg2, fontSize: 13),
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    XnChip(label: status, compact: true),
                    if (plan != null) XnChip(label: plan, compact: true),
                    if (weightKg != null)
                      XnChip(
                        label:
                            '${formatWeight(unit.fromKg(weightKg))} ${unit.suffix}',
                        compact: true,
                      ),
                    if (attention)
                      XnChip(
                        label: l10n.coachNeedsAttentionLabel,
                        tone: XnChipTone.warn,
                        compact: true,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          PopupMenuButton<_RelationshipAction>(
            tooltip: l10n.coachRelationshipActionsTooltip,
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
  const _AvatarMark({required this.name, required this.attention});

  final String name;
  final bool attention;

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .where((part) => part.trim().isNotEmpty)
        .take(2)
        .map((part) => part.characters.first.toUpperCase())
        .join();

    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: attention ? AppColors.warningBg : AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: attention
              ? AppColors.warning.withValues(alpha: 0.22)
              : AppColors.surfaceBorderSoft,
        ),
      ),
      child: Text(
        initials.isEmpty ? '-' : initials,
        style: TextStyle(
          color: attention ? AppColors.warning : AppColors.clay900,
          fontWeight: FontWeight.w500,
        ),
      ),
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

String _firstMetric(JsonMap item, List<String> keys, {Object? fallback}) {
  final value = textOf(item, keys, fallback: '');
  if (value.isNotEmpty) return value;
  return fallback?.toString() ?? '0';
}

List<_BoardMetric> _dashboardMetrics(
  AppLocalizations l10n,
  JsonMap? dashboard,
  List<JsonMap>? clients, {
  int? activeFallback,
  int? pendingFallback,
}) {
  final activeCount = clients?.length ?? activeFallback;
  final attentionCount = clients
      ?.where(
        (client) =>
            client['needsAttention'] == true ||
            optionalTextOf(client, ['attentionReason']) != null,
      )
      .length;
  final noActivePlanCount = clients
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
  final inactiveCount = clients
      ?.where(
        (client) =>
            textOf(client, ['status'], fallback: '').toLowerCase() ==
            'inactive',
      )
      .length;

  return [
    _BoardMetric(
      l10n.coachMetricActiveClients,
      dashboard == null
          ? (activeCount?.toString() ?? '-')
          : _firstMetric(dashboard, [
              'activeClients',
              'activeClientCount',
              'clientCount',
              'totalClients',
            ], fallback: activeCount),
      Icons.groups_2_outlined,
      AppColors.accentSoft,
      AppColors.clay900,
    ),
    _BoardMetric(
      l10n.coachMetricNeedAttention,
      dashboard == null
          ? (attentionCount?.toString() ?? '0')
          : _firstMetric(dashboard, [
              'needAttention',
              'needsAttention',
              'attentionCount',
            ], fallback: attentionCount),
      Icons.warning_amber_rounded,
      AppColors.warningBg,
      AppColors.warning,
    ),
    _BoardMetric(
      l10n.coachMetricNoActivePlan,
      dashboard == null
          ? (noActivePlanCount?.toString() ?? '0')
          : _firstMetric(
              dashboard,
              ['noActivePlan', 'withoutActivePlan'],
              fallback: noActivePlanCount,
            ),
      Icons.assignment_outlined,
      AppColors.infoBg,
      AppColors.info,
    ),
    _BoardMetric(
      l10n.coachMetricInactive,
      dashboard == null
          ? (inactiveCount?.toString() ?? '0')
          : _firstMetric(
              dashboard,
              ['inactiveClients', 'inactiveCount'],
              fallback: inactiveCount,
            ),
      Icons.calendar_month_outlined,
      AppColors.dangerBg,
      AppColors.danger,
    ),
  ];
}

bool _hasAnyText(JsonMap item, List<String> keys) {
  return optionalTextOf(item, keys) != null;
}

List<String> _monthLabels() {
  const names = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final now = DateTime.now();
  return List.generate(6, (index) {
    final month = DateTime(now.year, now.month + index);
    return names[month.month - 1];
  });
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
