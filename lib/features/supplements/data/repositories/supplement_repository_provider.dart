import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/supplement_repository.dart';
import '../datasources/supplement_remote_data_source.dart';
import 'supplement_repository_impl.dart';

part 'supplement_repository_provider.g.dart';

@riverpod
SupplementRepository supplementRepository(Ref ref) => SupplementRepositoryImpl(
  SupplementRemoteDataSource(ref.watch(dioProvider)),
);
