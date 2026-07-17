import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Typography for Xenoh.
abstract final class AppTypography {
  static const fontFamily = 'BeVietnamPro';
  static const displayFontFamily = 'Fraunces';

  static FontWeight textWeight(FontWeight weight) => weight;

  static double tracking(double letterSpacing) => letterSpacing;

  static TextStyle display(
    double size, {
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.fg1,
    double letterSpacing = 0,
    double? height,
  }) => TextStyle(
    fontFamily: displayFontFamily,
    fontSize: size,
    fontWeight: textWeight(weight),
    color: color,
    letterSpacing: tracking(letterSpacing),
    height: height,
  );

  static TextStyle mono(
    double size, {
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.fg1,
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: textWeight(weight),
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextTheme textTheme() {
    const body = TextTheme();
    return body.copyWith(
      displayLarge: display(
        44,
        weight: FontWeight.w700,
        letterSpacing: -1.1,
        height: 1.04,
      ),
      displayMedium: display(
        36,
        weight: FontWeight.w700,
        letterSpacing: -0.75,
        height: 1.08,
      ),
      displaySmall: display(
        30,
        weight: FontWeight.w600,
        letterSpacing: -0.45,
        height: 1.12,
      ),
      headlineLarge: display(
        28,
        weight: FontWeight.w600,
        letterSpacing: -0.35,
        height: 1.15,
      ),
      headlineMedium: display(
        24,
        weight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.18,
      ),
      headlineSmall: display(21, weight: FontWeight.w600, height: 1.2),
      titleLarge: const TextStyle(
        fontFamily: fontFamily,
        color: AppColors.fg1,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      titleMedium: const TextStyle(
        fontFamily: fontFamily,
        color: AppColors.fg1,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleSmall: const TextStyle(
        fontFamily: fontFamily,
        color: AppColors.fg2,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      bodyLarge: const TextStyle(
        fontFamily: fontFamily,
        color: AppColors.fg1,
        fontSize: 16,
        height: 1.48,
      ),
      bodyMedium: const TextStyle(
        fontFamily: fontFamily,
        color: AppColors.fg1,
        fontSize: 14,
        height: 1.45,
      ),
      bodySmall: const TextStyle(
        fontFamily: fontFamily,
        color: AppColors.fg3,
        fontSize: 12,
        height: 1.4,
      ),
      labelLarge: const TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
      ),
      labelMedium: const TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    );
  }
}
