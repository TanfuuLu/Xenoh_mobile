import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_typography.dart';
import 'xn_animated_number.dart';
import 'xn_card.dart';

/// Metric tile with a quiet label and prominent tabular value.
class XnStat extends StatelessWidget {
  const XnStat({
    required this.label,
    required this.value,
    this.unit,
    this.mono = false,
    this.onTap,
    this.trailing,
    super.key,
  });

  final String label;
  final String value;
  final String? unit;

  /// Render the value in JetBrains Mono (for raw numbers); otherwise Fraunces.
  final bool mono;

  /// Makes the tile tappable (e.g. to log a new value).
  final VoidCallback? onTap;

  /// Optional adornment shown at the top-right (e.g. an "add" affordance).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final numericValue = _parseNumericValue(value);
    final valueStyle = mono
        ? AppTypography.mono(24, weight: FontWeight.w600)
        : AppTypography.display(
            25,
            weight: FontWeight.w600,
            letterSpacing: -0.2,
          );

    return XnCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: numericValue == null
                    ? Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: valueStyle,
                      )
                    : XnAnimatedNumber(
                        value: numericValue,
                        formatter: _formatLike(value),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: valueStyle,
                      ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Text(
                  unit!,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

double? _parseNumericValue(String value) {
  final normalized = value.replaceAll(',', '').trim();
  return double.tryParse(normalized);
}

XnNumberFormatter _formatLike(String source) {
  final hasCommas = source.contains(',');
  final decimals = source.contains('.') ? source.split('.').last.length : 0;
  if (hasCommas && decimals == 0) return formatAnimatedThousands;
  return (value) => decimals == 0
      ? value.round().toString()
      : value.toStringAsFixed(decimals);
}
