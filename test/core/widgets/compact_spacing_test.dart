import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/widgets/xn_button.dart';
import 'package:xenoh_mobile/core/widgets/xn_card.dart';
import 'package:xenoh_mobile/core/widgets/xn_section.dart';

void main() {
  test('shared card uses compact default padding', () {
    const card = XnCard(child: SizedBox());

    expect(card.padding, const EdgeInsets.all(14));
  });

  testWidgets('card stack renders every child in a separate spaced card', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: XnCardStack(
            children: [Text('First'), Text('Second')],
          ),
        ),
      ),
    );

    final cards = find.byType(XnCard);
    expect(cards, findsNWidgets(2));
    expect(
      tester.widget<XnCard>(cards.first).padding,
      const EdgeInsets.all(AppSpacing.lg),
    );
    expect(
      tester.getTopLeft(cards.at(1)).dy - tester.getBottomLeft(cards.at(0)).dy,
      AppSpacing.md,
    );
  });

  test('grouped sections keep a compact vertical rhythm', () {
    const group = XnSectionGroup(children: []);
    const section = XnSection(child: SizedBox());
    const sectionList = XnSectionList(children: []);

    expect(
      group.padding,
      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
    );
    expect(
      section.padding,
      const EdgeInsets.symmetric(horizontal: 3.5, vertical: 9),
    );
    expect(sectionList.padding, const EdgeInsets.all(9));
  });

  test('global action buttons use compact visual padding', () {
    final theme = AppTheme.light();
    final filledStyle = theme.filledButtonTheme.style!;
    final outlinedStyle = theme.outlinedButtonTheme.style!;
    final textStyle = theme.textButtonTheme.style!;

    expect(filledStyle.minimumSize!.resolve({}), const Size(56, 40));
    expect(filledStyle.tapTargetSize, MaterialTapTargetSize.shrinkWrap);
    expect(
      filledStyle.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    );
    expect(outlinedStyle.minimumSize!.resolve({}), const Size(56, 40));
    expect(outlinedStyle.tapTargetSize, MaterialTapTargetSize.shrinkWrap);
    expect(
      outlinedStyle.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    );
    expect(textStyle.minimumSize!.resolve({}), const Size(40, 40));
    expect(textStyle.tapTargetSize, MaterialTapTargetSize.shrinkWrap);
    expect(
      textStyle.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 6),
    );
  });

  testWidgets('danger button follows the compact action size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: XnButton(
            label: 'Delete',
            variant: XnButtonVariant.danger,
            onPressed: _noop,
          ),
        ),
      ),
    );

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.style!.minimumSize!.resolve({}), const Size(56, 40));
    expect(
      button.style!.tapTargetSize,
      MaterialTapTargetSize.shrinkWrap,
    );
    expect(
      button.style!.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    );
  });
}

void _noop() {}
