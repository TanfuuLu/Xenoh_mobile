import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

enum XnButtonVariant { primary, secondary, ghost, danger }

/// Branded action button with an inline loading state.
class XnButton extends StatelessWidget {
  const XnButton({
    required this.label,
    this.onPressed,
    this.variant = XnButtonVariant.primary,
    this.loading = false,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final XnButtonVariant variant;
  final bool loading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = loading ? null : onPressed;
    final loadingColor = switch (variant) {
      XnButtonVariant.primary || XnButtonVariant.danger => AppColors.fgOnClay,
      XnButtonVariant.secondary ||
      XnButtonVariant.ghost => AppColors.buttonPrimary,
    };
    final child = AnimatedSwitcher(
      duration: AppMotion.fast,
      reverseDuration: AppMotion.fast,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1).animate(animation),
          child: child,
        ),
      ),
      child: loading
          ? SizedBox(
              key: const ValueKey('loading'),
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: loadingColor,
              ),
            )
          : KeyedSubtree(
              key: const ValueKey('content'),
              child: _content(),
            ),
    );

    return switch (variant) {
      XnButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      XnButtonVariant.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      XnButtonVariant.ghost => TextButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      XnButtonVariant.danger => FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.danger,
          foregroundColor: AppColors.fgOnClay,
          minimumSize: const Size(56, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: child,
      ),
    };
  }

  Widget _content() {
    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
