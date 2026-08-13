import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_density.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';

void main() {
  test('global density is twelve percent smaller', () {
    expect(AppDensity.uiScale, 0.88);
    expect(AppSpacing.lg, 14);
    expect(AppSpacing.xxxl, 32);
    expect(AppLayout.heroCardMinHeight, 222);
  });

  test('compact text scaler preserves platform accessibility scaling', () {
    final defaultScaler = AppDensity.compactTextScaler(TextScaler.noScaling);
    final accessibleScaler = AppDensity.compactTextScaler(
      const TextScaler.linear(1.5),
    );

    expect(defaultScaler.scale(20), closeTo(17.6, 0.001));
    expect(accessibleScaler.scale(20), closeTo(26.4, 0.001));
  });

  testWidgets('density scope composes with the current MediaQuery scaler', (
    tester,
  ) async {
    double? renderedSize;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
        child: AppDensityScope(
          child: Builder(
            builder: (context) {
              renderedSize = MediaQuery.textScalerOf(context).scale(20);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(renderedSize, closeTo(26.4, 0.001));
  });

  test('global application chrome uses compact dimensions', () {
    final theme = AppTheme.light();

    expect(
      theme.visualDensity,
      const VisualDensity(horizontal: -1.5, vertical: -1.5),
    );
    expect(theme.appBarTheme.toolbarHeight, 55);
    expect(theme.navigationBarTheme.height, 56);
    expect(theme.navigationRailTheme.minWidth, 64);
    expect(theme.listTileTheme.minTileHeight, 42);
    expect(
      theme.iconButtonTheme.style!.minimumSize!.resolve({}),
      const Size(40, 40),
    );
  });
}
