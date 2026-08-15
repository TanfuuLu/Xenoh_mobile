import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android OAuth callback is owned by the dedicated auth activity', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();

    expect(
      manifest,
      contains('com.linusu.flutter_web_auth_2.CallbackActivity'),
    );
    expect(RegExp('android:scheme="xenoh"').allMatches(manifest), hasLength(1));

    final mainActivity = RegExp(
      r'<activity\s+android:name="\.MainActivity"[\s\S]*?</activity>',
    ).firstMatch(manifest)!.group(0)!;
    expect(mainActivity, isNot(contains('android:scheme="xenoh"')));
  });
}
