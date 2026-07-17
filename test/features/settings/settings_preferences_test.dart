import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/settings/presentation/screens/settings_screen.dart';

void main() {
  group('normalizeThemePreference', () {
    test('preserves the supported dark value', () {
      expect(normalizeThemePreference('dark'), 'dark');
      expect(normalizeThemePreference('DARK'), 'dark');
    });

    test('falls back to the supported light value', () {
      expect(normalizeThemePreference('system'), 'light');
      expect(normalizeThemePreference('light'), 'light');
      expect(normalizeThemePreference(null), 'light');
    });
  });
}
