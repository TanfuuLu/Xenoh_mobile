import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android registers only the allowlisted Xenoh social callback', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();

    expect(manifest, contains('android:scheme="xenoh"'));
    expect(manifest, contains('android:host="auth"'));
    expect(manifest, contains('android:path="/social-callback"'));
    expect(
      manifest,
      contains('android:name="android.intent.category.BROWSABLE"'),
    );
  });

  test('iOS registers the Xenoh URL scheme for Flutter routing', () {
    final infoPlist = File('ios/Runner/Info.plist').readAsStringSync();

    expect(infoPlist, contains('<key>CFBundleURLTypes</key>'));
    expect(infoPlist, contains('<string>xenoh</string>'));
  });
}
