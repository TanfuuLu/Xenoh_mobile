import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan.freezed.dart';

/// A training plan (maps from `PlanResponse`, API ref §3.3).
@freezed
abstract class Plan with _$Plan {
  const factory Plan({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required String planType, // "Self" | "Coach"
    required String ownerName,
    required int totalWeeks,
    required int completedWeeks,
    required int totalDays,
    required int completedDays,
    required bool isActive,
    String? coachName,
  }) = _Plan;

  const Plan._();

  int get progressPercent =>
      totalDays == 0 ? 0 : ((completedDays / totalDays) * 100).round();
}
