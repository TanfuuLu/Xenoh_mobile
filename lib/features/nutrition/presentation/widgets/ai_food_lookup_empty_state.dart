import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class AiFoodLookupEmptyState extends StatelessWidget {
  const AiFoodLookupEmptyState({
    required this.query,
    required this.loading,
    required this.onLookup,
    super.key,
  });

  final String query;
  final bool loading;
  final VoidCallback onLookup;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final trimmed = query.trim();

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.bg2,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.surfaceBorderSoft),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.nutritionNoResultsForQuery(trimmed),
              style: const TextStyle(color: AppColors.fg1, fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextButton.icon(
              onPressed: loading ? null : onLookup,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accent,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: AppTypography.mono(13, color: AppColors.accent),
              ),
              icon: loading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_awesome_rounded, size: 17),
              label: Text('${l10n.nutritionAiLookupCta} ->'),
            ),
          ],
        ),
      ),
    );
  }
}
