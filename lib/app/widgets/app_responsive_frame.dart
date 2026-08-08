import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';

enum AppBreakpoint { compact, medium, expanded }

/// Keeps complete application screens comfortably sized on large viewports.
///
/// Phone layouts remain edge-to-edge. Tablets, desktop, and web receive a
/// centered application canvas while the surrounding page keeps the app
/// background color.
class AppResponsiveFrame extends StatelessWidget {
  const AppResponsiveFrame({required this.child, super.key});

  static const canvasKey = ValueKey('app-responsive-canvas');

  final Widget child;

  static AppBreakpoint breakpointForWidth(double width) {
    if (width >= 840) return AppBreakpoint.expanded;
    if (width >= 600) return AppBreakpoint.medium;
    return AppBreakpoint.compact;
  }

  static bool usesNavigationRail(double width) =>
      breakpointForWidth(width) == AppBreakpoint.expanded;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        key: canvasKey,
        constraints: const BoxConstraints(
          maxWidth: AppLayout.screenMaxWidth,
        ),
        child: SizedBox.expand(child: child),
      ),
    );
  }
}
