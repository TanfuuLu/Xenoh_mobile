import 'package:flutter/foundation.dart';

/// Runtime configuration, supplied via `--dart-define`.
///
/// Example (Android emulator, dev backend on https://localhost:7017):
///   flutter run --dart-define=API_BASE_URL=https://10.0.2.2:7017/api
/// Production:
///   --dart-define=API_BASE_URL=https://api.xenoh.online/api
abstract final class AppConfig {
  static const _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

  /// Release builds fail safe to the public API when a build pipeline omits
  /// `API_BASE_URL`; debug builds retain the Android-emulator convenience.
  static final apiBaseUrl = resolveApiBaseUrl(
    configured: _apiBaseUrlOverride,
    isRelease: kReleaseMode,
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

  /// Explicit opt-in for a self-signed local development backend.
  static const _allowBadCertificateRequested = bool.fromEnvironment(
    'ALLOW_BAD_CERT',
    defaultValue: false,
  );

  static bool get isLocalhost =>
      apiBaseUrl.contains('localhost') || apiBaseUrl.contains('10.0.2.2');

  /// Certificate bypass is impossible in release builds and for remote hosts,
  /// even when a bad production build flag is supplied.
  static bool get allowBadCertificate => canAllowBadCertificate(
    requested: _allowBadCertificateRequested,
    isDebug: kDebugMode,
    isLocalhost: isLocalhost,
  );
}

@visibleForTesting
String resolveApiBaseUrl({
  required String configured,
  required bool isRelease,
}) {
  if (configured.isNotEmpty) return configured;
  return isRelease
      ? 'https://api.xenoh.online/api'
      : 'https://10.0.2.2:7017/api';
}

@visibleForTesting
bool canAllowBadCertificate({
  required bool requested,
  required bool isDebug,
  required bool isLocalhost,
}) => requested && isDebug && isLocalhost;
