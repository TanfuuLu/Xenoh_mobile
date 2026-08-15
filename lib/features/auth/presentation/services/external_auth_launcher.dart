import 'package:url_launcher/url_launcher.dart';

enum ExternalAuthProvider {
  google('google'),
  facebook('facebook');

  const ExternalAuthProvider(this.wireValue);

  final String wireValue;
}

typedef ExternalUrlOpener = Future<bool> Function(Uri uri);

class ExternalAuthLauncher {
  ExternalAuthLauncher({
    required String apiBaseUrl,
    ExternalUrlOpener? openUrl,
  }) : _apiBaseUrl = apiBaseUrl,
       _openUrl = openUrl ?? _openInExternalBrowser;

  final String _apiBaseUrl;
  final ExternalUrlOpener _openUrl;

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

  Future<bool> launch(ExternalAuthProvider provider) =>
      _openUrl(uriFor(provider));
}

Future<bool> _openInExternalBrowser(Uri uri) =>
    launchUrl(uri, mode: LaunchMode.externalApplication);
