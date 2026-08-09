import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../data/storage_remote_data_source.dart';
import '../data/storage_repository_impl.dart';
import '../domain/storage_models.dart';
import '../domain/storage_repository.dart';

final storageRemoteProvider = Provider<StorageRemoteDataSource>(
  (ref) => StorageRemoteDataSource(ref.watch(dioProvider)),
);
final storageRepositoryProvider = Provider<StorageRepository>(
  (ref) => StorageRepositoryImpl(ref.watch(storageRemoteProvider)),
);
final myFilesProvider = FutureProvider.autoDispose<MyFiles>(
  (ref) => ref.watch(storageRepositoryProvider).listMine(),
);
final sharedFilesProvider = FutureProvider.autoDispose<List<SharedFile>>(
  (ref) => ref.watch(storageRepositoryProvider).sharedWithMe(),
);
