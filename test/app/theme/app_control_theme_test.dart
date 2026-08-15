import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_colors.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';

void main() {
  test('date and range pickers use Xenoh surfaces and selection colors', () {
    final theme = AppTheme.light().datePickerTheme;
    const selected = <WidgetState>{WidgetState.selected};

    expect(theme.backgroundColor, AppColors.bg2);
    expect(theme.surfaceTintColor, Colors.transparent);
    expect(theme.headerBackgroundColor, AppColors.accentSoft);
    expect(theme.headerForegroundColor, AppColors.clay900);
    expect(theme.dayBackgroundColor!.resolve(selected), AppColors.accent);
    expect(theme.dayForegroundColor!.resolve(selected), AppColors.fgOnClay);
    expect(theme.todayBorder, const BorderSide(color: AppColors.accent));
    expect(theme.rangePickerBackgroundColor, AppColors.bgPage);
    expect(theme.rangeSelectionBackgroundColor, AppColors.accentSoft);
  });

  test('time picker uses the same warm option-selection language', () {
    final theme = AppTheme.light().timePickerTheme;
    const selected = <WidgetState>{WidgetState.selected};

    expect(theme.backgroundColor, AppColors.bg2);
    expect(
      WidgetStateProperty.resolveAs(theme.hourMinuteColor!, selected),
      AppColors.accentSoft,
    );
    expect(
      WidgetStateProperty.resolveAs(theme.hourMinuteTextColor!, selected),
      AppColors.accentPress,
    );
    expect(
      WidgetStateProperty.resolveAs(theme.dayPeriodColor!, selected),
      AppColors.accentSoft,
    );
    expect(theme.dialBackgroundColor, AppColors.bg3);
    expect(theme.dialHandColor, AppColors.accent);
    expect(theme.entryModeIconColor, AppColors.fg2);
  });

  test('chips show selection by background without a checkmark', () {
    final theme = AppTheme.light().chipTheme;
    const selected = <WidgetState>{WidgetState.selected};
    const disabled = <WidgetState>{WidgetState.disabled};

    expect(theme.backgroundColor, AppColors.bg2);
    expect(theme.selectedColor, AppColors.clay200);
    expect(theme.disabledColor, AppColors.bg3);
    expect(theme.showCheckmark, isFalse);
    expect(
      WidgetStateProperty.resolveAs(theme.labelStyle!.color!, selected),
      AppColors.accentPress,
    );
    expect(
      WidgetStateProperty.resolveAs(theme.labelStyle!.color!, {}),
      AppColors.fg2,
    );
    expect(
      WidgetStateProperty.resolveAs(theme.labelStyle!.color!, disabled),
      AppColors.fg4,
    );
  });

  test('segmented choices use background selection without a check icon', () {
    final theme = AppTheme.light().segmentedButtonTheme;
    const selected = <WidgetState>{WidgetState.selected};

    expect(theme.selectedIcon, isA<SizedBox>());
    expect(
      theme.style!.backgroundColor!.resolve(selected),
      AppColors.segmentedButtonSelectedBg,
    );
  });
}
