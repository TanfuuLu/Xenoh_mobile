import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FeatureScreenFrame(
      title: l10n.marketingAboutTitle,
      children: [
        FeatureHeader(
          title: l10n.marketingBuiltForTitle,
          subtitle: l10n.marketingBuiltForSubtitle,
          icon: Icons.info_outline_rounded,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.marketingIndividualsTitle,
          style: AppTypography.display(20),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.marketingIndividualsBody,
          style: const TextStyle(color: AppColors.fg2, height: 1.45),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.marketingCoachesTitle, style: AppTypography.display(20)),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.marketingCoachesBody,
          style: const TextStyle(color: AppColors.fg2, height: 1.45),
        ),
        const SizedBox(height: AppSpacing.xl),
        XnButton(
          label: l10n.subscriptionTitle,
          icon: Icons.workspace_premium_outlined,
          onPressed: () => unawaited(context.push('/subscription')),
        ),
        const SizedBox(height: AppSpacing.sm),
        XnButton(
          label: l10n.marketingCreateAccountCta,
          variant: XnButtonVariant.secondary,
          onPressed: () => unawaited(context.push('/register')),
        ),
      ],
    );
  }
}
