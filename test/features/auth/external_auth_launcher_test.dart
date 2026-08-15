import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/auth/presentation/services/external_auth_launcher.dart';

void main() {
  test('builds fixed mobile OAuth URLs for both supported providers', () {
    final launcher = ExternalAuthLauncher(
      apiBaseUrl: 'https://api.xenoh.online/api/',
      openUrl: (_) async => true,
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
    'launch delegates only the generated allowlisted provider URL',
    () async {
      Uri? openedUri;
      final launcher = ExternalAuthLauncher(
        apiBaseUrl: 'https://10.0.2.2:7017/api',
        openUrl: (uri) async {
          openedUri = uri;
          return true;
        },
      );

      final opened = await launcher.launch(ExternalAuthProvider.facebook);

      expect(opened, isTrue);
      expect(
        openedUri.toString(),
        'https://10.0.2.2:7017/api/auth/external/facebook?client=mobile',
      );
    },
  );
}
