import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/app/widgets/app_responsive_frame.dart';

void main() {
  testWidgets('uses the full phone width', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        home: AppResponsiveFrame(child: ColoredBox(color: Colors.red)),
      ),
    );

    expect(
      tester.getSize(find.byKey(AppResponsiveFrame.canvasKey)).width,
      390,
    );
  });

  testWidgets('caps the application canvas on a wide viewport', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        home: AppResponsiveFrame(child: ColoredBox(color: Colors.red)),
      ),
    );

    expect(
      tester.getSize(find.byKey(AppResponsiveFrame.canvasKey)).width,
      AppLayout.screenMaxWidth,
    );
  });
}
