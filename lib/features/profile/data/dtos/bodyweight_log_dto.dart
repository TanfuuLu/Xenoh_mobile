import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/bodyweight_log.dart';

part 'bodyweight_log_dto.freezed.dart';
part 'bodyweight_log_dto.g.dart';

/// `BodyweightLogResponse` (API ref §3.2). `date` is a `DateOnly` string.
@freezed
abstract class BodyweightLogDto with _$BodyweightLogDto {
  const factory BodyweightLogDto({
    required String id,
    required double weight,
    required String date,
  }) = _BodyweightLogDto;

  const BodyweightLogDto._();

  factory BodyweightLogDto.fromJson(Map<String, dynamic> json) =>
      _$BodyweightLogDtoFromJson(json);

  BodyweightLog toEntity() =>
      BodyweightLog(id: id, weight: weight, date: DateOnly.tryParse(date)!);
}
