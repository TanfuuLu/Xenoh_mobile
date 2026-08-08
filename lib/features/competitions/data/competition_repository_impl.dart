import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';
import '../domain/competition_models.dart';
import '../domain/competition_repository.dart';
import 'competition_remote_data_source.dart';

class CompetitionRepositoryImpl implements CompetitionRepository {
  CompetitionRepositoryImpl(this._remote);
  final CompetitionRemoteDataSource _remote;
  Future<T> _call<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw failureFromDio(error);
    }
  }

  @override
  Future<List<CompetitionSummary>> list({String? discipline}) =>
      _call(() => _remote.list(discipline: discipline));
  @override
  Future<CompetitionEvent> getBySlug(String slug) =>
      _call(() => _remote.getBySlug(slug));
  @override
  Future<List<CompetitionRegistration>> mine() => _call(_remote.mine);
  @override
  Future<CompetitionRegistration> register({
    required String eventId,
    required String categoryId,
    required String contactEmail,
    required String contactPhone,
    String? contactFacebook,
  }) => _call(
    () => _remote.register(
      eventId: eventId,
      categoryId: categoryId,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
      contactFacebook: contactFacebook,
    ),
  );
  @override
  Future<void> withdraw(String eventId) =>
      _call(() => _remote.withdraw(eventId));
  @override
  Future<void> uploadReceipt(String eventId, String filePath) =>
      _call(() => _remote.uploadReceipt(eventId, filePath));

  @override
  Future<OrganizerProfile?> getOrganizerProfile() =>
      _call(_remote.getOrganizerProfile);

  @override
  Future<List<CompetitionSummary>> getManagedEvents() =>
      _call(_remote.getManagedEvents);

  @override
  Future<OrganizerProfile> applyAsOrganizer({
    required String organizationName,
    required String contactEmail,
    required String contactPhone,
    required String evidenceFileId,
    String? websiteUrl,
    String? notes,
  }) => _call(
    () => _remote.applyAsOrganizer(
      organizationName: organizationName,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
      evidenceFileId: evidenceFileId,
      websiteUrl: websiteUrl,
      notes: notes,
    ),
  );

  @override
  Future<String> uploadOrganizerEvidence(String filePath) =>
      _call(() => _remote.uploadOrganizerEvidence(filePath));

  @override
  Future<List<CompetitionRegistration>> getRoster(
    String eventId, {
    String? status,
    String? paymentStatus,
  }) => _call(
    () => _remote.getRoster(
      eventId,
      status: status,
      paymentStatus: paymentStatus,
    ),
  );

  @override
  Future<void> decideRegistration({
    required String eventId,
    required String registrationId,
    required bool approve,
    String? reason,
  }) => _call(
    () => _remote.decideRegistration(
      eventId: eventId,
      registrationId: registrationId,
      approve: approve,
      reason: reason,
    ),
  );

  @override
  Future<void> publishEvent(String eventId) =>
      _call(() => _remote.publishEvent(eventId));

  @override
  Future<void> publishResults(String eventId) =>
      _call(() => _remote.publishResults(eventId));

  @override
  Future<CompetitionEvent> createEvent(CompetitionEventInput input) =>
      _call(() => _remote.createEvent(input));

  @override
  Future<CompetitionEvent> updateEvent(
    String eventId,
    CompetitionEventInput input,
  ) => _call(() => _remote.updateEvent(eventId, input));

  @override
  Future<void> deleteEvent(String eventId) =>
      _call(() => _remote.deleteEvent(eventId));

  @override
  Future<void> upsertPowerliftingResult({
    required String eventId,
    required String registrationId,
    required double bodyweightKg,
    required double bestSquatKg,
    required double bestBenchKg,
    required double bestDeadliftKg,
    required String state,
    String? notes,
  }) => _call(
    () => _remote.upsertPowerliftingResult(
      eventId: eventId,
      registrationId: registrationId,
      bodyweightKg: bodyweightKg,
      bestSquatKg: bestSquatKg,
      bestBenchKg: bestBenchKg,
      bestDeadliftKg: bestDeadliftKg,
      state: state,
      notes: notes,
    ),
  );

  @override
  Future<void> upsertBodybuildingResult({
    required String eventId,
    required String registrationId,
    required int? place,
    required String state,
    String? notes,
  }) => _call(
    () => _remote.upsertBodybuildingResult(
      eventId: eventId,
      registrationId: registrationId,
      place: place,
      state: state,
      notes: notes,
    ),
  );

  @override
  Future<List<OrganizerProfile>> getOrganizerApplications({String? status}) =>
      _call(() => _remote.getOrganizerApplications(status: status));

  @override
  Future<void> decideOrganizerApplication({
    required String profileId,
    required String decision,
    required String reason,
  }) => _call(
    () => _remote.decideOrganizerApplication(
      profileId: profileId,
      decision: decision,
      reason: reason,
    ),
  );

  @override
  Future<String> getOrganizerEvidenceUrl(String profileId) =>
      _call(() => _remote.getOrganizerEvidenceUrl(profileId));

  @override
  Future<void> closeRegistration(String eventId) =>
      _call(() => _remote.closeRegistration(eventId));

  @override
  Future<void> cancelEvent(String eventId, String reason) =>
      _call(() => _remote.cancelEvent(eventId, reason));

  @override
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
  }) => _call(
    () => _remote.addCategory(
      eventId,
      code: code,
      name: name,
      capacity: capacity,
      displayOrder: displayOrder,
      eligibilityNotes: eligibilityNotes,
      sexDivision: sexDivision,
      ageDivision: ageDivision,
      minAge: minAge,
      maxAge: maxAge,
      minWeightKg: minWeightKg,
      maxWeightKg: maxWeightKg,
      minHeightCm: minHeightCm,
      maxHeightCm: maxHeightCm,
      equipmentDivision: equipmentDivision,
      bodybuildingDivision: bodybuildingDivision,
    ),
  );

  @override
  Future<void> deleteCategory(String eventId, String categoryId) =>
      _call(() => _remote.deleteCategory(eventId, categoryId));

  @override
  Future<void> clearCategories(String eventId) =>
      _call(() => _remote.clearCategories(eventId));

  @override
  Future<void> setStaff(
    String eventId,
    String userId,
    List<String> permissions,
  ) => _call(() => _remote.setStaff(eventId, userId, permissions));

  @override
  Future<void> removeStaff(String eventId, String userId) =>
      _call(() => _remote.removeStaff(eventId, userId));

  @override
  Future<void> addGuestRegistration(
    String eventId, {
    required String categoryId,
    required String athleteName,
    required String contactEmail,
    required String contactPhone,
    String? contactFacebook,
  }) => _call(
    () => _remote.addGuestRegistration(
      eventId,
      categoryId: categoryId,
      athleteName: athleteName,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
      contactFacebook: contactFacebook,
    ),
  );

  @override
  Future<void> promoteWaitlist(String eventId, String registrationId) =>
      _call(() => _remote.promoteWaitlist(eventId, registrationId));

  @override
  Future<void> linkGuestRegistration(
    String eventId,
    String registrationId,
    String userId,
  ) => _call(
    () => _remote.linkGuestRegistration(eventId, registrationId, userId),
  );

  @override
  Future<void> decideReceipt({
    required String eventId,
    required String receiptId,
    required bool approve,
    String? reason,
  }) => _call(
    () => _remote.decideReceipt(
      eventId: eventId,
      receiptId: receiptId,
      approve: approve,
      reason: reason,
    ),
  );

  @override
  Future<String> getReceiptUrl(String eventId, String receiptId) =>
      _call(() => _remote.getReceiptUrl(eventId, receiptId));
}
