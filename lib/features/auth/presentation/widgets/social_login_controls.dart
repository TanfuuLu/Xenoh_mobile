import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: SizedBox(
            height: 1,
            child: ColoredBox(color: AppColors.border1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.fg4,
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(
            height: 1,
            child: ColoredBox(color: AppColors.border1),
          ),
        ),
      ],
    );
  }
}

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    required this.label,
    required this.mark,
    required this.loading,
    required this.onPressed,
    super.key,
  });

  final String label;

  /// The provider's brand mark, drawn in its own official colors
  /// ([GoogleMark] / [FacebookMark]).
  final Widget mark;
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: OutlinedButton(
        onPressed: loading ? null : onPressed,
        child: AnimatedSwitcher(
          duration: AppMotion.fast,
          child: loading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mark,
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(child: Text(label)),
                  ],
                ),
        ),
      ),
    );
  }
}

/// Google's four-color "G", drawn on a white disc so the brand colors keep
/// their contrast on the app's clay-toned buttons.
class GoogleMark extends StatelessWidget {
  const GoogleMark({this.size = 22, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border1),
      ),
      child: Center(
        child: CustomPaint(
          size: Size.square(size * 0.66),
          painter: const _GoogleGPainter(),
        ),
      ),
    );
  }
}

class _GoogleGPainter extends CustomPainter {
  const _GoogleGPainter();

  // Official Google brand palette.
  static const _blue = Color(0xFF4285F4);
  static const _green = Color(0xFF34A853);
  static const _yellow = Color(0xFFFBBC05);
  static const _red = Color(0xFFEA4335);

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height);
    final stroke = side * 0.24;
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: (side - stroke) / 2,
    );
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    void sweep(Color color, double startDeg, double endDeg) {
      canvas.drawArc(
        rect,
        startDeg * math.pi / 180,
        (endDeg - startDeg) * math.pi / 180,
        false,
        arc..color = color,
      );
    }

    // 0 degrees is 3 o'clock, sweeping clockwise. The gap between the red
    // terminal and the blue crossbar is the notch on the right of the mark.
    sweep(_blue, 0, 38);
    sweep(_green, 38, 128);
    sweep(_yellow, 128, 198);
    sweep(_red, 198, 338);

    // The crossbar running from the center out to the right edge.
    canvas.drawRect(
      Rect.fromLTRB(
        size.width / 2 - stroke * 0.15,
        size.height / 2 - stroke / 2,
        rect.right + stroke / 2,
        size.height / 2 + stroke / 2,
      ),
      Paint()..color = _blue,
    );
  }

  @override
  bool shouldRepaint(_GoogleGPainter oldDelegate) => false;
}

/// Facebook's white "f" on the brand blue disc. The glyph is drawn as a path
/// (rather than typeset) so it keeps the brand's exact shape regardless of the
/// app's font.
class FacebookMark extends StatelessWidget {
  const FacebookMark({this.size = 22, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: const _FacebookFPainter(),
    );
  }
}

class _FacebookFPainter extends CustomPainter {
  const _FacebookFPainter();

  static const _brandBlue = Color(0xFF1877F2);

  /// The brand mark is authored on a 512x512 canvas.
  static const _designSize = 512.0;

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      side / 2,
      Paint()..color = _brandBlue,
    );

    final f = Path()
      ..moveTo(301.6, 512)
      ..lineTo(301.6, 295)
      ..lineTo(374.5, 295)
      ..lineTo(385.4, 210.4)
      ..lineTo(301.6, 210.4)
      ..lineTo(301.6, 156.4)
      ..cubicTo(301.6, 131.9, 308.4, 115.2, 343.5, 115.2)
      ..lineTo(388.3, 115.2)
      ..lineTo(388.3, 39.5)
      ..cubicTo(380.6, 38.5, 354, 36.2, 323, 36.2)
      ..cubicTo(258.4, 36.2, 214.2, 75.6, 214.2, 148.1)
      ..lineTo(214.2, 210.4)
      ..lineTo(141.2, 210.4)
      ..lineTo(141.2, 295)
      ..lineTo(214.2, 295)
      ..lineTo(214.2, 512)
      ..close();

    canvas
      ..save()
      ..translate(
        (size.width - side) / 2,
        (size.height - side) / 2,
      )
      ..scale(side / _designSize)
      ..drawPath(f, Paint()..color = Colors.white)
      ..restore();
  }

  @override
  bool shouldRepaint(_FacebookFPainter oldDelegate) => false;
}
