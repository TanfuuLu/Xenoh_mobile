import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/app/widgets/xn_grid_background.dart';

void main() {
  testWidgets('draws the subtle website grid behind transparent screens', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const XnGridBackground(
          child: Scaffold(body: Center(child: Text('Content'))),
        ),
      ),
    );

    expect(find.byType(XnGridBackground), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
    expect(
      Theme.of(tester.element(find.text('Content'))).scaffoldBackgroundColor,
      Colors.transparent,
    );
    expect(XnGridBackground.lineColor, AppColors.gridLine);
    expect(XnGridBackground.compactSpacing, 72);
  });
}
