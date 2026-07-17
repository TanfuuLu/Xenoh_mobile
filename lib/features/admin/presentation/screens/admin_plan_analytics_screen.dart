import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final adminPlanAnalyticsProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, planId) {
      return ref
          .watch(xenohApiProvider)
          .getObject('/admin/plans/$planId/analytics');
    });

class AdminPlanAnalyticsScreen extends ConsumerWidget {
  const AdminPlanAnalyticsScreen({required this.planId, super.key});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final analytics = ref.watch(adminPlanAnalyticsProvider(planId));
    return FeatureScreenFrame(
      title: l10n.adminPlanAnalyticsTitle,
      onRefresh: () => ref.refresh(adminPlanAnalyticsProvider(planId).future),
      children: [
        FeatureHeader(
          title: l10n.adminPlanAnalyticsHeaderTitle,
          subtitle: l10n.adminPlanAnalyticsHeaderSubtitle,
          icon: Icons.query_stats_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (analytics) {
          AsyncData(:final value) => KeyValueGrid(
            items: {
              l10n.adminNameLabel: textOf(value, ['name']),
              l10n.adminOwnerLabel: textOf(value, ['ownerName', 'ownerEmail']),
              l10n.adminCoachLabel: textOf(value, ['coachName', 'coachEmail']),
              l10n.adminTypeLabel: textOf(value, ['planType']),
              l10n.adminActiveLabel: textOf(value, ['isActive']),
              l10n.adminCompletionLabel:
                  '${textOf(value, ['completionPercent'])}%',
              l10n.adminDaysLabel:
                  '${textOf(value, ['completedDays'])}/${textOf(value, ['totalDays'])}',
              l10n.adminVolumeLabel: textOf(value, ['totalVolume']),
            },
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(adminPlanAnalyticsProvider(planId)),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}
