import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/nutrition/data/datasources/nutrition_remote_data_source.dart';

void main() {
  test(
    'loads coach-visible client nutrition from client-scoped endpoints',
    () async {
      final adapter = _ClientNutritionAdapter();
      final source = NutritionRemoteDataSource(
        Dio()..httpClientAdapter = adapter,
      );

      final summary = await source.getClientSummary('client-1');
      final log = await source.getClientDailyLog(
        'client-1',
        DateTime(2026, 8, 3),
      );
      final history = await source.getClientHistory(
        'client-1',
        from: DateTime(2026, 7, 28),
        to: DateTime(2026, 8, 3),
      );

      expect(summary.calculation.calorieTarget, 2250);
      expect(log?.calories, 2100);
      expect(history, hasLength(2));
      expect(adapter.requests, [
        '/nutrition/clients/client-1/summary',
        '/nutrition/clients/client-1/logs/2026-08-03',
        '/nutrition/clients/client-1/history?from=2026-07-28&to=2026-08-03',
      ]);
    },
  );

  test('returns null when the client has no daily log for the date', () async {
    final adapter = _ClientNutritionAdapter(missingDailyLog: true);
    final source = NutritionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final log = await source.getClientDailyLog(
      'client-1',
      DateTime(2026, 8, 2),
    );

    expect(log, isNull);
  });

  test('loads athlete history from the non-client endpoint', () async {
    final adapter = _ClientNutritionAdapter();
    final source = NutritionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final history = await source.getHistory(
      from: DateTime(2026, 7, 21),
      to: DateTime(2026, 8, 3),
    );

    expect(history, hasLength(2));
    expect(
      adapter.requests.single,
      '/nutrition/history?from=2026-07-21&to=2026-08-03',
    );
  });
}

class _ClientNutritionAdapter implements HttpClientAdapter {
  _ClientNutritionAdapter({this.missingDailyLog = false});

  final bool missingDailyLog;
  final List<String> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final query = options.queryParameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
    requests.add('${options.path}${query.isEmpty ? '' : '?$query'}');

    if (missingDailyLog && options.path.contains('/logs/')) {
      return ResponseBody.fromString('', 404);
    }

    final response = switch (options.path) {
      '/nutrition/clients/client-1/summary' => {
        'profile': {'activityLevel': 'ModeratelyActive', 'goal': 'Maintain'},
        'calculation': {'calorieTarget': 2250, 'missingFields': <String>[]},
        'todayLog': null,
        'canUseAdvancedAnalysis': true,
      },
      '/nutrition/clients/client-1/logs/2026-08-03' => {
        'date': '2026-08-03',
        'calories': 2100,
        'proteinG': 120.0,
        'carbsG': 250.0,
        'fatG': 60.0,
        'notes': null,
      },
      '/nutrition/clients/client-1/history' => [
        {
          'date': '2026-08-02',
          'calories': 2000,
          'proteinG': 110.0,
          'carbsG': 240.0,
          'fatG': 58.0,
        },
        {
          'date': '2026-08-03',
          'calories': 2100,
          'proteinG': 120.0,
          'carbsG': 250.0,
          'fatG': 60.0,
        },
      ],
      '/nutrition/history' => [
        {
          'date': '2026-08-02',
          'calories': 2000,
          'proteinG': 110.0,
          'carbsG': 240.0,
          'fatG': 58.0,
        },
        {
          'date': '2026-08-03',
          'calories': 2100,
          'proteinG': 120.0,
          'carbsG': 250.0,
          'fatG': 60.0,
        },
      ],
      _ => throw StateError('Unexpected request: ${options.path}'),
    };

    return ResponseBody.fromString(
      jsonEncode(response),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
