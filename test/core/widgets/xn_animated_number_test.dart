import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/widgets/xn_animated_number.dart';

void main() {
  testWidgets('counts up on first display', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: XnAnimatedNumber(
          value: 42,
          formatter: formatAnimatedInt,
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('42'), findsOneWidget);
  });

  testWidgets('animates from the previous value to the new value', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: XnAnimatedNumber(
          value: 10,
          formatter: formatAnimatedInt,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.pumpWidget(
      const MaterialApp(
        home: XnAnimatedNumber(
          value: 20,
          formatter: formatAnimatedInt,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 350));

    final midText = tester.widget<Text>(find.byType(Text)).data!;
    final midValue = int.parse(midText);
    expect(midValue, greaterThan(10));
    expect(midValue, lessThan(20));

    await tester.pumpAndSettle();
    expect(find.text('20'), findsOneWidget);
  });

  testWidgets('applies custom decimal and unit formatting', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: XnAnimatedNumber(
          value: 76.45,
          formatter: (value) => '${value.toStringAsFixed(1)} kg',
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('76.5 kg'), findsOneWidget);
  });

  testWidgets('preserves text style and layout options', (tester) async {
    const style = TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

    await tester.pumpWidget(
      const MaterialApp(
        home: XnAnimatedNumber(
          value: 1200,
          formatter: formatAnimatedThousands,
          style: style,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
        ),
      ),
    );

    await tester.pumpAndSettle();
    final text = tester.widget<Text>(find.text('1,200'));
    expect(text.style, style);
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(text.textAlign, TextAlign.right);
  });
}
