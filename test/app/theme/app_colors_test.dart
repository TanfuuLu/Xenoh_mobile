import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';

void main() {
  test('uses the approved calm website-aligned brand surfaces', () {
    expect(AppColors.bgPage, const Color(0xFFF7F4EF));
    expect(AppColors.bg2, const Color(0xFFFFFDFA));
    expect(AppColors.bg3, const Color(0xFFF0ECE7));
    expect(AppColors.bg4, const Color(0xFFE7E0D9));
    expect(AppColors.accent, const Color(0xFFB6532F));
    expect(AppColors.accent2, const Color(0xFF6FBF9A));
  });

  test('provides six vivid and distinct data colors', () {
    expect(AppColors.dataPalette, hasLength(6));
    expect(AppColors.dataPalette.toSet(), hasLength(6));
    expect(AppColors.dataBlue, const Color(0xFF3B82F6));
    expect(AppColors.dataTeal, const Color(0xFF14B8A6));
    expect(AppColors.dataViolet, const Color(0xFF8B5CF6));
    expect(AppColors.dataAmber, const Color(0xFFF59E0B));
    expect(AppColors.dataRose, const Color(0xFFF43F5E));
    expect(AppColors.dataOlive, const Color(0xFF84CC16));
  });

  test('uses consistent semantic colors for nutrition macros', () {
    expect(AppColors.macroProtein, const Color(0xFFE53935));
    expect(AppColors.macroFat, const Color(0xFFF9A825));
    expect(AppColors.macroCarbs, const Color(0xFF43A047));
  });

  test('button colors match the website semantic tokens', () {
    expect(AppColors.buttonPrimary, const Color(0xFF725945));
    expect(AppColors.buttonBg, const Color(0xFFFBF7EF));
    expect(AppColors.buttonHover, const Color(0xFFF1E8DC));
    expect(AppColors.buttonBorder, const Color(0xFFD7C7B6));
    expect(AppColors.buttonText, const Color(0xFF2E2218));

    final theme = AppTheme.light();
    expect(
      theme.filledButtonTheme.style!.backgroundColor!.resolve({}),
      AppColors.buttonPrimary,
    );
    expect(
      theme.outlinedButtonTheme.style!.backgroundColor!.resolve({}),
      AppColors.buttonBg,
    );
    expect(
      theme.outlinedButtonTheme.style!.foregroundColor!.resolve({}),
      AppColors.buttonText,
    );
    expect(
      theme.textButtonTheme.style!.foregroundColor!.resolve({}),
      AppColors.buttonPrimary,
    );
    expect(
      theme.floatingActionButtonTheme.backgroundColor,
      AppColors.buttonPrimary,
    );
    expect(
      theme.floatingActionButtonTheme.foregroundColor,
      AppColors.fgOnClay,
    );
  });

  test('navigation selection uses the filled clay capsule', () {
    expect(AppColors.navigationSelectedBackground, AppColors.clay900);
    expect(AppColors.navigationSelectedForeground, AppColors.fgOnClay);

    final theme = AppTheme.light();
    expect(
      theme.navigationBarTheme.indicatorColor,
      AppColors.navigationSelectedBackground,
    );
    expect(
      theme.navigationRailTheme.indicatorColor,
      AppColors.navigationSelectedBackground,
    );
  });

  test('segmented buttons use muted fills and black borders', () {
    final style = AppTheme.light().segmentedButtonTheme.style!;

    expect(
      style.backgroundColor!.resolve(<WidgetState>{}),
      AppColors.segmentedButtonBg,
    );
    expect(
      style.backgroundColor!.resolve(<WidgetState>{WidgetState.selected}),
      AppColors.segmentedButtonSelectedBg,
    );
    expect(
      style.side!.resolve(<WidgetState>{}),
      const BorderSide(color: Colors.black, width: 1.2),
    );
    expect(
      style.side!.resolve(<WidgetState>{WidgetState.selected}),
      const BorderSide(color: Colors.black, width: 1.2),
    );
  });
}
