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
    this.intro,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<LegalSection> sections;
  final String? intro;
}

LegalPageContent legalPageContent(LegalPageKind kind, AppLocalizations l10n) =>
    switch (kind) {
      LegalPageKind.privacy => LegalPageContent(
        title: l10n.legalPrivacyTitle,
        subtitle: l10n.legalLastUpdated,
        icon: Icons.privacy_tip_outlined,
        intro: l10n.legalPrivacyIntro,
        sections: [
          LegalSection(
            title: l10n.legalPrivacyWhatWeCollectTitle,
            body: l10n.legalPrivacyWhatWeCollectBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyHowWeUseTitle,
            body: l10n.legalPrivacyHowWeUseBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyCoachSharingTitle,
            body: l10n.legalPrivacyCoachSharingBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyAiAnalysisTitle,
            body: l10n.legalPrivacyAiAnalysisBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyProvidersTitle,
            body: l10n.legalPrivacyProvidersBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyRetentionDeletionTitle,
            body: l10n.legalPrivacyRetentionDeletionBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyCookiesTitle,
            body: l10n.legalPrivacyCookiesBody,
          ),
          LegalSection(
            title: l10n.legalPrivacySecurityTitle,
            body: l10n.legalPrivacySecurityBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyMinorsTitle,
            body: l10n.legalPrivacyMinorsBody,
          ),
          LegalSection(
            title: l10n.legalPrivacyRightsContactTitle,
            body: l10n.legalPrivacyRightsContactBody,
          ),
        ],
      ),
      LegalPageKind.terms => LegalPageContent(
        title: l10n.legalTermsTitle,
        subtitle: l10n.legalLastUpdated,
        icon: Icons.description_outlined,
        intro: l10n.legalTermsIntro,
        sections: [
          LegalSection(
            title: l10n.legalTermsAccountTitle,
            body: l10n.legalTermsAccountBody,
          ),
          LegalSection(
            title: l10n.legalTermsPlansBillingTitle,
            body: l10n.legalTermsPlansBillingBody,
          ),
          LegalSection(
            title: l10n.legalTermsAcceptableUseTitle,
            body: l10n.legalTermsAcceptableUseBody,
          ),
          LegalSection(
            title: l10n.legalTermsCommunityContentTitle,
            body: l10n.legalTermsCommunityContentBody,
          ),
          LegalSection(
            title: l10n.legalTermsHealthDisclaimerTitle,
            body: l10n.legalTermsHealthDisclaimerBody,
          ),
          LegalSection(
            title: l10n.legalTermsCoachClientTitle,
            body: l10n.legalTermsCoachClientBody,
          ),
          LegalSection(
            title: l10n.legalTermsOwnershipTitle,
            body: l10n.legalTermsOwnershipBody,
          ),
          LegalSection(
            title: l10n.legalTermsAvailabilityTitle,
            body: l10n.legalTermsAvailabilityBody,
          ),
          LegalSection(
            title: l10n.legalTermsLiabilityTitle,
            body: l10n.legalTermsLiabilityBody,
          ),
          LegalSection(
            title: l10n.legalTermsTerminationTitle,
            body: l10n.legalTermsTerminationBody,
          ),
          LegalSection(
            title: l10n.legalTermsContactTitle,
            body: l10n.legalTermsContactBody,
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
        if (content.intro != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            content.intro!,
            style: const TextStyle(color: AppColors.fg2, height: 1.55),
          ),
        ],
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
        if (kind == LegalPageKind.refund) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.legalDisclaimerMessage,
            style: const TextStyle(color: AppColors.fg3, height: 1.45),
          ),
        ],
      ],
    );
  }
}

class LegalSection {
  const LegalSection({required this.title, required this.body});

  final String title;
  final String body;
}
