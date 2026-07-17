import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.title,
    required this.subtitle,
    required this.child,
    this.footer,
    this.currentStep,
    this.totalSteps,
    this.stepLabel,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;
  final int? currentStep;
  final int? totalSteps;
  final String? stepLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: _AuthBackdrop())),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 840;
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    wide ? AppSpacing.xxxl : AppSpacing.xl,
                    AppSpacing.lg,
                    wide ? AppSpacing.xxxl : AppSpacing.xl,
                    AppSpacing.xxxl,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1080),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _AuthBrand(),
                          SizedBox(
                            height: wide ? AppSpacing.xxxl : AppSpacing.xl,
                          ),
                          if (wide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: AppSpacing.xxxl,
                                      bottom: AppSpacing.xxxl,
                                    ),
                                    child: _AuthHero(
                                      title: title,
                                      subtitle: subtitle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: _AuthFormColumn(
                                    currentStep: currentStep,
                                    totalSteps: totalSteps,
                                    stepLabel: stepLabel,
                                    footer: footer,
                                    child: child,
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            _AuthHero(title: title, subtitle: subtitle),
                            const SizedBox(height: AppSpacing.xl),
                            _AuthFormColumn(
                              currentStep: currentStep,
                              totalSteps: totalSteps,
                              stepLabel: stepLabel,
                              footer: footer,
                              child: child,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthFormColumn extends StatelessWidget {
  const _AuthFormColumn({
    required this.child,
    required this.footer,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabel,
  });

  final Widget child;
  final Widget? footer;
  final int? currentStep;
  final int? totalSteps;
  final String? stepLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AuthSurface(
          progress: currentStep != null && totalSteps != null
              ? _AuthProgress(
                  currentStep: currentStep!,
                  totalSteps: totalSteps!,
                  label: stepLabel,
                )
              : null,
          child: child,
        ),
        if (footer != null) ...[
          const SizedBox(height: AppSpacing.md),
          footer!,
        ],
      ],
    );
  }
}

class AuthFooterAction extends StatelessWidget {
  const AuthFooterAction({
    required this.prompt,
    required this.actionLabel,
    required this.onPressed,
    super.key,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.xs,
      children: [
        Text(prompt, style: const TextStyle(color: AppColors.fg3)),
        TextButton(onPressed: onPressed, child: Text(actionLabel)),
      ],
    );
  }
}

class AuthResponsivePair extends StatelessWidget {
  const AuthResponsivePair({
    required this.first,
    required this.second,
    super.key,
  });

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 430) {
          return Column(
            children: [
              first,
              const SizedBox(height: AppSpacing.lg),
              second,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: first),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: second),
          ],
        );
      },
    );
  }
}

class AuthSectionLabel extends StatelessWidget {
  const AuthSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.fg2,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}

class _AuthBrand extends StatelessWidget {
  const _AuthBrand();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'assets/icon/banner_logo_xenoh.png',
        height: 42,
        width: 154,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}

class _AuthHero extends StatelessWidget {
  const _AuthHero({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -18,
          top: -24,
          child: Opacity(
            opacity: 0.055,
            child: Image.asset(
              'assets/icon/logo_xenoh_transparent.png',
              width: 164,
              height: 164,
              filterQuality: FilterQuality.medium,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.sage500,
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: AppTypography.display(
                42,
                height: 1.02,
                weight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 410),
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.fg2,
                  fontSize: 15,
                  height: 1.55,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AuthSurface extends StatelessWidget {
  const _AuthSurface({required this.child, this.progress});

  final Widget child;
  final Widget? progress;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.bg2.withValues(alpha: 0.97),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xxl),
          topRight: Radius.circular(AppRadius.lg),
          bottomLeft: Radius.circular(AppRadius.lg),
          bottomRight: Radius.circular(AppRadius.xxl),
        ),
        border: Border.all(
          color: AppColors.surfaceBorderSoft.withValues(alpha: 0.9),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDeep.withValues(alpha: 0.14),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (progress != null) ...[
              progress!,
              const SizedBox(height: AppSpacing.xl),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

class _AuthProgress extends StatelessWidget {
  const _AuthProgress({
    required this.currentStep,
    required this.totalSteps,
    required this.label,
  });

  final int currentStep;
  final int totalSteps;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(totalSteps, (index) {
              final active = index < currentStep;
              return Expanded(
                child: AnimatedContainer(
                  duration: AppMotion.med,
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index == totalSteps - 1 ? 0 : AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: active ? AppColors.accent : AppColors.bg3,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                ),
              );
            }),
          ),
        ),
        if (label != null) ...[
          const SizedBox(width: AppSpacing.md),
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ],
    );
  }
}

class _AuthBackdrop extends CustomPainter {
  const _AuthBackdrop();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(AppColors.bgPage, BlendMode.src);

    final upperGlowBounds = Rect.fromCircle(
      center: Offset(size.width * 0.9, size.height * 0.04),
      radius: size.width * 0.62,
    );
    final upperGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.clay200.withValues(alpha: 0.42),
          AppColors.clay100.withValues(alpha: 0),
        ],
      ).createShader(upperGlowBounds);
    canvas.drawCircle(
      upperGlowBounds.center,
      upperGlowBounds.width / 2,
      upperGlow,
    );

    final lowerGlowBounds = Rect.fromCircle(
      center: Offset(-size.width * 0.05, size.height * 0.94),
      radius: size.width * 0.58,
    );
    final lowerGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.sage100.withValues(alpha: 0.58),
          AppColors.sage100.withValues(alpha: 0),
        ],
      ).createShader(lowerGlowBounds);
    canvas.drawCircle(
      lowerGlowBounds.center,
      lowerGlowBounds.width / 2,
      lowerGlow,
    );

    final ringPaint = Paint()
      ..color = AppColors.border1.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var radius = 72.0; radius <= 224; radius += 38) {
      canvas.drawCircle(
        Offset(size.width, size.height * 0.76),
        radius,
        ringPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
