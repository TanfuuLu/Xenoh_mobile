import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/storage/data/storage_remote_data_source.dart';

void main() {
  test('loads owned and shared files using the exact storage routes', () async {
    final adapter = _StorageAdapter();
    final source = StorageRemoteDataSource(Dio()..httpClientAdapter = adapter);

    final mine = await source.listMine();
    final shared = await source.sharedWithMe();

    expect(mine.usedBytes, 100);
    expect(mine.files.single.fileName, 'program.pdf');
    expect(shared.single.ownerName, 'Coach');
    expect(adapter.requests, ['GET /files', 'GET /files/shared-with-me']);
  });

  test('uses exact download, share, unshare, and delete contracts', () async {
    final adapter = _StorageAdapter();
    final source = StorageRemoteDataSource(Dio()..httpClientAdapter = adapter);

    expect(await source.downloadUrl('f1'), 'https://files.test/f1');
    await source.share('f1', 'client-1');
    await source.unshare('f1', 'share-1');
    await source.delete('f1');

    expect(adapter.requests, [
      'GET /files/f1/download-url',
      'POST /files/f1/share',
      'DELETE /files/f1/share/share-1',
      'DELETE /files/f1',
    ]);
    expect(adapter.lastJsonBody, {'clientId': 'client-1'});
  });
}

class _StorageAdapter implements HttpClientAdapter {
  final requests = <String>[];
  Map<String, dynamic>? lastJsonBody;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add('${options.method} ${options.path}');
    if (requestStream != null && options.data is! FormData) {
      final bytes = await requestStream.expand((chunk) => chunk).toList();
      if (bytes.isNotEmpty) {
        lastJsonBody = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      }
    }
    final Object body;
    if (options.path == '/files') {
      body = {
        'usedBytes': 100,
        'quotaBytes': 1000,
        'maxFileSizeBytes': 500,
        'files': [_ownedFile],
      };
    } else if (options.path == '/files/shared-with-me') {
      body = [_sharedFile];
    } else if (options.path.endsWith('/download-url')) {
      body = {'url': 'https://files.test/f1'};
    } else {
      body = <String, dynamic>{};
    }
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final _ownedFile = <String, dynamic>{
  'id': 'f1',
  'fileName': 'program.pdf',
  'contentType': 'application/pdf',
  'sizeBytes': 100,
  'createdAt': '2026-08-03T00:00:00Z',
  'sharedWith': <dynamic>[],
};

final _sharedFile = <String, dynamic>{
  'id': 'f2',
  'fileName': 'nutrition.pdf',
  'contentType': 'application/pdf',
  'sizeBytes': 200,
  'createdAt': '2026-08-03T00:00:00Z',
  'ownerName': 'Coach',
};
