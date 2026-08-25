import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_labels.dart';
import '../../../../core/utils/weight_units.dart';
import '../../domain/entities/bodyweight_log.dart';

/// Sparkline of bodyweight over time (no external chart dep): a smoothed line
/// over a fading gradient, with the date range as the only chrome. [logs] must
/// be sorted oldest → newest, values in kg; displayed in [unit].
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
      child: CustomPaint(
        painter: _ChartPainter(
          logs,
          unit,
          Localizations.localeOf(context).toString(),
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  _ChartPainter(this.logs, this.unit, this.locale);

  final List<BodyweightLog> logs;
  final WeightUnit unit;
  final String locale;

  // No y-axis labels to leave room for, so the line runs edge to edge; the
  // side padding only keeps the endpoint dot from clipping.
  static const _leftPad = 2.0;
  static const _rightPad = 8.0;
  static const _topPad = 14.0;
  static const _bottomPad = 26.0;

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

    final points = [
      for (var i = 0; i < logs.length; i++) Offset(xAt(i), yAt(weights[i])),
    ];

    if (points.length > 1) {
      final line = _smoothPath(points);

      // Gradient area, fading to nothing at the baseline.
      final fill = Path.from(line)
        ..lineTo(points.last.dx, chartBottom)
        ..lineTo(points.first.dx, chartBottom)
        ..close();
      canvas
        ..drawPath(
          fill,
          Paint()
            ..shader =
                LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.accent.withValues(alpha: 0.22),
                    AppColors.accent.withValues(alpha: 0),
                  ],
                ).createShader(
                  Rect.fromLTRB(chartLeft, _topPad, chartRight, chartBottom),
                ),
        )
        ..drawPath(
          line,
          Paint()
            ..color = AppColors.accent
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke
            ..strokeJoin = StrokeJoin.round
            ..strokeCap = StrokeCap.round,
        );
    }

    // Endpoint: soft halo, solid dot, punched-out centre.
    final last = points.last;
    canvas
      ..drawCircle(
        last,
        8,
        Paint()..color = AppColors.accent.withValues(alpha: 0.16),
      )
      ..drawCircle(last, 4, Paint()..color = AppColors.accent)
      ..drawCircle(last, 1.6, Paint()..color = AppColors.bg2);

    _paintDateAxis(canvas, size, xAt, chartBottom);
  }

  /// Catmull-Rom through every point, converted to cubics. Control points are
  /// clamped to their segment so a smoothed curve never invents a high or low
  /// the user never weighed.
  Path _smoothPath(List<Offset> points) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 0; i < points.length - 1; i++) {
      final previous = i == 0 ? points[i] : points[i - 1];
      final start = points[i];
      final end = points[i + 1];
      final next = i + 2 < points.length ? points[i + 2] : end;

      final c1 = Offset(
        start.dx + (end.dx - previous.dx) / 6,
        _clampBetween(start.dy + (end.dy - previous.dy) / 6, start.dy, end.dy),
      );
      final c2 = Offset(
        end.dx - (next.dx - start.dx) / 6,
        _clampBetween(end.dy - (next.dy - start.dy) / 6, start.dy, end.dy),
      );
      path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, end.dx, end.dy);
    }
    return path;
  }

  double _clampBetween(double value, double a, double b) {
    final low = a < b ? a : b;
    final high = a < b ? b : a;
    return value < low ? low : (value > high ? high : value);
  }

  void _paintDateAxis(
    Canvas canvas,
    Size size,
    double Function(int index) xAt,
    double chartBottom,
  ) {
    for (final index in _dateTickIndexes(size.width)) {
      _dateLabel(
        canvas,
        _formatDate(logs[index].date),
        Offset(xAt(index), chartBottom + 10),
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
    return DateLabels.monthDay(date, locale);
  }

  @override
  bool shouldRepaint(_ChartPainter old) =>
      old.logs != logs || old.unit != unit || old.locale != locale;
}

enum _DateLabelAlign { left, center, right }
