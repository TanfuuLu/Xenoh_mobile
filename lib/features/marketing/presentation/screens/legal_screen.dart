import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';

enum LegalPageKind { privacy, terms, refund }

class LegalPageContent {
  const LegalPageContent({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.sections,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<LegalSection> sections;
}

LegalPageContent legalPageContent(LegalPageKind kind, AppLocalizations l10n) =>
    switch (kind) {
      LegalPageKind.privacy => LegalPageContent(
        title: l10n.legalPrivacyTitle,
        subtitle: l10n.legalPrivacySubtitle,
        icon: Icons.privacy_tip_outlined,
        sections: [
          LegalSection(
            title: l10n.legalPrivacyDataWeUseTitle,
            body: l10n.legalPrivacyDataWeUseBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyCoachingVisibilityTitle,
            body: l10n.legalPrivacyCoachingVisibilityBody,
          ),
          LegalSection(
            title: l10n.legalPrivacySecurityTitle,
            body: l10n.legalPrivacySecurityBody,
          ),
        ],
      ),
      LegalPageKind.terms => LegalPageContent(
        title: l10n.legalTermsTitle,
        subtitle: l10n.legalTermsSubtitle,
        icon: Icons.description_outlined,
        sections: [
          LegalSection(
            title: l10n.legalTermsTrainingResponsibilityTitle,
            body: l10n.legalTermsTrainingResponsibilityBody,
          ),
          LegalSection(
            title: l10n.legalTermsAccountAccessTitle,
            body: l10n.legalTermsAccountAccessBody,
          ),
          LegalSection(
            title: l10n.legalTermsAiLimitsTitle,
            body: l10n.legalTermsAiLimitsBody,
          ),
          LegalSection(
            title: l10n.legalTermsCommunityContentTitle,
            body: l10n.legalTermsCommunityContentBody,
          ),
        ],
      ),
      LegalPageKind.refund => LegalPageContent(
        title: l10n.legalRefundTitle,
        subtitle: l10n.legalRefundSubtitle,
        icon: Icons.receipt_long_outlined,
        sections: [
          LegalSection(
            title: l10n.legalRefundSubscriptionAccessTitle,
            body: l10n.legalRefundSubscriptionAccessBody,
          ),
          LegalSection(
            title: l10n.legalRefundReviewProcessTitle,
            body: l10n.legalRefundReviewProcessBody,
          ),
          LegalSection(
            title: l10n.legalRefundAccessChangesTitle,
            body: l10n.legalRefundAccessChangesBody,
          ),
        ],
      ),
    };

class LegalScreen extends StatelessWidget {
  const LegalScreen({required this.kind, super.key});

  final LegalPageKind kind;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final content = legalPageContent(kind, l10n);
    return FeatureScreenFrame(
      title: content.title,
      children: [
        FeatureHeader(
          title: content.title,
          subtitle: content.subtitle,
          icon: content.icon,
        ),
        const SizedBox(height: AppSpacing.lg),
        XnCardStack(
          children: [
            for (final section in content.sections)
              XnSection(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.title, style: AppTypography.display(20)),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      section.body,
                      style: const TextStyle(
                        color: AppColors.fg2,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.legalDisclaimerMessage,
          style: const TextStyle(color: AppColors.fg3, height: 1.45),
        ),
      ],
    );
  }
}

class LegalSection {
  const LegalSection({required this.title, required this.body});

  final String title;
  final String body;
}
