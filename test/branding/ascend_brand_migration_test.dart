import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/branding/app_brand.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/core/config/app_config.dart';

void main() {
  test('exposes Ascend as the visible product identity', () {
    expect(AppBrand.name, 'Ascend');
    expect(AppBrand.coachName, 'Ascend Coach');
    expect(AppBrand.libraryName, 'Ascend Library');
    expect(AppBrand.horizontalLogoAsset, 'assets/icon/ascend_logo.png');
    expect(AppBrand.emblemAsset, 'assets/icon/ascend_emblem.png');
  });

  test('uses the approved Ascend neutral and action colors', () {
    expect(AppColors.paper.value, 0xFFFFFDF8);
    expect(AppColors.bgPage.value, 0xFFF7F4EF);
    expect(AppColors.accent.value, 0xFFB6532F);
    expect(AppColors.accentPress.value, 0xFF84371F);
    expect(AppColors.gold.value, 0xFFD99A1D);
    expect(AppColors.sage.value, 0xFF83917B);
  });

  test('keeps the deployed Xenoh API endpoint for compatibility', () {
    expect(
      resolveApiBaseUrl(configured: '', isRelease: true),
      'https://api.xenoh.online/api',
    );
  });

  test('uses Ascend for native display names while keeping the Xenoh callback', () {
    final android = File('android/app/src/main/AndroidManifest.xml')
        .readAsStringSync();
    final ios = File('ios/Runner/Info.plist').readAsStringSync();

    expect(android, contains('android:label="Ascend"'));
    expect(android, contains('android:scheme="xenoh"'));
    expect(ios, contains('<string>Ascend</string>'));
    expect(ios, contains('<string>xenoh</string>'));
  });

  test('contains no visible Xenoh wording in app localizations', () {
    for (final path in ['lib/l10n/app_en.arb', 'lib/l10n/app_vi.arb']) {
      final messages = jsonDecode(File(path).readAsStringSync())
          as Map<String, dynamic>;
      final visibleValues = messages.entries
          .where((entry) => !entry.key.startsWith('@') && entry.value is String)
          .map((entry) => entry.value as String);

      expect(visibleValues, everyElement(isNot(contains('Xenoh'))));
    }
  });
}
