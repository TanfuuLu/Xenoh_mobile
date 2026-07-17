import '../entities/food.dart';
import '../entities/food_log.dart';
import '../entities/meal_plan.dart';
import '../entities/nutrition_summary.dart';

/// Nutrition reads/writes. Methods throw a domain `Failure` on error.
abstract interface class NutritionRepository {
  Future<NutritionSummary> getSummary();

  /// Update activity/goal/targets (`PUT /nutrition/profile`).
  Future<NutritionProfile> updateProfile({
    required String activityLevel,
    required String goal,
    double? targetWeightKg,
    int? customCalorieTarget,
    double? proteinPerKg,
    double? fatPerKg,
  });

  /// Search the food database. Returns [] for blank queries.
  Future<List<FoodItem>> searchFoods({required String query, String lang});

  /// AI macro estimation: resolve a free-text food [name] into a [FoodItem]
  /// with estimated macros (Pro, rate-limited). Throws `ForbiddenFailure` when
  /// not Pro and `RateLimitFailure` when the AI quota is exhausted.
  Future<FoodItem> resolveFood({required String name, String lang});

  /// Create a custom food item.
  Future<FoodItem> createCustomFood({
    required String nameVi,
    required String nameEn,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    String? defaultServingLabel,
    double? defaultServingGrams,
  });

  /// Logged foods + totals for a date.
  Future<FoodLogsForDate> getFoodLogs(DateTime date);

  /// Log a food by grams or by serving × count.
  Future<void> addFoodLog({
    required DateTime date,
    required String foodItemId,
    double? grams,
    String? servingLabel,
    double? servingCount,
  });

  /// Remove a logged food entry.
  Future<void> deleteFoodLog({
    required DateTime date,
    required String foodLogId,
  });

  Future<MealPlanDay> getMealPlan(DateTime date);

  Future<MealPlanDay> upsertMealPlan({
    required DateTime date,
    required List<Map<String, dynamic>> meals,
    String? notes,
  });

  Future<MealPlanDay> checkMealPlanItem(String itemId);

  Future<MealPlanDay> uncheckMealPlanItem(String itemId);
}
