import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import 'social_callback_uri.dart';

enum ExternalAuthProvider {
  google('google'),
  facebook('facebook');

  const ExternalAuthProvider(this.wireValue);

  final String wireValue;
}

typedef ExternalAuthSession = Future<Uri> Function(Uri authorizationUri);

class ExternalAuthLauncher {
  ExternalAuthLauncher({
    required String apiBaseUrl,
    ExternalAuthSession? authenticate,
  }) : _apiBaseUrl = apiBaseUrl,
       _authenticate = authenticate ?? _authenticateWithBrowserSession;

  final String _apiBaseUrl;
  final ExternalAuthSession _authenticate;

  Uri uriFor(ExternalAuthProvider provider) {
    final baseUri = Uri.parse(_apiBaseUrl);
    final basePath = baseUri.path.endsWith('/')
        ? baseUri.path.substring(0, baseUri.path.length - 1)
        : baseUri.path;
    return baseUri.replace(
      path: '$basePath/auth/external/${provider.wireValue}',
      queryParameters: const {'client': 'mobile'},
    );
  }

  Future<Uri?> authenticate(ExternalAuthProvider provider) async {
    final callback = await _authenticate(uriFor(provider));
    return callback.hasScheme && isSupportedSocialCallbackUri(callback)
        ? callback
        : null;
  }
}

Future<Uri> _authenticateWithBrowserSession(Uri uri) async {
  final callback = await FlutterWebAuth2.authenticate(
    url: uri.toString(),
    callbackUrlScheme: 'xenoh',
  );
  return Uri.parse(callback);
}
