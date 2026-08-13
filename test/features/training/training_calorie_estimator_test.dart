import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/training/domain/services/training_calorie_estimator.dart';

void main() {
  group('estimateTrainingCalories', () {
    test('estimates six calories per completed training minute', () {
      expect(estimateTrainingCalories(const Duration(minutes: 40)), 240);
    });

    test('rounds partial minutes and keeps positive sessions visible', () {
      expect(estimateTrainingCalories(const Duration(seconds: 1)), 1);
      expect(
        estimateTrainingCalories(const Duration(minutes: 2, seconds: 30)),
        15,
      );
    });

    test('returns zero when there is no elapsed training time', () {
      expect(estimateTrainingCalories(Duration.zero), 0);
      expect(estimateTrainingCalories(const Duration(seconds: -1)), 0);
    });
  });
}
