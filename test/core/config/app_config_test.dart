import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/config/app_config.dart';

void main() {
  group('API base URL', () {
    test('uses the local emulator API by default in debug builds', () {
      expect(
        resolveApiBaseUrl(configured: '', isRelease: false),
        'https://10.0.2.2:7017/api',
      );
    });

    test('uses the production API by default in release builds', () {
      expect(
        resolveApiBaseUrl(configured: '', isRelease: true),
        'https://api.xenoh.online/api',
      );
    });

    test('an explicit API base URL wins in every build mode', () {
      const configured = 'https://staging-api.xenoh.online/api';

      expect(
        resolveApiBaseUrl(configured: configured, isRelease: false),
        configured,
      );
      expect(
        resolveApiBaseUrl(configured: configured, isRelease: true),
        configured,
      );
    });
  });

  test('bad certificates require explicit debug localhost opt-in', () {
    expect(
      canAllowBadCertificate(
        requested: true,
        isDebug: true,
        isLocalhost: true,
      ),
      isTrue,
    );
    expect(
      canAllowBadCertificate(
        requested: false,
        isDebug: true,
        isLocalhost: true,
      ),
      isFalse,
    );
    expect(
      canAllowBadCertificate(
        requested: true,
        isDebug: false,
        isLocalhost: true,
      ),
      isFalse,
    );
    expect(
      canAllowBadCertificate(
        requested: true,
        isDebug: true,
        isLocalhost: false,
      ),
      isFalse,
    );
  });
}
