import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/cycle_models.dart';
import '../../domain/repositories/cycle_repository.dart';
import '../datasources/cycle_remote_data_source.dart';

class CycleRepositoryImpl implements CycleRepository {
  CycleRepositoryImpl(this._remote);

  final CycleRemoteDataSource _remote;

  @override
  Future<CycleOverview> getOverview() async {
    try {
      return (await _remote.getOverview()).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<List<CycleDailyLog>> getLogs({
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final dtos = await _remote.getLogs(from: from, to: to);
      return dtos.map((e) => e.toEntity()).toList(growable: false);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<CycleDailyLog> upsertLog({
    required DateTime date,
    String? flow,
    List<String>? symptoms,
    String? mood,
    int? energyLevel,
    String? notes,
  }) async {
    try {
      return (await _remote.upsertLog(
        date: date,
        flow: flow,
        symptoms: symptoms,
        mood: mood,
        energyLevel: energyLevel,
        notes: notes,
      )).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> deleteLog(DateTime date) async {
    try {
      await _remote.deleteLog(date);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<CycleSettings> getSettings() async {
    try {
      return (await _remote.getSettings()).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<CycleSettings> updateSettings({
    required bool shareWithCoach,
    int? averageCycleLengthOverride,
    int? averagePeriodLengthOverride,
  }) async {
    try {
      return (await _remote.updateSettings(
        shareWithCoach: shareWithCoach,
        averageCycleLengthOverride: averageCycleLengthOverride,
        averagePeriodLengthOverride: averagePeriodLengthOverride,
      )).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<CycleInsight> getInsight({String lang = 'en'}) async {
    try {
      return (await _remote.getInsight(lang: lang)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
