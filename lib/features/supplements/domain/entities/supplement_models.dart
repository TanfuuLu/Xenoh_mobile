enum SupplementIntakeStatus { taken, skipped }

enum SupplementDoseStatus { pending, taken, skipped, missed }

enum SupplementWeekday {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

extension SupplementEnumWire on Enum {
  String get wireValue => name[0].toUpperCase() + name.substring(1);
}

class SupplementDoseSlot {
  const SupplementDoseSlot({
    required this.id,
    required this.amount,
    required this.unit,
    required this.time,
    required this.daysOfWeek,
  });

  final String id;
  final double amount;
  final String unit;
  final String time;
  final List<SupplementWeekday> daysOfWeek;
}

class SupplementDoseSlotInput {
  const SupplementDoseSlotInput({
    required this.amount,
    required this.unit,
    required this.time,
    required this.daysOfWeek,
  });

  final double amount;
  final String unit;
  final String time;
  final List<SupplementWeekday> daysOfWeek;

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'unit': unit.trim(),
    'time': time,
    'daysOfWeek': daysOfWeek.map((day) => day.wireValue).toList(),
  };
}

class SupplementRegimenInput {
  const SupplementRegimenInput({
    required this.name,
    required this.effectiveDate,
    required this.doseSlots,
    this.brand,
    this.form,
    this.instructions,
    this.notes,
  });

  final String name;
  final String? brand;
  final String? form;
  final String? instructions;
  final String? notes;
  final DateTime effectiveDate;
  final List<SupplementDoseSlotInput> doseSlots;
}

class SupplementCreator {
  const SupplementCreator({required this.id, required this.fullName});

  final String id;
  final String fullName;
}

class SupplementRegimen {
  const SupplementRegimen({
    required this.id,
    required this.userId,
    required this.name,
    required this.isArchived,
    required this.doseSlots,
    required this.createdAt,
    required this.updatedAt,
    this.brand,
    this.form,
    this.instructions,
    this.notes,
    this.archivedAt,
    this.createdBy,
    this.scheduleVersionId,
    this.scheduleEffectiveFrom,
    this.scheduleEffectiveTo,
  });

  final String id;
  final String userId;
  final String name;
  final String? brand;
  final String? form;
  final String? instructions;
  final String? notes;
  final bool isArchived;
  final DateTime? archivedAt;
  final SupplementCreator? createdBy;
  final String? scheduleVersionId;
  final DateTime? scheduleEffectiveFrom;
  final DateTime? scheduleEffectiveTo;
  final List<SupplementDoseSlot> doseSlots;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class SupplementAdherenceTotals {
  const SupplementAdherenceTotals({
    required this.planned,
    required this.taken,
    required this.skipped,
    required this.missed,
    required this.pending,
    this.adherencePercentage,
  });

  final int planned;
  final int taken;
  final int skipped;
  final int missed;
  final int pending;
  final double? adherencePercentage;
}

class SupplementDailyDose {
  const SupplementDailyDose({
    required this.doseSlotId,
    required this.regimenId,
    required this.regimenName,
    required this.amount,
    required this.unit,
    required this.time,
    required this.status,
    this.brand,
    this.form,
    this.recordedAt,
    this.note,
  });

  final String doseSlotId;
  final String regimenId;
  final String regimenName;
  final String? brand;
  final String? form;
  final double amount;
  final String unit;
  final String time;
  final SupplementDoseStatus status;
  final DateTime? recordedAt;
  final String? note;
}

class SupplementDaily {
  const SupplementDaily({
    required this.userId,
    required this.date,
    required this.doses,
    required this.totals,
  });

  final String userId;
  final DateTime date;
  final List<SupplementDailyDose> doses;
  final SupplementAdherenceTotals totals;
}

class SupplementHistoryDay {
  const SupplementHistoryDay({required this.date, required this.totals});

  final DateTime date;
  final SupplementAdherenceTotals totals;
}

class SupplementHistory {
  const SupplementHistory({
    required this.userId,
    required this.from,
    required this.to,
    required this.totals,
    required this.days,
  });

  final String userId;
  final DateTime from;
  final DateTime to;
  final SupplementAdherenceTotals totals;
  final List<SupplementHistoryDay> days;
}
