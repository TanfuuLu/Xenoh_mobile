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
    expect(
      AppBrand.openingEmblemWhiteCircleAsset,
      'assets/icon/ascend_emblem_circle_white.png',
    );
    expect(
      AppBrand.openingEmblemGoldCircleAsset,
      'assets/icon/ascend_emblem_circle_gold.png',
    );
  });

  test('uses double-sized Ascend marks on branded surfaces', () {
    expect(AppBrand.toolbarLogoWidth, 180);
    expect(AppBrand.toolbarLogoHeight, 60);
    expect(AppBrand.authLogoWidth, 222);
    expect(AppBrand.authLogoHeight, 74);
    expect(AppBrand.marketingLogoWidth, 228);
    expect(AppBrand.marketingLogoHeight, 76);
    expect(AppBrand.splashEmblemSize, 360);
  });

  test('uses the approved Ascend neutral and action colors', () {
    expect(AppColors.paper.toARGB32(), 0xFFFFFDF8);
    expect(AppColors.bgPage.toARGB32(), 0xFFF7F4EF);
    expect(AppColors.accent.toARGB32(), 0xFFB6532F);
    expect(AppColors.accentPress.toARGB32(), 0xFF84371F);
    expect(AppColors.gold.toARGB32(), 0xFFD99A1D);
    expect(AppColors.sage.toARGB32(), 0xFF83917B);
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

  test('uses Ascend in installable web metadata', () {
    final manifest = File('web/manifest.json').readAsStringSync();
    final index = File('web/index.html').readAsStringSync();

    expect(manifest, contains('"name": "Ascend"'));
    expect(manifest, contains('"background_color": "#F7F4EF"'));
    expect(index, contains('<title>Ascend</title>'));
    expect(index, contains('content="Ascend training and recovery companion."'));
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

  test('uses Ascend artwork throughout branded Flutter surfaces', () {
    final files = [
      'lib/app/home_shell.dart',
      'lib/app/splash_screen.dart',
      'lib/core/widgets/hero_card_background.dart',
      'lib/features/auth/presentation/widgets/auth_layout.dart',
      'lib/features/dashboard/presentation/screens/dashboard_screen.dart',
      'lib/features/marketing/presentation/screens/landing_screen.dart',
    ];

    for (final path in files) {
      final source = File(path).readAsStringSync();
      expect(source, isNot(contains('banner_logo_xenoh.png')));
      expect(source, isNot(contains('logo_xenoh_transparent.png')));
      expect(source, isNot(contains('xenoh_splash.png')));
    }
  });
}
