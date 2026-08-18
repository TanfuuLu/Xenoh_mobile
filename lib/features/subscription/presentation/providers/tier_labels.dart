import '../../../../l10n/app_localizations.dart';

/// Human label for a `PlanTier` name from the API.
///
/// Matched case- and whitespace-insensitively for the same reason
/// `Subscription.isPro` is: the tier string originates from a purchase made
/// outside the app. An unrecognised tier falls back to the raw server value
/// rather than mislabelling the plan.
String tierLabel(String tier, AppLocalizations l10n) =>
    switch (tier.trim().toLowerCase()) {
      'proindividual' => l10n.subscriptionTierProIndividual,
      'procoach' => l10n.subscriptionTierProCoach,
      'free' => l10n.subscriptionTierFree,
      _ => tier,
    };
