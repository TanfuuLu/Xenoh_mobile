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
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('/auth/social-callback?ticket=one-time#fragment'),
      ),
      isFalse,
    );
    expect(
      isSupportedSocialCallbackUri(
        Uri.parse('//attacker/auth/social-callback?ticket=one-time'),
      ),
      isFalse,
    );
  });

  test('accepts and removes the Facebook compatibility fragment', () {
    final callback = Uri.parse(
      'xenoh://auth/social-callback?ticket=one-time#_=_',
    );

    expect(isSupportedSocialCallbackUri(callback), isTrue);
    expect(
      internalSocialCallbackLocation(callback),
      '/auth/social-callback?ticket=one-time',
    );
  });

  test('converts an allowlisted app callback into an internal route', () {
    expect(
      internalSocialCallbackLocation(
        Uri.parse(
          'xenoh://auth/social-callback?ticket=one-time&state=ignored',
        ),
      ),
      '/auth/social-callback?ticket=one-time&state=ignored',
    );
    expect(
      internalSocialCallbackLocation(
        Uri.parse('xenoh://attacker/social-callback?ticket=stolen'),
      ),
      isNull,
    );
  });
}
