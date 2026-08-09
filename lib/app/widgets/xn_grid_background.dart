import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Draws Xenoh's calm website canvas: a warm tonal wash with faint vertical
/// rules. The pattern is rendered at the physical viewport size, so it stays
/// crisp without an image asset or stretching artifacts.
class XnGridBackground extends StatelessWidget {
  const XnGridBackground({required this.child, super.key});

  static const double compactSpacing = 72;
  static const double maximumSpacing = 112;
  static const Color lineColor = AppColors.gridLine;

  final Widget child;

  static double spacingForWidth(double width) =>
      (width * 0.09).clamp(compactSpacing, maximumSpacing);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RepaintBoundary(
        child: CustomPaint(
          painter: _XnGridPainter(
            spacing: spacingForWidth(constraints.maxWidth),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _XnGridPainter extends CustomPainter {
  const _XnGridPainter({required this.spacing});

  final double spacing;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final basePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.gridTop, AppColors.gridBottom],
      ).createShader(rect);
    canvas.drawRect(rect, basePaint);

    final glowPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.78, -1.08),
        radius: 1.12,
        colors: [AppColors.gridGlow, Colors.transparent],
      ).createShader(rect);
    canvas.drawRect(rect, glowPaint);

    final linePaint = Paint()
      ..color = XnGridBackground.lineColor
      ..strokeWidth = 1;
    final center = size.width / 2;
    for (var x = center; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (var x = center - spacing; x >= 0; x -= spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _XnGridPainter oldDelegate) =>
      oldDelegate.spacing != spacing;
}
