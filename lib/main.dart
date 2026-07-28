import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/network/cookie_jar_provider.dart';
import 'core/network/http_client.dart';
import 'core/storage/secure_cookie_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Let Image.network accept the dev backend's self-signed cert (dev only).
  configureImageHttpOverrides(
    allowBadCertificate: AppConfig.allowBadCertificate,
  );

  final cookieJar = await _createCookieJar();

  runApp(
    ProviderScope(
      overrides: [cookieJarProvider.overrideWithValue(cookieJar)],
      child: const XenohApp(),
    ),
  );
}

Future<CookieJar> _createCookieJar() async {
  if (kIsWeb) {
    // Browser cookies are managed by the browser. Use an in-memory jar so
    // startup does not touch mobile/desktop file-system APIs on web.
    return CookieJar();
  }

  // Persist refresh credentials in Android Keystore / Apple Keychain-backed
  // storage instead of a regular application-support file.
  return PersistCookieJar(
    storage: const SecureCookieStorage(FlutterSecureStorage()),
  );
}
