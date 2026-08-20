import 'package:dio/dio.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/supplement_models.dart';
import '../dtos/supplement_dtos.dart';

class SupplementRemoteDataSource {
  SupplementRemoteDataSource(this._dio);

  final Dio _dio;

  String _base(String? clientId) =>
      clientId == null ? '/supplements' : '/supplements/clients/$clientId';

  Future<List<SupplementRegimen>> getRegimens({
    String? clientId,
    bool includeArchived = false,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '${_base(clientId)}/regimens',
      queryParameters: {'includeArchived': includeArchived},
    );
    return (response.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(SupplementDtoMapper.regimen)
        .toList(growable: false);
  }

  Future<SupplementRegimen> createRegimen(
    SupplementRegimenInput input, {
    String? clientId,
  }) async {
    final response = await _dio.post<JsonMap>(
      '${_base(clientId)}/regimens',
      data: _regimenData(input, create: true),
    );
    return SupplementDtoMapper.regimen(response.data!);
  }

  Future<SupplementRegimen> updateRegimen(
    String regimenId,
    SupplementRegimenInput input, {
    String? clientId,
  }) async {
    final response = await _dio.put<JsonMap>(
      '${_base(clientId)}/regimens/$regimenId',
      data: _regimenData(input, create: false),
    );
    return SupplementDtoMapper.regimen(response.data!);
  }

  Future<void> archiveRegimen(
    String regimenId, {
    String? clientId,
  }) => _dio.delete<void>('${_base(clientId)}/regimens/$regimenId');

  /// Permanent removal: drops the regimen, every schedule version, and the
  /// intake history. Distinct from [archiveRegimen], which keeps the history.
  Future<void> deleteRegimen(
    String regimenId, {
    String? clientId,
  }) => _dio.delete<void>(
    '${_base(clientId)}/regimens/$regimenId/permanent',
  );

  Future<SupplementDaily> getDaily(
    DateTime date, {
    String? clientId,
  }) async {
    final response = await _dio.get<JsonMap>(
      '${_base(clientId)}/daily',
      queryParameters: {'date': DateOnly.format(date)},
    );
    return SupplementDtoMapper.daily(response.data!);
  }

  Future<SupplementDailyDose> recordDose({
    required String doseSlotId,
    required DateTime date,
    required SupplementIntakeStatus status,
    String? note,
  }) async {
    final response = await _dio.put<JsonMap>(
      '/supplements/doses/$doseSlotId/${DateOnly.format(date)}',
      data: {
        'status': status.wireValue,
        'recordedAt': null,
        'note': note,
      },
    );
    return SupplementDtoMapper.dailyDose(response.data!);
  }

  Future<void> resetDose({
    required String doseSlotId,
    required DateTime date,
  }) => _dio.delete<void>(
    '/supplements/doses/$doseSlotId/${DateOnly.format(date)}',
  );

  Future<SupplementHistory> getHistory({
    required DateTime from,
    required DateTime to,
    String? clientId,
  }) async {
    final response = await _dio.get<JsonMap>(
      '${_base(clientId)}/history',
      queryParameters: {
        'from': DateOnly.format(from),
        'to': DateOnly.format(to),
      },
    );
    return SupplementDtoMapper.history(response.data!);
  }

  Map<String, dynamic> _regimenData(
    SupplementRegimenInput input, {
    required bool create,
  }) => {
    'name': input.name.trim(),
    'brand': _nullable(input.brand),
    'form': _nullable(input.form),
    'instructions': _nullable(input.instructions),
    'notes': _nullable(input.notes),
    if (create)
      'startDate': DateOnly.format(input.effectiveDate)
    else
      'effectiveFrom': DateOnly.format(input.effectiveDate),
    'doseSlots': input.doseSlots.map((slot) => slot.toJson()).toList(),
  };

  String? _nullable(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
