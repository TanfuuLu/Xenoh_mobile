import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';

void main() {
  group('WeightUnit conversion', () {
    test('kg is a no-op', () {
      expect(WeightUnit.kg.fromKg(82.5), 82.5);
      expect(WeightUnit.kg.toKg(82.5), 82.5);
      expect(WeightUnit.kg.suffix, 'kg');
    });

    test('kg <-> lb round-trips', () {
      const kg = 100.0;
      final lb = WeightUnit.lb.fromKg(kg);
      expect(lb, closeTo(220.462, 0.001));
      expect(WeightUnit.lb.toKg(lb), closeTo(kg, 1e-9));
      expect(WeightUnit.lb.suffix, 'lb');
    });

    test('weightUnitFromString parses backend values', () {
      expect(weightUnitFromString('lb'), WeightUnit.lb);
      expect(weightUnitFromString('kg'), WeightUnit.kg);
      expect(weightUnitFromString(null), WeightUnit.kg);
      expect(weightUnitFromString('bogus'), WeightUnit.kg);
    });
  });

  group('formatWeight', () {
    test('trims a whole number to no decimals', () {
      expect(formatWeight(100), '100');
    });

    test('trims a single trailing zero', () {
      expect(formatWeight(82.50), '82.5');
    });

    test('keeps two significant decimals otherwise', () {
      expect(formatWeight(44.092452436), '44.09');
    });
  });
}
