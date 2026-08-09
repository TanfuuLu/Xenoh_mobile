import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/widgets/xn_user_avatar.dart';

void main() {
  testWidgets('uses the server image when an avatar URL is available', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: XnUserAvatar(
          name: 'Demo Athlete',
          imageUrl: 'https://example.test/avatar.webp',
          size: 48,
        ),
      ),
    );

    final image = tester.widget<Image>(find.byType(Image));
    expect(
      (image.image as NetworkImage).url,
      'https://example.test/avatar.webp',
    );
    expect(find.text('DA'), findsNothing);
  });

  testWidgets('falls back to initials when the URL is blank', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: XnUserAvatar(
          name: 'Demo Athlete',
          imageUrl: '  ',
          size: 48,
        ),
      ),
    );

    expect(find.byType(Image), findsNothing);
    expect(find.text('DA'), findsOneWidget);
  });
}
