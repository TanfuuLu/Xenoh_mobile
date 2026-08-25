import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

/// The four phases the guidance covers, in cycle order. The API's `Unknown`
/// has no guidance of its own and falls back to `Menstrual`.
const cycleGuidancePhases = ['Menstrual', 'Follicular', 'Ovulation', 'Luteal'];

/// Per-phase accent, matching the web frontend's `PHASE_COLORS`.
Color cyclePhaseColor(String phase) => switch (phase) {
  'Menstrual' => const Color(0xFFF43F5E),
  'Follicular' => const Color(0xFF22C55E),
  'Ovulation' => const Color(0xFF06B6D4),
  'Luteal' => const Color(0xFFA855F7),
  _ => const Color(0xFF94A3B8),
};

String cyclePhaseLabel(String phase, AppLocalizations l10n) => switch (phase) {
  'Menstrual' => l10n.cyclePhaseMenstrual,
  'Follicular' => l10n.cyclePhaseFollicular,
  'Ovulation' => l10n.cyclePhaseOvulation,
  'Luteal' => l10n.cyclePhaseLuteal,
  _ => l10n.cyclePhaseUnknown,
};

List<String> _trainingTips(String phase, AppLocalizations l10n) =>
    switch (phase) {
      'Follicular' => [
        l10n.cycleGuidanceFollicularTraining1,
        l10n.cycleGuidanceFollicularTraining2,
        l10n.cycleGuidanceFollicularTraining3,
      ],
      'Ovulation' => [
        l10n.cycleGuidanceOvulationTraining1,
        l10n.cycleGuidanceOvulationTraining2,
        l10n.cycleGuidanceOvulationTraining3,
      ],
      'Luteal' => [
        l10n.cycleGuidanceLutealTraining1,
        l10n.cycleGuidanceLutealTraining2,
        l10n.cycleGuidanceLutealTraining3,
      ],
      _ => [
        l10n.cycleGuidanceMenstrualTraining1,
        l10n.cycleGuidanceMenstrualTraining2,
        l10n.cycleGuidanceMenstrualTraining3,
      ],
    };

List<String> _nutritionTips(String phase, AppLocalizations l10n) =>
    switch (phase) {
      'Follicular' => [
        l10n.cycleGuidanceFollicularNutrition1,
        l10n.cycleGuidanceFollicularNutrition2,
        l10n.cycleGuidanceFollicularNutrition3,
      ],
      'Ovulation' => [
        l10n.cycleGuidanceOvulationNutrition1,
        l10n.cycleGuidanceOvulationNutrition2,
        l10n.cycleGuidanceOvulationNutrition3,
      ],
      'Luteal' => [
        l10n.cycleGuidanceLutealNutrition1,
        l10n.cycleGuidanceLutealNutrition2,
        l10n.cycleGuidanceLutealNutrition3,
      ],
      _ => [
        l10n.cycleGuidanceMenstrualNutrition1,
        l10n.cycleGuidanceMenstrualNutrition2,
        l10n.cycleGuidanceMenstrualNutrition3,
      ],
    };

/// Training and nutrition guidance for a cycle phase, with chips to browse the
/// other phases. Opens on the athlete's current phase.
class CyclePhaseGuidancePanel extends StatefulWidget {
  const CyclePhaseGuidancePanel({required this.currentPhase, super.key});

  final String currentPhase;

  @override
  State<CyclePhaseGuidancePanel> createState() =>
      _CyclePhaseGuidancePanelState();
}

class _CyclePhaseGuidancePanelState extends State<CyclePhaseGuidancePanel> {
  late String _active;

  @override
  void initState() {
    super.initState();
    _active = cycleGuidancePhases.contains(widget.currentPhase)
        ? widget.currentPhase
        : cycleGuidancePhases.first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accent = cyclePhaseColor(_active);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(
              Icons.menu_book_outlined,
              size: 18,
              color: Color(0xFFF43F5E),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                l10n.cycleGuidanceTitle,
                style: AppTypography.display(18, letterSpacing: 0),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final phase in cycleGuidancePhases)
              _PhaseChip(
                label: cyclePhaseLabel(phase, l10n),
                color: cyclePhaseColor(phase),
                selected: phase == _active,
                onTap: () => setState(() => _active = phase),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _GuidanceColumn(
          icon: Icons.fitness_center_rounded,
          title: l10n.cycleGuidanceTrainingLabel,
          tips: _trainingTips(_active, l10n),
          accent: accent,
        ),
        const SizedBox(height: AppSpacing.md),
        _GuidanceColumn(
          icon: Icons.restaurant_rounded,
          title: l10n.cycleGuidanceNutritionLabel,
          tips: _nutritionTips(_active, l10n),
          accent: accent,
        ),
      ],
    );
  }
}

class _PhaseChip extends StatelessWidget {
  const _PhaseChip({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: selected ? color : AppColors.bg2,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: selected ? color : AppColors.border1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.fgOnClay : AppColors.fg2,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _GuidanceColumn extends StatelessWidget {
  const _GuidanceColumn({
    required this.icon,
    required this.title,
    required this.tips,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final List<String> tips;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, size: 15, color: accent),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          for (final (index, tip) in tips.indexed) ...[
            if (index > 0) const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    tip,
                    style: const TextStyle(
                      color: AppColors.fg2,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
