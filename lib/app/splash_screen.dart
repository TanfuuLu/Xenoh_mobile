import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'branding/app_brand.dart';
import 'theme/app_colors.dart';

/// Shown while the app resolves the initial auth state (silent refresh).
///
/// Deliberately mirrors `flutter_native_splash.yaml`'s native splash (same
/// Ascend emblem, same [AppColors.bgPage]
/// background) so there's no visible logo swap or background flash the
/// instant the Flutter engine takes over from the native splash. Uses an
/// explicit background color rather than the app's usual transparent
/// Scaffold, so it never shows the user's custom background photo before
/// preferences have even loaded.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _openingLightController = AnimationController(
    duration: const Duration(milliseconds: 1600),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _openingLightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final emblemSize = math.min(
      AppBrand.splashEmblemSize,
      screenSize.shortestSide - 48,
    );

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                RepaintBoundary(
                  child: SizedBox.square(
                    dimension: emblemSize + 32,
                    child: AnimatedBuilder(
                      animation: _openingLightController,
                      builder: (context, _) => CustomPaint(
                        key: const Key('splash-opening-light'),
                        painter: _OpeningLightRingPainter(
                          progress: _openingLightController.value,
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  AppBrand.emblemAsset,
                  width: emblemSize,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.medium,
                ),
              ],
            ),
            const SizedBox(height: 28),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}

/// A restrained gold comet that travels clockwise from the logo's left edge.
class _OpeningLightRingPainter extends CustomPainter {
  const _OpeningLightRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final ring = bounds.deflate(8);
    final center = ring.center;
    final radius = ring.width / 2;
    final headAngle = math.pi + (math.pi * 2 * progress);
    const tailSweep = 0.74;

    final head =
        center + Offset(math.cos(headAngle), math.sin(headAngle)) * radius;
    canvas
      ..drawArc(
        ring,
        0,
        math.pi * 2,
        false,
        Paint()
          ..color = AppColors.gold.withValues(alpha: 0.14)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      )
      ..drawArc(
        ring,
        headAngle - tailSweep,
        tailSweep,
        false,
        Paint()
          ..color = AppColors.gold.withValues(alpha: 0.88)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round,
      )
      ..drawCircle(
        head,
        7,
        Paint()
          ..color = AppColors.gold.withValues(alpha: 0.24)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
      )
      ..drawCircle(head, 2.6, Paint()..color = AppColors.gold);
  }

  @override
  bool shouldRepaint(covariant _OpeningLightRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
