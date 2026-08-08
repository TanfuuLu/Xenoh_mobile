class SubscriptionCatalog {
  const SubscriptionCatalog({
    required this.termsVersion,
    required this.offers,
  });

  factory SubscriptionCatalog.fromJson(Map<String, dynamic> json) =>
      SubscriptionCatalog(
        termsVersion: json['termsVersion'] as String? ?? '',
        offers: (json['offers'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(SubscriptionOffer.fromJson)
            .toList(growable: false),
      );

  final String termsVersion;
  final List<SubscriptionOffer> offers;
}

class SubscriptionOffer {
  const SubscriptionOffer({
    required this.tier,
    required this.durationMonths,
    required this.price,
    required this.currency,
    required this.isPrepaid,
    required this.automaticallyRenews,
    required this.hasUnlimitedClients,
  });

  factory SubscriptionOffer.fromJson(Map<String, dynamic> json) =>
      SubscriptionOffer(
        tier: json['tier'] as String? ?? '',
        durationMonths: (json['durationMonths'] as num?)?.toInt() ?? 0,
        price: json['price'] as num? ?? 0,
        currency: json['currency'] as String? ?? 'VND',
        isPrepaid: json['isPrepaid'] as bool? ?? true,
        automaticallyRenews: json['automaticallyRenews'] as bool? ?? false,
        hasUnlimitedClients: json['hasUnlimitedClients'] as bool? ?? false,
      );

  final String tier;
  final int durationMonths;
  final num price;
  final String currency;
  final bool isPrepaid;
  final bool automaticallyRenews;
  final bool hasUnlimitedClients;
}

class PromotionValidation {
  const PromotionValidation({
    required this.valid,
    required this.discountValue,
    this.message,
    this.code,
    this.discountType,
    this.appliesToTier,
    this.originalAmount,
    this.discountAmount,
    this.finalAmount,
  });

  factory PromotionValidation.fromJson(Map<String, dynamic> json) =>
      PromotionValidation(
        valid: json['valid'] as bool? ?? false,
        message: json['message'] as String?,
        code: json['code'] as String?,
        discountType: json['discountType'] as String?,
        discountValue: json['discountValue'] as num? ?? 0,
        appliesToTier: json['appliesToTier'] as String?,
        originalAmount: json['originalAmount'] as num?,
        discountAmount: json['discountAmount'] as num?,
        finalAmount: json['finalAmount'] as num?,
      );

  final bool valid;
  final String? message;
  final String? code;
  final String? discountType;
  final num discountValue;
  final String? appliesToTier;
  final num? originalAmount;
  final num? discountAmount;
  final num? finalAmount;
}

class CreatePaymentOrderInput {
  const CreatePaymentOrderInput({
    required this.requestedTier,
    required this.durationMonths,
    required this.termsVersion,
    this.promotionCode,
  });

  final String requestedTier;
  final int durationMonths;
  final String termsVersion;
  final String? promotionCode;

  Map<String, dynamic> toJson() => {
    'requestedTier': requestedTier,
    'durationMonths': durationMonths,
    if (promotionCode case final code? when code.isNotEmpty)
      'promotionCode': code,
    'acceptedTerms': true,
    'termsVersion': termsVersion,
  };
}

class PaymentOrder {
  const PaymentOrder({
    required this.orderId,
    required this.transferCode,
    required this.amount,
    required this.originalAmount,
    required this.discountAmount,
    required this.durationMonths,
    required this.requestedTier,
    required this.expiresAt,
    required this.bankAccountNumber,
    required this.bankAccountName,
    required this.bankName,
    required this.transferDescription,
    this.promotionCode,
  });

  factory PaymentOrder.fromJson(Map<String, dynamic> json) => PaymentOrder(
    orderId: json['orderId'] as String? ?? '',
    transferCode: json['transferCode'] as String? ?? '',
    amount: json['amount'] as num? ?? 0,
    originalAmount: json['originalAmount'] as num? ?? 0,
    discountAmount: json['discountAmount'] as num? ?? 0,
    promotionCode: json['promotionCode'] as String?,
    durationMonths: (json['durationMonths'] as num?)?.toInt() ?? 0,
    requestedTier: json['requestedTier'] as String? ?? '',
    expiresAt:
        DateTime.tryParse(json['expiresAt'] as String? ?? '')?.toLocal() ??
        DateTime.fromMillisecondsSinceEpoch(0),
    bankAccountNumber: json['bankAccountNumber'] as String? ?? '',
    bankAccountName: json['bankAccountName'] as String? ?? '',
    bankName: json['bankName'] as String? ?? '',
    transferDescription: json['transferDescription'] as String? ?? '',
  );

  final String orderId;
  final String transferCode;
  final num amount;
  final num originalAmount;
  final num discountAmount;
  final String? promotionCode;
  final int durationMonths;
  final String requestedTier;
  final DateTime expiresAt;
  final String bankAccountNumber;
  final String bankAccountName;
  final String bankName;
  final String transferDescription;
}
