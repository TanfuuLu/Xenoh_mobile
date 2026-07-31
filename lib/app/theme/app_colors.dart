import 'package:flutter/material.dart';

/// Xenoh website palette translated to mobile.
///
/// Keep the app aligned with the web UI screenshots: warm paper background,
/// ivory cards, clay navigation states, and muted sage as the secondary accent.
abstract final class AppColors {
  // Clay / brand primary.
  static const clay050 = Color(0xFFFAF5EE);
  static const clay100 = Color(0xFFE9D7C4);
  static const clay200 = Color(0xFFCFB096);
  static const clay800 = Color(0xFF6D4837);
  static const clay900 = Color(0xFF35251D);

  // Sage / secondary accent.
  static const sage100 = Color(0xFFE3E6D2);
  static const sage500 = Color(0xFF959976);
  static const sage700 = Color(0xFF61664A);

  // Ink / text.
  static const ink050 = Color(0xFFF5EFE8);
  static const ink300 = Color(0xFFB4A08D);
  static const ink500 = Color(0xFF806A57);
  static const ink900 = Color(0xFF201711);

  // Website paper canvas.
  static const paper = Color(0xFFF7F0E6);
  static const paperAlt = Color(0xFFE4D2BC);

  // Semantic surfaces.
  static const bgPage = paper;
  static const bg2 = Color(0xFFFFFDF9);
  static const bg3 = Color(0xFFEEE1D0);
  static const bg4 = Color(0xFFD4BEA5);
  static const bgInverse = ink900;

  // Semantic foreground.
  static const fg1 = ink900;
  static const fg2 = Color(0xFF594638);
  static const fg3 = Color(0xFF75604E);
  static const fg4 = Color(0xFF9D8773);
  static const fgOnClay = Color(0xFFFFFFFF);

  // Borders.
  static const border1 = Color(0xFFC9B39D);
  static const border2 = Color(0xFF8A6D59);
  static const surfaceBorderSoft = Color(0xFFDFD0C1);

  // Accent.
  static const accent = clay800;
  static const accentHover = clay900;
  static const accentPress = Color(0xFF4A3526);
  static const accentSoft = clay100;
  static const accent2 = sage500;
  static const accent2Soft = sage100;

  // Buttons.
  static const buttonBg = Color(0xFFFFFDF9);
  static const buttonHover = Color(0xFFF2E7DB);
  static const buttonBorder = Color(0xFFD8C5B3);

  // Status.
  static const success = Color(0xFF485A26);
  static const successBright = Color(0xFF2E7D32);
  static const successBg = Color(0xFFE8ECD6);
  static const warning = Color(0xFF8D560D);
  static const warningBg = Color(0xFFF0E0C8);
  static const danger = Color(0xFF802013);
  static const dangerBg = Color(0xFFF0D9D6);
  static const info = Color(0xFF485A66);
  static const infoBg = Color(0xFFDEE5EA);

  // Website-like soft shadows.
  static const shadow = Color(0x18503A2B);
  static const shadowDeep = Color(0x30503A2B);
}
