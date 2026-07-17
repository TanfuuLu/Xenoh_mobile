import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/cookie_jar_provider.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import 'auth_repository_impl.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
  remote: AuthRemoteDataSource(ref.watch(dioProvider)),
  tokens: ref.watch(tokenStorageProvider),
  cookieJar: ref.watch(cookieJarProvider),
);
