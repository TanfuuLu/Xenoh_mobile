import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';

class AdminModerationScreen extends StatelessWidget {
  const AdminModerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _AdminHub(
      title: l10n.appShellNavModeration,
      color: AppColors.dataRose,
      icon: Icons.shield_rounded,
      actions: [
        _HubAction(
          icon: Icons.flag_outlined,
          title: l10n.appShellDrawerAdminReports,
          route: '/admin/reports',
        ),
        _HubAction(
          icon: Icons.bug_report_outlined,
          title: l10n.appShellDrawerAdminBugReports,
          route: '/admin/bug-reports',
        ),
        _HubAction(
          icon: Icons.verified_user_outlined,
          title: l10n.adminOrganizerVerification,
          route: '/admin/organizers',
        ),
      ],
    );
  }
}

class AdminFinanceScreen extends StatelessWidget {
  const AdminFinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _AdminHub(
      title: l10n.appShellNavFinance,
      color: AppColors.dataTeal,
      icon: Icons.account_balance_wallet_rounded,
      actions: [
        _HubAction(
          icon: Icons.receipt_long_outlined,
          title: l10n.adminPaymentsTitle,
          route: '/admin/payments',
        ),
        _HubAction(
          icon: Icons.percent_rounded,
          title: l10n.adminPromotionsTitle,
          route: '/admin/promotions',
        ),
        _HubAction(
          icon: Icons.sell_outlined,
          title: l10n.appShellDrawerAdminPlans,
          route: '/admin/plans',
        ),
        _HubAction(
          icon: Icons.query_stats_rounded,
          title: l10n.appShellDrawerAdminAnalytics,
          route: '/admin/analytics',
        ),
      ],
    );
  }
}

class AdminMoreScreen extends StatelessWidget {
  const AdminMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _AdminHub(
      title: l10n.appShellNavMore,
      color: AppColors.dataViolet,
      icon: Icons.apps_rounded,
      actions: [
        _HubAction(
          icon: Icons.person_outline_rounded,
          title: l10n.appShellNavProfile,
          route: '/profile',
        ),
        _HubAction(
          icon: Icons.settings_outlined,
          title: l10n.settingsTitle,
          route: '/settings',
        ),
        _HubAction(
          icon: Icons.storage_outlined,
          title: l10n.storageTitle,
          route: '/storage',
        ),
      ],
    );
  }
}

class _AdminHub extends StatelessWidget {
  const _AdminHub({
    required this.title,
    required this.color,
    required this.icon,
    required this.actions,
  });

  final String title;
  final Color color;
  final IconData icon;
  final List<_HubAction> actions;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color,
                foregroundColor: Colors.white,
                child: Icon(icon, size: 30),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        for (final action in actions) ...[
          XnCard(
            onTap: () => context.push(action.route),
            child: Row(
              children: [
                Icon(action.icon, color: color),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    action.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    ),
  );
}

class _HubAction {
  const _HubAction({
    required this.icon,
    required this.title,
    required this.route,
  });
  final IconData icon;
  final String title;
  final String route;
}
