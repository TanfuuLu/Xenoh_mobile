import 'package:freezed_annotation/freezed_annotation.dart';

part 'bodyweight_log.freezed.dart';

/// A single bodyweight entry (`BodyweightLogResponse`, API ref §3.2).
@freezed
abstract class BodyweightLog with _$BodyweightLog {
  const factory BodyweightLog({
    required String id,
    required double weight,
    required DateTime date,
  }) = _BodyweightLog;
}
