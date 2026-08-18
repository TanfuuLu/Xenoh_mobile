import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final adminDashboardProvider = FutureProvider.autoDispose<JsonMap>((ref) {
  ref.syncOn(const [DataTopic.admin]);
  return ref.watch(xenohApiProvider).getObject('/admin/dashboard');
});

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final dashboard = ref.watch(adminDashboardProvider);
    return FeatureScreenFrame(
      title: l10n.adminDashboardTitle,
      onRefresh: () => ref.refresh(adminDashboardProvider.future),
      children: [
        FeatureHeader(
          title: l10n.adminPlatformOperationsTitle,
          subtitle: l10n.adminPlatformOperationsSubtitle,
          icon: Icons.admin_panel_settings_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (dashboard) {
          AsyncData(:final value) => KeyValueGrid(
            items: {
              l10n.adminUsersLabel: textOf(value, ['totalUsers']),
              l10n.adminNewThisMonthLabel: textOf(
                value,
                ['newUsersThisMonth'],
              ),
              l10n.adminActiveCoachesLabel: textOf(value, ['activeCoaches']),
              l10n.adminPaidSubsLabel: textOf(
                value,
                ['activePaidSubscriptions'],
              ),
              l10n.adminPendingReportsLabel: textOf(
                value,
                ['pendingReports'],
              ),
              l10n.adminPlansLabel: textOf(value, ['totalPlansCreated']),
              l10n.adminWorkoutDaysLabel: textOf(
                value,
                ['completedWorkoutDays'],
              ),
              l10n.adminRevenueMonthLabel: textOf(
                value,
                ['completedPaymentRevenueThisMonth'],
              ),
            },
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(adminDashboardProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}
