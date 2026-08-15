import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/auth/presentation/services/social_callback_uri.dart';

void main() {
  test('accepts the fixed app callback and internal router callback', () {
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('xenoh://auth/social-callback?ticket=one-time'),
      ),
      isTrue,
    );
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('/auth/social-callback?ticket=one-time'),
      ),
      isTrue,
    );
  });

  test('rejects unrelated schemes, hosts, and paths', () {
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('https://auth/social-callback?ticket=one-time'),
      ),
      isFalse,
    );
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('xenoh://other/social-callback?ticket=one-time'),
      ),
      isFalse,
    );
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('xenoh://auth/other?ticket=one-time'),
      ),
      isFalse,
    );
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('xenoh://user@auth/social-callback?ticket=one-time'),
      ),
      isFalse,
    );
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('xenoh://auth:443/social-callback?ticket=one-time'),
      ),
      isFalse,
    );
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('xenoh://auth/social-callback?ticket=one-time#fragment'),
      ),
      isFalse,
    );
  });
}
