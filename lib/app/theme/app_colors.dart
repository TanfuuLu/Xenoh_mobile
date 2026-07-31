import 'package:flutter/material.dart';

/// Xenoh website palette translated to mobile.
///
/// Warm paper and clay remain the foundation, while coral, mint, sky, violet,
/// and amber give each interaction and status a distinct, lively character.
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

  // Coral / energetic primary.
  static const coral100 = Color(0xFFFFE2D8);
  static const coral500 = Color(0xFFE85D3F);
  static const coral700 = Color(0xFFC9432E);

  // Sky / information and focus.
  static const sky100 = Color(0xFFDFF2FC);
  static const sky500 = Color(0xFF3183B5);
  static const sky700 = Color(0xFF205F88);

  // Violet / plans and discovery.
  static const violet100 = Color(0xFFF0E6FA);
  static const violet500 = Color(0xFF8A5BB5);
  static const violet700 = Color(0xFF68408E);

  // Amber / energy and attention.
  static const amber100 = Color(0xFFFFE9BE);
  static const amber500 = Color(0xFFE49A22);
  static const amber700 = Color(0xFF9A5B00);

  // Mint / completion and recovery.
  static const mint100 = Color(0xFFDDF3E3);
  static const mint500 = Color(0xFF4B9B68);
  static const mint700 = Color(0xFF2F7048);

  // Ink / text.
  static const ink050 = Color(0xFFF5EFE8);
  static const ink300 = Color(0xFFB4A08D);
  static const ink500 = Color(0xFF806A57);
  static const ink900 = Color(0xFF201711);

  // Website paper canvas.
  static const paper = Color(0xFFFFF6EA);
  static const paperAlt = Color(0xFFFFDDC8);

  // Semantic surfaces.
  static const bgPage = paper;
  static const bg2 = Color(0xFFFFFCF7);
  static const bg3 = Color(0xFFFFE9DC);
  static const bg4 = Color(0xFFE6BFA5);
  static const bgInverse = ink900;

  // Semantic foreground.
  static const fg1 = ink900;
  static const fg2 = Color(0xFF594638);
  static const fg3 = Color(0xFF75604E);
  static const fg4 = Color(0xFF9D8773);
  static const fgOnClay = Color(0xFFFFFFFF);

  // Borders.
  static const border1 = Color(0xFFD8B49D);
  static const border2 = Color(0xFF8A6D59);
  static const surfaceBorderSoft = Color(0xFFE8CFC0);

  // Accent.
  static const accent = coral700;
  static const accentHover = Color(0xFFAA3525);
  static const accentPress = Color(0xFF8E2B20);
  static const accentSoft = coral100;
  static const accent2 = sky500;
  static const accent2Soft = sky100;

  // Buttons.
  static const buttonBg = Color(0xFFFFFDF9);
  static const buttonHover = Color(0xFFFFEDE4);
  static const buttonBorder = Color(0xFFE6C2AE);

  // Status.
  static const success = mint700;
  static const successBg = mint100;
  static const warning = amber700;
  static const warningBg = amber100;
  static const danger = Color(0xFFA62F3D);
  static const dangerBg = Color(0xFFF9DDE1);
  static const info = sky700;
  static const infoBg = sky100;

  // Website-like soft shadows.
  static const shadow = Color(0x1F9D4C34);
  static const shadowDeep = Color(0x339D4C34);
}
