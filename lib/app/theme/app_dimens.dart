/// Spacing, radius and motion tokens (from `STYLE_GUIDE.md` §3).
abstract final class AppSpacing {
  static const xs = 3.5;
  static const sm = 6.0;
  static const md = 9.0;
  static const lg = 14.0;
  static const xl = 18.0;
  static const xxl = 23.0;
  static const xxxl = 32.0;
}

abstract final class AppRadius {
  static const xs = 4.0;
  static const sm = 5.0;
  static const md = 10.0;
  static const lg = 12.0;
  static const xl = 16.0;
  static const xxl = 19.0;
  static const pill = 999.0;
}

abstract final class AppLayout {
  /// Maximum width of a complete screen on tablets, desktop, and web.
  static const screenMaxWidth = 1120.0;

  /// Maximum width for reading-focused lists and forms.
  static const contentMaxWidth = 760.0;

  /// Matches the rendered height of the dashboard hero card, so every
  /// screen's first card reads at the same visual weight regardless of
  /// how little content it holds.
  static const heroCardMinHeight = 222.0;
}

abstract final class AppMotion {
  static const fast = Duration(milliseconds: 150);
  static const med = Duration(milliseconds: 260);
  static const slow = Duration(milliseconds: 440);
}
