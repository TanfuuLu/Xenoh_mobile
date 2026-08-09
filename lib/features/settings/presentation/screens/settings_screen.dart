import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

String normalizeThemePreference(String? value) =>
    value?.toLowerCase() == 'dark' ? 'dark' : 'light';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _language;
  String? _weightUnit;
  var _saving = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final prefs = ref.watch(preferencesProvider);
    return FeatureScreenFrame(
      title: l10n.settingsTitle,
      onRefresh: () => ref.refresh(preferencesProvider.future),
      children: [
        _SettingsHero(
          title: l10n.settingsTitle,
          subtitle: l10n.settingsSubtitle,
        ),
        const SizedBox(height: AppSpacing.md),
        XnSectionGroup(
          children: [
            XnSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XnSectionEyebrow(l10n.profilePreferencesTitle),
                  const SizedBox(height: AppSpacing.sm),
                  switch (prefs) {
                    AsyncData(:final value) => _preferenceFields(
                      context,
                      value,
                    ),
                    AsyncError(:final error) => FeatureError(
                      error: error,
                      onRetry: () => ref.invalidate(preferencesProvider),
                    ),
                    _ => const LoadingList(),
                  },
                ],
              ),
            ),
            const XnSectionDivider(),
            XnSection(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XnSectionEyebrow(l10n.profileAccountTitle),
                  const SizedBox(height: AppSpacing.sm),
                  _SettingsRow(
                    icon: Icons.person_outline_rounded,
                    label: l10n.profileAccountProfile,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _SettingsRow(
                    icon: Icons.lock_outline_rounded,
                    label: l10n.profileAccountChangePassword,
                    onTap: () => context.push('/change-password'),
                  ),
                  _SettingsRow(
                    icon: Icons.bug_report_outlined,
                    label: l10n.profileAccountReportBug,
                    onTap: () => context.push('/report-bug'),
                  ),
                  _SettingsRow(
                    icon: Icons.folder_outlined,
                    label: l10n.storageTitle,
                    onTap: () => context.push('/storage'),
                  ),
                  _SettingsRow(
                    icon: Icons.delete_forever_outlined,
                    label: l10n.accountDeletionSettingsLabel,
                    danger: true,
                    onTap: _confirmAccountDeletion,
                  ),
                ],
              ),
            ),
            const XnSectionDivider(),
            XnSection(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              child: _SettingsRow(
                icon: Icons.logout_rounded,
                label: l10n.profileAccountSignOut,
                danger: true,
                onTap: () => unawaited(
                  ref.read(authControllerProvider.notifier).logout(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _preferenceFields(BuildContext context, JsonMap value) {
    final l10n = AppLocalizations.of(context);
    final language = _language ?? textOf(value, ['language'], fallback: 'en');
    final theme = normalizeThemePreference(value['theme']?.toString());
    final weightUnit =
        _weightUnit ?? textOf(value, ['weightUnit'], fallback: 'kg');

    return Column(
      children: [
        _PreferenceSelectField(
          label: l10n.profilePreferencesLanguageLabel,
          value: language,
          enabled: !_saving,
          options: [
            _PreferenceOption(
              value: 'en',
              label: l10n.profilePreferencesLanguageEnglish,
              icon: Icons.language_rounded,
            ),
            _PreferenceOption(
              value: 'vi',
              label: l10n.profilePreferencesLanguageVietnamese,
              icon: Icons.translate_rounded,
            ),
          ],
          onChanged: (selected) {
            setState(() => _language = selected);
            unawaited(_save(selected, theme, weightUnit));
          },
        ),
        const _PreferenceDivider(),
        _PreferenceSelectField(
          label: l10n.profilePreferencesWeightUnitLabel,
          value: weightUnit,
          enabled: !_saving,
          options: [
            _PreferenceOption(
              value: 'kg',
              label: l10n.profilePreferencesWeightUnitKilograms,
              icon: Icons.monitor_weight_outlined,
            ),
            _PreferenceOption(
              value: 'lb',
              label: l10n.profilePreferencesWeightUnitPounds,
              icon: Icons.fitness_center_rounded,
            ),
          ],
          onChanged: (selected) {
            setState(() => _weightUnit = selected);
            unawaited(_save(language, theme, selected));
          },
        ),
      ],
    );
  }

  Future<void> _save(String language, String theme, String weightUnit) async {
    setState(() => _saving = true);
    try {
      await ref.read(xenohApiProvider).putObject('/users/me/preferences', {
        'language': language,
        'theme': theme,
        'weightUnit': weightUnit,
      });
      ref.read(appLocaleProvider.notifier).setLocale(language);
      ref.invalidate(preferencesProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).profilePreferencesSavedSnackbar,
          ),
        ),
      );
    } catch (error) {
      // Drop the optimistic overrides and refetch so the UI falls back to
      // the server's state instead of showing a value that never saved.
      _language = null;
      _weightUnit = null;
      ref.invalidate(preferencesProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmAccountDeletion() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.accountDeletionConfirmationTitle),
        content: Text(l10n.accountDeletionConfirmationMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.accountDeletionConfirmLabel),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final failure = await ref
        .read(authControllerProvider.notifier)
        .deleteAccount();
    if (!mounted || failure == null) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(apiErrorMessage(failure, context))));
  }
}

class _SettingsHero extends StatelessWidget {
  const _SettingsHero({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.surfaceBorderSoft),
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: AppColors.accent,
              size: 21,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.display(
                    24,
                    weight: FontWeight.w700,
                    color: AppColors.fg1,
                    letterSpacing: -0.25,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontSize: 13,
                    height: 1.34,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final fg = danger ? AppColors.danger : AppColors.fg1;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: danger ? AppColors.danger : AppColors.fg3,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: fg,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: danger ? AppColors.danger : AppColors.fg3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreferenceDivider extends StatelessWidget {
  const _PreferenceDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 58),
      child: Divider(
        height: AppSpacing.lg,
        thickness: 1,
        color: AppColors.surfaceBorderSoft.withValues(alpha: 0.7),
      ),
    );
  }
}

class _PreferenceOption {
  const _PreferenceOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}

class _PreferenceSelectField extends StatelessWidget {
  const _PreferenceSelectField({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.enabled,
  });

  final String label;
  final String value;
  final List<_PreferenceOption> options;
  final ValueChanged<String> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final selected = options.firstWhere(
      (option) => option.value == value,
      orElse: () => options.first,
    );

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: enabled ? () => _showOptions(context, selected) : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: AppMotion.fast,
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: enabled
                      ? AppColors.accentSoft
                      : AppColors.bg3.withValues(alpha: 0.48),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.surfaceBorderSoft),
                ),
                child: Icon(
                  selected.icon,
                  color: enabled ? AppColors.accent : AppColors.fg3,
                  size: 21,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 12,
                        height: 1.15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      selected.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontSize: 16,
                        height: 1.15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.fg3,
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showOptions(
    BuildContext context,
    _PreferenceOption selected,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.ink900.withValues(alpha: 0.26),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.bg2,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: AppColors.surfaceBorderSoft),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowDeep,
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.sm,
                    AppSpacing.xs,
                    AppSpacing.sm,
                    AppSpacing.md,
                  ),
                  child: Text(label, style: AppTypography.display(20)),
                ),
                for (final option in options)
                  _PreferenceOptionTile(
                    option: option,
                    selected: option.value == selected.value,
                    onTap: () {
                      Navigator.of(context).pop();
                      onChanged(option.value);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreferenceOptionTile extends StatelessWidget {
  const _PreferenceOptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _PreferenceOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: selected ? AppColors.accentSoft : AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                Icon(
                  option.icon,
                  color: selected ? AppColors.clay900 : AppColors.fg3,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    option.label,
                    style: TextStyle(
                      color: selected ? AppColors.clay900 : AppColors.fg1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: selected ? 1 : 0,
                  duration: AppMotion.fast,
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.clay900,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
