import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android OAuth uses the stable custom-tab callback configuration', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync();

    expect(
      manifest,
      contains('com.linusu.flutter_web_auth_2.CallbackActivity'),
    );
    expect(pubspec, contains('flutter_web_auth_2: 4.1.0'));
    expect(RegExp('android:scheme="xenoh"').allMatches(manifest), hasLength(1));

    final mainActivity = RegExp(
      r'<activity\s+android:name="\.MainActivity"[\s\S]*?</activity>',
    ).firstMatch(manifest)!.group(0)!;
    final callbackActivity = RegExp(
      r'<activity\s+android:name="com\.linusu\.flutter_web_auth_2\.CallbackActivity"[\s\S]*?</activity>',
    ).firstMatch(manifest)!.group(0)!;
    expect(mainActivity, isNot(contains('android:scheme="xenoh"')));
    expect(mainActivity, contains('android:launchMode="singleTop"'));
    expect(mainActivity, isNot(contains('android:taskAffinity')));
    expect(callbackActivity, isNot(contains('android:taskAffinity')));
    expect(callbackActivity, isNot(contains('android:host')));
    expect(callbackActivity, isNot(contains('android:path')));
  });
}
