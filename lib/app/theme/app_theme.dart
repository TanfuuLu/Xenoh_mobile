import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_typography.dart';

/// The single light theme for Xenoh (warm earthy light mode only).
abstract final class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: AppColors.accent,
      primaryContainer: AppColors.accentSoft,
      onPrimaryContainer: AppColors.clay900,
      secondary: AppColors.accent2,
      onSecondary: AppColors.fgOnClay,
      secondaryContainer: AppColors.accent2Soft,
      onSecondaryContainer: AppColors.sage700,
      surface: AppColors.bg2,
      onSurface: AppColors.fg1,
      surfaceContainerHighest: AppColors.bg3,
      onSurfaceVariant: AppColors.fg2,
      outline: AppColors.border1,
      outlineVariant: AppColors.surfaceBorderSoft,
      error: AppColors.danger,
      errorContainer: AppColors.dangerBg,
    );

    final textTheme = AppTypography.textTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
      canvasColor: AppColors.bg2,
      visualDensity: const VisualDensity(horizontal: -1.5, vertical: -1.5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      focusColor: AppColors.accentSoft.withValues(alpha: 0.72),
      hoverColor: AppColors.buttonHover.withValues(alpha: 0.72),
      highlightColor: AppColors.accentSoft.withValues(alpha: 0.42),
      fontFamily: AppTypography.fontFamily,
      textTheme: textTheme,
      iconTheme: const IconThemeData(color: AppColors.fg2, size: 21),
      primaryIconTheme: const IconThemeData(
        color: AppColors.fgOnClay,
        size: 21,
      ),
      splashFactory: InkSparkle.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgPage,
        foregroundColor: AppColors.fg1,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 55,
        centerTitle: false,
        titleSpacing: AppSpacing.xl,
        titleTextStyle: AppTypography.display(
          25,
          weight: FontWeight.w600,
          letterSpacing: -0.2,
          height: 1.15,
        ),
        iconTheme: const IconThemeData(color: AppColors.fg2, size: 21),
      ),
      cardTheme: CardThemeData(
        color: AppColors.bg2,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.fgOnClay,
          disabledBackgroundColor: AppColors.fg4,
          minimumSize: const Size(56, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.buttonPrimary,
        foregroundColor: AppColors.fgOnClay,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.buttonText,
          backgroundColor: AppColors.buttonBg,
          side: const BorderSide(color: AppColors.buttonBorder, width: 1.2),
          minimumSize: const Size(56, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.buttonPrimary,
          minimumSize: const Size(40, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bg2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        hintStyle: const TextStyle(
          color: AppColors.fg4,
          fontFamily: AppTypography.fontFamily,
        ),
        labelStyle: const TextStyle(
          color: AppColors.fg2,
          fontFamily: AppTypography.fontFamily,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.accent,
          fontFamily: AppTypography.fontFamily,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: _border(AppColors.surfaceBorderSoft),
        focusedBorder: _border(AppColors.accent, width: 2),
        errorBorder: _border(AppColors.danger),
        focusedErrorBorder: _border(AppColors.danger, width: 2),
        border: _border(AppColors.border1),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.surfaceBorderSoft,
        space: AppSpacing.xs,
        thickness: 1,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.fg2,
          iconSize: 21,
          minimumSize: const Size(40, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.bg2,
        surfaceTintColor: Colors.transparent,
        elevation: 18,
        shadowColor: AppColors.shadowDeep,
        insetPadding: const EdgeInsets.all(AppSpacing.xl),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          side: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
        titleTextStyle: AppTypography.display(
          24,
          weight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        contentTextStyle: const TextStyle(
          color: AppColors.fg2,
          fontFamily: AppTypography.fontFamily,
          fontSize: 14,
          height: 1.45,
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.bg2,
        surfaceTintColor: Colors.transparent,
        elevation: 18,
        shadowColor: AppColors.shadowDeep,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          side: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
        headerBackgroundColor: AppColors.accentSoft,
        headerForegroundColor: AppColors.clay900,
        headerHeadlineStyle: AppTypography.display(
          28,
          weight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        headerHelpStyle: const TextStyle(
          color: AppColors.clay800,
          fontFamily: AppTypography.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
        weekdayStyle: const TextStyle(
          color: AppColors.fg3,
          fontFamily: AppTypography.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        dayStyle: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return AppColors.fg4;
          if (states.contains(WidgetState.selected)) {
            return AppColors.fgOnClay;
          }
          return AppColors.fg1;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.accent;
          return Colors.transparent;
        }),
        dayOverlayColor: WidgetStatePropertyAll(
          AppColors.accentSoft.withValues(alpha: 0.72),
        ),
        dayShape: const WidgetStatePropertyAll(CircleBorder()),
        todayForegroundColor: const WidgetStatePropertyAll(AppColors.accent),
        todayBackgroundColor: const WidgetStatePropertyAll(
          Colors.transparent,
        ),
        todayBorder: const BorderSide(color: AppColors.accent),
        yearStyle: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        yearForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return AppColors.fg4;
          if (states.contains(WidgetState.selected)) {
            return AppColors.fgOnClay;
          }
          return AppColors.fg1;
        }),
        yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.accent;
          return Colors.transparent;
        }),
        yearOverlayColor: WidgetStatePropertyAll(
          AppColors.accentSoft.withValues(alpha: 0.72),
        ),
        rangePickerBackgroundColor: AppColors.bgPage,
        rangePickerSurfaceTintColor: Colors.transparent,
        rangePickerShadowColor: AppColors.shadowDeep,
        rangePickerHeaderBackgroundColor: AppColors.accentSoft,
        rangePickerHeaderForegroundColor: AppColors.clay900,
        rangeSelectionBackgroundColor: AppColors.accentSoft,
        rangeSelectionOverlayColor: WidgetStatePropertyAll(
          AppColors.accentSoft.withValues(alpha: 0.72),
        ),
        dividerColor: AppColors.surfaceBorderSoft,
        cancelButtonStyle: _pickerActionStyle(),
        confirmButtonStyle: _pickerActionStyle(),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.bg2,
        elevation: 18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          side: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
        helpTextStyle: const TextStyle(
          color: AppColors.fg3,
          fontFamily: AppTypography.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
        hourMinuteColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.accentSoft
              : AppColors.bg3,
        ),
        hourMinuteTextColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.accentPress
              : AppColors.fg1,
        ),
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
        dayPeriodColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.accentSoft
              : AppColors.bg2,
        ),
        dayPeriodTextColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.accentPress
              : AppColors.fg2,
        ),
        dayPeriodBorderSide: const BorderSide(color: AppColors.buttonBorder),
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        dialBackgroundColor: AppColors.bg3,
        dialHandColor: AppColors.accent,
        dialTextColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.fgOnClay
              : AppColors.fg1,
        ),
        entryModeIconColor: AppColors.fg2,
        cancelButtonStyle: _pickerActionStyle(),
        confirmButtonStyle: _pickerActionStyle(),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bg2,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: AppColors.bg2,
        modalBarrierColor: Color(0x8A251A13),
        showDragHandle: true,
        dragHandleColor: AppColors.border1,
        dragHandleSize: Size(37, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.fg2,
        textColor: AppColors.fg1,
        contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        minTileHeight: 42,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.accent,
        selectionColor: AppColors.clay200,
        selectionHandleColor: AppColors.accent,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.bg2,
        selectedColor: AppColors.clay200,
        disabledColor: AppColors.bg3,
        showCheckmark: false,
        labelStyle: TextStyle(
          color: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return AppColors.fg4;
            if (states.contains(WidgetState.selected)) {
              return AppColors.accentPress;
            }
            return AppColors.fg2;
          }),
          fontFamily: AppTypography.fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(
          color: AppColors.accentPress,
          fontFamily: AppTypography.fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
        ),
        side: const BorderSide(color: AppColors.surfaceBorderSoft),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        pressElevation: 0,
      ),
      checkboxTheme: CheckboxThemeData(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        side: const BorderSide(color: AppColors.border2, width: 1.4),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent;
          }
          if (states.contains(WidgetState.disabled)) {
            return AppColors.bg3.withValues(alpha: 0.46);
          }
          return AppColors.bg2;
        }),
        checkColor: const WidgetStatePropertyAll(AppColors.fgOnClay),
        overlayColor: WidgetStatePropertyAll(
          AppColors.accentSoft.withValues(alpha: 0.54),
        ),
      ),
      radioTheme: RadioThemeData(
        visualDensity: VisualDensity.compact,
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent;
          }
          if (states.contains(WidgetState.disabled)) return AppColors.fg4;
          return AppColors.border2;
        }),
        overlayColor: WidgetStatePropertyAll(
          AppColors.accentSoft.withValues(alpha: 0.54),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.fgOnClay;
          }
          return AppColors.fg3;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent;
          }
          return AppColors.bg3;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accent;
          }
          return AppColors.surfaceBorderSoft;
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        selectedIcon: const SizedBox.shrink(),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.segmentedButtonSelectedBg;
            }
            return AppColors.segmentedButtonBg;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.clay900;
            }
            return AppColors.fg2;
          }),
          overlayColor: WidgetStatePropertyAll(
            AppColors.accentSoft.withValues(alpha: 0.48),
          ),
          side: const WidgetStatePropertyAll(
            BorderSide(color: AppColors.segmentedButtonBorder, width: 1.2),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(
          color: AppColors.fg1,
          fontFamily: AppTypography.fontFamily,
          fontWeight: FontWeight.w500,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: AppColors.bg2,
        ),
        menuStyle: _menuStyle(),
      ),
      menuTheme: MenuThemeData(style: _menuStyle()),
      navigationBarTheme: NavigationBarThemeData(
        height: 56,
        backgroundColor: AppColors.bg2,
        indicatorColor: AppColors.navigationSelectedBackground,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            color: states.contains(WidgetState.selected)
                ? AppColors.navigationSelectedForeground
                : AppColors.fg3,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.navigationSelectedForeground
                : AppColors.fg3,
            size: 20,
          ),
        ),
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AppColors.bg2,
        indicatorColor: AppColors.navigationSelectedBackground,
        minWidth: 64,
        minExtendedWidth: 225,
        selectedIconTheme: IconThemeData(
          color: AppColors.navigationSelectedForeground,
          size: 20,
        ),
        unselectedIconTheme: IconThemeData(color: AppColors.fg3, size: 20),
        selectedLabelTextStyle: TextStyle(
          color: AppColors.navigationSelectedForeground,
          fontFamily: AppTypography.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: AppColors.fg3,
          fontFamily: AppTypography.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.bg2,
        actionTextColor: AppColors.accent,
        disabledActionTextColor: AppColors.fg4,
        contentTextStyle: const TextStyle(
          color: AppColors.fg1,
          fontFamily: AppTypography.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),
        elevation: 12,
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
        linearTrackColor: AppColors.bg3,
        circularTrackColor: AppColors.bg3,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.bg2,
        surfaceTintColor: Colors.transparent,
        elevation: 10,
        shadowColor: AppColors.shadowDeep,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          side: const BorderSide(color: AppColors.surfaceBorderSoft),
        ),
        textStyle: const TextStyle(
          color: AppColors.fg1,
          fontFamily: AppTypography.fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static OutlineInputBorder _border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(color: color, width: width),
      );

  static ButtonStyle _pickerActionStyle() => TextButton.styleFrom(
    foregroundColor: AppColors.accentPress,
    minimumSize: const Size(44, 40),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    textStyle: const TextStyle(
      fontFamily: AppTypography.fontFamily,
      fontWeight: FontWeight.w600,
    ),
  );

  static MenuStyle _menuStyle() => MenuStyle(
    backgroundColor: const WidgetStatePropertyAll(AppColors.bg2),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    shadowColor: const WidgetStatePropertyAll(AppColors.shadowDeep),
    elevation: const WidgetStatePropertyAll(10),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: AppSpacing.xs),
    ),
    side: const WidgetStatePropertyAll(
      BorderSide(color: AppColors.surfaceBorderSoft),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
    ),
  );
}
