import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

/// Renders [items] as a simple dot-bulleted list — used to make long AI
/// response paragraphs easier to scan than a single text block.
class BulletList extends StatelessWidget {
  const BulletList({
    required this.items,
    this.color = AppColors.fg2,
    this.dotColor = AppColors.accent,
    super.key,
  });

  final List<String> items;
  final Color color;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                    height: 1.42,
                  ),
                ),
              ),
            ],
          ),
          if (item != items.last) const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}
