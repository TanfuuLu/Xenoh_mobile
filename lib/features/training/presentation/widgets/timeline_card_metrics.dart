import 'package:flutter/material.dart';

/// Height of the week and day timeline carousels.
///
/// Both screens call this so a week card and a day card render at the same
/// size: the carousel is sized to its content instead of stretching to fill
/// whatever viewport is left, which is what used to make day cards taller
/// than week cards. `extraLines` covers optional rows a card may carry
/// (a warning line, a cycle marker chip) that would otherwise overflow.
double trainingTimelineCardHeight(
  BuildContext context, {
  required double crossAxisExtent,
  int extraLines = 0,
}) {
  final textScale = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 1.6);
  final narrow = crossAxisExtent < 380;
  return (narrow ? 462.0 : 430.0) + ((textScale - 1) * 180) + (extraLines * 34);
}
