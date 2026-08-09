import 'entities/nutrition_summary.dart';

enum NutritionCalorieAction { setTarget, hold, reduce, add }

enum NutritionProteinAction { prioritizeProtein, keepTiming }

class NutritionMacroStrategy {
  const NutritionMacroStrategy({
    required this.proteinPercent,
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.recommended,
  });

  final int proteinPercent;
  final int carbsPercent;
  final int fatPercent;
  final int? proteinG;
  final int? carbsG;
  final int? fatG;
  final bool recommended;
}

class NutritionInsight {
  const NutritionInsight({
    required this.hasMeaningfulData,
    required this.averageCalories,
    required this.averageProteinG,
    required this.averageCarbsG,
    required this.averageFatG,
    required this.calorieDelta,
    required this.macroBalancePercent,
    required this.weightGapKg,
    required this.calorieAction,
    required this.proteinAction,
    required this.strategies,
  });

  final bool hasMeaningfulData;
  final int averageCalories;
  final double averageProteinG;
  final double averageCarbsG;
  final double averageFatG;
  final int? calorieDelta;
  final int? macroBalancePercent;
  final double? weightGapKg;
  final NutritionCalorieAction calorieAction;
  final NutritionProteinAction proteinAction;
  final List<NutritionMacroStrategy> strategies;
}

NutritionInsight buildNutritionInsight({
  required NutritionSummary summary,
  required List<NutritionDailyLog> history,
}) {
  final today = summary.todayLog;
  final source = history.isNotEmpty
      ? history
      : today != null
      ? [today]
      : const <NutritionDailyLog>[];
  final hasData = source.any(
    (log) =>
        log.calories > 0 || log.proteinG > 0 || log.carbsG > 0 || log.fatG > 0,
  );
  final calories = _average(source.map((log) => log.calories));
  final protein = _average(source.map((log) => log.proteinG));
  final carbs = _average(source.map((log) => log.carbsG));
  final fat = _average(source.map((log) => log.fatG));
  final target = summary.calculation.calorieTarget;
  final calorieDelta = target == null ? null : (calories - target).round();
  final macroRatios = <double?>[
    _targetRatio(protein, summary.calculation.proteinG),
    _targetRatio(carbs, summary.calculation.carbsG),
    _targetRatio(fat, summary.calculation.fatG),
  ].whereType<double>().toList();
  final macroBalance = macroRatios.isEmpty
      ? null
      : (macroRatios.fold<double>(
                  0,
                  (sum, ratio) => sum + ratio.clamp(0, 100),
                ) /
                macroRatios.length)
            .round();
  final proteinTarget = summary.calculation.proteinG;

  return NutritionInsight(
    hasMeaningfulData: hasData,
    averageCalories: calories.round(),
    averageProteinG: protein,
    averageCarbsG: carbs,
    averageFatG: fat,
    calorieDelta: calorieDelta,
    macroBalancePercent: hasData ? macroBalance : null,
    weightGapKg:
        summary.profile.targetWeightKg != null &&
            summary.calculation.bodyweightKg != null
        ? summary.profile.targetWeightKg! - summary.calculation.bodyweightKg!
        : null,
    calorieAction: calorieDelta == null
        ? NutritionCalorieAction.setTarget
        : calorieDelta.abs() <= 150
        ? NutritionCalorieAction.hold
        : calorieDelta > 0
        ? NutritionCalorieAction.reduce
        : NutritionCalorieAction.add,
    proteinAction: proteinTarget != null && protein < proteinTarget * 0.9
        ? NutritionProteinAction.prioritizeProtein
        : NutritionProteinAction.keepTiming,
    strategies: _strategies(target, summary.profile.goal),
  );
}

double _average(Iterable<num> values) {
  if (values.isEmpty) return 0;
  return values.fold<double>(0, (sum, value) => sum + value) / values.length;
}

double? _targetRatio(double actual, double? target) =>
    target == null || target <= 0 ? null : actual / target * 100;

List<NutritionMacroStrategy> _strategies(int? calories, String goal) {
  final normalizedGoal = goal.toLowerCase();
  final splits = <(int, int, int)>[(30, 40, 30), (35, 35, 30), (25, 50, 25)];
  final recommendedIndex = normalizedGoal == 'cut'
      ? 1
      : normalizedGoal == 'bulk'
      ? 2
      : 0;
  return [
    for (var index = 0; index < splits.length; index++)
      NutritionMacroStrategy(
        proteinPercent: splits[index].$1,
        carbsPercent: splits[index].$2,
        fatPercent: splits[index].$3,
        proteinG: calories == null
            ? null
            : (calories * splits[index].$1 / 100 / 4).round(),
        carbsG: calories == null
            ? null
            : (calories * splits[index].$2 / 100 / 4).round(),
        fatG: calories == null
            ? null
            : (calories * splits[index].$3 / 100 / 9).round(),
        recommended: index == recommendedIndex,
      ),
  ];
}
