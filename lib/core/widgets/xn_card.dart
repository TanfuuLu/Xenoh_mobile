import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

/// A card surface with fast tap feedback and smooth content size changes.
class XnCard extends StatefulWidget {
  const XnCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
    this.color = AppColors.bg2,
    this.onTap,
    this.border,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final VoidCallback? onTap;

  /// Overrides the default soft border (e.g. to highlight the card).
  final BoxBorder? border;

  @override
  State<XnCard> createState() => _XnCardState();
}

class _XnCardState extends State<XnCard> {
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.xxl);

    return AnimatedScale(
      scale: widget.onTap != null && _pressed ? 0.985 : 1,
      duration: AppMotion.fast,
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: widget.onTap == null
              ? null
              : (value) => setState(() => _pressed = value),
          borderRadius: radius,
          child: Ink(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: radius,
              border:
                  widget.border ??
                  Border.all(
                    color: AppColors.surfaceBorderSoft.withValues(alpha: 0.82),
                  ),
            ),
            child: Padding(
              padding: widget.padding,
              child: AnimatedSize(
                duration: AppMotion.med,
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
