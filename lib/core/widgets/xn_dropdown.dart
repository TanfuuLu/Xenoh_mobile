import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

class XnDropdownOption<T> {
  const XnDropdownOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final T value;
  final String label;
  final bool enabled;
}

/// App-styled dropdown for form choices.
///
/// Keeps native Material form behavior while giving every menu the same
/// branded option rows, selected marker, radius, and constrained height.
class XnDropdown<T> extends StatelessWidget {
  const XnDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.hint,
    this.validator,
    this.enabled = true,
    this.isExpanded = true,
    super.key,
  });

  final String label;
  final T? value;
  final List<XnDropdownOption<T>> options;
  final ValueChanged<T?>? onChanged;

  /// Falls back to the localized "Select" placeholder when omitted.
  final String? hint;
  final String? Function(T?)? validator;
  final bool enabled;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final effectiveValue = options.any((option) => option.value == value)
        ? value
        : null;
    final effectiveOnChanged = enabled ? onChanged : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.fg2,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<T>(
          initialValue: effectiveValue,
          isExpanded: isExpanded,
          validator: validator,
          dropdownColor: AppColors.bg2,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          menuMaxHeight: 356,
          elevation: 12,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.fg3,
          ),
          style: const TextStyle(
            color: AppColors.fg1,
            fontFamily: AppTypography.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint ?? AppLocalizations.of(context).commonSelect,
          ),
          selectedItemBuilder: (_) => [
            for (final option in options)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  option.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: option.enabled ? AppColors.fg1 : AppColors.fg4,
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
          items: [
            for (final option in options)
              DropdownMenuItem<T>(
                value: option.value,
                enabled: option.enabled,
                child: _OptionRow(
                  label: option.label,
                  selected: option.value == effectiveValue,
                  enabled: option.enabled,
                ),
              ),
          ],
          onChanged: effectiveOnChanged,
        ),
      ],
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.label,
    required this.selected,
    required this.enabled,
  });

  final String label;
  final bool selected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.fast,
      curve: Curves.easeOutCubic,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: selected ? AppColors.accentSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: AppMotion.fast,
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: selected ? AppColors.accent : AppColors.bg3,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(
                color: selected
                    ? AppColors.accent
                    : AppColors.surfaceBorderSoft,
              ),
            ),
            child: selected
                ? const Icon(
                    Icons.check_rounded,
                    size: 15,
                    color: AppColors.fgOnClay,
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: enabled ? AppColors.fg1 : AppColors.fg4,
                fontFamily: AppTypography.fontFamily,
                fontSize: 15,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
