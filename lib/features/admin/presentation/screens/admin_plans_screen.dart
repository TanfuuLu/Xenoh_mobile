import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final adminPlansProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  return ref.watch(xenohApiProvider).getList('/admin/plans');
});

class AdminPlansScreen extends ConsumerWidget {
  const AdminPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plans = ref.watch(adminPlansProvider);
    return FeatureScreenFrame(
      title: l10n.adminPlansLabel,
      onRefresh: () => ref.refresh(adminPlansProvider.future),
      children: [
        FeatureHeader(
          title: l10n.adminPlatformPlansTitle,
          subtitle: l10n.adminPlatformPlansSubtitle,
          icon: Icons.calendar_month_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (plans) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.adminNoPlansTitle,
            message: l10n.adminNoPlansMessage,
          ),
          AsyncData(:final value) => XnCardStack(
            children: [
              for (final item in value)
                DataCard(
                  title: textOf(item, ['name']),
                  subtitle: textOf(item, ['ownerName', 'ownerEmail']),
                  meta: [
                    textOf(item, ['planType']),
                    l10n.adminDaysProgressLabel(
                      textOf(item, ['completedDays']),
                      textOf(item, ['totalDays']),
                    ),
                    l10n.adminVolumeValueLabel(textOf(item, ['totalVolume'])),
                  ],
                  onTap: () =>
                      context.push('/admin/plans/${item['id']}/analytics'),
                ),
            ],
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(adminPlansProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}
