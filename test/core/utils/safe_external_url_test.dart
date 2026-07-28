import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/safe_external_url.dart';

void main() {
  const hosts = {'api.xenoh.online', 'assets.xenoh.online'};

  test('accepts HTTPS URLs from an approved host', () {
    final uri = safeExternalUri(
      'https://assets.xenoh.online/file.pdf?token=signed',
      allowedHosts: hosts,
    );

    expect(uri?.host, 'assets.xenoh.online');
  });

  test('rejects insecure, unapproved, and executable URLs', () {
    expect(
      safeExternalUri(
        'http://assets.xenoh.online/file.pdf',
        allowedHosts: hosts,
      ),
      isNull,
    );
    expect(
      safeExternalUri('https://example.com/file.pdf', allowedHosts: hosts),
      isNull,
    );
    expect(
      safeExternalUri('javascript:alert(1)', allowedHosts: hosts),
      isNull,
    );
  });
}
