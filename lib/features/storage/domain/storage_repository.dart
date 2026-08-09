import 'storage_models.dart';

typedef StorageProgress = void Function(int sent, int total);

abstract interface class StorageRepository {
  Future<MyFiles> listMine();
  Future<List<SharedFile>> sharedWithMe();
  Future<void> upload(String path, {StorageProgress? onProgress});
  Future<void> delete(String id);
  Future<String> downloadUrl(String id);
  Future<void> share(String id, String clientId);
  Future<void> unshare(String id, String shareId);
}
