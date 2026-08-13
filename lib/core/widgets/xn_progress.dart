import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';

class XnAnimatedLinearProgress extends StatelessWidget {
  const XnAnimatedLinearProgress({
    required this.value,
    required this.backgroundColor,
    required this.color,
    this.minHeight = 7,
    super.key,
  });

  final double value;
  final Color backgroundColor;
  final Color color;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: value.clamp(0.0, 1.0)),
      duration: AppMotion.med,
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) => LinearProgressIndicator(
        value: animatedValue,
        minHeight: minHeight,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}

class XnAnimatedCircularProgress extends StatelessWidget {
  const XnAnimatedCircularProgress({
    required this.value,
    required this.backgroundColor,
    required this.color,
    required this.strokeWidth,
    this.indeterminate = false,
    super.key,
  });

  final double? value;
  final Color backgroundColor;
  final Color color;
  final double strokeWidth;
  final bool indeterminate;

  @override
  Widget build(BuildContext context) {
    if (indeterminate) {
      return CircularProgressIndicator(
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation(color),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: (value ?? 0).clamp(0.0, 1.0)),
      duration: AppMotion.med,
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) => CircularProgressIndicator(
        value: animatedValue,
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}
