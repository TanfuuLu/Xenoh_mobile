import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/chart_axis_layout.dart';

void main() {
  group('visibleChartTickIndexes', () {
    test('keeps every label when the axis has enough room', () {
      expect(
        visibleChartTickIndexes(
          itemCount: 4,
          availableWidth: 240,
          minLabelSpacing: 48,
        ),
        [0, 1, 2, 3],
      );
    });

    test('thins a dense axis while preserving both endpoints', () {
      final indexes = visibleChartTickIndexes(
        itemCount: 24,
        availableWidth: 320,
        minLabelSpacing: 48,
      );

      expect(indexes.length, lessThanOrEqualTo(6));
      expect(indexes.first, 0);
      expect(indexes.last, 23);
      expect(indexes.toSet(), hasLength(indexes.length));
    });

    test('handles empty and single-point axes', () {
      expect(
        visibleChartTickIndexes(
          itemCount: 0,
          availableWidth: 320,
          minLabelSpacing: 48,
        ),
        isEmpty,
      );
      expect(
        visibleChartTickIndexes(
          itemCount: 1,
          availableWidth: 20,
          minLabelSpacing: 48,
        ),
        [0],
      );
    });
  });
}
