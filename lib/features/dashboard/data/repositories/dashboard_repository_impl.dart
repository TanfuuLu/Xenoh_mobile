import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/personal_dashboard.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this._remote);

  final DashboardRemoteDataSource _remote;

  @override
  Future<PersonalDashboard> fetchPersonal() async {
    try {
      final dto = await _remote.getPersonal();
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
