import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/supplements/data/dtos/supplement_dtos.dart';
import 'package:xenoh_mobile/features/supplements/domain/entities/supplement_models.dart';

void main() {
  group('SupplementDtoMapper', () {
    test('maps a regimen and preserves backend weekday values', () {
      final regimen = SupplementDtoMapper.regimen({
        'id': 'regimen-1',
        'userId': 'user-1',
        'name': 'Creatine',
        'brand': 'Xenoh',
        'form': 'Powder',
        'instructions': 'With water',
        'notes': null,
        'isArchived': false,
        'archivedAt': null,
        'createdBy': {'id': 'coach-1', 'fullName': 'Coach One'},
        'scheduleVersionId': 'version-1',
        'scheduleEffectiveFrom': '2026-07-23',
        'scheduleEffectiveTo': null,
        'doseSlots': [
          {
            'id': 'slot-1',
            'amount': 5,
            'unit': 'g',
            'time': '08:30:00',
            'daysOfWeek': ['Monday', 'Wednesday', 'Friday'],
          },
        ],
        'createdAt': '2026-07-23T01:00:00Z',
        'updatedAt': '2026-07-23T02:00:00Z',
      });

      expect(regimen.name, 'Creatine');
      expect(regimen.createdBy?.fullName, 'Coach One');
      expect(regimen.scheduleEffectiveFrom, DateTime(2026, 7, 23));
      expect(regimen.doseSlots.single.amount, 5);
      expect(regimen.doseSlots.single.daysOfWeek, [
        SupplementWeekday.monday,
        SupplementWeekday.wednesday,
        SupplementWeekday.friday,
      ]);
    });

    test('maps daily status and adherence totals', () {
      final daily = SupplementDtoMapper.daily({
        'userId': 'user-1',
        'date': '2026-07-23',
        'doses': [
          {
            'doseSlotId': 'slot-1',
            'regimenId': 'regimen-1',
            'regimenName': 'Creatine',
            'brand': null,
            'form': 'Powder',
            'amount': 5.0,
            'unit': 'g',
            'time': '08:30:00',
            'status': 'Taken',
            'recordedAt': '2026-07-23T08:31:00Z',
            'note': null,
          },
        ],
        'totals': {
          'planned': 1,
          'taken': 1,
          'skipped': 0,
          'missed': 0,
          'pending': 0,
          'adherencePercentage': 100.0,
        },
      });

      expect(daily.date, DateTime(2026, 7, 23));
      expect(daily.doses.single.status, SupplementDoseStatus.taken);
      expect(daily.totals.adherencePercentage, 100);
    });
  });

  test('dose input emits the backend enum casing', () {
    const input = SupplementDoseSlotInput(
      amount: 1,
      unit: 'capsule',
      time: '20:00:00',
      daysOfWeek: [
        SupplementWeekday.sunday,
        SupplementWeekday.saturday,
      ],
    );

    expect(input.toJson(), {
      'amount': 1.0,
      'unit': 'capsule',
      'time': '20:00:00',
      'daysOfWeek': ['Sunday', 'Saturday'],
    });
  });
}
