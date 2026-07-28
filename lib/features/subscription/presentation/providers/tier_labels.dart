import '../../../../l10n/app_localizations.dart';

/// Human label for a `PlanTier` name from the API.
String tierLabel(String tier, AppLocalizations l10n) => switch (tier) {
  'ProIndividual' => l10n.subscriptionTierProIndividual,
  'ProCoach' => l10n.subscriptionTierProCoach,
  'Free' => l10n.subscriptionTierFree,
  _ => tier,
};
