import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/features/dashboard/data/repositories/dashboard_repository_provider.dart';
import 'package:xenoh_mobile/features/dashboard/domain/entities/personal_dashboard.dart';
import 'package:xenoh_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/providers/dashboard_controller.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

const _dashboard = PersonalDashboard(
  profile: DashboardProfile(
    firstName: 'Ada',
    currentStreak: 3,
    level: 2,
    totalXp: 150,
    xpToNextLevel: 50,
    title: 'Apprentice',
  ),
  nutritionToday: NutritionToday(
    loggedCalories: 1200,
    loggedProteinG: 80,
    loggedCarbsG: 100,
    loggedFatG: 40,
  ),
  proInsights: ProInsights(isUnlocked: false),
);

ProviderContainer _container(DashboardRepository repo) {
  final container = ProviderContainer(
    overrides: [dashboardRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('emits the dashboard from the repository', () async {
    final repo = MockDashboardRepository();
    when(repo.fetchPersonal).thenAnswer((_) async => _dashboard);

    final container = _container(repo);
    final data = await container.read(dashboardControllerProvider.future);

    expect(data.profile.firstName, 'Ada');
    expect(data.profile.currentStreak, 3);
    expect(data.proInsights.isUnlocked, isFalse);
  });

  test('surfaces a failure as AsyncError', () async {
    final repo = MockDashboardRepository();
    when(repo.fetchPersonal).thenThrow(const NetworkFailure());

    final container = _container(repo);
    // Keep the auto-dispose provider alive while it resolves.
    final sub = container.listen(dashboardControllerProvider, (_, _) {});
    addTearDown(sub.close);

    await Future<void>.delayed(Duration.zero);

    final state = sub.read();
    expect(state.hasError, isTrue);
    expect(state.error, isA<NetworkFailure>());
  });
}
