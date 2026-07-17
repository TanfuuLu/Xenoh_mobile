import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../l10n/app_localizations.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icon/banner_logo_xenoh.png',
                  width: 164,
                  height: 38,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => unawaited(context.push('/about')),
                  child: Text(l10n.marketingAboutNavLabel),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xxl,
                AppSpacing.xl,
                AppSpacing.xxl,
              ),
              decoration: BoxDecoration(
                color: AppColors.ink900,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowDeep,
                    blurRadius: 28,
                    offset: Offset(0, 14),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -62,
                    bottom: -82,
                    child: Opacity(
                      opacity: 0.07,
                      child: Image.asset(
                        'assets/icon/logo_xenoh_transparent.png',
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.marketingHeroTitle,
                        style: AppTypography.display(
                          42,
                          weight: FontWeight.w700,
                          color: AppColors.fgOnClay,
                          letterSpacing: -0.9,
                          height: 1.02,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Text(
                          l10n.marketingHeroSubtitle,
                          style: const TextStyle(
                            color: AppColors.ink300,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      XnButton(
                        label: l10n.marketingCreateAccountCta,
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () => unawaited(context.push('/register')),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      XnButton(
                        label: l10n.marketingSignInCta,
                        variant: XnButtonVariant.secondary,
                        onPressed: () => unawaited(context.push('/login')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            _FeatureCard(
              index: '01',
              icon: Icons.fitness_center_rounded,
              title: l10n.marketingFeatureWorkoutTitle,
              body: l10n.marketingFeatureWorkoutBody,
            ),
            const SizedBox(height: AppSpacing.sm),
            _FeatureCard(
              index: '02',
              icon: Icons.restaurant_menu_rounded,
              title: l10n.marketingFeatureNutritionTitle,
              body: l10n.marketingFeatureNutritionBody,
            ),
            const SizedBox(height: AppSpacing.sm),
            _FeatureCard(
              index: '03',
              icon: Icons.supervisor_account_rounded,
              title: l10n.marketingFeatureCoachTitle,
              body: l10n.marketingFeatureCoachBody,
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                TextButton(
                  onPressed: () => unawaited(context.push('/privacy')),
                  child: Text(l10n.marketingPrivacyNavLabel),
                ),
                TextButton(
                  onPressed: () => unawaited(context.push('/account-deletion')),
                  child: Text(l10n.accountDeletionSettingsLabel),
                ),
                TextButton(
                  onPressed: () => unawaited(context.push('/terms')),
                  child: Text(l10n.marketingTermsNavLabel),
                ),
                TextButton(
                  onPressed: () => unawaited(context.push('/refund-policy')),
                  child: Text(l10n.marketingRefundsNavLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.index,
    required this.icon,
    required this.title,
    required this.body,
  });

  final String index;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.clay100,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, color: AppColors.clay900, size: 21),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  body,
                  style: const TextStyle(color: AppColors.fg3, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
