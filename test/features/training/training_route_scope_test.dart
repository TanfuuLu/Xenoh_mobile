import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/training/presentation/navigation/training_route_scope.dart';

void main() {
  test('coach training route preserves coach mode and client id', () {
    expect(
      trainingRouteLocation(
        '/plans/plan-1',
        coachView: true,
        clientId: 'client-1',
      ),
      '/plans/plan-1?coachView=true&clientId=client-1',
    );
  });

  test('athlete training route has no coach query parameters', () {
    expect(trainingRouteLocation('/weeks/week-1'), '/weeks/week-1');
  });
}
