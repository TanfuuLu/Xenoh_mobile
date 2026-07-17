import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../datasources/nutrition_remote_data_source.dart';
import 'nutrition_repository_impl.dart';

part 'nutrition_repository_provider.g.dart';

@riverpod
NutritionRepository nutritionRepository(Ref ref) =>
    NutritionRepositoryImpl(NutritionRemoteDataSource(ref.watch(dioProvider)));
