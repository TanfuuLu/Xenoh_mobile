import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/branding/app_brand.dart';
import 'package:xenoh_mobile/app/splash_screen.dart';
import 'package:xenoh_mobile/app/startup/opening_animation_gate.dart';

void main() {
  test('reveal moves left to right and includes the full logo height', () {
    const size = Size(300, 300);
    expect(
      const CircleStrokeRevealClipper(progress: 0).getClip(size),
      const Rect.fromLTWH(0, 0, 0, 300),
    );
    expect(
      const CircleStrokeRevealClipper(progress: 0.5).getClip(size),
      const Rect.fromLTWH(0, 0, 150, 300),
    );
    expect(
      const CircleStrokeRevealClipper(progress: 1).getClip(size),
      Offset.zero & size,
    );
  });
  testWidgets('keeps the Ascend circle reveal visible before its final frame', (
    tester,
  ) async {
    openingAnimationCompletedNotifier.value = false;
    addTearDown(() => openingAnimationCompletedNotifier.value = false);
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    await tester.runAsync(() async {
      final context = tester.element(find.byType(SplashScreen));
      await Future.wait([
        precacheImage(const AssetImage(AppBrand.emblemAsset), context),
        precacheImage(
          const AssetImage(AppBrand.openingEmblemWhiteCircleAsset),
          context,
        ),
      ]);
    });
    await tester.pump();

    expect(find.byKey(const Key('splash-circle-base')), findsOneWidget);
    expect(find.byKey(const Key('splash-circle-reveal')), findsOneWidget);
    expect(find.byKey(const Key('splash-gold-circle')), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));

    expect(find.byKey(const Key('splash-circle-reveal')), findsOneWidget);
    expect(find.byKey(const Key('splash-original-emblem')), findsNothing);
    expect(openingAnimationCompletedNotifier.value, isFalse);

    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.byKey(const Key('splash-circle-reveal')), findsNothing);
    expect(find.byKey(const Key('splash-original-emblem')), findsOneWidget);
    expect(openingAnimationCompletedNotifier.value, isTrue);

    expect(tester.takeException(), isNull);
  });
}
