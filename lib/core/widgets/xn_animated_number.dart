import 'package:flutter/material.dart';

typedef XnNumberFormatter = String Function(double value);

/// Lightweight count-up text for changing numeric values.
class XnAnimatedNumber extends StatelessWidget {
  const XnAnimatedNumber({
    required this.value,
    required this.formatter,
    this.style,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutCubic,
    this.animateOnMount = true,
    this.initialValue = 0,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.textWidthBasis,
    super.key,
  });

  final double value;
  final XnNumberFormatter formatter;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;
  final bool animateOnMount;
  final double initialValue;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextWidthBasis? textWidthBasis;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: animateOnMount ? initialValue : value,
        end: value,
      ),
      duration: duration,
      curve: curve,
      builder: (context, animatedValue, child) {
        return Text(
          formatter(animatedValue),
          style: style,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
        );
      },
    );
  }
}

String formatAnimatedInt(double value) => value.round().toString();

XnNumberFormatter formatAnimatedFixed(int fractionDigits) {
  return (value) => value.toStringAsFixed(fractionDigits);
}

String formatAnimatedThousands(double value) {
  final rounded = value.round();
  final sign = rounded < 0 ? '-' : '';
  final source = rounded.abs().toString();
  final buffer = StringBuffer(sign);
  for (var i = 0; i < source.length; i++) {
    if (i > 0 && (source.length - i) % 3 == 0) buffer.write(',');
    buffer.write(source[i]);
  }
  return buffer.toString();
}

String formatAnimatedDuration(double value) {
  final totalSeconds = value.round().clamp(0, 1 << 31);
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(hours)}:${two(minutes)}:${two(seconds)}';
}
