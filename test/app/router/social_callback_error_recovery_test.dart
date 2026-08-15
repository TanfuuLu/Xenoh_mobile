import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/home_shell.dart';
import 'package:xenoh_mobile/app/router/router.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/social_callback_screen.dart';

void main() {
  test('router error recovery handles the allowlisted OAuth callback', () {
    final screen = routerErrorScreenFor(
      Uri.parse('xenoh://auth/social-callback?ticket=one-time'),
      isAuthenticated: false,
    );

    expect(screen, isA<AppBottomMenuFrame>());
    final callback = (screen as AppBottomMenuFrame).child;
    expect(callback, isA<SocialCallbackScreen>());
    final socialCallback = callback as SocialCallbackScreen;
    expect(socialCallback.ticket, 'one-time');
    expect(socialCallback.errorCode, isNull);
  });
}
