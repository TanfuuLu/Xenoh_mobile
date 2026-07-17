import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';

import '../storage/token_storage.dart';
import 'api_language.dart';
import 'http_client.dart';

/// Injects `Authorization: Bearer <accessToken>` and transparently refreshes a
/// 60-min access token on `401` using the `xenoh.refresh` cookie, then retries
/// the original request once. A single in-flight refresh is shared by all
/// concurrent 401s (see API ref §1 auth + §6.5/§6.6).
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenStorage tokens,
    required CookieJar cookieJar,
    required String baseUrl,
    required bool allowBadCertificate,
    required this.onSessionExpired,
  }) : _tokens = tokens,
       _refreshDio = _buildRefreshDio(
         baseUrl: baseUrl,
         cookieJar: cookieJar,
         allowBadCertificate: allowBadCertificate,
       );

  final TokenStorage _tokens;
  final Dio _refreshDio;

  /// Called after a failed refresh so the app can return to the login screen.
  final void Function() onSessionExpired;

  static const _refreshPath = '/auth/refresh-token';
  static const _retriedFlag = 'x-retried';

  Future<bool>? _ongoingRefresh;

  static Dio _buildRefreshDio({
    required String baseUrl,
    required CookieJar cookieJar,
    required bool allowBadCertificate,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    if (!kIsWeb) dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(ApiLanguageInterceptor());
    configureHttpClient(dio, allowBadCertificate: allowBadCertificate);
    return dio;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokens.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final isUnauthorized = response?.statusCode == 401;
    final isRefreshCall = err.requestOptions.path.contains(_refreshPath);
    final alreadyRetried = err.requestOptions.extra[_retriedFlag] == true;

    if (!isUnauthorized || isRefreshCall || alreadyRetried) {
      handler.next(err);
      return;
    }

    final refreshed = await _refresh();
    if (!refreshed) {
      onSessionExpired();
      handler.next(err);
      return;
    }

    try {
      final retried = await _retry(err.requestOptions);
      handler.resolve(retried);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  /// Single-flight refresh: concurrent 401s await the same call.
  Future<bool> _refresh() {
    return _ongoingRefresh ??= _doRefresh().whenComplete(() {
      _ongoingRefresh = null;
    });
  }

  Future<bool> _doRefresh() async {
    try {
      final res = await _refreshDio.post<Map<String, dynamic>>(_refreshPath);
      final token = res.data?['accessToken'] as String?;
      if (token == null || token.isEmpty) return false;
      _tokens.accessToken = token;
      return true;
    } on DioException {
      await _tokens.clear();
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options) {
    final token = _tokens.accessToken;
    return _refreshDio.fetch<dynamic>(
      options
        ..headers['Authorization'] = 'Bearer $token'
        ..extra[_retriedFlag] = true,
    );
  }
}
