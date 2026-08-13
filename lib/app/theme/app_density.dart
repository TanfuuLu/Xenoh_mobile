import 'package:flutter/material.dart';

/// Global visual density for the Xenoh interface.
///
/// The website renders its mobile UI below the browser default scale. The
/// Flutter app applies the same compact treatment while delegating text
/// accessibility scaling to the platform-provided [TextScaler].
abstract final class AppDensity {
  static const uiScale = 0.88;

  static TextScaler compactTextScaler(TextScaler platformScaler) =>
      _CompactTextScaler(platformScaler);
}

/// Applies Xenoh's compact base scale without replacing the platform's
/// accessibility text scaler.
class AppDensityScope extends StatelessWidget {
  const AppDensityScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(
        textScaler: AppDensity.compactTextScaler(mediaQuery.textScaler),
      ),
      child: child,
    );
  }
}

final class _CompactTextScaler extends TextScaler {
  const _CompactTextScaler(this.platformScaler);

  final TextScaler platformScaler;

  @override
  double scale(double fontSize) =>
      platformScaler.scale(fontSize) * AppDensity.uiScale;

  @override
  double get textScaleFactor => scale(1);
}
