import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android registers the Xenoh custom scheme callback', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();

    expect(manifest, contains('android:scheme="xenoh"'));
    // flutter_web_auth_2 4.x dispatches by scheme. The returned URI is still
    // allowlisted by ExternalAuthLauncher before the ticket is exchanged.
    expect(manifest, isNot(contains('android:host="auth"')));
    expect(manifest, isNot(contains('android:path="/social-callback"')));
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
