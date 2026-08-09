class LastExercisePerformance {
  const LastExercisePerformance({
    required this.exerciseTemplateId,
    this.lastActualWeight,
    this.lastActualReps,
    this.lastRpe,
    this.performedAt,
    this.workoutDate,
  });

  factory LastExercisePerformance.fromJson(Map<String, dynamic> json) =>
      LastExercisePerformance(
        exerciseTemplateId: json['exerciseTemplateId'] as String? ?? '',
        lastActualWeight: (json['lastActualWeight'] as num?)?.toDouble(),
        lastActualReps: (json['lastActualReps'] as num?)?.toInt(),
        lastRpe: (json['lastRpe'] as num?)?.toDouble(),
        performedAt: DateTime.tryParse(json['performedAt'] as String? ?? ''),
        workoutDate: DateTime.tryParse(json['workoutDate'] as String? ?? ''),
      );

  final String exerciseTemplateId;
  final double? lastActualWeight;
  final int? lastActualReps;
  final double? lastRpe;
  final DateTime? performedAt;
  final DateTime? workoutDate;

  bool get hasPerformance => lastActualWeight != null;
}
