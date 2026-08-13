import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

enum XnChipTone { accent, sage, warn, danger, info, neutral }

/// Pill badge (mirrors the web `.xn-chip`).
class XnChip extends StatelessWidget {
  const XnChip({
    required this.label,
    this.tone = XnChipTone.accent,
    this.icon,
    this.compact = false,
    super.key,
  });

  final String label;
  final XnChipTone tone;
  final IconData? icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      XnChipTone.accent => (AppColors.accentSoft, AppColors.clay900),
      XnChipTone.sage => (AppColors.accent2Soft, AppColors.sage700),
      XnChipTone.warn => (AppColors.warningBg, AppColors.warning),
      XnChipTone.danger => (AppColors.dangerBg, AppColors.danger),
      XnChipTone.info => (AppColors.infoBg, AppColors.info),
      XnChipTone.neutral => (AppColors.bg3, AppColors.fg2),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.sm : AppSpacing.md,
        vertical: compact ? 3.5 : 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.sm : AppRadius.md,
        ),
        border: Border.all(color: fg.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: compact ? 11 : 12, color: fg),
            SizedBox(width: compact ? 3.5 : 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: compact ? 11 : 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
