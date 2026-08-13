import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/home_shell.dart';

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
}
