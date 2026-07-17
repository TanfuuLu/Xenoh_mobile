import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';
import 'dashboard_repository_impl.dart';

part 'dashboard_repository_provider.g.dart';

@riverpod
DashboardRepository dashboardRepository(Ref ref) =>
    DashboardRepositoryImpl(DashboardRemoteDataSource(ref.watch(dioProvider)));
