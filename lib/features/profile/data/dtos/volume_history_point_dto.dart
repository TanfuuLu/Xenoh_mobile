import '../../domain/entities/volume_history_point.dart';

class VolumeHistoryPointDto {
  const VolumeHistoryPointDto({
    required this.year,
    required this.month,
    required this.volumeKg,
  });

  factory VolumeHistoryPointDto.fromJson(Map<String, dynamic> json) =>
      VolumeHistoryPointDto(
        year: (json['year'] as num).toInt(),
        month: (json['month'] as num).toInt(),
        volumeKg: (json['volumeKg'] as num).toDouble(),
      );

  final int year;
  final int month;
  final double volumeKg;

  VolumeHistoryPoint toEntity() => VolumeHistoryPoint(
    year: year,
    month: month,
    volumeKg: volumeKg,
  );
}
