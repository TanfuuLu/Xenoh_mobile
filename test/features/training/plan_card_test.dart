import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/training/domain/entities/plan.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/plan_card.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('plan actions stack without overflow on a narrow card', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(300, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: PlanCard(
              plan: Plan(
                id: 'plan-1',
                name: 'Starter powerlifting three-day program',
                startDate: DateTime(2026, 8, 5),
                endDate: DateTime(2026, 9, 30),
                planType: 'Self',
                ownerName: 'Ada',
                totalWeeks: 9,
                completedWeeks: 0,
                totalDays: 63,
                completedDays: 0,
                isActive: false,
              ),
              onTap: () {},
              onReview: () {},
              onActivate: () {},
              onDelete: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(
      tester.getTopLeft(find.byTooltip('Review plan')).dy,
      greaterThan(tester.getBottomLeft(find.text('Activate')).dy),
    );
  });
}
