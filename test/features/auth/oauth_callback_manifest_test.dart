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
    expect(mainActivitySource, contains('uri.userInfo == null'));
    expect(mainActivitySource, contains('uri.port == -1'));
    expect(
      mainActivitySource,
      contains('uri.fragment == FACEBOOK_COMPAT_FRAGMENT'),
    );
    expect(
      mainActivitySource,
      contains(
        'val hasTicket = allowedCallback && '
        'callback?.getQueryParameter("ticket") != null',
      ),
    );
    expect(
      mainActivitySource,
      contains(
        'val hasError = allowedCallback && '
        'callback?.getQueryParameter("error") != null',
      ),
    );
  });

  test('warm OAuth callback is consumed before Flutter deep-link routing', () {
    final mainActivitySource = File(
      'android/app/src/main/kotlin/online/xenoh/xenoh_mobile/MainActivity.kt',
    ).readAsStringSync();
    final onNewIntent = mainActivitySource.substring(
      mainActivitySource.indexOf('override fun onNewIntent'),
      mainActivitySource.indexOf('override fun onResume'),
    );
    final completesBrowserSession = onNewIntent.indexOf(
      'finishPendingWithCallback(callback)',
    );
    final forwardsToFlutter = onNewIntent.indexOf('super.onNewIntent(intent)');

    expect(
      onNewIntent,
      contains('isAllowedCallback(callback)'),
    );
    expect(onNewIntent, contains('pendingResult != null'));
    expect(completesBrowserSession, greaterThanOrEqualTo(0));
    expect(forwardsToFlutter, greaterThan(completesBrowserSession));
  });
}
