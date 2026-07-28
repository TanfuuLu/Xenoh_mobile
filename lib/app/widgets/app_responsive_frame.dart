import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// Keeps complete application screens comfortably sized on large viewports.
///
/// Phone layouts remain edge-to-edge. Tablets, desktop, and web receive a
/// centered application canvas while the surrounding page keeps the app
/// background color.
class AppResponsiveFrame extends StatelessWidget {
  const AppResponsiveFrame({required this.child, super.key});

  static const canvasKey = ValueKey('app-responsive-canvas');

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bgPage,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          key: canvasKey,
          constraints: const BoxConstraints(
            maxWidth: AppLayout.screenMaxWidth,
          ),
          child: SizedBox.expand(child: child),
        ),
      ),
    );
  }
}
