import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/workout_notification/workout_notification_controller.dart';

void main() {
  group('buildWorkoutNotificationSetInfo', () {
    test('shows the current set, reps, and compact weight', () {
      expect(
        buildWorkoutNotificationSetInfo(
          completedSets: 0,
          plannedSets: 4,
          plannedReps: 6,
          plannedWeight: 43.5,
        ),
        'Set 1 of 4 • 6 reps • 43.5 kg',
      );
    });

    test('omits weight when it is not planned', () {
      expect(
        buildWorkoutNotificationSetInfo(
          completedSets: 2,
          plannedSets: 3,
          plannedReps: 10,
        ),
        'Set 3 of 3 • 10 reps',
      );
    });

    test('does not show a set number beyond the plan', () {
      expect(
        buildWorkoutNotificationSetInfo(
          completedSets: 4,
          plannedSets: 4,
          plannedReps: 6,
          plannedWeight: 60,
        ),
        'Set 4 of 4 • 6 reps • 60 kg',
      );
    });
  });
}
