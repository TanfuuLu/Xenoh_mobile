import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/register_params.dart';
import '../providers/auth_controller.dart';
import '../widgets/auth_layout.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _accountFormKey = GlobalKey<FormState>();
  final _profileFormKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _height = TextEditingController();
  final _bodyweight = TextEditingController();

  var _step = 0;
  Gender? _gender;
  DevelopmentDirection? _developmentDirection;
  TrainingDiscipline? _trainingDiscipline;
  DateTime? _dob;
  bool _obscure = true;
  bool _submitting = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _height.dispose();
    _bodyweight.dispose();
    super.dispose();
  }

  void _continueToProfile() {
    if (!_accountFormKey.currentState!.validate()) return;
    setState(() => _step = 1);
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(now.year - 20),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (picked != null) setState(() => _dob = picked);
  }

  Future<void> _submit() async {
    if (!_profileFormKey.currentState!.validate()) return;
    if (_dob == null) {
      _toast(AppLocalizations.of(context).authSelectDobError);
      return;
    }

    setState(() => _submitting = true);
    final failure = await ref
        .read(authControllerProvider.notifier)
        .register(
          RegisterParams(
            email: _email.text.trim(),
            password: _password.text,
            firstName: _firstName.text.trim(),
            lastName: _lastName.text.trim(),
            role: SignupRole.individual,
            gender: _gender!,
            dateOfBirth: _dob!,
            developmentDirection: _developmentDirection!,
            trainingDiscipline: _trainingDiscipline!,
            height: double.tryParse(_height.text.trim()),
            bodyweight: double.tryParse(_bodyweight.text.trim()),
          ),
        );

    if (!mounted) return;
    setState(() => _submitting = false);
    if (failure != null) {
      _toast(failure.message);
      return;
    }

    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    context.go('/login');
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.authAccountCreatedSnackbar)));
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthLayout(
      title: _step == 0
          ? l10n.authRegisterTitleStep0
          : l10n.authRegisterTitleStep1,
      subtitle: _step == 0
          ? l10n.authRegisterSubtitleStep0
          : l10n.authRegisterSubtitleStep1,
      currentStep: _step + 1,
      totalSteps: 2,
      stepLabel: _step == 0
          ? l10n.authRegisterStep1Of2
          : l10n.authRegisterStep2Of2,
      footer: AuthFooterAction(
        prompt: l10n.authRegisterHaveAccountPrompt,
        actionLabel: l10n.authSignInCta,
        onPressed: _submitting ? null : () => context.go('/login'),
      ),
      child: AnimatedSwitcher(
        duration: AppMotion.med,
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: _step == 0
            ? _AccountStep(
                key: const ValueKey('account-step'),
                formKey: _accountFormKey,
                firstName: _firstName,
                lastName: _lastName,
                email: _email,
                password: _password,
                obscure: _obscure,
                onTogglePassword: () => setState(() => _obscure = !_obscure),
                onContinue: _continueToProfile,
              )
            : _ProfileStep(
                key: const ValueKey('profile-step'),
                formKey: _profileFormKey,
                gender: _gender,
                dateOfBirth: _dob,
                developmentDirection: _developmentDirection,
                trainingDiscipline: _trainingDiscipline,
                height: _height,
                bodyweight: _bodyweight,
                submitting: _submitting,
                onGenderChanged: (v) => setState(() => _gender = v),
                onDevelopmentDirectionChanged: (v) =>
                    setState(() => _developmentDirection = v),
                onTrainingDisciplineChanged: (v) =>
                    setState(() => _trainingDiscipline = v),
                onPickDob: _pickDob,
                onBack: _submitting ? null : () => setState(() => _step = 0),
                onSubmit: _submit,
              ),
      ),
    );
  }
}

class _AccountStep extends StatelessWidget {
  const _AccountStep({
    required this.formKey,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.obscure,
    required this.onTogglePassword,
    required this.onContinue,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController password;
  final bool obscure;
  final VoidCallback onTogglePassword;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepHeader(
            step: l10n.authRegisterStep1Of2,
            title: l10n.authRegisterAccountDetailsTitle,
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthResponsivePair(
            first: XnInput(
              label: l10n.authFirstNameLabel,
              controller: firstName,
              prefix: const Icon(Icons.person_outline_rounded, size: 20),
              textInputAction: TextInputAction.next,
              validator: (v) => _required(v, l10n),
            ),
            second: XnInput(
              label: l10n.authLastNameLabel,
              controller: lastName,
              prefix: const Icon(Icons.person_outline_rounded, size: 20),
              textInputAction: TextInputAction.next,
              validator: (v) => _required(v, l10n),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          XnInput(
            label: l10n.authEmailLabel,
            controller: email,
            hint: l10n.authEmailHint,
            prefix: const Icon(Icons.alternate_email_rounded, size: 20),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (v) => _validateEmail(v, l10n),
          ),
          const SizedBox(height: AppSpacing.lg),
          XnInput(
            label: l10n.authPasswordLabel,
            controller: password,
            hint: l10n.authPasswordMinHint,
            prefix: const Icon(Icons.lock_outline_rounded, size: 20),
            obscureText: obscure,
            textInputAction: TextInputAction.done,
            validator: (v) => (v == null || v.length < 8)
                ? l10n.authPasswordTooShortError
                : null,
            suffix: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.fg3,
              ),
              onPressed: onTogglePassword,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          XnButton(
            label: l10n.authContinueCta,
            icon: Icons.arrow_forward_rounded,
            onPressed: onContinue,
          ),
        ],
      ),
    );
  }
}

class _ProfileStep extends StatelessWidget {
  const _ProfileStep({
    required this.formKey,
    required this.gender,
    required this.dateOfBirth,
    required this.developmentDirection,
    required this.trainingDiscipline,
    required this.height,
    required this.bodyweight,
    required this.submitting,
    required this.onGenderChanged,
    required this.onDevelopmentDirectionChanged,
    required this.onTrainingDisciplineChanged,
    required this.onPickDob,
    required this.onBack,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final Gender? gender;
  final DateTime? dateOfBirth;
  final DevelopmentDirection? developmentDirection;
  final TrainingDiscipline? trainingDiscipline;
  final TextEditingController height;
  final TextEditingController bodyweight;
  final bool submitting;
  final ValueChanged<Gender?> onGenderChanged;
  final ValueChanged<DevelopmentDirection?> onDevelopmentDirectionChanged;
  final ValueChanged<TrainingDiscipline?> onTrainingDisciplineChanged;
  final VoidCallback onPickDob;
  final VoidCallback? onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepHeader(
            step: l10n.authRegisterStep2Of2,
            title: l10n.authRegisterTrainingProfileTitle,
          ),
          const SizedBox(height: AppSpacing.lg),
          _RegisterDropdown<Gender>(
            label: l10n.authGenderLabel,
            value: gender,
            options: Gender.values,
            displayText: (value) => _genderLabel(value, l10n),
            onChanged: onGenderChanged,
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthSectionLabel(l10n.authDobLabel),
          OutlinedButton.icon(
            onPressed: onPickDob,
            icon: const Icon(Icons.calendar_today_rounded, size: 18),
            label: Text(
              dateOfBirth == null
                  ? l10n.authSelectDateCta
                  : DateOnly.format(dateOfBirth!),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthResponsivePair(
            first: XnInput(
              label: l10n.authHeightLabel,
              controller: height,
              prefix: const Icon(Icons.height_rounded, size: 20),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  _optionalRange(v, min: 50, max: 300, l10n: l10n),
            ),
            second: XnInput(
              label: l10n.authWeightLabel,
              controller: bodyweight,
              prefix: const Icon(Icons.monitor_weight_outlined, size: 20),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  _optionalRange(v, min: 20, max: 500, l10n: l10n),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _RegisterDropdown<DevelopmentDirection>(
            label: l10n.authDevelopmentDirectionLabel,
            value: developmentDirection,
            options: DevelopmentDirection.values,
            displayText: (value) => _developmentDirectionLabel(value, l10n),
            onChanged: onDevelopmentDirectionChanged,
          ),
          const SizedBox(height: AppSpacing.lg),
          _RegisterDropdown<TrainingDiscipline>(
            label: l10n.authTrainingDisciplineLabel,
            value: trainingDiscipline,
            options: TrainingDiscipline.values,
            displayText: (value) => _trainingDisciplineLabel(value, l10n),
            onChanged: onTrainingDisciplineChanged,
          ),
          const SizedBox(height: AppSpacing.xl),
          _ProfileActions(
            submitting: submitting,
            onBack: onBack,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}

class _ProfileActions extends StatelessWidget {
  const _ProfileActions({
    required this.submitting,
    required this.onBack,
    required this.onSubmit,
  });

  final bool submitting;
  final VoidCallback? onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final backButton = XnButton(
      label: l10n.commonBack,
      variant: XnButtonVariant.secondary,
      onPressed: onBack,
    );
    final submitButton = XnButton(
      label: l10n.authRegisterCta,
      icon: Icons.check_rounded,
      loading: submitting,
      onPressed: onSubmit,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 340) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              submitButton,
              const SizedBox(height: AppSpacing.sm),
              backButton,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: backButton),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: submitButton),
          ],
        );
      },
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.step, required this.title});

  final String step;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step,
          style: const TextStyle(
            color: AppColors.fg3,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(title, style: AppTypography.display(22, weight: FontWeight.w500)),
      ],
    );
  }
}

class _RegisterDropdown<T> extends StatelessWidget {
  const _RegisterDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.displayText,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<T> options;
  final String Function(T value) displayText;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnDropdown<T>(
          label: label,
          value: value,
          hint: l10n.authSelectOneHint,
          options: [
            for (final option in options)
              XnDropdownOption(value: option, label: displayText(option)),
          ],
          validator: (v) => v == null ? l10n.commonRequiredError : null,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

String _genderLabel(Gender value, AppLocalizations l10n) {
  return switch (value) {
    Gender.male => l10n.authGenderMale,
    Gender.female => l10n.authGenderFemale,
    Gender.other => l10n.authGenderOther,
  };
}

String _developmentDirectionLabel(
  DevelopmentDirection value,
  AppLocalizations l10n,
) {
  return switch (value) {
    DevelopmentDirection.strength => l10n.authDevStrength,
    DevelopmentDirection.hypertrophy => l10n.authDevHypertrophy,
    DevelopmentDirection.fatLoss => l10n.authDevFatLoss,
    DevelopmentDirection.recomposition => l10n.authDevRecomposition,
    DevelopmentDirection.endurance => l10n.authDevEndurance,
    DevelopmentDirection.generalHealth => l10n.authDevGeneralHealth,
  };
}

String _trainingDisciplineLabel(
  TrainingDiscipline value,
  AppLocalizations l10n,
) {
  return switch (value) {
    TrainingDiscipline.powerlifting => l10n.authDisciplinePowerlifting,
    TrainingDiscipline.bodybuilding => l10n.authDisciplineBodybuilding,
    TrainingDiscipline.weightlifting => l10n.authDisciplineWeightlifting,
    TrainingDiscipline.calisthenics => l10n.authDisciplineCalisthenics,
    TrainingDiscipline.crossFit => l10n.authDisciplineCrossFit,
    TrainingDiscipline.running => l10n.authDisciplineRunning,
    TrainingDiscipline.generalFitness => l10n.authDisciplineGeneralFitness,
  };
}

String? _required(String? v, AppLocalizations l10n) =>
    (v == null || v.trim().isEmpty) ? l10n.commonRequiredError : null;

String? _validateEmail(String? v, AppLocalizations l10n) {
  if (v == null || v.trim().isEmpty) return l10n.authEnterEmailError;
  final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
  return ok ? null : l10n.authInvalidEmailError;
}

String? _optionalRange(
  String? v, {
  required double min,
  required double max,
  required AppLocalizations l10n,
}) {
  final text = v?.trim() ?? '';
  if (text.isEmpty) return null;
  final number = double.tryParse(text);
  if (number == null) return l10n.commonEnterNumberError;
  if (number < min || number > max) {
    return l10n.authOptionalRangeError(
      min.toStringAsFixed(0),
      max.toStringAsFixed(0),
    );
  }
  return null;
}
