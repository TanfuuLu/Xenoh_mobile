import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/config/app_config.dart';

void main() {
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
