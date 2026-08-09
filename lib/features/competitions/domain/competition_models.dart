class CompetitionSummary {
  const CompetitionSummary({
    required this.id,
    required this.slug,
    required this.title,
    required this.discipline,
    required this.status,
    required this.venueName,
    required this.address,
    required this.startsAtUtc,
    required this.endsAtUtc,
    required this.registrationFee,
    required this.currency,
    required this.capacity,
    required this.confirmedCount,
  });

  factory CompetitionSummary.fromJson(Map<String, dynamic> json) =>
      CompetitionSummary(
        id: json['id'].toString(),
        slug: json['slug']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        discipline: json['discipline']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        venueName: json['venueName']?.toString() ?? '',
        address: json['address']?.toString() ?? '',
        startsAtUtc: DateTime.parse(json['startsAtUtc'].toString()),
        endsAtUtc: DateTime.parse(json['endsAtUtc'].toString()),
        registrationFee: (json['registrationFee'] as num?)?.toDouble() ?? 0,
        currency: json['currency']?.toString() ?? '',
        capacity: (json['capacity'] as num?)?.toInt() ?? 0,
        confirmedCount: (json['confirmedCount'] as num?)?.toInt() ?? 0,
      );

  final String id;
  final String slug;
  final String title;
  final String discipline;
  final String status;
  final String venueName;
  final String address;
  final DateTime startsAtUtc;
  final DateTime endsAtUtc;
  final double registrationFee;
  final String currency;
  final int capacity;
  final int confirmedCount;
}

class CompetitionEventInput {
  const CompetitionEventInput({
    required this.title,
    required this.description,
    required this.discipline,
    required this.venueName,
    required this.address,
    required this.timeZoneId,
    required this.startsAtUtc,
    required this.endsAtUtc,
    required this.registrationOpensAtUtc,
    required this.registrationClosesAtUtc,
    required this.capacity,
    required this.registrationFee,
    required this.currency,
    required this.organizerContact,
    required this.powerliftingScoringFormula,
    this.bannerUrl,
    this.bankName,
    this.bankAccountNumber,
    this.bankAccountName,
    this.transferInstructions,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'bannerUrl': bannerUrl,
    'discipline': discipline,
    'venueName': venueName,
    'address': address,
    'timeZoneId': timeZoneId,
    'startsAtUtc': startsAtUtc.toUtc().toIso8601String(),
    'endsAtUtc': endsAtUtc.toUtc().toIso8601String(),
    'registrationOpensAtUtc': registrationOpensAtUtc.toUtc().toIso8601String(),
    'registrationClosesAtUtc': registrationClosesAtUtc
        .toUtc()
        .toIso8601String(),
    'capacity': capacity,
    'registrationFee': registrationFee,
    'currency': currency,
    'organizerContact': organizerContact,
    'bankName': bankName,
    'bankAccountNumber': bankAccountNumber,
    'bankAccountName': bankAccountName,
    'transferInstructions': transferInstructions,
    'powerliftingScoringFormula': powerliftingScoringFormula,
  };

  final String title;
  final String description;
  final String? bannerUrl;
  final String discipline;
  final String venueName;
  final String address;
  final String timeZoneId;
  final DateTime startsAtUtc;
  final DateTime endsAtUtc;
  final DateTime registrationOpensAtUtc;
  final DateTime registrationClosesAtUtc;
  final int capacity;
  final double registrationFee;
  final String currency;
  final String organizerContact;
  final String? bankName;
  final String? bankAccountNumber;
  final String? bankAccountName;
  final String? transferInstructions;
  final String powerliftingScoringFormula;
}

class CompetitionEvent extends CompetitionSummary {
  const CompetitionEvent({
    required super.id,
    required super.slug,
    required super.title,
    required super.discipline,
    required super.status,
    required super.venueName,
    required super.address,
    required super.startsAtUtc,
    required super.endsAtUtc,
    required super.registrationFee,
    required super.currency,
    required super.capacity,
    required super.confirmedCount,
    required this.description,
    required this.timeZoneId,
    required this.categories,
    required this.registrationOpensAtUtc,
    required this.registrationClosesAtUtc,
    required this.organizerContact,
    required this.powerliftingScoringFormula,
    required this.canManage,
    this.bankName,
    this.bankAccountNumber,
    this.bankAccountName,
    this.transferInstructions,
    this.cancellationReason,
    this.resultsPublishedAt,
  });

  factory CompetitionEvent.fromJson(Map<String, dynamic> json) {
    final summary = CompetitionSummary.fromJson(json);
    return CompetitionEvent(
      id: summary.id,
      slug: summary.slug,
      title: summary.title,
      discipline: summary.discipline,
      status: summary.status,
      venueName: summary.venueName,
      address: summary.address,
      startsAtUtc: summary.startsAtUtc,
      endsAtUtc: summary.endsAtUtc,
      registrationFee: summary.registrationFee,
      currency: summary.currency,
      capacity: summary.capacity,
      confirmedCount: summary.confirmedCount,
      description: json['description']?.toString() ?? '',
      timeZoneId: json['timeZoneId']?.toString() ?? '',
      registrationOpensAtUtc: DateTime.tryParse(
        json['registrationOpensAtUtc']?.toString() ?? '',
      ),
      registrationClosesAtUtc: DateTime.tryParse(
        json['registrationClosesAtUtc']?.toString() ?? '',
      ),
      organizerContact: json['organizerContact']?.toString() ?? '',
      bankName: json['bankName']?.toString(),
      bankAccountNumber: json['bankAccountNumber']?.toString(),
      bankAccountName: json['bankAccountName']?.toString(),
      transferInstructions: json['transferInstructions']?.toString(),
      powerliftingScoringFormula:
          json['powerliftingScoringFormula']?.toString() ?? 'Dots',
      canManage: json['canManage'] == true,
      cancellationReason: json['cancellationReason']?.toString(),
      resultsPublishedAt: DateTime.tryParse(
        json['resultsPublishedAt']?.toString() ?? '',
      ),
      categories: (json['categories'] as List<dynamic>? ?? const [])
          .map(
            (item) =>
                CompetitionCategory.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String description;
  final String timeZoneId;
  final DateTime? registrationOpensAtUtc;
  final DateTime? registrationClosesAtUtc;
  final String organizerContact;
  final String? bankName;
  final String? bankAccountNumber;
  final String? bankAccountName;
  final String? transferInstructions;
  final String powerliftingScoringFormula;
  final bool canManage;
  final String? cancellationReason;
  final DateTime? resultsPublishedAt;
  final List<CompetitionCategory> categories;
}

class CompetitionCategory {
  const CompetitionCategory({
    required this.id,
    required this.code,
    required this.name,
    required this.capacity,
    required this.displayOrder,
    this.eligibilityNotes,
  });
  factory CompetitionCategory.fromJson(Map<String, dynamic> json) =>
      CompetitionCategory(
        id: json['id'].toString(),
        code: json['code']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        capacity: (json['capacity'] as num?)?.toInt() ?? 0,
        displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
        eligibilityNotes: json['eligibilityNotes']?.toString(),
      );
  final String id;
  final String code;
  final String name;
  final int capacity;
  final int displayOrder;
  final String? eligibilityNotes;
}

class CompetitionRegistration {
  const CompetitionRegistration({
    required this.id,
    required this.eventId,
    required this.eventTitle,
    required this.eventSlug,
    required this.categoryName,
    required this.athleteName,
    required this.contactEmail,
    required this.status,
    required this.paymentStatus,
    required this.isConfirmed,
    required this.expectedFee,
    required this.currency,
    required this.submittedAt,
    this.categoryId,
    this.userId,
    this.contactPhone,
    this.contactFacebook,
    this.dateOfBirth,
    this.sex,
    this.declaredWeightKg,
    this.declaredHeightCm,
    this.receipts = const [],
    this.decisionReason,
  });
  factory CompetitionRegistration.fromJson(Map<String, dynamic> json) =>
      CompetitionRegistration(
        id: json['id'].toString(),
        eventId: json['eventId'].toString(),
        eventTitle: json['eventTitle']?.toString() ?? '',
        eventSlug: json['eventSlug']?.toString() ?? '',
        categoryName: json['categoryName']?.toString() ?? '',
        athleteName: json['athleteName']?.toString() ?? '',
        contactEmail: json['contactEmail']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        paymentStatus: json['paymentStatus']?.toString() ?? '',
        isConfirmed: json['isConfirmed'] == true,
        expectedFee: (json['expectedFee'] as num?)?.toDouble() ?? 0,
        currency: json['currency']?.toString() ?? '',
        submittedAt: DateTime.parse(json['submittedAt'].toString()),
        categoryId: json['categoryId']?.toString(),
        userId: json['userId']?.toString(),
        contactPhone: json['contactPhone']?.toString(),
        contactFacebook: json['contactFacebook']?.toString(),
        dateOfBirth: DateTime.tryParse(json['dateOfBirth']?.toString() ?? ''),
        sex: json['sex']?.toString(),
        declaredWeightKg: (json['declaredWeightKg'] as num?)?.toDouble(),
        declaredHeightCm: (json['declaredHeightCm'] as num?)?.toDouble(),
        receipts: (json['receipts'] as List<dynamic>? ?? const [])
            .map(
              (item) =>
                  CompetitionReceipt.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        decisionReason: json['decisionReason']?.toString(),
      );
  final String id;
  final String eventId;
  final String eventTitle;
  final String eventSlug;
  final String categoryName;
  final String athleteName;
  final String contactEmail;
  final String status;
  final String paymentStatus;
  final bool isConfirmed;
  final double expectedFee;
  final String currency;
  final DateTime submittedAt;
  final String? categoryId;
  final String? userId;
  final String? contactPhone;
  final String? contactFacebook;
  final DateTime? dateOfBirth;
  final String? sex;
  final double? declaredWeightKg;
  final double? declaredHeightCm;
  final List<CompetitionReceipt> receipts;
  final String? decisionReason;
}

class CompetitionReceipt {
  const CompetitionReceipt({
    required this.id,
    required this.fileName,
    required this.contentType,
    required this.sizeBytes,
    required this.status,
    required this.createdAt,
    this.reviewedAt,
    this.rejectionReason,
  });

  factory CompetitionReceipt.fromJson(Map<String, dynamic> json) =>
      CompetitionReceipt(
        id: json['id'].toString(),
        fileName: json['fileName']?.toString() ?? '',
        contentType: json['contentType']?.toString() ?? '',
        sizeBytes: (json['sizeBytes'] as num?)?.toInt() ?? 0,
        status: json['status']?.toString() ?? '',
        createdAt: DateTime.parse(json['createdAt'].toString()),
        reviewedAt: DateTime.tryParse(json['reviewedAt']?.toString() ?? ''),
        rejectionReason: json['rejectionReason']?.toString(),
      );

  final String id;
  final String fileName;
  final String contentType;
  final int sizeBytes;
  final String status;
  final DateTime createdAt;
  final DateTime? reviewedAt;
  final String? rejectionReason;
}

class OrganizerProfile {
  const OrganizerProfile({
    required this.id,
    required this.organizationName,
    required this.contactEmail,
    required this.contactPhone,
    required this.status,
    this.websiteUrl,
    this.notes,
    this.evidenceFileId,
    this.reviewedAt,
    this.reviewReason,
  });

  factory OrganizerProfile.fromJson(Map<String, dynamic> json) =>
      OrganizerProfile(
        id: json['id'].toString(),
        organizationName: json['organizationName']?.toString() ?? '',
        contactEmail: json['contactEmail']?.toString() ?? '',
        contactPhone: json['contactPhone']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        websiteUrl: json['websiteUrl']?.toString(),
        notes: json['notes']?.toString(),
        evidenceFileId: json['evidenceFileId']?.toString(),
        reviewedAt: DateTime.tryParse(json['reviewedAt']?.toString() ?? ''),
        reviewReason: json['reviewReason']?.toString(),
      );

  final String id;
  final String organizationName;
  final String contactEmail;
  final String contactPhone;
  final String status;
  final String? websiteUrl;
  final String? notes;
  final String? evidenceFileId;
  final DateTime? reviewedAt;
  final String? reviewReason;

  bool get isApproved => status == 'Approved';
}
