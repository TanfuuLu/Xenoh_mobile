import 'package:flutter/material.dart';

/// Xenoh website palette translated to mobile.
///
/// Keep the app aligned with the web UI screenshots: warm paper background,
/// ivory cards, clay navigation states, and muted sage as the secondary accent.
abstract final class AppColors {
  // Clay / brand primary.
  static const clay050 = Color(0xFFF8F2EB);
  static const clay100 = Color(0xFFECDCCA);
  static const clay200 = Color(0xFFDDBFA2);
  static const clay800 = Color(0xFF6C503D);
  static const clay900 = Color(0xFF493326);

  // Sage / secondary accent.
  static const sage100 = Color(0xFFE3E6D2);
  static const sage500 = Color(0xFF959976);
  static const sage700 = Color(0xFF61664A);

  // Ink / text.
  static const ink050 = Color(0xFFF5EFE8);
  static const ink300 = Color(0xFFB8A593);
  static const ink500 = Color(0xFF8A7359);
  static const ink900 = Color(0xFF251A13);

  // Website paper canvas.
  static const paper = Color(0xFFF2E9DC);
  static const paperAlt = Color(0xFFDEC5A5);

  // Semantic surfaces.
  static const bgPage = paper;
  static const bg2 = Color(0xFFFFFBF6);
  static const bg3 = Color(0xFFECDBC5);
  static const bg4 = Color(0xFFDCC09F);
  static const bgInverse = ink900;

  // Semantic foreground.
  static const fg1 = ink900;
  static const fg2 = Color(0xFF5B4839);
  static const fg3 = Color(0xFF806B57);
  static const fg4 = Color(0xFFA38D78);
  static const fgOnClay = Color(0xFFFFFFFF);

  // Borders.
  static const border1 = Color(0xFFC7B09A);
  static const border2 = Color(0xFF927560);
  static const surfaceBorderSoft = Color(0xFFDDCDBD);

  // Accent.
  static const accent = clay800;
  static const accentHover = clay900;
  static const accentPress = Color(0xFF4A3526);
  static const accentSoft = clay100;
  static const accent2 = sage500;
  static const accent2Soft = sage100;

  // Buttons.
  static const buttonBg = Color(0xFFFFFBF6);
  static const buttonHover = Color(0xFFF3E9DD);
  static const buttonBorder = Color(0xFFD9C7B5);

  // Status.
  static const success = Color(0xFF485A26);
  static const successBg = Color(0xFFE8ECD6);
  static const warning = Color(0xFF8D560D);
  static const warningBg = Color(0xFFF0E0C8);
  static const danger = Color(0xFF802013);
  static const dangerBg = Color(0xFFF0D9D6);
  static const info = Color(0xFF485A66);
  static const infoBg = Color(0xFFDEE5EA);

  // Website-like soft shadows.
  static const shadow = Color(0x1F583F2E);
  static const shadowDeep = Color(0x33583F2E);
}
