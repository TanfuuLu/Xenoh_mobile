import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/current_date_provider.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../supplements/domain/entities/supplement_models.dart';
import '../../../supplements/presentation/providers/supplement_controllers.dart';

/// Compact view of today's supplement adherence. Doses can be marked taken
/// straight from here; skipping, notes and schedules stay on `/supplements`.
class SupplementsCard extends ConsumerWidget {
  const SupplementsCard({this.onOpen, super.key});

  /// Overrides the default tab switch, for hosts that would rather push
  /// `/supplements` onto their own stack (so back returns to them).
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(currentDateProvider);
    final daily = ref.watch(supplementDailyProvider(date: today));

    return XnSection(
      onTap: onOpen ?? () => context.go('/supplements'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SupplementsHeader(),
          const SizedBox(height: AppSpacing.lg),
          switch (daily) {
            AsyncData(:final value) => _SupplementsContent(daily: value),
            AsyncError() => const _SupplementsError(),
            _ => const _SupplementsLoading(),
          },
        ],
      ),
    );
  }
}

class _SupplementsHeader extends StatelessWidget {
  const _SupplementsHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.dataViolet.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Icon(
            Icons.medication_outlined,
            color: AppColors.dataViolet,
            size: 21,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.supplementsTitle,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                l10n.supplementsTodayLabel,
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded, color: AppColors.fg3),
      ],
    );
  }
}

class _SupplementsContent extends StatelessWidget {
  const _SupplementsContent({required this.daily});

  final SupplementDaily daily;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final totals = daily.totals;
    final progress = totals.planned == 0
        ? 0.0
        : (totals.taken / totals.planned).clamp(0.0, 1.0);
    final visibleDoses = daily.doses.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.supplementsTakenOfPlanned(totals.taken, totals.planned),
                style: AppTypography.mono(
                  14,
                  color: AppColors.fg1,
                  weight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: AppTypography.mono(12, color: AppColors.fg3),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: XnAnimatedLinearProgress(
            value: progress,
            minHeight: 7,
            backgroundColor: AppColors.bg3,
            color: AppColors.dataViolet,
          ),
        ),
        if (visibleDoses.isEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.supplementsNoDosesMessage,
            style: const TextStyle(color: AppColors.fg3, fontSize: 13),
          ),
        ] else ...[
          const SizedBox(height: AppSpacing.lg),
          XnCardStack(
            children: [
              for (final dose in visibleDoses) _DosePreview(dose: dose),
            ],
          ),
        ],
      ],
    );
  }
}

class _DosePreview extends ConsumerWidget {
  const _DosePreview({required this.dose});

  final SupplementDailyDose dose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tone = _statusTone(dose.status);
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tone.background,
            shape: BoxShape.circle,
          ),
          child: Icon(tone.icon, size: 16, color: tone.foreground),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dose.regimenName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${_formatAmount(dose.amount)} ${dose.unit}'
                ' · ${_formatTime(dose.time)}',
                style: AppTypography.mono(11, color: AppColors.fg3),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _DoseAction(dose: dose),
      ],
    );
  }
}

/// Marks a dose taken without leaving the dashboard. Already-recorded doses
/// show their state instead — changing or undoing one stays on `/supplements`,
/// where skip, reset and notes live.
class _DoseAction extends ConsumerWidget {
  const _DoseAction({required this.dose});

  final SupplementDailyDose dose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    switch (dose.status) {
      case SupplementDoseStatus.taken:
        return XnChip(
          compact: true,
          tone: XnChipTone.sage,
          icon: Icons.check_rounded,
          label: l10n.supplementsStatusTaken,
        );
      case SupplementDoseStatus.skipped:
        return XnChip(
          compact: true,
          tone: XnChipTone.neutral,
          label: l10n.supplementsStatusSkipped,
        );
      case SupplementDoseStatus.pending:
      case SupplementDoseStatus.missed:
        final pending = ref
            .watch(supplementMutationControllerProvider)
            .isLoading;
        // Just an empty box to tick: the row already names the dose, so a
        // label would repeat it. The action name lives in the tooltip and
        // semantics instead.
        return _MarkTakenCheckbox(
          label: l10n.supplementsMarkTakenAction,
          pending: pending,
          onTap: () => unawaited(_record(context, ref)),
        );
    }
  }

  Future<void> _record(BuildContext context, WidgetRef ref) async {
    final success = await ref
        .read(supplementMutationControllerProvider.notifier)
        .recordDose(
          doseSlotId: dose.doseSlotId,
          date: ref.read(currentDateProvider),
          status: SupplementIntakeStatus.taken,
        );
    if (success || !context.mounted) return;
    final error = ref.read(supplementMutationControllerProvider).error;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$error')));
  }
}

class _MarkTakenCheckbox extends StatelessWidget {
  const _MarkTakenCheckbox({
    required this.label,
    required this.pending,
    required this.onTap,
  });

  final String label;
  final bool pending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = pending
        ? AppColors.accent.withValues(alpha: 0.45)
        : AppColors.accent;
    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: pending ? null : onTap,
            splashColor: AppColors.accent.withValues(alpha: 0.12),
            highlightColor: AppColors.accent.withValues(alpha: 0.06),
            child: SizedBox(
              width: 36,
              height: 36,
              child: Center(
                child: pending
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.8,
                          color: fg,
                        ),
                      )
                    : Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.accentSoft,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: fg, width: 1.4),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SupplementsLoading extends StatelessWidget {
  const _SupplementsLoading();

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
  );
}

class _SupplementsError extends StatelessWidget {
  const _SupplementsError();

  @override
  Widget build(BuildContext context) => Text(
    AppLocalizations.of(context).dashboardSupplementsLoadError,
    style: const TextStyle(color: AppColors.fg3, fontSize: 13),
  );
}

({Color background, Color foreground, IconData icon}) _statusTone(
  SupplementDoseStatus status,
) => switch (status) {
  SupplementDoseStatus.taken => (
    background: AppColors.successBg,
    foreground: AppColors.success,
    icon: Icons.check_rounded,
  ),
  SupplementDoseStatus.skipped => (
    background: AppColors.warningBg,
    foreground: AppColors.warning,
    icon: Icons.remove_rounded,
  ),
  SupplementDoseStatus.missed => (
    background: AppColors.dangerBg,
    foreground: AppColors.danger,
    icon: Icons.close_rounded,
  ),
  SupplementDoseStatus.pending => (
    background: AppColors.bg3,
    foreground: AppColors.fg3,
    icon: Icons.schedule_rounded,
  ),
};

/// The API sends `HH:mm:ss`; the card only has room for the clock time.
String _formatTime(String value) =>
    value.length >= 5 ? value.substring(0, 5) : value;

String _formatAmount(double value) => value == value.roundToDouble()
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(1);
