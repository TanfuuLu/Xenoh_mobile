import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/client_detail_screen.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/clients_screen.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';

class _FakeXenohApi extends XenohApi {
  _FakeXenohApi() : super(Dio());

  final requestedPaths = <String>[];
  final postedBodies = <JsonMap>[];
  final putBodies = <JsonMap>[];

  @override
  Future<JsonMap> getObject(String path) async {
    requestedPaths.add(path);
    if (path == '/nutrition/clients/client-1/summary') {
      return {
        'profile': {'activityLevel': 'Moderate', 'goal': 'Maintain'},
        'calculation': {
          'missingFields': <String>[],
          'tdee': 2586,
          'calorieTarget': 2250,
          'proteinG': 120.0,
          'carbsG': 314.0,
          'fatG': 57.0,
        },
        'todayLog': {
          'date': '2026-08-03',
          'calories': 1800,
          'proteinG': 105.0,
          'carbsG': 220.0,
          'fatG': 50.0,
        },
        'canUseAdvancedAnalysis': true,
      };
    }
    return {
      'id': 'client-1',
      'email': 'demo@xenoh.app',
      'firstName': 'Demo',
      'lastName': 'Athlete',
      'avatarUrl': 'https://assets.xenoh.online/avatars/client-1.webp',
      'height': 165,
      'dateOfBirth': '1998-07-22',
      'latestBodyweight': 63.2,
      'bmi': 23.2,
      'dotsScore': 274.1,
    };
  }

  @override
  Future<List<JsonMap>> getList(String path) async {
    requestedPaths.add(path);
    if (path == '/plans/coach-overview?pageNumber=1&pageSize=100') {
      return [
        {
          'id': 'plan-1',
          'name': 'Strength block',
          'ownerId': 'client-1',
          'planType': 'Coach',
          'startDate': '2026-08-01',
          'endDate': '2026-08-31',
          'totalWeeks': 4,
        },
        {
          'id': 'other-plan',
          'ownerId': 'client-2',
          'planType': 'Coach',
        },
      ];
    }
    if (path == '/coach-client/dashboard') {
      return [
        {
          'clientId': 'client-1',
          'activePlanId': 'plan-1',
          'planProgressPercent': 42,
        },
      ];
    }
    if (path == '/exercise-templates/for-client/client-1') {
      return [
        {
          'id': 'exercise-1',
          'name': 'Tempo squat',
          'primaryMuscleGroup': 'Quads',
          'exerciseKind': 'Strength',
          'isCustom': true,
          'secondaryMuscleGroups': ['Glutes'],
          'description': 'Three-second eccentric.',
          'ownerId': 'client-1',
        },
        {
          'id': 'exercise-2',
          'name': 'Shared exercise',
          'primaryMuscleGroup': 'Back',
          'exerciseKind': 'Strength',
          'isCustom': false,
          'ownerId': null,
        },
      ];
    }
    return [];
  }

  @override
  Future<JsonMap> postObject(String path, JsonMap data) async {
    requestedPaths.add(path);
    postedBodies.add(data);
    return {
      'id': 'created-exercise',
      'name': data['name'],
      'description': data['description'],
      'primaryMuscleGroup': data['primaryMuscleGroup'],
      'secondaryMuscleGroups': data['secondaryMuscleGroups'],
      'exerciseKind': data['exerciseKind'],
      'isCustom': true,
      'ownerId': data['clientId'],
      'imageUrl': null,
    };
  }

  @override
  Future<JsonMap> putObject(String path, JsonMap data) async {
    requestedPaths.add(path);
    putBodies.add(data);
    return {
      'id': data['id'],
      'name': data['name'],
      'description': data['description'],
      'primaryMuscleGroup': data['primaryMuscleGroup'],
      'secondaryMuscleGroups': data['secondaryMuscleGroups'],
      'exerciseKind': data['exerciseKind'],
      'isCustom': true,
      'ownerId': 'client-1',
    };
  }

  @override
  Future<void> delete(String path) async {
    requestedPaths.add(path);
  }
}

void main() {
  test('coach dashboard preserves the backend per-client array', () async {
    final api = _FakeXenohApi();
    final container = ProviderContainer(
      overrides: [xenohApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);

    final dashboard = await container.read(coachDashboardProvider.future);

    expect(api.requestedPaths, ['/coach-client/dashboard']);
    expect(dashboard.single['clientId'], 'client-1');
    expect(dashboard.single['planProgressPercent'], 42);
  });

  test('coach client profile uses the private user profile contract', () async {
    final api = _FakeXenohApi();
    final container = ProviderContainer(
      overrides: [xenohApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);

    final profile = await container.read(
      clientProfileProvider('client-1').future,
    );

    expect(api.requestedPaths, ['/users/client-1']);
    expect(profile['fullName'], 'Demo Athlete');
    expect(
      profile['avatarUrl'],
      'https://assets.xenoh.online/avatars/client-1.webp',
    );
    expect(profile['height'], 165);
    expect(profile['dateOfBirth'], '1998-07-22');
    expect(profile['latestBodyweight'], 63.2);
    expect(profile['bmi'], 23.2);
    expect(profile['dotsScore'], 274.1);
  });

  test(
    'coach nutrition summary preserves the nested website contract',
    () async {
      final api = _FakeXenohApi();
      final container = ProviderContainer(
        overrides: [xenohApiProvider.overrideWithValue(api)],
      );
      addTearDown(container.dispose);

      final summary = await container.read(
        clientNutritionProvider('client-1').future,
      );

      expect(api.requestedPaths, ['/nutrition/clients/client-1/summary']);
      expect(summary.profile.goal, 'Maintain');
      expect(summary.calculation.tdee, 2586);
      expect(summary.calculation.calorieTarget, 2250);
      expect(summary.calculation.proteinG, 120);
      expect(summary.calculation.carbsG, 314);
      expect(summary.calculation.fatG, 57);
      expect(summary.todayLog?.calories, 1800);
    },
  );

  test('coach plans include the matching dashboard progress', () async {
    final api = _FakeXenohApi();
    final container = ProviderContainer(
      overrides: [xenohApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);

    final plans = await container.read(clientPlansProvider('client-1').future);

    expect(api.requestedPaths, [
      '/plans/coach-overview?pageNumber=1&pageSize=100',
      '/coach-client/dashboard',
    ]);
    expect(plans, hasLength(1));
    expect(plans.single['id'], 'plan-1');
    expect(plans.single['progressPercent'], 42);
    expect(plans.single['isActive'], isTrue);
  });

  test(
    'coach client exercises use the same for-client endpoint as web',
    () async {
      final api = _FakeXenohApi();
      final container = ProviderContainer(
        overrides: [xenohApiProvider.overrideWithValue(api)],
      );
      addTearDown(container.dispose);

      final exercises = await container.read(
        clientExerciseTemplatesProvider('client-1').future,
      );

      expect(api.requestedPaths, [
        '/exercise-templates/for-client/client-1',
      ]);
      expect(exercises, hasLength(1));
      expect(exercises.single.name, 'Tempo squat');
      expect(exercises.single.ownerId, 'client-1');
      expect(exercises.single.secondaryMuscleGroups, ['Glutes']);
    },
  );

  test('coach creates a custom exercise owned by the client', () async {
    final api = _FakeXenohApi();

    final created = await createCustomExerciseForClient(
      api: api,
      clientId: 'client-1',
      name: 'Tempo squat',
      description: 'Three-second eccentric.',
      primaryMuscleGroup: 'Quads',
      secondaryMuscleGroups: ['Glutes'],
      exerciseKind: 'Strength',
    );

    expect(api.requestedPaths, [
      '/exercise-templates/custom/for-client/client-1',
    ]);
    expect(api.postedBodies.single, {
      'clientId': 'client-1',
      'name': 'Tempo squat',
      'description': 'Three-second eccentric.',
      'primaryMuscleGroup': 'Quads',
      'secondaryMuscleGroups': ['Glutes'],
      'exerciseKind': 'Strength',
    });
    expect(created.id, 'created-exercise');
    expect(created.ownerId, 'client-1');
  });

  test('coach updates a custom exercise owned by the client', () async {
    final api = _FakeXenohApi();

    final updated = await updateCustomExerciseForClient(
      api: api,
      exerciseId: 'exercise-1',
      name: 'Paused squat',
      description: 'Two-second pause.',
      primaryMuscleGroup: 'Quads',
      secondaryMuscleGroups: ['Glutes'],
      exerciseKind: 'Strength',
    );

    expect(api.requestedPaths, ['/exercise-templates/custom/exercise-1']);
    expect(api.putBodies.single, {
      'id': 'exercise-1',
      'name': 'Paused squat',
      'description': 'Two-second pause.',
      'primaryMuscleGroup': 'Quads',
      'secondaryMuscleGroups': ['Glutes'],
      'exerciseKind': 'Strength',
    });
    expect(updated.name, 'Paused squat');
  });

  test('coach deletes a custom exercise owned by the client', () async {
    final api = _FakeXenohApi();

    await deleteCustomExerciseForClient(
      api: api,
      exerciseId: 'exercise-1',
    );

    expect(api.requestedPaths, ['/exercise-templates/custom/exercise-1']);
  });
}
