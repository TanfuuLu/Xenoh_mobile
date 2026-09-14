import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/branding/app_brand.dart';
import 'package:xenoh_mobile/app/splash_screen.dart';
import 'package:xenoh_mobile/app/startup/opening_animation_gate.dart';

void main() {
  test('paint follows the arc from lower left over the top to lower right', () {
    const size = Size(300, 300);
    const leftTip = Offset(35, 225);
    const top = Offset(150, 30);
    const rightTip = Offset(265, 225);
    final empty = const CircleStrokeRevealClipper(progress: 0).getClip(size);
    final early = const CircleStrokeRevealClipper(progress: 0.2).getClip(size);
    final late = const CircleStrokeRevealClipper(progress: 0.8).getClip(size);
    final full = const CircleStrokeRevealClipper(progress: 1).getClip(size);
    expect(empty.contains(leftTip), isFalse);
    expect(early.contains(leftTip), isTrue);
    expect(early.contains(top), isFalse);
    expect(early.contains(rightTip), isFalse);
    expect(late.contains(leftTip), isTrue);
    expect(late.contains(top), isTrue);
    expect(late.contains(rightTip), isFalse);
    expect(full.contains(rightTip), isTrue);
    expect(full.contains(const Offset(10, 290)), isTrue);
    expect(full.contains(const Offset(290, 290)), isTrue);
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
