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

  test('navigation selection matches the website active destination', () {
    expect(
      AppColors.navigationSelectedBackground,
      const Color(0xFFFFF0E5),
    );
    expect(
      AppColors.navigationSelectedForeground,
      const Color(0xFF84371F),
    );

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
}
