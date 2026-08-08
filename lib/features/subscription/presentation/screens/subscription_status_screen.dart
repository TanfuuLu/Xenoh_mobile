import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../providers/subscription_controllers.dart';
import '../providers/tier_labels.dart';
import '../widgets/subscription_checkout_section.dart';

class SubscriptionStatusScreen extends ConsumerWidget {
  const SubscriptionStatusScreen({super.key});

  static const termsCheckboxKey = SubscriptionCheckoutSection.termsCheckboxKey;
  static const promotionInputKey =
      SubscriptionCheckoutSection.promotionInputKey;
  static const applyPromotionKey =
      SubscriptionCheckoutSection.applyPromotionKey;

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
        const SizedBox(height: AppSpacing.xl),
        const SubscriptionCheckoutSection(),
      ],
    );
  }
}
