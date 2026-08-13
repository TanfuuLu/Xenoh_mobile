import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/features/nutrition/domain/entities/food.dart';
import 'package:xenoh_mobile/features/nutrition/presentation/widgets/food_search_result_card.dart';

void main() {
  testWidgets('renders each food on its own card with dashboard macro colors', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const foods = [
      FoodItem(
        id: 'chicken',
        nameVi: 'Ức gà (luộc)',
        nameEn: 'Boiled chicken breast',
        caloriesPer100g: 165,
        proteinPer100g: 31,
        carbsPer100g: 0,
        fatPer100g: 4,
      ),
      FoodItem(
        id: 'egg',
        nameVi: 'Trứng gà (luộc)',
        nameEn: 'Boiled egg',
        caloriesPer100g: 155,
        proteinPer100g: 13,
        carbsPer100g: 1,
        fatPer100g: 11,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              FoodSearchResultCard(food: foods[0], languageCode: 'vi'),
              FoodSearchResultCard(food: foods[1], languageCode: 'vi'),
            ],
          ),
        ),
      ),
    );

    expect(find.byKey(FoodSearchResultCard.cardKey('chicken')), findsOneWidget);
    expect(find.byKey(FoodSearchResultCard.cardKey('egg')), findsOneWidget);
    expect(
      _color(tester, FoodSearchResultCard.proteinKey('chicken')),
      AppColors.macroProtein.withValues(alpha: 0.08),
    );
    expect(
      _color(tester, FoodSearchResultCard.carbsKey('chicken')),
      AppColors.macroCarbs.withValues(alpha: 0.08),
    );
    expect(
      _color(tester, FoodSearchResultCard.fatKey('chicken')),
      AppColors.macroFat.withValues(alpha: 0.08),
    );
    expect(tester.takeException(), isNull);
  });
}

Color? _color(WidgetTester tester, Key key) {
  final box = tester.widget<DecoratedBox>(find.byKey(key));
  return (box.decoration as BoxDecoration).color;
}
