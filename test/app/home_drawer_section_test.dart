import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/home_shell.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('expanded drawer group is borderless and indents its options', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeDrawerSection(
            title: 'Community',
            icon: Icons.groups_outlined,
            initiallyExpanded: true,
            children: [Text('Friends')],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final expansionTile = tester.widget<ExpansionTile>(
      find.byType(ExpansionTile),
    );
    expect(
      expansionTile.childrenPadding,
      const EdgeInsets.fromLTRB(24, 0, 7, 7),
    );
    expect(
      find.ancestor(
        of: find.byType(ExpansionTile),
        matching: find.byType(AnimatedContainer),
      ),
      findsNothing,
    );
    expect(find.text('Friends'), findsOneWidget);
  });

  testWidgets('client coach-access section exposes Coach Chat', (tester) async {
    var chatTaps = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CoachAccessDrawerSection(
            onOpenMyCoach: () {},
            onOpenCoachChat: () => chatTaps++,
            onOpenEnterCoachCode: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Coach access'));
    await tester.pumpAndSettle();
    expect(find.text('Coach Chat'), findsOneWidget);
    await tester.tap(find.text('Coach Chat'));
    await tester.pump();
    expect(chatTaps, 1);
  });
}
