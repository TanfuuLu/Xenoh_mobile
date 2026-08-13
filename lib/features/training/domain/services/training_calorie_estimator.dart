import 'dart:math' as math;

/// Provides a lightweight estimate for strength-training sessions when the
/// API only supplies elapsed time. The product currently uses a six-kcal per
/// minute baseline in its weekly training summaries.
int estimateTrainingCalories(Duration duration) {
  final seconds = duration.inSeconds;
  if (seconds <= 0) return 0;
  return math.max(1, (seconds / 10).round());
}
