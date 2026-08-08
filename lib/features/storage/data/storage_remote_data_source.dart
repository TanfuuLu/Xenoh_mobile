import 'package:dio/dio.dart';

import '../domain/storage_models.dart';

class StorageRemoteDataSource {
  StorageRemoteDataSource(this._dio);
  final Dio _dio;
  Future<MyFiles> listMine() async =>
      MyFiles.fromJson((await _dio.get<Map<String, dynamic>>('/files')).data!);
  Future<List<SharedFile>> sharedWithMe() async =>
      ((await _dio.get<List<dynamic>>('/files/shared-with-me')).data ??
              const [])
          .map((item) => SharedFile.fromJson(item as Map<String, dynamic>))
          .toList();
  Future<void> upload(
    String path, {
    void Function(int sent, int total)? onProgress,
  }) async {
    final form = FormData.fromMap({'file': await MultipartFile.fromFile(path)});
    await _dio.post<void>('/files', data: form, onSendProgress: onProgress);
  }

  Future<void> delete(String id) => _dio.delete<void>('/files/$id');
  Future<String> downloadUrl(String id) async =>
      (await _dio.get<Map<String, dynamic>>(
        '/files/$id/download-url',
      )).data!['url'].toString();
  Future<void> share(String id, String clientId) =>
      _dio.post<void>('/files/$id/share', data: {'clientId': clientId});
  Future<void> unshare(String id, String shareId) =>
      _dio.delete<void>('/files/$id/share/$shareId');
}
