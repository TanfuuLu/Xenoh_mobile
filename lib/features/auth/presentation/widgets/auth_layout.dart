import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';

enum AuthLayoutVariant { standard, featured }

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.title,
    required this.subtitle,
    required this.child,
    this.footer,
    this.currentStep,
    this.totalSteps,
    this.stepLabel,
    this.variant = AuthLayoutVariant.standard,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;
  final int? currentStep;
  final int? totalSteps;
  final String? stepLabel;
  final AuthLayoutVariant variant;

  static const headerKey = ValueKey('auth-layout-header');
  static const formKey = ValueKey('auth-layout-form');
  static const formSurfaceKey = ValueKey('auth-layout-form-surface');
  static const wideKey = ValueKey('auth-layout-wide');
  static const featuredKey = ValueKey('auth-layout-featured');

  @override
  Widget build(BuildContext context) {
    if (variant == AuthLayoutVariant.featured) {
      return _FeaturedAuthLayout(
        title: title,
        subtitle: subtitle,
        footer: footer,
        child: child,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 840;
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                wide ? AppSpacing.xxl : AppSpacing.lg,
                AppSpacing.lg,
                wide ? AppSpacing.xxl : AppSpacing.lg,
                AppSpacing.xxl,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 960),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _AuthBrand(),
                      SizedBox(height: wide ? AppSpacing.xxxl : AppSpacing.xl),
                      if (wide)
                        Row(
                          key: wideKey,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: _AuthHero(
                                key: headerKey,
                                title: title,
                                subtitle: subtitle,
                              ),
                            ),
                            const SizedBox(width: 46),
                            Expanded(
                              flex: 5,
                              child: _AuthFormColumn(
                                key: formKey,
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
                        _AuthHero(
                          key: headerKey,
                          title: title,
                          subtitle: subtitle,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _AuthFormColumn(
                          key: formKey,
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
    );
  }
}

class _FeaturedAuthLayout extends StatelessWidget {
  const _FeaturedAuthLayout({
    required this.title,
    required this.subtitle,
    required this.child,
    required this.footer,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 840;
            final panel = _FeaturedAuthHero(
              key: AuthLayout.headerKey,
              title: title,
              subtitle: subtitle,
              wide: wide,
            );
            final form = _AuthFormColumn(
              key: AuthLayout.formKey,
              currentStep: null,
              totalSteps: null,
              stepLabel: null,
              footer: footer,
              elevated: true,
              child: child,
            );

            return SingleChildScrollView(
              key: AuthLayout.featuredKey,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(wide ? AppSpacing.xl : AppSpacing.md),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: wide
                      ? SizedBox(
                          height: (constraints.maxHeight - 40).clamp(
                            620.0,
                            760.0,
                          ),
                          child: Row(
                            key: AuthLayout.wideKey,
                            children: [
                              Expanded(flex: 6, child: panel),
                              const SizedBox(width: AppSpacing.xxl),
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: form,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            panel,
                            const SizedBox(height: AppSpacing.xl),
                            form,
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FeaturedAuthHero extends StatelessWidget {
  const _FeaturedAuthHero({
    required this.title,
    required this.subtitle,
    required this.wide,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        wide ? AppSpacing.xxxl : AppSpacing.md,
        wide ? AppSpacing.xxxl : AppSpacing.lg,
        wide ? AppSpacing.xxxl : AppSpacing.md,
        wide ? AppSpacing.xxxl : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AuthBrand(),
          if (wide) const Spacer() else const SizedBox(height: AppSpacing.xxxl),
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.buttonPrimary,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _AuthHero(title: title, subtitle: subtitle, featured: true),
          if (wide) ...[
            const SizedBox(height: AppSpacing.xxxl),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.buttonBorder.withValues(alpha: 0.72),
              ),
            ),
          ],
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
    this.elevated = false,
    super.key,
  });

  final Widget child;
  final Widget? footer;
  final int? currentStep;
  final int? totalSteps;
  final String? stepLabel;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AuthSurface(
          elevated: elevated,
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
        semanticLabel: 'Xenoh',
        height: 37,
        width: 136,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}

class _AuthHero extends StatelessWidget {
  const _AuthHero({
    required this.title,
    required this.subtitle,
    this.featured = false,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.display(
            featured ? 42 : 36,
            height: featured ? 0.98 : 1.04,
            weight: FontWeight.w700,
            letterSpacing: featured ? -1.1 : -0.7,
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
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _AuthSurface extends StatelessWidget {
  const _AuthSurface({
    required this.child,
    required this.elevated,
    this.progress,
  });

  final Widget child;
  final Widget? progress;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: AuthLayout.formSurfaceKey,
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(
          elevated ? AppRadius.xxl : AppRadius.lg,
        ),
        border: Border.all(color: AppColors.surfaceBorderSoft),
        boxShadow: elevated
            ? const [
                BoxShadow(
                  color: AppColors.shadowDeep,
                  blurRadius: 28,
                  offset: Offset(0, 14),
                ),
              ]
            : null,
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
