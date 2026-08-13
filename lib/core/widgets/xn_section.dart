import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

export 'xn_card.dart' show XnCardStack;

/// A single translucent panel that stacks flat [XnSection]s separated by
/// [XnSectionDivider]s — the app's grouped-section layout, first used on the
/// dashboard. Screens use one group per page instead of individual cards.
class XnSectionGroup extends StatelessWidget {
  const XnSectionGroup({
    required this.children,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    super.key,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class XnSection extends StatefulWidget {
  const XnSection({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.xs,
      vertical: AppSpacing.md,
    ),
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  State<XnSection> createState() => _XnSectionState();
}

class _XnSectionState extends State<XnSection> {
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.md);

    return AnimatedScale(
      scale: widget.onTap != null && _pressed ? 0.99 : 1,
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
    );
  }
}

/// An [XnSectionGroup] that interleaves an [XnSectionDivider] between each
/// child — the one-liner for turning a list of cards into one flat panel.
class XnSectionList extends StatelessWidget {
  const XnSectionList({
    required this.children,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    super.key,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return XnSectionGroup(
      padding: padding,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const XnSectionDivider(),
          children[i],
        ],
      ],
    );
  }
}

class XnSectionDivider extends StatelessWidget {
  const XnSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.surfaceBorderSoft.withValues(alpha: 0.76),
    );
  }
}

/// Small-caps section label used at the top of an [XnSection].
class XnSectionEyebrow extends StatelessWidget {
  const XnSectionEyebrow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: AppColors.fg3,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.7,
      ),
    );
  }
}
