import 'package:dio/dio.dart';

import '../../../../core/network/api_language.dart';
import '../dtos/personal_dashboard_dto.dart';

class DashboardRemoteDataSource {
  DashboardRemoteDataSource(this._dio);

  final Dio _dio;

  Future<PersonalDashboardDto> getPersonal() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/dashboard/personal',
      queryParameters: {'lang': apiLanguageCode},
    );
    return PersonalDashboardDto.fromJson(res.data!);
  }
}
