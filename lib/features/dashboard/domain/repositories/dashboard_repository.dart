import '../entities/personal_dashboard.dart';

abstract interface class DashboardRepository {
  /// Fetch the personal dashboard. Throws a domain `Failure` on error.
  Future<PersonalDashboard> fetchPersonal();
}
