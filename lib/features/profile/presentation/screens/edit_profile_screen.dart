import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/profile_controller.dart';

const _genders = ['Male', 'Female'];
const _developmentDirections = [
  'Strength',
  'Hypertrophy',
  'FatLoss',
  'Recomposition',
  'Endurance',
  'GeneralHealth',
];
const _trainingDisciplines = [
  'Powerlifting',
  'Bodybuilding',
  'Weightlifting',
  'Calisthenics',
  'CrossFit',
  'Running',
  'GeneralFitness',
];

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({required this.profile, super.key});

  final UserProfile profile;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _firstName = TextEditingController(text: widget.profile.firstName);
  late final _lastName = TextEditingController(text: widget.profile.lastName);
  late final _bio = TextEditingController(text: widget.profile.bio ?? '');
  late final _height = TextEditingController(
    text: widget.profile.height == null
        ? ''
        : _trimZero(widget.profile.height!),
  );
  late final _facebook = TextEditingController(
    text: widget.profile.facebookUrl ?? '',
  );
  late final _instagram = TextEditingController(
    text: widget.profile.instagramUrl ?? '',
  );
  late final _zalo = TextEditingController(text: widget.profile.zaloUrl ?? '');

  late String? _gender = widget.profile.gender;
  late String? _developmentDirection = widget.profile.developmentDirection;
  late String? _trainingDiscipline = widget.profile.trainingDiscipline;
  late DateTime? _dateOfBirth = widget.profile.dateOfBirth;
  bool _submitting = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _bio.dispose();
    _height.dispose();
    _facebook.dispose();
    _instagram.dispose();
    _zalo.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  String? _nullIfBlank(String value) {
    final v = value.trim();
    return v.isEmpty ? null : v;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    final l10n = AppLocalizations.of(context);
    try {
      await ref
          .read(myProfileControllerProvider.notifier)
          .updateProfile(
            firstName: _firstName.text.trim(),
            lastName: _lastName.text.trim(),
            bio: _bio.text.trim(),
            height: double.tryParse(_height.text.trim()),
            gender: _gender,
            dateOfBirth: _dateOfBirth,
            developmentDirection: _developmentDirection,
            trainingDiscipline: _trainingDiscipline,
            facebookUrl: _nullIfBlank(_facebook.text),
            instagramUrl: _nullIfBlank(_instagram.text),
            zaloUrl: _nullIfBlank(_zalo.text),
          );
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.profileUpdatedSnackbar)));
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileEditTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            96,
          ),
          children: [
            XnSectionGroup(
              children: [
                XnSectionEyebrow(l10n.profileEditBasicsSection),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: XnInput(
                        label: l10n.authFirstNameLabel,
                        controller: _firstName,
                        textInputAction: TextInputAction.next,
                        validator: (value) => _required(value, l10n),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: XnInput(
                        label: l10n.authLastNameLabel,
                        controller: _lastName,
                        textInputAction: TextInputAction.next,
                        validator: (value) => _required(value, l10n),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                XnInput(
                  label: l10n.profileBioLabel,
                  controller: _bio,
                  hint: l10n.profileBioHint,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            XnSectionGroup(
              children: [
                XnSectionEyebrow(l10n.profileEditPhysicalSection),
                const SizedBox(height: AppSpacing.md),
                XnInput(
                  label: l10n.profileHeightLabel,
                  controller: _height,
                  hint: l10n.profileHeightHint,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                  ],
                  validator: (v) {
                    final t = v?.trim() ?? '';
                    if (t.isEmpty) return null;
                    final h = double.tryParse(t);
                    if (h == null) return l10n.commonEnterNumberError;
                    if (h < 50 || h > 300) return l10n.profileHeightRangeError;
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                _Dropdown(
                  label: l10n.authGenderLabel,
                  value: _gender,
                  options: _genders,
                  l10n: l10n,
                  onChanged: (v) => setState(() => _gender = v),
                ),
                const SizedBox(height: AppSpacing.lg),
                _DateField(
                  label: l10n.profileDateOfBirthLabel,
                  value: _dateOfBirth,
                  pickLabel: l10n.profilePickDateCta,
                  clearTooltip: l10n.profileClearDateTooltip,
                  onTap: _pickDob,
                  onClear: _dateOfBirth == null
                      ? null
                      : () => setState(() => _dateOfBirth = null),
                ),
                const SizedBox(height: AppSpacing.lg),
                _Dropdown(
                  label: l10n.authDevelopmentDirectionLabel,
                  value: _developmentDirection,
                  options: _developmentDirections,
                  l10n: l10n,
                  onChanged: (v) => setState(() => _developmentDirection = v),
                ),
                const SizedBox(height: AppSpacing.lg),
                _Dropdown(
                  label: l10n.authTrainingDisciplineLabel,
                  value: _trainingDiscipline,
                  options: _trainingDisciplines,
                  l10n: l10n,
                  onChanged: (v) => setState(() => _trainingDiscipline = v),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            XnSectionGroup(
              children: [
                XnSectionEyebrow(l10n.profileEditSocialSection),
                const SizedBox(height: AppSpacing.md),
                XnInput(
                  label: l10n.profileFacebookUrlLabel,
                  controller: _facebook,
                  hint: 'https://facebook.com/...',
                  keyboardType: TextInputType.url,
                  validator: (value) => _optionalUrl(value, l10n),
                ),
                const SizedBox(height: AppSpacing.lg),
                XnInput(
                  label: l10n.profileInstagramUrlLabel,
                  controller: _instagram,
                  hint: 'https://instagram.com/...',
                  keyboardType: TextInputType.url,
                  validator: (value) => _optionalUrl(value, l10n),
                ),
                const SizedBox(height: AppSpacing.lg),
                XnInput(
                  label: l10n.profileZaloUrlLabel,
                  controller: _zalo,
                  hint: 'https://zalo.me/...',
                  keyboardType: TextInputType.url,
                  validator: (value) => _optionalUrl(value, l10n),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            XnButton(
              label: l10n.commonSaveChanges,
              loading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

String? _required(String? v, AppLocalizations l10n) =>
    (v == null || v.trim().isEmpty) ? l10n.commonRequiredError : null;

String? _optionalUrl(String? v, AppLocalizations l10n) {
  final t = v?.trim() ?? '';
  if (t.isEmpty) return null;
  final uri = Uri.tryParse(t);
  if (uri == null || !uri.hasScheme || !uri.isAbsolute) {
    return l10n.profileFullUrlError;
  }
  return null;
}

String _trimZero(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

/// Spaced label for a `PascalCase` enum (e.g. `FatLoss` -> `Fat Loss`).
String _humanize(String value) => value.replaceAllMapped(
  RegExp('([a-z])([A-Z])'),
  (m) => '${m[1]} ${m[2]}',
);

String _profileEnumLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Male' => l10n.authGenderMale,
      'Female' => l10n.authGenderFemale,
      'Strength' => l10n.authDevStrength,
      'Hypertrophy' => l10n.authDevHypertrophy,
      'FatLoss' => l10n.authDevFatLoss,
      'Recomposition' => l10n.authDevRecomposition,
      'Endurance' => l10n.authDevEndurance,
      'GeneralHealth' => l10n.authDevGeneralHealth,
      'Powerlifting' => l10n.authDisciplinePowerlifting,
      'Bodybuilding' => l10n.authDisciplineBodybuilding,
      'Weightlifting' => l10n.authDisciplineWeightlifting,
      'Calisthenics' => l10n.authDisciplineCalisthenics,
      'CrossFit' => l10n.authDisciplineCrossFit,
      'Running' => l10n.authDisciplineRunning,
      'GeneralFitness' => l10n.authDisciplineGeneralFitness,
      _ => _humanize(value),
    };

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.l10n,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> options;
  final AppLocalizations l10n;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return XnDropdown<String>(
      label: label,
      value: value,
      options: [
        for (final option in options)
          XnDropdownOption(
            value: option,
            label: _profileEnumLabel(option, l10n),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.pickLabel,
    required this.clearTooltip,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final DateTime? value;
  final String pickLabel;
  final String clearTooltip;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.fg2,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.calendar_today_rounded, size: 16),
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value == null ? pickLabel : DateOnly.format(value!),
                  ),
                ),
              ),
            ),
            if (onClear != null)
              IconButton(
                tooltip: clearTooltip,
                icon: const Icon(Icons.close_rounded, color: AppColors.fg3),
                onPressed: onClear,
              ),
          ],
        ),
      ],
    );
  }
}
