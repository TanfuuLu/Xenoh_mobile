import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/plan.dart';
import '../providers/plans_controller.dart';

enum PlanFormMode { create, edit, duplicate }

typedef CreatePlanCallback =
    Future<void> Function({
      required String name,
      required DateTime startDate,
      required DateTime endDate,
    });

/// Bottom sheet to create a plan (name + start/end dates). Pops `true` on
/// success.
class CreatePlanSheet extends ConsumerStatefulWidget {
  const CreatePlanSheet({
    this.initialPlan,
    this.mode = PlanFormMode.create,
    this.onCreate,
    super.key,
  });

  final Plan? initialPlan;
  final PlanFormMode mode;

  /// Overrides the default self-plan creation command. Coach flows use this
  /// to create a plan for a specific client while reusing the same validated
  /// form and date rules.
  final CreatePlanCallback? onCreate;

  @override
  ConsumerState<CreatePlanSheet> createState() => _CreatePlanSheetState();
}

class _CreatePlanSheetState extends ConsumerState<CreatePlanSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  DateTime? _start;
  DateTime? _end;
  bool _submitting = false;

  String _title(AppLocalizations l10n) => switch (widget.mode) {
    PlanFormMode.create => l10n.trainingNewPlanTitle,
    PlanFormMode.edit => l10n.trainingEditPlanTitle,
    PlanFormMode.duplicate => l10n.trainingDuplicatePlanTitle,
  };

  String _submitLabel(AppLocalizations l10n) => switch (widget.mode) {
    PlanFormMode.create => l10n.trainingCreatePlanCta,
    PlanFormMode.edit => l10n.commonSaveChanges,
    PlanFormMode.duplicate => l10n.trainingCreateCopyCta,
  };

  @override
  void initState() {
    super.initState();
    final plan = widget.initialPlan;
    if (plan == null) return;
    _name.text = widget.mode == PlanFormMode.duplicate
        ? AppLocalizations.of(context).trainingDuplicatePlanName(plan.name)
        : plan.name;
    _start = plan.startDate;
    _end = plan.endDate;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pick({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart ? (_start ?? now) : (_end ?? _start ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) {
      setState(() => isStart ? _start = picked : _end = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    if (_start == null || _end == null) {
      _toast(l10n.trainingPickDatesError);
      return;
    }
    if (_end!.isBefore(_start!)) {
      _toast(l10n.trainingEndAfterStartError);
      return;
    }
    setState(() => _submitting = true);
    try {
      switch (widget.mode) {
        case PlanFormMode.create:
          final onCreate = widget.onCreate;
          if (onCreate != null) {
            await onCreate(
              name: _name.text.trim(),
              startDate: _start!,
              endDate: _end!,
            );
          } else {
            await ref
                .read(plansControllerProvider.notifier)
                .createPlan(
                  name: _name.text.trim(),
                  startDate: _start!,
                  endDate: _end!,
                );
          }
        case PlanFormMode.edit:
          final plan = widget.initialPlan!;
          await ref
              .read(plansControllerProvider.notifier)
              .updatePlan(
                planId: plan.id,
                name: _name.text.trim(),
                startDate: _start!,
                endDate: _end!,
              );
        case PlanFormMode.duplicate:
          final plan = widget.initialPlan!;
          await ref
              .read(plansControllerProvider.notifier)
              .duplicatePlan(
                sourcePlanId: plan.id,
                name: _name.text.trim(),
                startDate: _start!,
                endDate: _end!,
              );
      }
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      _toast('$e');
    }
  }

  void _toast(String msg) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _title(l10n),
              style: AppTypography.display(22, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.lg),
            XnInput(
              label: l10n.trainingPlanNameLabel,
              controller: _name,
              hint: l10n.trainingPlanNameHint,
              validator: (v) => (v == null || v.trim().length < 2)
                  ? l10n.trainingPlanNameError
                  : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _DateField(
                    label: l10n.trainingStartLabel,
                    value: _start,
                    onTap: () => _pick(isStart: true),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _DateField(
                    label: l10n.trainingEndLabel,
                    value: _end,
                    onTap: () => _pick(isStart: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            XnButton(
              label: _submitLabel(l10n),
              loading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

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
        OutlinedButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.calendar_today_rounded, size: 16),
          label: Text(
            value == null
                ? AppLocalizations.of(context).trainingPickDateCta
                : DateOnly.format(value!),
          ),
        ),
      ],
    );
  }
}
