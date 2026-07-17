import 'package:dio/dio.dart';

import '../../../../core/utils/date_only.dart';
import '../dtos/cycle_dtos.dart';

class CycleRemoteDataSource {
  CycleRemoteDataSource(this._dio);

  final Dio _dio;

  Future<CycleOverviewDto> getOverview() async {
    final res = await _dio.get<Map<String, dynamic>>('/cycle/overview');
    return CycleOverviewDto.fromJson(res.data!);
  }

  Future<List<CycleDailyLogDto>> getLogs({
    required DateTime from,
    required DateTime to,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      '/cycle/logs',
      queryParameters: {
        'from': DateOnly.format(from),
        'to': DateOnly.format(to),
      },
    );
    return (res.data ?? const [])
        .map((e) => CycleDailyLogDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<CycleDailyLogDto> upsertLog({
    required DateTime date,
    String? flow,
    List<String>? symptoms,
    String? mood,
    int? energyLevel,
    String? notes,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/cycle/logs/${DateOnly.format(date)}',
      data: {
        'flow': flow,
        'symptoms': symptoms ?? const <String>[],
        'mood': mood,
        'energyLevel': energyLevel,
        'notes': notes,
      },
    );
    return CycleDailyLogDto.fromJson(res.data!);
  }

  Future<void> deleteLog(DateTime date) async {
    await _dio.delete<void>('/cycle/logs/${DateOnly.format(date)}');
  }

  Future<CycleSettingsDto> getSettings() async {
    final res = await _dio.get<Map<String, dynamic>>('/cycle/settings');
    return CycleSettingsDto.fromJson(res.data!);
  }

  Future<CycleSettingsDto> updateSettings({
    required bool shareWithCoach,
    int? averageCycleLengthOverride,
    int? averagePeriodLengthOverride,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/cycle/settings',
      data: {
        'averageCycleLengthOverride': averageCycleLengthOverride,
        'averagePeriodLengthOverride': averagePeriodLengthOverride,
        'shareWithCoach': shareWithCoach,
      },
    );
    return CycleSettingsDto.fromJson(res.data!);
  }

  Future<CycleInsightDto> getInsight({String lang = 'en'}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/cycle/insight',
      queryParameters: {'lang': lang},
    );
    return CycleInsightDto.fromJson(res.data!);
  }
}
