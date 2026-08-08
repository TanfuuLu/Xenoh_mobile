import '../../training/domain/entities/daily_workout.dart';
import '../../training/domain/entities/weekly_workout.dart';
import '../../training/domain/repositories/training_repository.dart';

class ClientTodayWorkoutTarget {
  const ClientTodayWorkoutTarget({
    required this.weekId,
    required this.dayId,
  });

  final String weekId;
  final String dayId;
}

Future<ClientTodayWorkoutTarget?> resolveClientTodayWorkout({
  required TrainingRepository repository,
  required String planId,
  required DateTime today,
}) async {
  if (planId.isEmpty) return null;

  final weeksPage = await repository.getWeeks(
    planId,
    pageNumber: 1,
    pageSize: 100,
  );
  final weeks = [...weeksPage.items]
    ..sort((a, b) => a.startDate.compareTo(b.startDate));
  if (weeks.isEmpty) return null;

  final date = _dateOnly(today);
  final targetWeek = _targetWeek(weeks, date);
  final daysPage = await repository.getDays(
    targetWeek.id,
    pageNumber: 1,
    pageSize: 100,
  );
  final days = [...daysPage.items]..sort((a, b) => a.date.compareTo(b.date));
  if (days.isEmpty) return null;

  final targetDay = days.cast<DailyWorkout?>().firstWhere(
    (day) => _dateOnly(day!.date) == date,
    orElse: () => days.first,
  )!;
  return ClientTodayWorkoutTarget(
    weekId: targetWeek.id,
    dayId: targetDay.id,
  );
}

WeeklyWorkout _targetWeek(List<WeeklyWorkout> weeks, DateTime today) {
  for (final week in weeks) {
    final start = _dateOnly(week.startDate);
    final end = _dateOnly(week.endDate);
    if (!today.isBefore(start) && !today.isAfter(end)) return week;
  }

  for (final week in weeks.reversed) {
    if (!_dateOnly(week.startDate).isAfter(today)) return week;
  }
  return weeks.first;
}

DateTime _dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);
