/// Runtime configuration, supplied via `--dart-define`.
///
/// Example (Android emulator, dev backend on https://localhost:7017):
///   flutter run --dart-define=API_BASE_URL=https://10.0.2.2:7017/api
/// Production:
///   --dart-define=API_BASE_URL=https://api.xenoh.online/api
abstract final class AppConfig {
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://10.0.2.2:7017/api',
  );

  /// Public origin for exercise images stored in Cloudflare R2.
  ///
  /// The API may return an R2 object key such as
  /// `exercises-image/bench-press.webp`; clients resolve that key against this
  /// origin before rendering it. Override with `--dart-define` per environment.
  static const assetsBaseUrl = String.fromEnvironment(
    'ASSETS_BASE_URL',
    defaultValue: 'https://assets.xenoh.online/',
  );

  /// Allow self-signed certs (dev backend). Defaults to true only for the
  /// localhost-style dev hosts; pass --dart-define=ALLOW_BAD_CERT=false in prod.
  static const allowBadCertificate = bool.fromEnvironment(
    'ALLOW_BAD_CERT',
    defaultValue: true,
  );

  static bool get isLocalhost =>
      apiBaseUrl.contains('localhost') || apiBaseUrl.contains('10.0.2.2');
}
