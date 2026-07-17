import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// One labelled line on a [LineSeriesChart]. [points] are `(x, y)` where `x` is
/// a sortable category key (e.g. an ISO week-start date) shared across series.
class LineSeries {
  const LineSeries({
    required this.name,
    required this.color,
    required this.points,
  });

  final String name;
  final Color color;
  final List<({String x, double y})> points;
}

/// Lightweight multi-series line chart (no external chart dependency) used by
/// the powerlifting view for the estimated-1RM trend and DOTS-over-time. Series
/// share one x domain built from the union of their x keys; gaps are connected.
class LineSeriesChart extends StatelessWidget {
  const LineSeriesChart({
    required this.series,
    this.height = 200,
    this.yLabel,
    super.key,
  });

  final List<LineSeries> series;
  final double height;

  /// Optional formatter for the min/max y-axis labels. Defaults to a rounded
  /// integer.
  final String Function(double value)? yLabel;

  @override
  Widget build(BuildContext context) {
    final legend = series.where((s) => s.points.isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (legend.length > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                for (final s in legend)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: s.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        s.name,
                        style: AppTypography.mono(11, color: AppColors.fg3),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        SizedBox(
          height: height,
          width: double.infinity,
          child: CustomPaint(
            painter: _LineSeriesPainter(series, yLabel ?? _defaultYLabel),
          ),
        ),
      ],
    );
  }

  static String _defaultYLabel(double v) => v.round().toString();
}

class _LineSeriesPainter extends CustomPainter {
  _LineSeriesPainter(this.series, this.yLabel);

  final List<LineSeries> series;
  final String Function(double) yLabel;

  static const _leftPad = 44.0;
  static const _vPad = 12.0;
  static const _bottomPad = 18.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Shared, sorted x domain across all series.
    final xs = (series.expand((s) => s.points.map((p) => p.x)).toSet().toList()
      ..sort());
    if (xs.isEmpty) return;
    final xIndex = {for (var i = 0; i < xs.length; i++) xs[i]: i};

    final allY = series.expand((s) => s.points.map((p) => p.y)).toList();
    if (allY.isEmpty) return;
    var minY = allY.reduce((a, b) => a < b ? a : b);
    var maxY = allY.reduce((a, b) => a > b ? a : b);
    if (maxY - minY < 1) {
      minY -= 1;
      maxY += 1;
    }
    final range = maxY - minY;

    const chartLeft = _leftPad;
    final chartW = size.width - _leftPad;
    final chartH = size.height - _vPad - _bottomPad;

    double xAt(int i) => xs.length == 1
        ? chartLeft + chartW / 2
        : chartLeft + chartW * i / (xs.length - 1);
    double yAt(double v) => _vPad + chartH * (1 - (v - minY) / range);

    // Y gridlines + labels at min/max.
    final gridPaint = Paint()
      ..color = AppColors.surfaceBorderSoft
      ..strokeWidth = 1;
    for (final v in [maxY, minY]) {
      final y = yAt(v);
      canvas.drawLine(Offset(chartLeft, y), Offset(size.width, y), gridPaint);
      _text(canvas, yLabel(v), Offset(0, y - 6), _leftPad - 6, right: true);
    }

    // X labels: first + last only, to avoid clutter.
    _text(
      canvas,
      _shortDate(xs.first),
      Offset(chartLeft, size.height - 12),
      60,
    );
    if (xs.length > 1) {
      _text(
        canvas,
        _shortDate(xs.last),
        Offset(size.width - 60, size.height - 12),
        60,
        right: true,
      );
    }

    for (final s in series) {
      if (s.points.isEmpty) continue;
      final ordered = [...s.points]..sort((a, b) => a.x.compareTo(b.x));
      final dots = [
        for (final p in ordered) Offset(xAt(xIndex[p.x]!), yAt(p.y)),
      ];

      if (dots.length > 1) {
        final linePaint = Paint()
          ..color = s.color
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
          ..drawCircle(p, 3.5, Paint()..color = s.color)
          ..drawCircle(p, 1.6, Paint()..color = AppColors.bg2);
      }
    }
  }

  void _text(
    Canvas canvas,
    String text,
    Offset offset,
    double maxWidth, {
    bool right = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTypography.mono(10, color: AppColors.fg3),
      ),
      textDirection: TextDirection.ltr,
      textAlign: right ? TextAlign.right : TextAlign.left,
    )..layout(maxWidth: maxWidth);
    final dx = right ? offset.dx - (maxWidth - tp.width) : offset.dx;
    tp.paint(canvas, Offset(dx, offset.dy));
  }

  @override
  bool shouldRepaint(_LineSeriesPainter old) => old.series != series;
}

/// Formats an ISO date string (`yyyy-MM-dd`) as `M/d`; falls back to the raw
/// value when it can't be parsed.
String _shortDate(String iso) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) return iso;
  return '${parsed.month}/${parsed.day}';
}
