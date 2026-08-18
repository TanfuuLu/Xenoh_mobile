import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../providers/subscription_controllers.dart';
import '../providers/tier_labels.dart';

/// Read-only view of the server-authoritative subscription.
///
/// The mobile client never sells anything: it has no offer catalog, promotion
/// code, payment order, or checkout link. Entitlements are granted elsewhere
/// and surface here only as current tier, expiry, and AI quota.
class SubscriptionStatusScreen extends ConsumerWidget {
  const SubscriptionStatusScreen({super.key});

  static const statusGridKey = ValueKey('subscription-status-grid');
  static const refreshButtonKey = ValueKey('subscription-refresh');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subscription = ref.watch(subscriptionProvider);
    return FeatureScreenFrame(
      title: l10n.subscriptionTitle,
      onRefresh: () async => ref.invalidate(subscriptionProvider),
      children: [
        FeatureHeader(
          title: l10n.subscriptionCurrentPlanLabel,
          subtitle: l10n.subscriptionUnlockMessage,
          icon: Icons.workspace_premium_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (subscription) {
          AsyncData(:final value) => KeyValueGrid(
            key: statusGridKey,
            items: {
              l10n.subscriptionTitle: tierLabel(value.tier, l10n),
              l10n.subscriptionExpiresLabel: value.expiresAt == null
                  ? l10n.subscriptionNoExpiryLabel
                  : value.expiresAt!.toLocal().toString().split(' ').first,
              l10n.subscriptionAiRequestsThisMonthLabel:
                  '${value.aiQuota.remainingRequests}/${value.aiQuota.monthlyLimit}',
            },
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(subscriptionProvider),
          ),
          _ => const LoadingList(),
        },
        const SizedBox(height: AppSpacing.lg),
        // Entitlements are granted outside the app, so an explicit control
        // matters: pull-to-refresh alone is not discoverable enough for a
        // user whose plan has just changed. Deliberately unlabelled as to
        // where a plan is bought — the app must not steer to a purchase.
        Align(
          alignment: Alignment.centerLeft,
          child: XnButton(
            key: refreshButtonKey,
            label: l10n.commonRefresh,
            variant: XnButtonVariant.secondary,
            onPressed: () => ref.invalidate(subscriptionProvider),
          ),
        ),
      ],
    );
  }
}
