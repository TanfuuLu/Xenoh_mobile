import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/widgets/exercise_thumbnail.dart';

void main() {
  testWidgets('uses persistent caching for exercise artwork', (tester) async {
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: ExerciseThumbnail(
            imageUrl: 'https://assets.xenoh.online/exercises/squat.webp',
            exerciseKind: 'Strength',
            size: 64,
          ),
        ),
      ),
    );

    final image = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );
    expect(
      image.imageUrl,
      'https://assets.xenoh.online/exercises/squat.webp',
    );
    expect(image.memCacheWidth, 128);
    expect(image.memCacheHeight, 128);
    expect(image.maxWidthDiskCache, 128);
    expect(image.maxHeightDiskCache, 128);
  });

  testWidgets('uses the exercise fallback when the image URL is blank', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: ExerciseThumbnail(
            imageUrl: ' ',
            exerciseKind: 'Cardio',
          ),
        ),
      ),
    );

    expect(find.byType(CachedNetworkImage), findsNothing);
    expect(find.byIcon(Icons.directions_run_rounded), findsOneWidget);
  });
}
