import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/current_date_provider.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../data/repositories/dashboard_repository_provider.dart';
import '../../domain/entities/personal_dashboard.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  Future<PersonalDashboard> build() {
    // "Today's workout" is computed server-side from the request date, so
    // this must refetch whenever the app's notion of "today" changes (e.g.
    // the app was backgrounded overnight and resumed the next day) — not
    // just once per app session. See `currentDateProvider`.
    ref
      ..watch(currentDateProvider)
      ..watch(appLocaleProvider);
    return ref.watch(dashboardRepositoryProvider).fetchPersonal();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      () => ref.read(dashboardRepositoryProvider).fetchPersonal(),
    );
  }
}
