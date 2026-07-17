import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../core/widgets/pro_locked_view.dart';
import '../../core/widgets/xn_button.dart';
import '../../core/widgets/xn_card.dart';
import '../../l10n/app_localizations.dart';
import 'api_widgets.dart';

/// Maps an error from a thin AI provider (raw `DioException`, since the AI
/// screens call `XenohApi` directly) to the right state:
///   - 403 → Pro upgrade prompt (feature is Pro-gated).
///   - 429 → AI quota-exhausted notice (try again later).
///   - else → generic retryable error.
///
/// Keeps AI features from ever appearing as a silent/broken screen.
class AiErrorView extends StatelessWidget {
  const AiErrorView({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final error = this.error;
    final status = error is DioException ? error.response?.statusCode : null;

    if (status == 403) {
      return ProLockedView(
        title: l10n.aiErrorProFeatureTitle,
        message: l10n.aiErrorProFeatureMessage,
        onUpgrade: () => context.push('/subscription'),
      );
    }
    if (status == 429) {
      return AiQuotaNotice(onRetry: onRetry);
    }
    return FeatureError(error: error, onRetry: onRetry);
  }
}

/// Quota-exhausted card (HTTP 429 from an `rate:ai` endpoint). Distinct from a
/// failure: the request was valid, the user is just out of AI runs for now.
class AiQuotaNotice extends StatelessWidget {
  const AiQuotaNotice({this.onRetry, super.key});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.hourglass_bottom_rounded,
                color: AppColors.warning,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.aiQuotaLimitReachedTitle,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.aiQuotaLimitReachedMessage,
            style: const TextStyle(color: AppColors.fg2),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              if (onRetry != null)
                XnButton(
                  label: l10n.aiTryAgainButton,
                  icon: Icons.refresh_rounded,
                  variant: XnButtonVariant.secondary,
                  onPressed: onRetry,
                ),
              if (onRetry != null) const SizedBox(width: AppSpacing.sm),
              XnButton(
                label: l10n.aiUpgradeButton,
                icon: Icons.bolt_rounded,
                variant: XnButtonVariant.ghost,
                onPressed: () => context.push('/subscription'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// True when [error] is an AI-gate response (403 Pro-required / 429 quota),
/// so callers (e.g. inline AI actions) can choose a softer message.
({bool isPro, bool isQuota}) aiGate(Object error) {
  final status = error is DioException ? error.response?.statusCode : null;
  return (isPro: status == 403, isQuota: status == 429);
}
