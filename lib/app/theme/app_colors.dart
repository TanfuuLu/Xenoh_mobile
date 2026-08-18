import 'package:flutter/material.dart';

/// Xenoh website palette translated to mobile.
///
/// Keep the app aligned with the web UI screenshots: warm paper background,
/// ivory cards, clay navigation states, and muted sage as the secondary accent.
abstract final class AppColors {
  // Clay / brand primary.
  static const clay050 = Color(0xFFFDF8EF);
  static const clay100 = Color(0xFFFAF1E0);
  static const clay200 = Color(0xFFF3E4C9);
  static const clay800 = Color(0xFF684331);
  static const clay900 = Color(0xFF4D3023);

  // Sage / secondary accent.
  static const sage100 = Color(0xFFDCF7EA);
  static const sage500 = Color(0xFF6FBF9A);
  static const sage700 = Color(0xFF398265);

  // Ink / text.
  static const ink050 = Color(0xFFF5EFE8);
  static const ink300 = Color(0xFFB4A08D);
  static const ink500 = Color(0xFF62584F);
  static const ink900 = Color(0xFF211B17);

  // Website paper canvas.
  static const paper = Color(0xFFF7F4EF);
  static const paperAlt = Color(0xFFE7E0D9);

  // Semantic surfaces.
  static const bgPage = paper;
  static const bg2 = Color(0xFFFFFDFA);
  static const bg3 = Color(0xFFF0ECE7);
  static const bg4 = Color(0xFFE7E0D9);
  static const bgInverse = ink900;

  // Semantic foreground.
  static const fg1 = ink900;
  static const fg2 = Color(0xFF483E36);
  static const fg3 = Color(0xFF62584F);
  static const fg4 = Color(0xFF8B8178);
  static const fgOnClay = Color(0xFFFFFFFF);

  // Borders.
  static const border1 = Color(0xFFD2C9C0);
  static const border2 = Color(0xFF8A6D59);
  static const surfaceBorderSoft = Color(0x21534135);

  // Accent.
  static const accent = Color(0xFFB6532F);
  static const accentHover = Color(0xFF9F4527);
  static const accentPress = Color(0xFF84371F);
  static const accentSoft = Color(0xFFFFF0E5);
  static const accent2 = sage500;
  static const accent2Soft = sage100;

  // Navigation active state. A filled clay capsule with a light glyph, which
  // matches the drawer's selected item instead of the old pale peach tint.
  static const navigationSelectedBackground = clay900;
  static const navigationSelectedForeground = fgOnClay;

  // Subtle authenticated-product background treatment from the website.
  static const gridTop = Color(0xFFFAF9F6);
  static const gridBottom = Color(0xFFF5EFE4);
  static const gridGlow = Color(0x145F402E);
  static const gridLine = Color(0x0C5F402E);

  // Buttons.
  static const buttonPrimary = Color(0xFF725945);
  static const buttonBg = Color(0xFFFBF7EF);
  static const buttonHover = Color(0xFFF1E8DC);
  static const buttonBorder = Color(0xFFD7C7B6);
  static const buttonText = Color(0xFF2E2218);
  static const segmentedButtonBg = bg3;
  static const segmentedButtonSelectedBg = clay200;
  static const segmentedButtonBorder = Color(0xFF000000);

  // Status.
  static const success = Color(0xFF485A26);
  static const successBg = Color(0xFFE8ECD6);
  static const warning = Color(0xFF8D560D);
  static const warningBg = Color(0xFFF0E0C8);
  static const danger = Color(0xFF802013);
  static const dangerBg = Color(0xFFF0D9D6);
  static const info = Color(0xFF485A66);
  static const infoBg = Color(0xFFDEE5EA);

  // Bright data-visualization palette. Color is concentrated in charts,
  // icons, progress, and status graphics while content surfaces stay quiet.
  static const dataBlue = Color(0xFF3B82F6);
  static const dataTeal = Color(0xFF14B8A6);
  static const dataViolet = Color(0xFF8B5CF6);
  static const dataAmber = Color(0xFFF59E0B);
  static const dataRose = Color(0xFFF43F5E);
  static const dataOlive = Color(0xFF84CC16);

  // Nutrition macro semantics. Keep these stable across every chart and card.
  static const macroProtein = Color(0xFFE53935);
  static const macroFat = Color(0xFFF9A825);
  static const macroCarbs = Color(0xFF43A047);

  static const dataPalette = <Color>[
    dataBlue,
    dataTeal,
    dataViolet,
    dataAmber,
    dataRose,
    dataOlive,
  ];

  static Color dataColor(int index) =>
      dataPalette[index.abs() % dataPalette.length];

  // IWF-style plate identification colors. These are equipment semantics,
  // not general UI accents, so they intentionally sit outside the brand ramp.
  static const plateRed = Color(0xFFD4483F);
  static const plateBlue = Color(0xFF3972B7);
  static const plateYellow = Color(0xFFE2B83F);
  static const plateGreen = Color(0xFF4F8B62);
  static const plateWhite = Color(0xFFF8F7F2);

  // Website-like soft shadows.
  static const shadow = Color(0x094A3426);
  static const shadowDeep = Color(0x1F4A3426);
}
