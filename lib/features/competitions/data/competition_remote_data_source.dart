import 'package:dio/dio.dart';

import '../domain/competition_models.dart';

class CompetitionRemoteDataSource {
  CompetitionRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<CompetitionSummary>> list({String? discipline}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/events',
      queryParameters: {'discipline': ?discipline, 'pageSize': 50},
    );
    return (response.data?['items'] as List<dynamic>? ?? const [])
        .map(
          (item) => CompetitionSummary.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<CompetitionEvent> getBySlug(String slug) async {
    final response = await _dio.get<Map<String, dynamic>>('/events/$slug');
    return CompetitionEvent.fromJson(response.data!);
  }

  Future<List<CompetitionRegistration>> mine() async {
    final response = await _dio.get<List<dynamic>>('/events/registrations/me');
    return (response.data ?? const [])
        .map(
          (item) =>
              CompetitionRegistration.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<CompetitionRegistration> register({
    required String eventId,
    required String categoryId,
    required String contactEmail,
    required String contactPhone,
    String? contactFacebook,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/events/$eventId/registrations',
      data: {
        'categoryId': categoryId,
        'contactEmail': contactEmail,
        'contactPhone': contactPhone,
        'contactFacebook': contactFacebook,
      },
    );
    return CompetitionRegistration.fromJson(response.data!);
  }

  Future<void> withdraw(String eventId) =>
      _dio.post<void>('/events/$eventId/registrations/me/withdraw');

  Future<void> uploadReceipt(String eventId, String filePath) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    await _dio.post<void>(
      '/events/$eventId/registrations/me/receipts',
      data: form,
    );
  }

  Future<OrganizerProfile?> getOrganizerProfile() async {
    final response = await _dio.get<dynamic>('/organizers/me');
    final data = response.data;
    if (data == null) return null;
    return OrganizerProfile.fromJson(data as Map<String, dynamic>);
  }

  Future<List<CompetitionSummary>> getManagedEvents() async {
    final response = await _dio.get<List<dynamic>>(
      '/competition-management/events',
    );
    return (response.data ?? const [])
        .map(
          (item) => CompetitionSummary.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<OrganizerProfile> applyAsOrganizer({
    required String organizationName,
    required String contactEmail,
    required String contactPhone,
    required String evidenceFileId,
    String? websiteUrl,
    String? notes,
  }) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/organizers/me/application',
      data: {
        'organizationName': organizationName,
        'contactEmail': contactEmail,
        'contactPhone': contactPhone,
        'websiteUrl': websiteUrl,
        'notes': notes,
        'evidenceFileId': evidenceFileId,
      },
    );
    return OrganizerProfile.fromJson(response.data!);
  }

  Future<String> uploadOrganizerEvidence(String filePath) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    final response = await _dio.post<Map<String, dynamic>>(
      '/organizers/me/evidence',
      data: form,
    );
    return response.data!['fileId'].toString();
  }

  Future<List<CompetitionRegistration>> getRoster(
    String eventId, {
    String? status,
    String? paymentStatus,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/competition-management/events/$eventId/registrations',
      queryParameters: {
        'status': ?status,
        'paymentStatus': ?paymentStatus,
        'pageSize': 100,
      },
    );
    return (response.data ?? const [])
        .map(
          (item) =>
              CompetitionRegistration.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> decideRegistration({
    required String eventId,
    required String registrationId,
    required bool approve,
    String? reason,
  }) => _dio.post<void>(
    '/competition-management/events/$eventId/registrations/$registrationId/decision',
    data: {'approve': approve, 'reason': reason},
  );

  Future<void> publishEvent(String eventId) => _dio.post<void>(
    '/competition-management/events/$eventId/publish',
  );

  Future<void> publishResults(String eventId) => _dio.post<void>(
    '/competition-management/events/$eventId/results/publish',
  );

  Future<CompetitionEvent> createEvent(CompetitionEventInput input) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/competition-management/events',
      data: input.toJson(),
    );
    return CompetitionEvent.fromJson(response.data!);
  }

  Future<CompetitionEvent> updateEvent(
    String eventId,
    CompetitionEventInput input,
  ) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/competition-management/events/$eventId',
      data: input.toJson(),
    );
    return CompetitionEvent.fromJson(response.data!);
  }

  Future<void> deleteEvent(String eventId) =>
      _dio.delete<void>('/competition-management/events/$eventId');

  Future<void> upsertPowerliftingResult({
    required String eventId,
    required String registrationId,
    required double bodyweightKg,
    required double bestSquatKg,
    required double bestBenchKg,
    required double bestDeadliftKg,
    required String state,
    String? notes,
  }) => _dio.put<void>(
    '/competition-management/events/$eventId/results/powerlifting/$registrationId',
    data: {
      'bodyweightKg': bodyweightKg,
      'bestSquatKg': bestSquatKg,
      'bestBenchKg': bestBenchKg,
      'bestDeadliftKg': bestDeadliftKg,
      'state': state,
      'notes': notes,
    },
  );

  Future<void> upsertBodybuildingResult({
    required String eventId,
    required String registrationId,
    required int? place,
    required String state,
    String? notes,
  }) => _dio.put<void>(
    '/competition-management/events/$eventId/results/bodybuilding/$registrationId',
    data: {'place': place, 'state': state, 'notes': notes},
  );

  Future<List<OrganizerProfile>> getOrganizerApplications({
    String? status,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/admin/organizers',
      queryParameters: {'status': ?status, 'page': 1, 'pageSize': 100},
    );
    return (response.data ?? const [])
        .map((item) => OrganizerProfile.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> decideOrganizerApplication({
    required String profileId,
    required String decision,
    required String reason,
  }) => _dio.post<void>(
    '/admin/organizers/$profileId/decision',
    data: {'decision': decision, 'reason': reason},
  );

  Future<String> getOrganizerEvidenceUrl(String profileId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/admin/organizers/$profileId/evidence',
    );
    return response.data!['url'].toString();
  }

  Future<void> closeRegistration(String eventId) => _dio.post<void>(
    '/competition-management/events/$eventId/close-registration',
  );

  Future<void> cancelEvent(String eventId, String reason) => _dio.post<void>(
    '/competition-management/events/$eventId/cancel',
    data: {'reason': reason},
  );

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
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/competition-management/events/$eventId/categories',
      data: {
        'code': code,
        'name': name,
        'eligibilityNotes': eligibilityNotes,
        'capacity': capacity,
        'displayOrder': displayOrder,
        'sexDivision': sexDivision,
        'ageDivision': ageDivision,
        'minAge': minAge,
        'maxAge': maxAge,
        'minWeightKg': minWeightKg,
        'maxWeightKg': maxWeightKg,
        'minHeightCm': minHeightCm,
        'maxHeightCm': maxHeightCm,
        'equipmentDivision': equipmentDivision,
        'bodybuildingDivision': bodybuildingDivision,
      },
    );
    return CompetitionCategory.fromJson(response.data!);
  }

  Future<void> deleteCategory(String eventId, String categoryId) =>
      _dio.delete<void>(
        '/competition-management/events/$eventId/categories/$categoryId',
      );

  Future<void> clearCategories(String eventId) => _dio.delete<void>(
    '/competition-management/events/$eventId/categories',
  );

  Future<void> setStaff(
    String eventId,
    String userId,
    List<String> permissions,
  ) => _dio.put<void>(
    '/competition-management/events/$eventId/staff/$userId',
    data: {'permissions': permissions.join(', ')},
  );

  Future<void> removeStaff(String eventId, String userId) => _dio.delete<void>(
    '/competition-management/events/$eventId/staff/$userId',
  );

  Future<void> addGuestRegistration(
    String eventId, {
    required String categoryId,
    required String athleteName,
    required String contactEmail,
    required String contactPhone,
    String? contactFacebook,
  }) => _dio.post<void>(
    '/competition-management/events/$eventId/registrations/guest',
    data: {
      'categoryId': categoryId,
      'athleteName': athleteName,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'contactFacebook': contactFacebook,
    },
  );

  Future<void> promoteWaitlist(
    String eventId,
    String registrationId,
  ) => _dio.post<void>(
    '/competition-management/events/$eventId/registrations/$registrationId/promote',
  );

  Future<void> linkGuestRegistration(
    String eventId,
    String registrationId,
    String userId,
  ) => _dio.post<void>(
    '/competition-management/events/$eventId/registrations/$registrationId/link/$userId',
  );

  Future<void> decideReceipt({
    required String eventId,
    required String receiptId,
    required bool approve,
    String? reason,
  }) => _dio.post<void>(
    '/competition-management/events/$eventId/receipts/$receiptId/decision',
    data: {'approve': approve, 'reason': reason},
  );

  Future<String> getReceiptUrl(String eventId, String receiptId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/competition-management/events/$eventId/receipts/$receiptId/download',
    );
    return response.data!['url'].toString();
  }
}
