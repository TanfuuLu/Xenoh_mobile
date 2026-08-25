import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../blocks_reports/presentation/widgets/moderation_dialogs.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

String _reportStatusLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Pending' => l10n.adminReportStatusPending,
      'Resolved' => l10n.adminReportStatusResolved,
      'Dismissed' => l10n.adminReportStatusDismissed,
      _ => value,
    };

final adminReportsProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  ref.syncOn(const [DataTopic.admin]);
  return ref.watch(xenohApiProvider).getList('/admin/reports');
});

class AdminReportsScreen extends ConsumerWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final reports = ref.watch(adminReportsProvider);
    return FeatureScreenFrame(
      title: l10n.adminReportsTitle,
      onRefresh: () => ref.refresh(adminReportsProvider.future),
      children: [
        FeatureHeader(
          title: l10n.adminModerationQueueTitle,
          subtitle: l10n.adminModerationQueueSubtitle,
          icon: Icons.report_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (reports) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.adminNoReportsTitle,
            message: l10n.adminNoReportsMessage,
          ),
          AsyncData(:final value) => XnCardStack(
            children: [
              for (final item in value)
                DataCard(
                  title: textOf(item, [
                    'reportedUserName',
                    'reportedUserEmail',
                  ]),
                  subtitle: optionalTextOf(item, ['details', 'adminNote']),
                  meta: [
                    moderationReasonLabel(textOf(item, ['reason']), l10n),
                    _reportStatusLabel(textOf(item, ['status']), l10n),
                  ],
                  trailing: PopupMenuButton<String>(
                    tooltip: l10n.adminReviewTooltip,
                    onSelected: (status) async {
                      await ref.read(xenohApiProvider).patchObject(
                        '/admin/reports/${item['id']}',
                        {
                          'status': status,
                          'adminNote': l10n.adminReviewedOnMobileNote,
                        },
                      );
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'Resolved',
                        child: Text(l10n.adminResolveAction),
                      ),
                      PopupMenuItem(
                        value: 'Dismissed',
                        child: Text(l10n.adminDismissAction),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(adminReportsProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}
