import '../entities/supplement_models.dart';

abstract interface class SupplementRepository {
  Future<List<SupplementRegimen>> getRegimens({
    String? clientId,
    bool includeArchived = false,
  });

  Future<SupplementRegimen> createRegimen(
    SupplementRegimenInput input, {
    String? clientId,
  });

  Future<SupplementRegimen> updateRegimen(
    String regimenId,
    SupplementRegimenInput input, {
    String? clientId,
  });

  Future<void> archiveRegimen(String regimenId, {String? clientId});

  Future<SupplementDaily> getDaily(DateTime date, {String? clientId});

  Future<SupplementDailyDose> recordDose({
    required String doseSlotId,
    required DateTime date,
    required SupplementIntakeStatus status,
    String? note,
  });

  Future<void> resetDose({
    required String doseSlotId,
    required DateTime date,
  });

  Future<SupplementHistory> getHistory({
    required DateTime from,
    required DateTime to,
    String? clientId,
  });
}
