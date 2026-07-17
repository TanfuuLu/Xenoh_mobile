import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/network/cookie_jar_provider.dart';
import 'core/network/http_client.dart';

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

  // Persist the refresh cookie (xenoh.refresh) across app restarts.
  final dir = await getApplicationSupportDirectory();
  return PersistCookieJar(storage: FileStorage('${dir.path}/.cookies/'));
}
