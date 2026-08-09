import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/supplements/presentation/screens/supplements_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets(
    'dose schedule uses structured cards and supports adding a dose',
    (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 800);
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SupplementRegimenSheet(clientId: null),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('dose-slot-card-0')), findsOneWidget);
      expect(find.byKey(const ValueKey('dose-slot-day-0-0')), findsOneWidget);
      expect(find.byKey(const ValueKey('dose-slot-day-0-6')), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline_rounded), findsNothing);
      expect(find.text('1/30'), findsNothing);

      await tester.ensureVisible(find.text('Add dose'));
      await tester.tap(find.text('Add dose'));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('dose-slot-card-1')), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline_rounded), findsNWidgets(2));
    },
  );
}
