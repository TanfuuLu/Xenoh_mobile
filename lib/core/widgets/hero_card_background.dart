import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// The default backdrop painted inside hero cards (dashboard, cycle, plans,
/// nutrition, ...) when the user hasn't set their own background photo.
///
/// A lit, dimensional clay surface — a warm diagonal base, a soft highlight in
/// the top-left corner (as if lit from above) and a deep espresso pool in the
/// bottom-right — finished with a faint embossed Xenoh owl mark bleeding off
/// the bottom-right corner. Resolution-independent, so it stays crisp at any
/// card size, and dark enough throughout to keep white hero text legible.
class HeroCardBackground extends StatelessWidget {
  const HeroCardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Warm clay base: lighter top-left easing to deep espresso, plus a
        // soft highlight (top-left) and a deep vignette pool (bottom-right).
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF7A6150), // lifted clay — the "lit" corner
                Color(0xFF583F2E), // clay900
                Color(0xFF43301F), // deep espresso
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.9),
                radius: 1.2,
                colors: [Color(0x2EDCC2A8), Color(0x00DCC2A8)],
                stops: [0.0, 0.65],
              ),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(1, 1.05),
                  radius: 1.1,
                  colors: [Color(0x592A1D12), Color(0x002A1D12)],
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
