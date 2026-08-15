import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/home_shell.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('bottom menu shows icons without visible screen names', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppBottomMenuFrame(child: SizedBox.expand()),
      ),
    );
    await tester.pumpAndSettle();

    for (final label in const ['Home', 'Training', 'Nutrition', 'Profile']) {
      expect(find.text(label), findsNothing);
      expect(find.bySemanticsLabel(label), findsOneWidget);
    }

    expect(tester.getSize(find.byType(InkWell).first).height, 48);
  });
}
