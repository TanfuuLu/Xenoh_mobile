import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../domain/entities/bodyweight_log.dart';

/// Lightweight line chart of bodyweight over time (no external chart dep).
/// [logs] must be sorted oldest → newest, values in kg; displayed in [unit].
class BodyweightChart extends StatelessWidget {
  const BodyweightChart({
    required this.logs,
    required this.unit,
    this.height = 152,
    super.key,
  });

  final List<BodyweightLog> logs;
  final WeightUnit unit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _ChartPainter(logs, unit)),
    );
  }
}

class _ChartPainter extends CustomPainter {
  _ChartPainter(this.logs, this.unit);

  final List<BodyweightLog> logs;
  final WeightUnit unit;

  static const _leftPad = 36.0;
  static const _topPad = 12.0;
  static const _bottomPad = 34.0;
  static const _rightPad = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (logs.isEmpty) return;

    final weights = logs.map((e) => unit.fromKg(e.weight)).toList();
    var minW = weights.reduce((a, b) => a < b ? a : b);
    var maxW = weights.reduce((a, b) => a > b ? a : b);
    if (maxW - minW < 1) {
      // Flat-ish series: pad so the line isn't glued to an edge.
      minW -= 1;
      maxW += 1;
    }
    final range = maxW - minW;

    const chartLeft = _leftPad;
    final chartRight = size.width - _rightPad;
    final chartW = chartRight - chartLeft;
    final chartH = size.height - _topPad - _bottomPad;
    final chartBottom = _topPad + chartH;

    double xAt(int i) => logs.length == 1
        ? chartLeft + chartW / 2
        : chartLeft + chartW * i / (logs.length - 1);
    double yAt(double w) => _topPad + chartH * (1 - (w - minW) / range);

    // Horizontal gridlines + min/max axis labels.
    final gridPaint = Paint()
      ..color = AppColors.surfaceBorderSoft
      ..strokeWidth = 1;
    for (final w in [maxW, minW]) {
      final y = yAt(w);
      canvas.drawLine(Offset(chartLeft, y), Offset(chartRight, y), gridPaint);
      _label(canvas, w.toStringAsFixed(0), Offset(0, y - 6));
    }

    final points = [
      for (var i = 0; i < logs.length; i++) Offset(xAt(i), yAt(weights[i])),
    ];

    // Area fill under the line.
    if (points.length > 1) {
      final fill = Path()..moveTo(points.first.dx, chartBottom);
      for (final p in points) {
        fill.lineTo(p.dx, p.dy);
      }
      fill
        ..lineTo(points.last.dx, chartBottom)
        ..close();
      canvas.drawPath(
        fill,
        Paint()..color = AppColors.accent.withValues(alpha: 0.10),
      );
    }

    // Line.
    final linePaint = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    if (points.length > 1) {
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final p in points.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, linePaint);
    }

    // Endpoint dot.
    final last = points.last;
    canvas
      ..drawCircle(last, 4.5, Paint()..color = AppColors.accent)
      ..drawCircle(last, 2, Paint()..color = AppColors.bg2);

    _paintDateAxis(canvas, size, xAt, chartBottom);
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

  void _paintDateAxis(
    Canvas canvas,
    Size size,
    double Function(int index) xAt,
    double chartBottom,
  ) {
    final ticks = _dateTickIndexes(size.width);
    final tickPaint = Paint()
      ..color = AppColors.surfaceBorderSoft
      ..strokeWidth = 1;

    for (final index in ticks) {
      final x = xAt(index);
      canvas.drawLine(
        Offset(x, chartBottom),
        Offset(x, chartBottom + 4),
        tickPaint,
      );
      _dateLabel(
        canvas,
        _formatDate(logs[index].date),
        Offset(x, chartBottom + 8),
        switch (index) {
          0 => _DateLabelAlign.left,
          _ when index == logs.length - 1 => _DateLabelAlign.right,
          _ => _DateLabelAlign.center,
        },
      );
    }
  }

  List<int> _dateTickIndexes(double width) {
    if (logs.length == 1) return const [0];
    if (logs.length == 2 || width < 280) return [0, logs.length - 1];
    return [0, logs.length ~/ 2, logs.length - 1];
  }

  void _dateLabel(
    Canvas canvas,
    String text,
    Offset anchor,
    _DateLabelAlign align,
  ) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTypography.mono(10, color: AppColors.fg3),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final dx = switch (align) {
      _DateLabelAlign.left => anchor.dx,
      _DateLabelAlign.center => anchor.dx - painter.width / 2,
      _DateLabelAlign.right => anchor.dx - painter.width,
    };
    painter.paint(canvas, Offset(dx, anchor.dy));
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  @override
  bool shouldRepaint(_ChartPainter old) => old.logs != logs || old.unit != unit;
}

enum _DateLabelAlign { left, center, right }
