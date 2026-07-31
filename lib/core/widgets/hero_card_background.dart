import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// The default backdrop painted inside hero cards (dashboard, cycle, plans,
/// nutrition, ...) when the user hasn't set their own background photo.
///
/// A vivid dimensional surface that moves from coral through violet to deep
/// sky, finished with a faint embossed Xenoh owl mark. Resolution-independent
/// and dark enough throughout to keep white hero text legible.
class HeroCardBackground extends StatelessWidget {
  const HeroCardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Saturated brand base with warm light and a cool vignette.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFB84935),
                Color(0xFF854665),
                Color(0xFF285D78),
              ],
              stops: [0.0, 0.52, 1.0],
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.9),
                radius: 1.2,
                colors: [Color(0x45FFD79A), Color(0x00FFD79A)],
                stops: [0.0, 0.65],
              ),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(1, 1.05),
                  radius: 1.1,
                  colors: [Color(0x66322A70), Color(0x00322A70)],
                  stops: [0.0, 0.7],
                ),
              ),
            ),
          ),
        ),
        // Embossed brand mark, bleeding off the bottom-right corner. Tinted to
        // a faint warm light so it reads as a quiet motif, not a logo stamp.
        Positioned(
          right: -34,
          bottom: -40,
          child: Image.asset(
            'assets/icon/logo_xenoh_transparent.png',
            width: 208,
            height: 208,
            color: AppColors.fgOnClay.withValues(alpha: 0.07),
            colorBlendMode: BlendMode.srcIn,
            filterQuality: FilterQuality.medium,
          ),
        ),
      ],
    );
  }
}
