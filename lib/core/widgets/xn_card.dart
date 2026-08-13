import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

/// A card surface with fast tap feedback and smooth content size changes.
class XnCard extends StatefulWidget {
  const XnCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
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
    final radius = BorderRadius.circular(AppRadius.lg);

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
                  Border.all(color: AppColors.surfaceBorderSoft),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
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

/// A vertical collection where every child owns an independent card surface.
///
/// Unlike the legacy grouped-section list, this widget has no shared outer
/// surface and draws no dividers between adjacent data items.
class XnCardStack extends StatelessWidget {
  const XnCardStack({
    required this.children,
    this.spacing = AppSpacing.md,
    this.itemPadding = const EdgeInsets.all(AppSpacing.lg),
    super.key,
  });

  final List<Widget> children;
  final double spacing;
  final EdgeInsetsGeometry itemPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < children.length; index++) ...[
          if (children[index] case final XnCard card)
            card
          else
            XnCard(padding: itemPadding, child: children[index]),
          if (index < children.length - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }
}
