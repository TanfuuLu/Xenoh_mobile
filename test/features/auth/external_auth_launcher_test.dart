import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/auth/presentation/services/external_auth_launcher.dart';

void main() {
  test('builds fixed mobile OAuth URLs for both supported providers', () {
    final launcher = ExternalAuthLauncher(
      apiBaseUrl: 'https://api.xenoh.online/api/',
      authenticate: (_) async =>
          Uri.parse('xenoh://auth/social-callback?ticket=one-time'),
    );

    expect(
      launcher.uriFor(ExternalAuthProvider.google).toString(),
      'https://api.xenoh.online/api/auth/external/google?client=mobile',
    );
    expect(
      launcher.uriFor(ExternalAuthProvider.facebook).toString(),
      'https://api.xenoh.online/api/auth/external/facebook?client=mobile',
    );
  });

  test(
    'authenticate returns the callback from the fixed provider URL',
    () async {
      Uri? openedUri;
      final launcher = ExternalAuthLauncher(
        apiBaseUrl: 'https://10.0.2.2:7017/api',
        authenticate: (uri) async {
          openedUri = uri;
          return Uri.parse(
            'xenoh://auth/social-callback?ticket=one-time-ticket',
          );
        },
      );

      final callback = await launcher.authenticate(
        ExternalAuthProvider.facebook,
      );

      expect(
        callback,
        Uri.parse('xenoh://auth/social-callback?ticket=one-time-ticket'),
      );
      expect(
        openedUri.toString(),
        'https://10.0.2.2:7017/api/auth/external/facebook?client=mobile',
      );
    },
  );

  test('authenticate rejects a callback outside the app allowlist', () async {
    final launcher = ExternalAuthLauncher(
      apiBaseUrl: 'https://api.xenoh.online/api',
      authenticate: (_) async =>
          Uri.parse('xenoh://attacker/social-callback?ticket=stolen'),
    );

    final callback = await launcher.authenticate(ExternalAuthProvider.google);

    expect(callback, isNull);
  });

  test('authenticate rejects an internal relative callback', () async {
    final launcher = ExternalAuthLauncher(
      apiBaseUrl: 'https://api.xenoh.online/api',
      authenticate: (_) async =>
          Uri.parse('/auth/social-callback?ticket=one-time'),
    );

    final callback = await launcher.authenticate(ExternalAuthProvider.google);

    expect(callback, isNull);
  });
}
