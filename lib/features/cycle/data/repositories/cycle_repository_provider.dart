import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/cycle_repository.dart';
import '../datasources/cycle_remote_data_source.dart';
import 'cycle_repository_impl.dart';

part 'cycle_repository_provider.g.dart';

@riverpod
CycleRepository cycleRepository(Ref ref) =>
    CycleRepositoryImpl(CycleRemoteDataSource(ref.watch(dioProvider)));
