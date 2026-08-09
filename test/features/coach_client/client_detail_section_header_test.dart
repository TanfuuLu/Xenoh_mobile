import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/client_detail_screen.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/widgets/client_detail_section_header.dart';

void main() {
  testWidgets('section header stays bold and readable on narrow screens', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(280, 240);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const title = 'Custom exercises with a deliberately long title';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(12),
            child: ClientDetailSectionHeader(
              title: title,
              icon: Icons.fitness_center_rounded,
              accent: AppColors.dataBlue,
              trailing: IconButton(
                onPressed: null,
                icon: Icon(Icons.add_rounded),
              ),
            ),
          ),
        ),
      ),
    );

    final titleWidget = tester.widget<Text>(find.text(title));
    expect(titleWidget.style?.fontWeight, FontWeight.w700);
    expect(titleWidget.maxLines, 2);
    expect(titleWidget.overflow, TextOverflow.ellipsis);

    final header = find.byType(ClientDetailSectionHeader);
    final containers = tester.widgetList<Container>(
      find.descendant(of: header, matching: find.byType(Container)),
    );
    expect(containers, hasLength(1));
    final decoration = containers.single.decoration as BoxDecoration?;
    expect(decoration?.color, Colors.transparent);
    expect(tester.takeException(), isNull);
  });

  testWidgets('client detail sections become two columns on web', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1120, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ClientDetailResponsiveLayout(
            primary: SizedBox(height: 100),
            secondary: SizedBox(height: 100),
          ),
        ),
      ),
    );

    expect(
      find.byKey(ClientDetailResponsiveLayout.desktopKey),
      findsOneWidget,
    );
    expect(
      find.byKey(ClientDetailResponsiveLayout.mobileKey),
      findsNothing,
    );
    final desktopRow = find.byKey(ClientDetailResponsiveLayout.desktopKey);
    final columns = tester.widgetList<Expanded>(
      find.descendant(of: desktopRow, matching: find.byType(Expanded)),
    );
    expect(columns.map((column) => column.flex), [7, 5]);

    tester.view.physicalSize = const Size(390, 844);
    await tester.pump();

    expect(
      find.byKey(ClientDetailResponsiveLayout.mobileKey),
      findsOneWidget,
    );
    expect(
      find.byKey(ClientDetailResponsiveLayout.desktopKey),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });
}
