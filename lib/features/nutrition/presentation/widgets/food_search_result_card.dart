import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/food.dart';

class FoodSearchResultCard extends StatelessWidget {
  const FoodSearchResultCard({
    required this.food,
    required this.languageCode,
    this.onTap,
    super.key,
  });

  final FoodItem food;
  final String languageCode;
  final VoidCallback? onTap;

  static Key cardKey(String foodId) => ValueKey('food-search-card-$foodId');
  static Key proteinKey(String foodId) =>
      ValueKey('food-search-protein-$foodId');
  static Key carbsKey(String foodId) => ValueKey('food-search-carbs-$foodId');
  static Key fatKey(String foodId) => ValueKey('food-search-fat-$foodId');

  @override
  Widget build(BuildContext context) {
    return Material(
      key: cardKey(food.id),
      color: AppColors.bg2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColors.surfaceBorderSoft),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      food.displayNameFor(languageCode),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.fg3,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${food.caloriesPer100g.toStringAsFixed(0)} kcal / 100 g',
                style: AppTypography.mono(11, color: AppColors.fg3),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: _MacroValue(
                      decorationKey: proteinKey(food.id),
                      label: 'P',
                      value: food.proteinPer100g,
                      color: AppColors.macroProtein,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: _MacroValue(
                      decorationKey: carbsKey(food.id),
                      label: 'C',
                      value: food.carbsPer100g,
                      color: AppColors.macroCarbs,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: _MacroValue(
                      decorationKey: fatKey(food.id),
                      label: 'F',
                      value: food.fatPer100g,
                      color: AppColors.macroFat,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MacroValue extends StatelessWidget {
  const _MacroValue({
    required this.decorationKey,
    required this.label,
    required this.value,
    required this.color,
  });

  final Key decorationKey;
  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: decorationKey,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                '$label ${value.toStringAsFixed(0)}g',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.mono(
                  10,
                  color: AppColors.fg1,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
