import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

const _severities = ['Low', 'Medium', 'High', 'Critical'];

class ReportBugScreen extends ConsumerStatefulWidget {
  const ReportBugScreen({super.key});

  @override
  ConsumerState<ReportBugScreen> createState() => _ReportBugScreenState();
}

class _ReportBugScreenState extends ConsumerState<ReportBugScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _screenController = TextEditingController();

  String _severity = 'Medium';
  var _submitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _screenController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);
    final l10n = AppLocalizations.of(context);
    try {
      await ref.read(xenohApiProvider).postObject('/bug-reports', {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'severity': _severity,
        'pageUrl': _screenController.text.trim().isEmpty
            ? null
            : _screenController.text.trim(),
        'browserInfo': _deviceInfo(),
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reportBugSubmittedSnackbar)),
      );
      context.pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String _deviceInfo() {
    if (kIsWeb) return 'Flutter web';
    try {
      return 'Flutter ${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
    } catch (_) {
      return 'Flutter mobile';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FeatureScreenFrame(
      title: l10n.reportBugTitle,
      children: [
        FeatureHeader(
          title: l10n.reportBugTitle,
          subtitle: l10n.reportBugSubtitle,
          icon: Icons.bug_report_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        Form(
          key: _formKey,
          child: XnCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                XnInput(
                  label: l10n.reportBugTitleLabel,
                  controller: _titleController,
                  hint: l10n.reportBugTitleHint,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? l10n.reportBugTitleRequiredError
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),
                XnDropdown<String>(
                  label: l10n.reportBugSeverityLabel,
                  value: _severity,
                  options: [
                    for (final severity in _severities)
                      XnDropdownOption(
                        value: severity,
                        label: _severityLabel(severity, l10n),
                      ),
                  ],
                  onChanged: _submitting
                      ? null
                      : (value) => setState(() {
                          _severity = value ?? 'Medium';
                        }),
                ),
                const SizedBox(height: AppSpacing.md),
                XnInput(
                  label: l10n.reportBugScreenLabel,
                  controller: _screenController,
                  hint: l10n.reportBugScreenHint,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _descriptionController,
                  enabled: !_submitting,
                  minLines: 5,
                  maxLines: 8,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: l10n.reportBugDescriptionLabel,
                    hintText: l10n.reportBugDescriptionHint,
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? l10n.reportBugDescriptionRequiredError
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.reportBugDeviceDetailsAttached,
                  style: const TextStyle(color: AppColors.fg3),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: XnButton(
                        label: l10n.commonCancel,
                        variant: XnButtonVariant.secondary,
                        onPressed: _submitting ? null : () => context.pop(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: XnButton(
                        label: l10n.commonSubmit,
                        icon: Icons.bug_report_outlined,
                        loading: _submitting,
                        onPressed: () => unawaited(_submit()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _severityLabel(String value, AppLocalizations l10n) => switch (value) {
  'Low' => l10n.reportBugSeverityLow,
  'Medium' => l10n.reportBugSeverityMedium,
  'High' => l10n.reportBugSeverityHigh,
  'Critical' => l10n.reportBugSeverityCritical,
  _ => value,
};
