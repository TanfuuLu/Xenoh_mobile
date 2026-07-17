import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_activity.freezed.dart';

/// Monthly training activity for the calendar + totals
/// (`TrainingActivityResponse`, API ref §3.2).
@freezed
abstract class TrainingActivity with _$TrainingActivity {
  const factory TrainingActivity({
    required int totalDurationSeconds,
    required double totalWeightTrainedKg,
    required DateTime accountCreatedAt,
    required int year,
    required int month,
    @Default(<DateTime>[]) List<DateTime> trainedDates,
  }) = _TrainingActivity;

  const TrainingActivity._();

  /// Day-of-month numbers that have a recorded session (for the calendar grid).
  Set<int> get trainedDaysOfMonth => {
    for (final d in trainedDates)
      if (d.year == year && d.month == month) d.day,
  };

  /// `HH:MM:SS` like the web profile timer.
  String get formattedDuration {
    final h = totalDurationSeconds ~/ 3600;
    final m = (totalDurationSeconds % 3600) ~/ 60;
    final s = totalDurationSeconds % 60;
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(h)}:${two(m)}:${two(s)}';
  }
}
