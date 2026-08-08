import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/widgets/xn_card_carousel.dart';

void main() {
  testWidgets('starts at the requested card and keeps the index in sync', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: XnCardCarousel<String>(
            items: const ['One', 'Two', 'Three'],
            initialIndex: 1,
            height: 180,
            semanticLabel: 'Training weeks',
            indexLabelBuilder: (_, item) => item,
            itemBuilder: (_, item, {required selected}) => Text(
              '$item:${selected ? 'selected' : 'idle'}',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Two:selected'), findsOneWidget);
    expect(
      tester
          .widget<Semantics>(
            find.byKey(const ValueKey('xn-card-carousel-index-1')),
          )
          .properties
          .selected,
      isTrue,
    );

    await tester.tap(
      find.byKey(const ValueKey('xn-card-carousel-index-2')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Three:selected'), findsOneWidget);
  });

  testWidgets('swipes horizontally and exposes adjacent cards', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: XnCardCarousel<int>(
            items: const [1, 2, 3],
            height: 180,
            semanticLabel: 'Training days',
            indexLabelBuilder: (_, item) => '$item',
            itemBuilder: (_, item, {required selected}) => Text('Day $item'),
          ),
        ),
      ),
    );

    final pageView = tester.widget<PageView>(find.byType(PageView));
    expect(pageView.controller?.viewportFraction, 0.9);

    await tester.fling(
      find.byType(PageView),
      const Offset(-700, 0),
      1200,
    );
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<Semantics>(
            find.byKey(const ValueKey('xn-card-carousel-index-1')),
          )
          .properties
          .selected,
      isTrue,
    );
  });
}
