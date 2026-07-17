import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/plan.dart';

part 'plan_dto.freezed.dart';
part 'plan_dto.g.dart';

/// `PlanResponse` (API ref §3.3). DateOnly fields are carried as String.
@freezed
abstract class PlanDto with _$PlanDto {
  const factory PlanDto({
    required String id,
    required String name,
    required String startDate,
    required String endDate,
    required String planType,
    required String ownerName,
    required int totalWeeks,
    required int completedWeeks,
    required int totalDays,
    required int completedDays,
    required bool isActive,
    String? coachName,
  }) = _PlanDto;

  const PlanDto._();

  factory PlanDto.fromJson(Map<String, dynamic> json) =>
      _$PlanDtoFromJson(json);

  Plan toEntity() => Plan(
    id: id,
    name: name,
    startDate: DateOnly.tryParse(startDate)!,
    endDate: DateOnly.tryParse(endDate)!,
    planType: planType,
    ownerName: ownerName,
    totalWeeks: totalWeeks,
    completedWeeks: completedWeeks,
    totalDays: totalDays,
    completedDays: completedDays,
    isActive: isActive,
    coachName: coachName,
  );
}
