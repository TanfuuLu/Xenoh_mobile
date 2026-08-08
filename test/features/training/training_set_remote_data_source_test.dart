import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/training/data/datasources/training_remote_data_source.dart';

void main() {
  test('updates one incomplete set plan with the backend contract', () async {
    final adapter = _TrainingSetAdapter();
    final source = TrainingRemoteDataSource(Dio()..httpClientAdapter = adapter);

    final exercise = await source.updateSetPlan(
      'set-1',
      plannedReps: 6,
      plannedWeight: 102.5,
    );

    expect(adapter.lastRequest?.method, 'PATCH');
    expect(adapter.lastRequest?.path, '/exercises/sets/set-1');
    expect(adapter.lastBody, {'plannedReps': 6, 'plannedWeight': 102.5});
    expect(exercise.sets.single.plannedWeight, 102.5);
  });

  test('loads the last completed performance for this workout owner', () async {
    final adapter = _TrainingSetAdapter();
    final source = TrainingRemoteDataSource(Dio()..httpClientAdapter = adapter);

    final performance = await source.getLastExercisePerformance(
      exerciseTemplateId: 'template-1',
      dailyWorkoutId: 'day-1',
    );

    expect(
      adapter.requestUri,
      '/exercise-templates/template-1/last-performance?dailyWorkoutId=day-1',
    );
    expect(performance.lastActualWeight, 100);
    expect(performance.lastActualReps, 5);
    expect(performance.lastRpe, 8.5);
    expect(performance.workoutDate, DateTime(2026, 7, 27));
  });

  test('loads exercise templates in the selected client scope', () async {
    final adapter = _TrainingSetAdapter();
    final source = TrainingRemoteDataSource(Dio()..httpClientAdapter = adapter);

    final templates = await source.getExerciseTemplates(
      muscleGroup: 'Quads',
      clientId: 'client-1',
    );

    expect(
      adapter.requestUri,
      '/exercise-templates/for-client/client-1?muscleGroup=Quads',
    );
    expect(templates.single.ownerId, 'client-1');
  });

  test('creates a custom exercise template for the selected client', () async {
    final adapter = _TrainingSetAdapter();
    final source = TrainingRemoteDataSource(Dio()..httpClientAdapter = adapter);

    await source.createCustomExerciseTemplate(
      name: 'Client squat',
      primaryMuscleGroup: 'Quads',
      secondaryMuscleGroups: const [],
      exerciseKind: 'Strength',
      clientId: 'client-1',
    );

    expect(adapter.lastRequest?.method, 'POST');
    expect(
      adapter.lastRequest?.path,
      '/exercise-templates/custom/for-client/client-1',
    );
    expect(adapter.lastBody?['clientId'], 'client-1');
  });
}

class _TrainingSetAdapter implements HttpClientAdapter {
  RequestOptions? lastRequest;
  Map<String, dynamic>? lastBody;
  String? requestUri;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    lastBody = options.data is Map
        ? Map<String, dynamic>.from(options.data as Map)
        : null;
    final query = options.queryParameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
    requestUri = '${options.path}${query.isEmpty ? '' : '?$query'}';

    final response = switch (options.path) {
      '/exercises/sets/set-1' => {
        'id': 'exercise-1',
        'exerciseTemplateId': 'template-1',
        'name': 'Squat',
        'primaryMuscleGroup': 'Quadriceps',
        'exerciseKind': 'Strength',
        'plannedSets': 1,
        'plannedReps': 6,
        'completedSetsCount': 0,
        'isCompleted': false,
        'isSkipped': false,
        'dailyWorkoutId': 'day-1',
        'sortOrder': 0,
        'sets': [
          {
            'id': 'set-1',
            'setNumber': 1,
            'plannedReps': 6,
            'plannedWeight': 102.5,
            'isCompleted': false,
          },
        ],
      },
      '/exercise-templates/template-1/last-performance' => {
        'exerciseTemplateId': 'template-1',
        'lastActualWeight': 100.0,
        'lastActualReps': 5,
        'lastRpe': 8.5,
        'performedAt': '2026-07-27T10:00:00Z',
        'workoutDate': '2026-07-27',
      },
      '/exercise-templates/for-client/client-1' => [
        {
          'id': 'client-template-1',
          'name': 'Client squat',
          'primaryMuscleGroup': 'Quads',
          'exerciseKind': 'Strength',
          'isCustom': true,
          'ownerId': 'client-1',
        },
      ],
      '/exercise-templates/custom/for-client/client-1' => {
        'id': 'client-template-1',
        'name': 'Client squat',
        'primaryMuscleGroup': 'Quads',
        'exerciseKind': 'Strength',
        'isCustom': true,
        'ownerId': 'client-1',
      },
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
