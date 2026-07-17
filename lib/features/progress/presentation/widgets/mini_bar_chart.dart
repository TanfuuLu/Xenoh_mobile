import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

/// One labelled bar.
class BarDatum {
  const BarDatum({required this.label, required this.value, this.caption});

  /// Short x-axis label (e.g. "W1").
  final String label;

  /// Bar height value (>= 0). Scaled against the series max.
  final double value;

  /// Optional value caption drawn above the bar (e.g. "82%").
  final String? caption;
}

/// Lightweight vertical bar chart (no external chart dep). Bars scale to the
/// series max; an empty series renders a friendly placeholder.
///
/// Each bar is given at least [minSlotWidth] so its value caption and x-axis
/// label never truncate; when the series is too wide to fit, the chart scrolls
/// horizontally instead of cramming the bars together.
class MiniBarChart extends StatelessWidget {
  const MiniBarChart({
    required this.data,
    this.height = 150,
    this.color = AppColors.accent,
    this.minSlotWidth = 38,
    super.key,
  });

  final List<BarDatum> data;
  final double height;
  final Color color;
  final double minSlotWidth;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            AppLocalizations.of(context).progressNoDataYet,
            style: const TextStyle(color: AppColors.fg3),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        final naturalSlot = available / data.length;
        final scrollable = naturalSlot < minSlotWidth;
        final width = scrollable ? minSlotWidth * data.length : available;

        final chart = SizedBox(
          height: height,
          width: width,
          child: CustomPaint(painter: _BarChartPainter(data, color)),
        );

        if (!scrollable) return chart;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: chart,
        );
      },
    );
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter(this.data, this.color);

  final List<BarDatum> data;
  final Color color;

  static const _labelArea = 18.0;
  static const _captionArea = 16.0;
  static const _gap = 6.0;

  @override
  void paint(Canvas canvas, Size size) {
    final maxV = data
        .map((d) => d.value)
        .fold<double>(0, (a, b) => a > b ? a : b);
    final plotH = size.height - _labelArea - _captionArea;
    final slot = size.width / data.length;
    final barW = (slot - _gap).clamp(4.0, 48.0);

    final barPaint = Paint()..color = color;
    final trackPaint = Paint()..color = AppColors.bg3;

    // Faint baseline grounding the bars.
    final baselineY = _captionArea + plotH;
    canvas.drawLine(
      Offset(0, baselineY),
      Offset(size.width, baselineY),
      Paint()
        ..color = AppColors.surfaceBorderSoft
        ..strokeWidth = 1,
    );

    for (var i = 0; i < data.length; i++) {
      final d = data[i];
      final cx = slot * i + slot / 2;
      final left = cx - barW / 2;
      final ratio = maxV <= 0 ? 0.0 : d.value / maxV;
      final barH = plotH * ratio;
      final top = _captionArea + (plotH - barH);
      final radius = Radius.circular(barW < 10 ? 2 : 4);

      // Faint full-height track behind each bar.
      canvas.drawRRect(
        RRect.fromLTRBR(
          left,
          _captionArea,
          left + barW,
          _captionArea + plotH,
          radius,
        ),
        trackPaint,
      );
      if (barH > 0) {
        canvas.drawRRect(
          RRect.fromLTRBR(left, top, left + barW, _captionArea + plotH, radius),
          barPaint,
        );
      }

      if (d.caption != null) {
        _text(canvas, d.caption!, cx, 0, AppColors.fg2, 10, slot);
      }
      _text(
        canvas,
        d.label,
        cx,
        _captionArea + plotH + 3,
        AppColors.fg3,
        10,
        slot,
      );
    }
  }

  void _text(
    Canvas canvas,
    String text,
    double cx,
    double top,
    Color color,
    double fontSize,
    double maxWidth,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTypography.mono(fontSize, color: color),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: maxWidth);
    tp.paint(canvas, Offset(cx - tp.width / 2, top));
  }

  @override
  bool shouldRepaint(_BarChartPainter old) =>
      old.data != data || old.color != color;
}
