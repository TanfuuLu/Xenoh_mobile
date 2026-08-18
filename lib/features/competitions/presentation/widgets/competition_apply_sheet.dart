import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../domain/competition_models.dart';
import '../competition_providers.dart';

/// Bottom-sheet application form for a competition.
///
/// Replaces the old cramped [AlertDialog]: the entry fee and remaining spots
/// stay visible while choosing, categories are tappable rows instead of a
/// dropdown, and submission happens inside the sheet so failures keep the
/// entered contact details.
class CompetitionApplySheet extends ConsumerStatefulWidget {
  const CompetitionApplySheet({
    required this.event,
    required this.initialEmail,
    super.key,
  });

  final CompetitionEvent event;
  final String initialEmail;

  static const categoryFieldKey = Key('competition-apply-category');
  static const submitKey = Key('competition-apply-submit');

  /// Shows the sheet and returns `true` once an application was submitted.
  static Future<bool?> show(
    BuildContext context, {
    required CompetitionEvent event,
    required String initialEmail,
  }) => showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.bgPage,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.xxl),
      ),
    ),
    builder: (_) => CompetitionApplySheet(
      event: event,
      initialEmail: initialEmail,
    ),
  );

  @override
  ConsumerState<CompetitionApplySheet> createState() =>
      _CompetitionApplySheetState();
}

class _CompetitionApplySheetState extends ConsumerState<CompetitionApplySheet> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: widget.initialEmail);
  final _phone = TextEditingController();
  final _facebook = TextEditingController();

  String? _categoryId;
  bool _submitting = false;

  @override
  void dispose() {
    _email.dispose();
    _phone.dispose();
    _facebook.dispose();
    super.dispose();
  }

  /// `Women Open up to 69kg · F-OPEN-69` — the code disambiguates categories
  /// whose names collide once an event has a long list of them.
  String _categoryLabel(CompetitionCategory category) => category.code.isEmpty
      ? category.name
      : '${category.name} · ${category.code}';

  Future<void> _submit() async {
    final categoryId = _categoryId;
    final formValid = _formKey.currentState?.validate() ?? false;
    if (categoryId == null || !formValid) return;

    setState(() => _submitting = true);
    try {
      await ref
          .read(competitionRepositoryProvider)
          .register(
            eventId: widget.event.id,
            categoryId: categoryId,
            contactEmail: _email.text.trim(),
            contactPhone: _phone.text.trim(),
            contactFacebook: _facebook.text.trim().isEmpty
                ? null
                : _facebook.text.trim(),
          );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(apiErrorMessage(error, context))),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Grabber(),
              _Header(event: widget.event, enabled: !_submitting),
              Flexible(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.xs,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    children: [
                      _EntrySummary(event: widget.event),
                      const SizedBox(height: AppSpacing.lg),
                      XnDropdown<String>(
                        key: CompetitionApplySheet.categoryFieldKey,
                        label: l10n.competitionCategory,
                        hint: l10n.competitionChooseCategoryHint,
                        value: _categoryId,
                        enabled: !_submitting,
                        options: [
                          for (final category in widget.event.categories)
                            XnDropdownOption(
                              value: category.id,
                              label: _categoryLabel(category),
                            ),
                        ],
                        validator: (value) => value == null
                            ? l10n.competitionChooseCategory
                            : null,
                        onChanged: (value) =>
                            setState(() => _categoryId = value),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      XnSectionEyebrow(l10n.competitionApplyContact),
                      const SizedBox(height: AppSpacing.sm),
                      XnInput(
                        label: l10n.competitionEmail,
                        hint: l10n.competitionEmailHint,
                        controller: _email,
                        enabled: !_submitting,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        prefix: const Icon(Icons.alternate_email_rounded),
                        validator: (value) => (value ?? '').trim().contains('@')
                            ? null
                            : l10n.accountDeletionInvalidEmail,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      XnInput(
                        label: l10n.competitionPhone,
                        hint: l10n.competitionPhoneHint,
                        controller: _phone,
                        enabled: !_submitting,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        prefix: const Icon(Icons.phone_outlined),
                        validator: (value) => (value?.trim().length ?? 0) >= 7
                            ? null
                            : l10n.competitionPhoneValidation,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      XnInput(
                        label: l10n.competitionFacebookOptional,
                        hint: l10n.competitionFacebookHint,
                        controller: _facebook,
                        enabled: !_submitting,
                        textInputAction: TextInputAction.done,
                        prefix: const Icon(Icons.public_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              _Footer(
                submitting: _submitting,
                onCancel: _submitting ? null : () => Navigator.pop(context),
                onSubmit: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 38,
      height: 4,
      margin: const EdgeInsets.only(top: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.border1,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.event, required this.enabled});

  final CompetitionEvent event;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.competitionApply,
                  style: AppTypography.display(
                    23,
                    weight: FontWeight.w600,
                    letterSpacing: -0.25,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.competitionApplySubtitle,
                  style: const TextStyle(
                    color: AppColors.fg4,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.commonClose,
            onPressed: enabled ? () => Navigator.pop(context) : null,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}

/// Keeps the money and the scarcity in view while the athlete decides.
class _EntrySummary extends StatelessWidget {
  const _EntrySummary({required this.event});

  final CompetitionEvent event;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spotsLeft = (event.capacity - event.confirmedCount).clamp(
      0,
      event.capacity,
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentSoft.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryStat(
              label: l10n.competitionEntryFee,
              value:
                  '${event.registrationFee.toStringAsFixed(0)} '
                  '${event.currency}',
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: AppColors.accent.withValues(alpha: 0.14),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.lg),
              child: _SummaryStat(
                label: l10n.competitionSpotsLeft,
                value: '$spotsLeft / ${event.capacity}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColors.fg3,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.mono(
          15,
          color: AppColors.fg1,
          weight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.submitting,
    required this.onCancel,
    required this.onSubmit,
  });

  final bool submitting;
  final VoidCallback? onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bgPage,
        border: Border(top: BorderSide(color: AppColors.surfaceBorderSoft)),
      ),
      child: Row(
        children: [
          Expanded(
            child: XnButton(
              label: l10n.commonCancel,
              variant: XnButtonVariant.secondary,
              onPressed: onCancel,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 2,
            child: XnButton(
              key: CompetitionApplySheet.submitKey,
              label: l10n.competitionSubmit,
              icon: Icons.check_rounded,
              loading: submitting,
              onPressed: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
