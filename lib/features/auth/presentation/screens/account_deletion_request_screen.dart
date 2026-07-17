import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/xenoh_api.dart';
import '../providers/auth_controller.dart';

/// Public web route for people who no longer have the app installed.
/// The backend verifies the email address before processing any deletion.
class AccountDeletionRequestScreen extends ConsumerStatefulWidget {
  const AccountDeletionRequestScreen({super.key});

  @override
  ConsumerState<AccountDeletionRequestScreen> createState() =>
      _AccountDeletionRequestScreenState();
}

class _AccountDeletionRequestScreenState
    extends ConsumerState<AccountDeletionRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  var _submitting = false;
  var _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    final failure = await ref
        .read(authControllerProvider.notifier)
        .requestAccountDeletion(_emailController.text.trim());
    if (!mounted) return;
    setState(() {
      _submitting = false;
      _submitted = failure == null;
    });
    if (failure != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(failure, context))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).accountDeletionAppBarTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(l10n.accountDeletionTitle, style: AppTypography.display(30)),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.accountDeletionDescription,
              style: const TextStyle(color: AppColors.fg2, height: 1.45),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (_submitted)
              XnSection(
                child: Text(
                  l10n.accountDeletionSuccessMessage,
                  style: const TextStyle(color: AppColors.fg1, height: 1.45),
                ),
              )
            else
              XnSection(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText: l10n.accountDeletionEmailLabel,
                        ),
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          return email.contains('@')
                              ? null
                              : l10n.accountDeletionInvalidEmail;
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      XnButton(
                        label: l10n.accountDeletionSubmitLabel,
                        icon: Icons.delete_forever_outlined,
                        onPressed: _submitting ? null : _submit,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
