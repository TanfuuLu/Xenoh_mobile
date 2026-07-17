import '../../../../l10n/app_localizations.dart';
import '../../../auth/domain/entities/user.dart';

/// The Pro tiers displayed on the public Xenoh website and reflected in app
/// subscription status responses.
enum PurchasableTier {
  proIndividual('ProIndividual'),
  proCoach('ProCoach');

  const PurchasableTier(this.apiName);

  final String apiName;

  /// The tier most relevant to [user] (coaches default to Pro Coach).
  static PurchasableTier defaultFor(User? user) =>
      (user?.isCoach ?? false) ? proCoach : proIndividual;
}

/// Localized display label for a [PurchasableTier].
String purchasableTierLabel(PurchasableTier tier, AppLocalizations l10n) =>
    switch (tier) {
      PurchasableTier.proIndividual => l10n.subscriptionTierProIndividual,
      PurchasableTier.proCoach => l10n.subscriptionTierProCoach,
    };

/// Localized tagline for a [PurchasableTier].
String purchasableTierTagline(PurchasableTier tier, AppLocalizations l10n) =>
    switch (tier) {
      PurchasableTier.proIndividual =>
        l10n.subscriptionTierProIndividualTagline,
      PurchasableTier.proCoach => l10n.subscriptionTierProCoachTagline,
    };

/// Benefit bullets for a [PurchasableTier], most-relevant first. Pro Coach
/// includes everything in Pro Individual plus the coaching tools. Shared by the
/// marketing pricing page and the in-app subscription picker.
List<String> purchasableTierFeatures(
  PurchasableTier tier,
  AppLocalizations l10n,
) {
  final shared = [
    l10n.marketingFeatureAiInsights,
    l10n.marketingFeaturePlanAnalytics,
    l10n.marketingFeatureNutritionInsight,
  ];
  if (tier == PurchasableTier.proIndividual) return shared;
  return [
    ...shared,
    l10n.marketingFeatureClientManagement,
    l10n.marketingFeatureClientPlans,
  ];
}

/// Selectable subscription durations, in months.
const kDurationOptions = [1, 3, 6, 12];

/// Indicative VND pricing displayed by the public website. The mobile app does
/// not create or process subscription payments.
const _priceTable = <PurchasableTier, Map<int, int>>{
  PurchasableTier.proIndividual: {
    1: 100000,
    3: 300000,
    6: 600000,
    12: 1200000,
  },
  PurchasableTier.proCoach: {
    1: 199000,
    3: 597000,
    6: 1194000,
    12: 2388000,
  },
};

/// Indicative total price (VND) for [tier] over [months]; 0 if unknown.
int priceFor(PurchasableTier tier, int months) =>
    _priceTable[tier]?[months] ?? 0;

/// Monthly-equivalent price (VND) for [tier] over [months].
int monthlyPriceFor(PurchasableTier tier, int months) {
  final total = priceFor(tier, months);
  return months <= 0 ? total : (total / months).round();
}

/// Percentage saved vs. paying monthly (0 for the 1-month option).
int savingsPercentFor(PurchasableTier tier, int months) {
  final monthly = priceFor(tier, 1);
  if (monthly <= 0 || months <= 1) return 0;
  final straight = monthly * months;
  final actual = priceFor(tier, months);
  if (straight <= 0 || actual >= straight) return 0;
  return ((1 - actual / straight) * 100).round();
}

/// Formats a VND amount with dot thousands separators, e.g. `1.788.000 ₫`.
String formatVnd(num amount) {
  final digits = amount.round().abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return '$buffer ₫';
}

/// Human label for a `PlanTier` name from the API.
String tierLabel(String tier, AppLocalizations l10n) => switch (tier) {
  'ProIndividual' => l10n.subscriptionTierProIndividual,
  'ProCoach' => l10n.subscriptionTierProCoach,
  'Free' => l10n.subscriptionTierFree,
  _ => tier,
};

/// `"1 month"` / `"3 months"`.
String monthsLabel(int months, AppLocalizations l10n) =>
    l10n.subscriptionMonthsLabel(months);
