import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';

/// A visually distinct header band for sections on the client detail screen.
class ClientDetailSectionHeader extends StatelessWidget {
  const ClientDetailSectionHeader({
    required this.title,
    required this.icon,
    required this.accent,
    super.key,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final Color accent;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: accent.withValues(alpha: 0.32)),
              ),
              child: Icon(icon, size: 17, color: accent),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.15,
                ),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Flexible(child: trailing!),
            ],
          ],
        ),
      ),
    );
  }
}
