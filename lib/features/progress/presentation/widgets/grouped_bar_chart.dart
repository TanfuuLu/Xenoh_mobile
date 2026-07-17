import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

/// One category with two comparable values (e.g. planned vs completed).
class GroupedBarDatum {
  const GroupedBarDatum({
    required this.label,
    required this.valueA,
    required this.valueB,
  });

  /// Short x-axis label (e.g. "W1").
  final String label;

  /// First series value (drawn left, e.g. planned).
  final double valueA;

  /// Second series value (drawn right, e.g. completed).
  final double valueB;
}

/// Grouped vertical bar chart (no external chart dep) that places two bars per
/// category for side-by-side comparison, with a legend. Gives each group a
/// minimum slot width and scrolls horizontally when the series is too wide to
/// fit.
class GroupedBarChart extends StatelessWidget {
  const GroupedBarChart({
    required this.data,
    required this.seriesALabel,
    required this.seriesBLabel,
    this.seriesAColor = AppColors.bg4,
    this.seriesBColor = AppColors.accent2,
    this.height = 160,
    this.minSlotWidth = 48,
    super.key,
  });

  final List<GroupedBarDatum> data;
  final String seriesALabel;
  final String seriesBLabel;
  final Color seriesAColor;
  final Color seriesBColor;
  final double height;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Row(
            children: [
              _LegendDot(color: seriesAColor, label: seriesALabel),
              const SizedBox(width: AppSpacing.lg),
              _LegendDot(color: seriesBColor, label: seriesBLabel),
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final available = constraints.maxWidth;
            final naturalSlot = available / data.length;
            final scrollable = naturalSlot < minSlotWidth;
            final width = scrollable ? minSlotWidth * data.length : available;

            final chart = SizedBox(
              height: height,
              width: width,
              child: CustomPaint(
                painter: _GroupedBarPainter(data, seriesAColor, seriesBColor),
              ),
            );

            if (!scrollable) return chart;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: chart,
            );
          },
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTypography.mono(11, color: AppColors.fg3)),
      ],
    );
  }
}

class _GroupedBarPainter extends CustomPainter {
  _GroupedBarPainter(this.data, this.colorA, this.colorB);

  final List<GroupedBarDatum> data;
  final Color colorA;
  final Color colorB;

  static const _labelArea = 18.0;
  static const _captionArea = 16.0;
  static const _innerGap = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final maxV = data.fold<double>(
      0,
      (m, d) => [m, d.valueA, d.valueB].reduce((a, b) => a > b ? a : b),
    );
    final plotH = size.height - _labelArea - _captionArea;
    final slot = size.width / data.length;
    // Two bars per slot share ~64% of the slot, split by an inner gap.
    final pairW = (slot * 0.64).clamp(8.0, 64.0);
    final barW = (pairW - _innerGap) / 2;
    final baselineY = _captionArea + plotH;

    final paintA = Paint()..color = colorA;
    final paintB = Paint()..color = colorB;

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
      final radius = Radius.circular(barW < 10 ? 2 : 4);

      _bar(
        canvas,
        cx - _innerGap / 2 - barW,
        barW,
        d.valueA,
        maxV,
        plotH,
        paintA,
        radius,
      );
      _bar(
        canvas,
        cx + _innerGap / 2,
        barW,
        d.valueB,
        maxV,
        plotH,
        paintB,
        radius,
      );

      _text(canvas, d.label, cx, baselineY + 3, AppColors.fg3, slot);
    }
  }

  void _bar(
    Canvas canvas,
    double left,
    double barW,
    double value,
    double maxV,
    double plotH,
    Paint paint,
    Radius radius,
  ) {
    final ratio = maxV <= 0 ? 0.0 : value / maxV;
    final barH = plotH * ratio;
    if (barH <= 0) return;
    final top = _captionArea + (plotH - barH);
    canvas.drawRRect(
      RRect.fromLTRBR(left, top, left + barW, _captionArea + plotH, radius),
      paint,
    );
  }

  void _text(
    Canvas canvas,
    String text,
    double cx,
    double top,
    Color color,
    double maxWidth,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTypography.mono(10, color: color),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: maxWidth);
    tp.paint(canvas, Offset(cx - tp.width / 2, top));
  }

  @override
  bool shouldRepaint(_GroupedBarPainter old) =>
      old.data != data || old.colorA != colorA || old.colorB != colorB;
}
