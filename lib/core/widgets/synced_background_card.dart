import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import 'hero_card_background.dart';

class SyncedBackgroundCard extends StatelessWidget {
  const SyncedBackgroundCard({
    required this.child,
    this.backgroundImagePath,
    this.padding = const EdgeInsets.all(AppSpacing.xxl),
    this.fallbackColor = AppColors.bgInverse,
    this.borderRadius = AppRadius.xxl,
    this.minHeight = AppLayout.heroCardMinHeight,
    this.backgroundAlignment = Alignment.center,
    super.key,
  });

  final Widget child;
  final String? backgroundImagePath;
  final EdgeInsetsGeometry padding;
  final Color fallbackColor;
  final double borderRadius;
  final double minHeight;
  final Alignment backgroundAlignment;

  @override
  Widget build(BuildContext context) {
    final backgroundFile = backgroundImagePath == null
        ? null
        : File(backgroundImagePath!);
    final hasCustomBackground =
        backgroundFile != null && backgroundFile.existsSync();

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: minHeight),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: fallbackColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: hasCustomBackground
              ? AppColors.fgOnClay.withValues(alpha: 0.12)
              : AppColors.clay200.withValues(alpha: 0.14),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDeep,
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (hasCustomBackground) ...[
            Positioned.fill(
              child: Image.file(
                backgroundFile,
                fit: BoxFit.cover,
                alignment: backgroundAlignment,
                filterQuality: FilterQuality.medium,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.clay900.withValues(alpha: 0.78),
                      AppColors.clay900.withValues(alpha: 0.56),
                    ],
                  ),
                ),
              ),
            ),
          ] else
            const Positioned.fill(child: HeroCardBackground()),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}
