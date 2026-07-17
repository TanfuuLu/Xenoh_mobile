import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/progress_remote_data_source.dart';
import 'progress_repository_impl.dart';

part 'progress_repository_provider.g.dart';

@riverpod
ProgressRepository progressRepository(Ref ref) =>
    ProgressRepositoryImpl(ProgressRemoteDataSource(ref.watch(dioProvider)));
