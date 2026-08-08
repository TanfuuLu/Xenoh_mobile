import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/widgets/xn_button.dart';
import 'package:xenoh_mobile/core/widgets/xn_card.dart';
import 'package:xenoh_mobile/core/widgets/xn_section.dart';

void main() {
  test('shared card uses compact default padding', () {
    const card = XnCard(child: SizedBox());

    expect(card.padding, const EdgeInsets.all(16));
  });

  test('grouped sections keep a compact vertical rhythm', () {
    const group = XnSectionGroup(children: []);
    const section = XnSection(child: SizedBox());
    const sectionList = XnSectionList(children: []);

    expect(
      group.padding,
      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
    expect(
      section.padding,
      const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
    );
    expect(sectionList.padding, const EdgeInsets.all(10));
  });

  test('global action buttons use compact visual padding', () {
    final theme = AppTheme.light();
    final filledStyle = theme.filledButtonTheme.style!;
    final outlinedStyle = theme.outlinedButtonTheme.style!;
    final textStyle = theme.textButtonTheme.style!;

    expect(filledStyle.minimumSize!.resolve({}), const Size(64, 44));
    expect(filledStyle.tapTargetSize, MaterialTapTargetSize.shrinkWrap);
    expect(
      filledStyle.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
    );
    expect(outlinedStyle.minimumSize!.resolve({}), const Size(64, 44));
    expect(outlinedStyle.tapTargetSize, MaterialTapTargetSize.shrinkWrap);
    expect(
      outlinedStyle.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
    );
    expect(textStyle.minimumSize!.resolve({}), const Size(44, 44));
    expect(textStyle.tapTargetSize, MaterialTapTargetSize.shrinkWrap);
    expect(
      textStyle.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 7),
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
    expect(button.style!.minimumSize!.resolve({}), const Size(64, 44));
    expect(
      button.style!.tapTargetSize,
      MaterialTapTargetSize.shrinkWrap,
    );
    expect(
      button.style!.padding!.resolve({}),
      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
    );
  });
}

void _noop() {}
