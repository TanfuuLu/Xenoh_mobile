import '../entities/cycle_models.dart';

abstract interface class CycleRepository {
  Future<CycleOverview> getOverview();

  Future<List<CycleDailyLog>> getLogs({
    required DateTime from,
    required DateTime to,
  });

  Future<CycleDailyLog> upsertLog({
    required DateTime date,
    String? flow,
    List<String>? symptoms,
    String? mood,
    int? energyLevel,
    String? notes,
  });

  Future<void> deleteLog(DateTime date);

  Future<CycleSettings> getSettings();

  Future<CycleSettings> updateSettings({
    required bool shareWithCoach,
    int? averageCycleLengthOverride,
    int? averagePeriodLengthOverride,
  });

  Future<CycleInsight> getInsight({String lang = 'en'});
}
