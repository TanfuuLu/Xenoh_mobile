enum WeightUnit { kg, lb }

extension WeightUnitConversion on WeightUnit {
  double fromKg(double kg) => this == WeightUnit.kg ? kg : kg * 2.2046226218;

  double toKg(double value) =>
      this == WeightUnit.kg ? value : value / 2.2046226218;

  String get suffix => this == WeightUnit.kg ? 'kg' : 'lb';
}

WeightUnit weightUnitFromString(String? value) =>
    value == 'lb' ? WeightUnit.lb : WeightUnit.kg;

/// Formats a weight value, trimming trailing zeros (e.g. `100.0` -> `100`,
/// `82.50` -> `82.5`).
String formatWeight(double value) {
  if (value == value.roundToDouble()) return value.toStringAsFixed(0);
  final fixed = value.toStringAsFixed(2);
  return fixed.endsWith('0') ? fixed.substring(0, fixed.length - 1) : fixed;
}
