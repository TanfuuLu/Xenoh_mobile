import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_controller.dart';
import '../services/external_auth_launcher.dart';
import '../services/social_callback_uri.dart';
import '../widgets/auth_layout.dart';
import '../widgets/social_login_controls.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({this.externalAuthLauncher, super.key});

  final ExternalAuthLauncher? externalAuthLauncher;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;
  ExternalAuthProvider? _launchingProvider;

  ExternalAuthLauncher get _externalAuthLauncher =>
      widget.externalAuthLauncher ??
      ExternalAuthLauncher(apiBaseUrl: AppConfig.apiBaseUrl);

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    final failure = await ref
        .read(authControllerProvider.notifier)
        .login(
          email: _email.text.trim(),
          password: _password.text,
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (failure != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failure.message)));
    }
    // On success the router redirect navigates away automatically.
  }

  Future<void> _startExternalLogin(ExternalAuthProvider provider) async {
    if (_submitting || _launchingProvider != null) return;
    setState(() => _launchingProvider = provider);

    String? callbackLocation;
    try {
      final callback = await _externalAuthLauncher.authenticate(provider);
      if (callback != null) {
        callbackLocation = internalSocialCallbackLocation(callback);
      }
    } on Exception {
      callbackLocation = null;
    }

    if (!mounted) return;
    setState(() => _launchingProvider = null);
    if (callbackLocation == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).authSocialLaunchFailedError,
            ),
          ),
        );
      return;
    }
    context.go(callbackLocation);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthLayout(
      title: l10n.authLoginTitle,
      subtitle: l10n.authLoginSubtitle,
      variant: AuthLayoutVariant.featured,
      footer: AuthFooterAction(
        prompt: l10n.authLoginNoAccountPrompt,
        actionLabel: l10n.authLoginCreateAccountCta,
        onPressed: _submitting ? null : () => context.push('/register'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            XnInput(
              label: l10n.authEmailLabel,
              controller: _email,
              hint: l10n.authEmailHint,
              prefix: const Icon(Icons.alternate_email_rounded, size: 20),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (v) => _validateEmail(v, l10n),
            ),
            const SizedBox(height: AppSpacing.lg),
            XnInput(
              label: l10n.authPasswordLabel,
              controller: _password,
              hint: l10n.authPasswordHint,
              prefix: const Icon(Icons.lock_outline_rounded, size: 20),
              obscureText: _obscure,
              textInputAction: TextInputAction.done,
              validator: (v) =>
                  (v == null || v.isEmpty) ? l10n.authEnterPasswordError : null,
              suffix: IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.fg3,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _submitting
                    ? null
                    : () => context.push('/forgot-password'),
                child: Text(l10n.authForgotPasswordCta),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            XnButton(
              label: l10n.authSignInCta,
              icon: Icons.arrow_forward_rounded,
              loading: _submitting,
              onPressed: _submit,
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthDivider(label: l10n.authOrDivider),
            const SizedBox(height: AppSpacing.lg),
            SocialAuthButton(
              label: l10n.authContinueWithGoogle,
              mark: const GoogleMark(),
              loading: _launchingProvider == ExternalAuthProvider.google,
              onPressed: _submitting || _launchingProvider != null
                  ? null
                  : () => _startExternalLogin(ExternalAuthProvider.google),
            ),
            const SizedBox(height: AppSpacing.sm),
            SocialAuthButton(
              label: l10n.authContinueWithFacebook,
              mark: const FacebookMark(),
              loading: _launchingProvider == ExternalAuthProvider.facebook,
              onPressed: _submitting || _launchingProvider != null
                  ? null
                  : () => _startExternalLogin(ExternalAuthProvider.facebook),
            ),
          ],
        ),
      ),
    );
  }

  static String? _validateEmail(String? v, AppLocalizations l10n) {
    if (v == null || v.trim().isEmpty) return l10n.authEnterEmailError;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : l10n.authInvalidEmailError;
  }
}
