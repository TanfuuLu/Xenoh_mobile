import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/network/api_language.dart';

void main() {
  tearDown(() => setApiLanguageCode('en'));

  test('adds the active API language to every request', () async {
    final adapter = _CapturingAdapter();
    final dio = Dio()..httpClientAdapter = adapter;
    dio.interceptors.add(ApiLanguageInterceptor());

    setApiLanguageCode('vi');

    await dio.get<void>('https://example.test/ping');

    expect(adapter.lastHeaders?['Accept-Language'], 'vi');
  });

  test('falls back to English for unsupported language codes', () async {
    final adapter = _CapturingAdapter();
    final dio = Dio()..httpClientAdapter = adapter;
    dio.interceptors.add(ApiLanguageInterceptor());

    setApiLanguageCode('fr');

    await dio.get<void>('https://example.test/ping');

    expect(adapter.lastHeaders?['Accept-Language'], 'en');
  });
}

class _CapturingAdapter implements HttpClientAdapter {
  Map<String, dynamic>? lastHeaders;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastHeaders = Map<String, dynamic>.from(options.headers);
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}
