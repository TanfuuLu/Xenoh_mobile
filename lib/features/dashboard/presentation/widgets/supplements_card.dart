import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../supplements/domain/entities/supplement_models.dart';
import '../../../supplements/presentation/providers/supplement_controllers.dart';

/// Compact, read-only view of today's supplement adherence.
/// Detailed recording and schedule management remain on `/supplements`.
class SupplementsCard extends ConsumerWidget {
  const SupplementsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final daily = ref.watch(supplementDailyProvider(date: today));

    return XnSection(
      onTap: () => context.go('/supplements'),
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

class _DosePreview extends StatelessWidget {
  const _DosePreview({required this.dose});

  final SupplementDailyDose dose;

  @override
  Widget build(BuildContext context) {
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
                '${_formatAmount(dose.amount)} ${dose.unit}',
                style: AppTypography.mono(11, color: AppColors.fg3),
              ),
            ],
          ),
        ),
        Text(
          dose.time,
          style: AppTypography.mono(12, color: AppColors.fg2),
        ),
      ],
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

String _formatAmount(double value) => value == value.roundToDouble()
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(1);
