import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/supplement_models.dart';
import '../../domain/repositories/supplement_repository.dart';
import '../datasources/supplement_remote_data_source.dart';

class SupplementRepositoryImpl implements SupplementRepository {
  SupplementRepositoryImpl(this._remote);

  final SupplementRemoteDataSource _remote;

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw failureFromDio(error);
    }
  }

  @override
  Future<List<SupplementRegimen>> getRegimens({
    String? clientId,
    bool includeArchived = false,
  }) => _guard(
    () => _remote.getRegimens(
      clientId: clientId,
      includeArchived: includeArchived,
    ),
  );

  @override
  Future<SupplementRegimen> createRegimen(
    SupplementRegimenInput input, {
    String? clientId,
  }) => _guard(() => _remote.createRegimen(input, clientId: clientId));

  @override
  Future<SupplementRegimen> updateRegimen(
    String regimenId,
    SupplementRegimenInput input, {
    String? clientId,
  }) => _guard(
    () => _remote.updateRegimen(
      regimenId,
      input,
      clientId: clientId,
    ),
  );

  @override
  Future<void> archiveRegimen(String regimenId, {String? clientId}) =>
      _guard(() => _remote.archiveRegimen(regimenId, clientId: clientId));

  @override
  Future<void> deleteRegimen(String regimenId, {String? clientId}) =>
      _guard(() => _remote.deleteRegimen(regimenId, clientId: clientId));

  @override
  Future<SupplementDaily> getDaily(DateTime date, {String? clientId}) =>
      _guard(() => _remote.getDaily(date, clientId: clientId));

  @override
  Future<SupplementDailyDose> recordDose({
    required String doseSlotId,
    required DateTime date,
    required SupplementIntakeStatus status,
    String? note,
  }) => _guard(
    () => _remote.recordDose(
      doseSlotId: doseSlotId,
      date: date,
      status: status,
      note: note,
    ),
  );

  @override
  Future<void> resetDose({
    required String doseSlotId,
    required DateTime date,
  }) => _guard(() => _remote.resetDose(doseSlotId: doseSlotId, date: date));

  @override
  Future<SupplementHistory> getHistory({
    required DateTime from,
    required DateTime to,
    String? clientId,
  }) => _guard(
    () => _remote.getHistory(
      from: from,
      to: to,
      clientId: clientId,
    ),
  );
}
