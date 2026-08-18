import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/router/router.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/social_callback_screen.dart';

void main() {
  test('router error recovery handles the allowlisted OAuth callback', () {
    final screen = routerErrorScreenFor(
      Uri.parse('xenoh://auth/social-callback?ticket=one-time'),
      isAuthenticated: false,
    );

    // The callback is a transient loading screen: no bottom menu bar around it.
    expect(screen, isA<SocialCallbackScreen>());
    final socialCallback = screen as SocialCallbackScreen;
    expect(socialCallback.ticket, 'one-time');
    expect(socialCallback.errorCode, isNull);
  });
}
