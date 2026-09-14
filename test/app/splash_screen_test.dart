import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/splash_screen.dart';

void main() {
  testWidgets('animates a gold opening light around the Ascend emblem', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.byKey(const Key('splash-opening-light')), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 800));

    expect(tester.takeException(), isNull);
  });
}
