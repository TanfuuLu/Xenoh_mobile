import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/training_activity.dart';

part 'training_activity_dto.freezed.dart';
part 'training_activity_dto.g.dart';

/// `TrainingActivityResponse` (API ref §3.2). `trainedDates` are `DateOnly`
/// strings; `accountCreatedAt` is a full ISO timestamp.
@freezed
abstract class TrainingActivityDto with _$TrainingActivityDto {
  const factory TrainingActivityDto({
    required int totalDurationSeconds,
    required double totalWeightTrainedKg,
    required String accountCreatedAt,
    required int year,
    required int month,
    @Default(<String>[]) List<String> trainedDates,
  }) = _TrainingActivityDto;

  const TrainingActivityDto._();

  factory TrainingActivityDto.fromJson(Map<String, dynamic> json) =>
      _$TrainingActivityDtoFromJson(json);

  TrainingActivity toEntity() => TrainingActivity(
    totalDurationSeconds: totalDurationSeconds,
    totalWeightTrainedKg: totalWeightTrainedKg,
    accountCreatedAt: DateTime.parse(accountCreatedAt),
    year: year,
    month: month,
    trainedDates: [
      for (final d in trainedDates) ?DateOnly.tryParse(d),
    ],
  );
}
