import 'competition_models.dart';

abstract interface class CompetitionRepository {
  Future<List<CompetitionSummary>> list({String? discipline});
  Future<CompetitionEvent> getBySlug(String slug);
  Future<List<CompetitionRegistration>> mine();
  Future<CompetitionRegistration> register({
    required String eventId,
    required String categoryId,
    required String contactEmail,
    required String contactPhone,
    String? contactFacebook,
  });
  Future<void> withdraw(String eventId);
  Future<void> uploadReceipt(String eventId, String filePath);
  Future<OrganizerProfile?> getOrganizerProfile();
  Future<List<CompetitionSummary>> getManagedEvents();
  Future<OrganizerProfile> applyAsOrganizer({
    required String organizationName,
    required String contactEmail,
    required String contactPhone,
    required String evidenceFileId,
    String? websiteUrl,
    String? notes,
  });
  Future<String> uploadOrganizerEvidence(String filePath);
  Future<List<CompetitionRegistration>> getRoster(
    String eventId, {
    String? status,
    String? paymentStatus,
  });
  Future<void> decideRegistration({
    required String eventId,
    required String registrationId,
    required bool approve,
    String? reason,
  });
  Future<void> publishEvent(String eventId);
  Future<void> publishResults(String eventId);
  Future<CompetitionEvent> createEvent(CompetitionEventInput input);
  Future<CompetitionEvent> updateEvent(
    String eventId,
    CompetitionEventInput input,
  );
  Future<void> deleteEvent(String eventId);
  Future<void> upsertPowerliftingResult({
    required String eventId,
    required String registrationId,
    required double bodyweightKg,
    required double bestSquatKg,
    required double bestBenchKg,
    required double bestDeadliftKg,
    required String state,
    String? notes,
  });
  Future<void> upsertBodybuildingResult({
    required String eventId,
    required String registrationId,
    required int? place,
    required String state,
    String? notes,
  });
  Future<List<OrganizerProfile>> getOrganizerApplications({String? status});
  Future<void> decideOrganizerApplication({
    required String profileId,
    required String decision,
    required String reason,
  });
  Future<String> getOrganizerEvidenceUrl(String profileId);
  Future<void> closeRegistration(String eventId);
  Future<void> cancelEvent(String eventId, String reason);
  Future<CompetitionCategory> addCategory(
    String eventId, {
    required String code,
    required String name,
    required int capacity,
    required int displayOrder,
    String? eligibilityNotes,
    String? sexDivision,
    String? ageDivision,
    double? minAge,
    double? maxAge,
    double? minWeightKg,
    double? maxWeightKg,
    double? minHeightCm,
    double? maxHeightCm,
    String? equipmentDivision,
    String? bodybuildingDivision,
  });
  Future<void> deleteCategory(String eventId, String categoryId);
  Future<void> clearCategories(String eventId);
  Future<void> setStaff(
    String eventId,
    String userId,
    List<String> permissions,
  );
  Future<void> removeStaff(String eventId, String userId);
  Future<void> addGuestRegistration(
    String eventId, {
    required String categoryId,
    required String athleteName,
    required String contactEmail,
    required String contactPhone,
    String? contactFacebook,
  });
  Future<void> promoteWaitlist(String eventId, String registrationId);
  Future<void> linkGuestRegistration(
    String eventId,
    String registrationId,
    String userId,
  );
  Future<void> decideReceipt({
    required String eventId,
    required String receiptId,
    required bool approve,
    String? reason,
  });
  Future<String> getReceiptUrl(String eventId, String receiptId);
}
