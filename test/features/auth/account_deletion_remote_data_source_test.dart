import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/auth/data/datasources/auth_remote_data_source.dart';

void main() {
  test('verifies account deletion with the public token contract', () async {
    final adapter = _AccountDeletionAdapter();
    final source = AuthRemoteDataSource(Dio()..httpClientAdapter = adapter);

    await source.verifyAccountDeletion('delete-token');

    expect(adapter.path, '/auth/account-deletion-requests/verify');
    expect(adapter.method, 'POST');
    expect(adapter.body, {'token': 'delete-token'});
  });
}

class _AccountDeletionAdapter implements HttpClientAdapter {
  String? path;
  String? method;
  Map<String, dynamic>? body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    path = options.path;
    method = options.method;
    final bytes = await requestStream?.expand((chunk) => chunk).toList();
    body = jsonDecode(utf8.decode(bytes ?? const [])) as Map<String, dynamic>;
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}
