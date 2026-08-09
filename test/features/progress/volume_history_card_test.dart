import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/features/profile/domain/entities/volume_history_point.dart';
import 'package:xenoh_mobile/features/progress/presentation/widgets/volume_history_card.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('renders monthly completed volume using the selected unit', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: VolumeHistoryCard(
            points: const [
              VolumeHistoryPoint(year: 2026, month: 7, volumeKg: 10000),
              VolumeHistoryPoint(year: 2026, month: 8, volumeKg: 12500),
            ],
            unit: WeightUnit.lb,
            months: 6,
            onMonthsChanged: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Completed monthly volume in lb'), findsOneWidget);
    expect(find.text('7/26'), findsOneWidget);
    expect(find.text('8/26'), findsOneWidget);
  });
}
