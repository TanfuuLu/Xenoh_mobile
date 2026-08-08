import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/app/widgets/app_responsive_frame.dart';

void main() {
  test('classifies layouts by available width', () {
    expect(AppResponsiveFrame.breakpointForWidth(320), AppBreakpoint.compact);
    expect(AppResponsiveFrame.breakpointForWidth(599), AppBreakpoint.compact);
    expect(AppResponsiveFrame.breakpointForWidth(600), AppBreakpoint.medium);
    expect(AppResponsiveFrame.breakpointForWidth(839), AppBreakpoint.medium);
    expect(AppResponsiveFrame.breakpointForWidth(840), AppBreakpoint.expanded);
    expect(AppResponsiveFrame.breakpointForWidth(1400), AppBreakpoint.expanded);
  });

  test('reserves persistent role navigation for expanded layouts', () {
    expect(AppResponsiveFrame.usesNavigationRail(839), isFalse);
    expect(AppResponsiveFrame.usesNavigationRail(840), isTrue);
    expect(AppResponsiveFrame.usesNavigationRail(1120), isTrue);
  });

  testWidgets('preserves the physical viewport on tablets', (tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    Size? viewport;
    await tester.pumpWidget(
      MaterialApp(
        home: AppResponsiveFrame(
          child: Builder(
            builder: (context) {
              viewport = MediaQuery.sizeOf(context);
              return const SizedBox.expand();
            },
          ),
        ),
      ),
    );

    expect(viewport, const Size(768, 1024));
  });

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
    expect(AppLayout.screenMaxWidth, 1120);
  });
}
