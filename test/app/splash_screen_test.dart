import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/splash_screen.dart';

void main() {
  testWidgets('keeps the Ascend circle reveal visible before its final frame', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    await tester.runAsync(() async {
      await Future<void>.delayed(Duration.zero);
    });
    await tester.pump();

    expect(find.byKey(const Key('splash-circle-base')), findsOneWidget);
    expect(find.byKey(const Key('splash-circle-reveal')), findsOneWidget);
    expect(find.byKey(const Key('splash-gold-circle')), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));

    expect(find.byKey(const Key('splash-circle-reveal')), findsOneWidget);
    expect(find.byKey(const Key('splash-original-emblem')), findsNothing);

    expect(tester.takeException(), isNull);
  });
}
