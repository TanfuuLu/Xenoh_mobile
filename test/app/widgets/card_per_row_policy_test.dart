import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('feature content does not use divider-based section lists', () {
    final violations = <String>[];
    final featureFiles = Directory('lib/features')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));

    for (final file in featureFiles) {
      final source = file.readAsStringSync();
      if (source.contains('XnSectionList(') ||
          source.contains('XnSectionDivider(')) {
        violations.add(file.path);
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Content rows on routed screens must use standalone cards.',
    );
  });

  test('week score metrics do not use compact dividers', () {
    final source = File(
      'lib/features/training/presentation/screens/week_analysis_screen.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('_CompactDivider()')));
  });

  test('content dividers are limited to explicit structural exceptions', () {
    const approved = <String>{
      // Authentication's labelled "or" rule.
      'auth/presentation/widgets/auth_layout.dart',
      // Action boundaries inside a single community/registration record.
      'community/presentation/widgets/community_widgets.dart',
      'competitions/presentation/organizer_screens.dart',
      // Approved KPI/calculator grids and real plate tables.
      'cycle/presentation/widgets/cycle_phase_card.dart',
      'dashboard/presentation/widgets/plate_calculator_card.dart',
      'nutrition/presentation/screens/nutrition_screen.dart',
      // Explicitly excluded sheets, dialogs, menus and pickers.
      'insights/presentation/screens/ai_coach_chat_screen.dart',
      'nutrition/presentation/widgets/add_food_sheet.dart',
      'nutrition/presentation/widgets/meal_plan_setup_sheet.dart',
      'profile/presentation/widgets/bodyweight_card.dart',
    };
    final violations = <String>[];

    for (final file
        in Directory('lib/features')
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('.dart'))) {
      final normalized = file.path.replaceAll(r'\', '/');
      final relative = normalized.split('/features/').last;
      final hasDivider = RegExp(
        r'(?<![A-Za-z])(?:Divider|VerticalDivider)\(',
      ).hasMatch(file.readAsStringSync());
      if (hasDivider && !approved.contains(relative)) {
        violations.add(file.path);
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'New content-row dividers must be standalone cards instead.',
    );
  });
}
