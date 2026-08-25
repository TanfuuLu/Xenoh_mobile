import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../domain/entities/exercise_pr.dart';

/// Line chart of PR weight over time (no external chart dep). [points] must be
/// sorted oldest → newest, in kg; the axis labels are shown in [unit].
class PrLineChart extends StatelessWidget {
  const PrLineChart({
    required this.points,
    required this.unit,
    this.height = 160,
    super.key,
  });

  final List<ExercisePrPoint> points;
  final WeightUnit unit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _PrChartPainter(points, unit)),
    );
  }
}

class _PrChartPainter extends CustomPainter {
  _PrChartPainter(this.points, this.unit);

  final List<ExercisePrPoint> points;
  final WeightUnit unit;

  static const _leftPad = 40.0;
  static const _vPad = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final weights = points.map((e) => e.weight).toList();
    var minW = weights.reduce((a, b) => a < b ? a : b);
    var maxW = weights.reduce((a, b) => a > b ? a : b);
    if (maxW - minW < 1) {
      minW -= 1;
      maxW += 1;
    }
    final range = maxW - minW;

    const chartLeft = _leftPad;
    final chartW = size.width - _leftPad;
    final chartH = size.height - _vPad * 2;

    double xAt(int i) => points.length == 1
        ? chartLeft + chartW / 2
        : chartLeft + chartW * i / (points.length - 1);
    double yAt(double w) => _vPad + chartH * (1 - (w - minW) / range);

    final gridPaint = Paint()
      ..color = AppColors.surfaceBorderSoft
      ..strokeWidth = 1;
    for (final w in [maxW, minW]) {
      final y = yAt(w);
      canvas.drawLine(Offset(chartLeft, y), Offset(size.width, y), gridPaint);
      _label(canvas, formatWeight(unit.fromKg(w)), Offset(0, y - 6));
    }

    final dots = [
      for (var i = 0; i < points.length; i++)
        Offset(xAt(i), yAt(points[i].weight)),
    ];

    if (dots.length > 1) {
      final fill = Path()..moveTo(dots.first.dx, size.height - _vPad);
      for (final p in dots) {
        fill.lineTo(p.dx, p.dy);
      }
      fill
        ..lineTo(dots.last.dx, size.height - _vPad)
        ..close();
      canvas.drawPath(
        fill,
        Paint()..color = AppColors.accent.withValues(alpha: 0.10),
      );

      final linePaint = Paint()
        ..color = AppColors.accent
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round;
      final path = Path()..moveTo(dots.first.dx, dots.first.dy);
      for (final p in dots.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, linePaint);
    }

    for (final p in dots) {
      canvas
        ..drawCircle(p, 4, Paint()..color = AppColors.accent)
        ..drawCircle(p, 1.8, Paint()..color = AppColors.bg2);
    }
  }

  void _label(Canvas canvas, String text, Offset offset) {
    TextPainter(
        text: TextSpan(
          text: text,
          style: AppTypography.mono(10, color: AppColors.fg3),
        ),
        textDirection: TextDirection.ltr,
      )
      ..layout(maxWidth: _leftPad - 4)
      ..paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_PrChartPainter old) => old.points != points;
}
