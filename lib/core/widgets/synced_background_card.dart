import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../features/profile/data/repositories/profile_background_repository.dart';
import 'hero_card_background.dart';

/// Header card whose backdrop is the signed-in user's chosen background.
/// It resolves that itself from [currentUserBackgroundProvider] rather than
/// taking a path, so every header card on every screen shows the same image
/// and swaps together when the account changes.
class SyncedBackgroundCard extends ConsumerWidget {
  const SyncedBackgroundCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.xxl),
    this.fallbackColor = AppColors.bgInverse,
    this.borderRadius = AppRadius.xxl,
    this.minHeight = AppLayout.heroCardMinHeight,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color fallbackColor;
  final double borderRadius;
  final double minHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final background =
        ref.watch(currentUserBackgroundProvider).value ??
        const UserBackground.none();
    final backgroundImagePath = background.path;
    final backgroundFile = backgroundImagePath == null
        ? null
        : File(backgroundImagePath);
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
                alignment: background.alignment,
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
