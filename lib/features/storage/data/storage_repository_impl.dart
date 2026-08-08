import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';
import '../domain/storage_models.dart';
import '../domain/storage_repository.dart';
import 'storage_remote_data_source.dart';

class StorageRepositoryImpl implements StorageRepository {
  StorageRepositoryImpl(this._remote);
  final StorageRemoteDataSource _remote;
  Future<T> _call<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw failureFromDio(error);
    }
  }

  @override
  Future<MyFiles> listMine() => _call(_remote.listMine);
  @override
  Future<List<SharedFile>> sharedWithMe() => _call(_remote.sharedWithMe);
  @override
  Future<void> upload(String path, {StorageProgress? onProgress}) =>
      _call(() => _remote.upload(path, onProgress: onProgress));
  @override
  Future<void> delete(String id) => _call(() => _remote.delete(id));
  @override
  Future<String> downloadUrl(String id) => _call(() => _remote.downloadUrl(id));
  @override
  Future<void> share(String id, String clientId) =>
      _call(() => _remote.share(id, clientId));
  @override
  Future<void> unshare(String id, String shareId) =>
      _call(() => _remote.unshare(id, shareId));
}
