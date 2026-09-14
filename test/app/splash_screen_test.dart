import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/splash_screen.dart';

void main() {
  testWidgets('paints the original gold circle over the white Ascend emblem', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.byKey(const Key('splash-circle-base')), findsOneWidget);
    expect(find.byKey(const Key('splash-circle-reveal')), findsOneWidget);
    expect(find.byKey(const Key('splash-gold-circle')), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump();

    expect(find.byKey(const Key('splash-circle-reveal')), findsNothing);
    expect(find.byKey(const Key('splash-original-emblem')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
