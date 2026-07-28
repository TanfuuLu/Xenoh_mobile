import '../../../../core/utils/date_only.dart';
import '../../domain/entities/supplement_models.dart';

typedef JsonMap = Map<String, dynamic>;

class SupplementDtoMapper {
  const SupplementDtoMapper._();

  static SupplementRegimen regimen(JsonMap json) => SupplementRegimen(
    id: json['id'] as String,
    userId: json['userId'] as String,
    name: json['name'] as String,
    brand: json['brand'] as String?,
    form: json['form'] as String?,
    instructions: json['instructions'] as String?,
    notes: json['notes'] as String?,
    isArchived: json['isArchived'] as bool? ?? false,
    archivedAt: _dateTime(json['archivedAt']),
    createdBy: json['createdBy'] is Map<String, dynamic>
        ? creator(json['createdBy'] as JsonMap)
        : null,
    scheduleVersionId: json['scheduleVersionId'] as String?,
    scheduleEffectiveFrom: DateOnly.tryParse(
      json['scheduleEffectiveFrom'] as String?,
    ),
    scheduleEffectiveTo: DateOnly.tryParse(
      json['scheduleEffectiveTo'] as String?,
    ),
    doseSlots: _maps(json['doseSlots']).map(slot).toList(growable: false),
    createdAt: _dateTime(json['createdAt']) ?? DateTime(1970),
    updatedAt: _dateTime(json['updatedAt']) ?? DateTime(1970),
  );

  static SupplementCreator creator(JsonMap json) => SupplementCreator(
    id: json['id'] as String,
    fullName: json['fullName'] as String? ?? '',
  );

  static SupplementDoseSlot slot(JsonMap json) => SupplementDoseSlot(
    id: json['id'] as String,
    amount: _double(json['amount']),
    unit: json['unit'] as String? ?? '',
    time: json['time'] as String? ?? '00:00:00',
    daysOfWeek: (json['daysOfWeek'] as List<dynamic>? ?? const [])
        .map((value) => _weekday('$value'))
        .whereType<SupplementWeekday>()
        .toList(growable: false),
  );

  static SupplementDaily daily(JsonMap json) => SupplementDaily(
    userId: json['userId'] as String,
    date: DateOnly.tryParse(json['date'] as String?) ?? DateTime(1970),
    doses: _maps(json['doses']).map(dailyDose).toList(growable: false),
    totals: totals(json['totals'] as JsonMap? ?? const {}),
  );

  static SupplementDailyDose dailyDose(JsonMap json) => SupplementDailyDose(
    doseSlotId: json['doseSlotId'] as String,
    regimenId: json['regimenId'] as String,
    regimenName: json['regimenName'] as String? ?? '',
    brand: json['brand'] as String?,
    form: json['form'] as String?,
    amount: _double(json['amount']),
    unit: json['unit'] as String? ?? '',
    time: json['time'] as String? ?? '00:00:00',
    status: _doseStatus(json['status'] as String?),
    recordedAt: _dateTime(json['recordedAt']),
    note: json['note'] as String?,
  );

  static SupplementAdherenceTotals totals(JsonMap json) =>
      SupplementAdherenceTotals(
        planned: (json['planned'] as num?)?.toInt() ?? 0,
        taken: (json['taken'] as num?)?.toInt() ?? 0,
        skipped: (json['skipped'] as num?)?.toInt() ?? 0,
        missed: (json['missed'] as num?)?.toInt() ?? 0,
        pending: (json['pending'] as num?)?.toInt() ?? 0,
        adherencePercentage: (json['adherencePercentage'] as num?)?.toDouble(),
      );

  static SupplementHistory history(JsonMap json) => SupplementHistory(
    userId: json['userId'] as String,
    from: DateOnly.tryParse(json['from'] as String?) ?? DateTime(1970),
    to: DateOnly.tryParse(json['to'] as String?) ?? DateTime(1970),
    totals: totals(json['totals'] as JsonMap? ?? const {}),
    days: _maps(json['days'])
        .map(
          (day) => SupplementHistoryDay(
            date: DateOnly.tryParse(day['date'] as String?) ?? DateTime(1970),
            totals: totals(day['totals'] as JsonMap? ?? const {}),
          ),
        )
        .toList(growable: false),
  );

  static List<JsonMap> _maps(Object? value) =>
      (value as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .toList(growable: false);

  static DateTime? _dateTime(Object? value) =>
      value is String ? DateTime.tryParse(value) : null;

  static double _double(Object? value) => (value as num?)?.toDouble() ?? 0;

  static SupplementWeekday? _weekday(String value) {
    final normalized = value.toLowerCase();
    for (final day in SupplementWeekday.values) {
      if (day.name == normalized) return day;
    }
    return null;
  }

  static SupplementDoseStatus _doseStatus(String? value) {
    final normalized = value?.toLowerCase();
    return SupplementDoseStatus.values.firstWhere(
      (status) => status.name == normalized,
      orElse: () => SupplementDoseStatus.pending,
    );
  }
}
