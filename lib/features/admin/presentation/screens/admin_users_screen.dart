import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final adminUsersProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  ref.syncOn(const [DataTopic.admin]);
  return ref.watch(xenohApiProvider).getList('/admin/users');
});

class AdminUsersScreen extends ConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final users = ref.watch(adminUsersProvider);
    return FeatureScreenFrame(
      title: l10n.adminUsersLabel,
      onRefresh: () => ref.refresh(adminUsersProvider.future),
      children: [
        FeatureHeader(
          title: l10n.adminUserManagementTitle,
          subtitle: l10n.adminUserManagementSubtitle,
          icon: Icons.people_alt_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (users) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.adminNoUsersTitle,
            message: l10n.adminNoUsersMessage,
          ),
          AsyncData(:final value) => XnCardStack(
            children: [
              for (final item in value)
                DataCard(
                  title: textOf(item, ['fullName', 'email']),
                  subtitle: optionalTextOf(item, ['email']),
                  meta: [
                    textOf(
                      item,
                      ['subscriptionTier'],
                      fallback: l10n.subscriptionTierFree,
                    ),
                    if (item['isSuspended'] == true) l10n.adminSuspendedLabel,
                    if (item['roles'] is List<dynamic>)
                      (item['roles'] as List<dynamic>).join(', '),
                  ],
                  onTap: () => context.push('/admin/users/${item['id']}'),
                  trailing: IconButton(
                    tooltip: item['isSuspended'] == true
                        ? l10n.adminUnsuspendUserTooltip
                        : l10n.adminSuspendUserTooltip,
                    icon: Icon(
                      item['isSuspended'] == true
                          ? Icons.lock_open_rounded
                          : Icons.block_rounded,
                    ),
                    onPressed: () async {
                      final action = item['isSuspended'] == true
                          ? 'unsuspend'
                          : 'suspend';
                      await ref
                          .read(xenohApiProvider)
                          .postVoid('/admin/users/${item['id']}/$action');
                    },
                  ),
                ),
            ],
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(adminUsersProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}
