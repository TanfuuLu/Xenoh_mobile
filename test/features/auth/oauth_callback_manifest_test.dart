import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android OAuth callback is handled by the app activity', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    final mainActivitySource = File(
      'android/app/src/main/kotlin/online/xenoh/xenoh_mobile/MainActivity.kt',
    ).readAsStringSync();

    expect(manifest, isNot(contains('flutter_web_auth_2.CallbackActivity')));
    expect(RegExp('android:scheme="xenoh"').allMatches(manifest), hasLength(1));

    final mainActivity = RegExp(
      r'<activity\s+android:name="\.MainActivity"[\s\S]*?</activity>',
    ).firstMatch(manifest)!.group(0)!;
    expect(mainActivity, contains('android:scheme="xenoh"'));
    expect(mainActivity, contains('android:host="auth"'));
    expect(mainActivity, contains('android:path="/social-callback"'));
    expect(mainActivity, contains('android:launchMode="singleTask"'));
    expect(mainActivitySource, contains('online.xenoh/oauth'));
    expect(mainActivitySource, contains('social-callback'));
  });
}
