import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_language.dart';
import 'auth_interceptor.dart';
import 'cookie_jar_provider.dart';
import 'http_client.dart';

part 'dio_provider.g.dart';

/// Signals that the session expired (refresh failed). The auth controller
/// watches this to drop back to the unauthenticated state; the router then
/// redirects to `/login`.
@Riverpod(keepAlive: true)
class SessionExpired extends _$SessionExpired {
  @override
  bool build() => false;

  void trigger() => state = true;
  void reset() => state = false;
}

/// The single shared authenticated [Dio] instance.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );

  final cookieJar = ref.watch(cookieJarProvider);
  if (!kIsWeb) dio.interceptors.add(CookieManager(cookieJar));
  dio.interceptors.add(ApiLanguageInterceptor());
  dio.interceptors.add(
    AuthInterceptor(
      tokens: ref.watch(tokenStorageProvider),
      cookieJar: cookieJar,
      baseUrl: AppConfig.apiBaseUrl,
      allowBadCertificate: AppConfig.allowBadCertificate,
      onSessionExpired: () =>
          ref.read(sessionExpiredProvider.notifier).trigger(),
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        // Auth endpoints carry passwords, reset codes, tickets, and tokens.
        // Log metadata only so debug device logs never contain credentials.
        requestBody: false,
        responseBody: false,
        requestHeader: false,
        responseHeader: false,
        logPrint: (o) => debugPrint('$o'),
      ),
    );
  }

  configureHttpClient(dio, allowBadCertificate: AppConfig.allowBadCertificate);
  return dio;
}
