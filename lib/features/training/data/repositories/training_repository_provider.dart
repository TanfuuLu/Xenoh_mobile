import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/training_repository.dart';
import '../datasources/training_remote_data_source.dart';
import 'training_repository_impl.dart';

part 'training_repository_provider.g.dart';

@riverpod
TrainingRepository trainingRepository(Ref ref) =>
    TrainingRepositoryImpl(TrainingRemoteDataSource(ref.watch(dioProvider)));
