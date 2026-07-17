import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/exercise_thumbnail.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../progress/domain/entities/exercise_pr.dart';
import '../../../progress/presentation/providers/progress_controllers.dart';
import '../../../progress/presentation/widgets/pr_history_sheet.dart';
import '../../domain/entities/exercise_template.dart';
import '../providers/exercise_templates_controller.dart';
import '../widgets/exercise_template_form_sheet.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends ConsumerState<ExerciseLibraryScreen> {
  String? _muscleGroup;
  String _query = '';

  Future<void> _createTemplate() async {
    final l10n = AppLocalizations.of(context);
    final result = await showModalBottomSheet<ExerciseTemplateFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseTemplateFormSheet(
        title: l10n.trainingCustomExerciseTitle,
        submitLabel: l10n.trainingCreateExerciseCta,
      ),
    );
    if (result == null) return;

    try {
      await ref
          .read(
            exerciseTemplatesControllerProvider(
              muscleGroup: _muscleGroup,
            ).notifier,
          )
          .createCustom(
            name: result.name,
            primaryMuscleGroup: result.primaryMuscleGroup,
            secondaryMuscleGroups: result.secondaryMuscleGroups,
            exerciseKind: result.exerciseKind,
            description: result.description,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.trainingExerciseCreatedSnackbar)),
        );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$error')));
    }
  }

  Future<void> _editTemplate(ExerciseTemplate template) async {
    final l10n = AppLocalizations.of(context);
    final result = await showModalBottomSheet<ExerciseTemplateFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseTemplateFormSheet(
        title: l10n.trainingEditExerciseTitle,
        submitLabel: l10n.commonSaveChanges,
        initial: template,
      ),
    );
    if (result == null) return;

    try {
      await ref
          .read(
            exerciseTemplatesControllerProvider(
              muscleGroup: _muscleGroup,
            ).notifier,
          )
          .updateCustom(
            id: template.id,
            name: result.name,
            primaryMuscleGroup: result.primaryMuscleGroup,
            secondaryMuscleGroups: result.secondaryMuscleGroups,
            exerciseKind: result.exerciseKind,
            description: result.description,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.trainingExerciseUpdatedSnackbar)),
        );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$error')));
    }
  }

  Future<void> _deleteTemplate(ExerciseTemplate template) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.trainingDeleteExerciseTitle),
        content: Text(l10n.trainingDeleteExerciseMessage(template.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (!(ok ?? false)) return;

    try {
      await ref
          .read(
            exerciseTemplatesControllerProvider(
              muscleGroup: _muscleGroup,
            ).notifier,
          )
          .deleteCustom(template.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.trainingExerciseDeletedSnackbar)),
        );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$error')));
    }
  }

  void _openPr(ExercisePr pr) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => PrHistorySheet(pr: pr),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unit = ref.watch(weightUnitProvider);
    final templates = ref.watch(
      exerciseTemplatesControllerProvider(muscleGroup: _muscleGroup),
    );
    // PRs load independently; pills appear once available without blocking the
    // library list (no spinner flash on refresh).
    final prByTemplate = <String, ExercisePr>{
      for (final pr
          in ref.watch(exercisePrsProvider).value ?? const <ExercisePr>[])
        pr.exerciseTemplateId: pr,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.trainingExerciseLibraryTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createTemplate,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.fgOnClay,
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.trainingCustomLabel),
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async => ref.invalidate(
          exerciseTemplatesControllerProvider(muscleGroup: _muscleGroup),
        ),
        child: AsyncValueView(
          value: templates,
          onRetry: () => ref.invalidate(
            exerciseTemplatesControllerProvider(muscleGroup: _muscleGroup),
          ),
          data: (items) {
            final filtered = items
                .where(
                  (template) =>
                      _query.trim().isEmpty ||
                      template.name.toLowerCase().contains(
                        _query.trim().toLowerCase(),
                      ),
                )
                .toList();

            return ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                96,
              ),
              children: [
                _LibraryHeader(
                  total: items.length,
                  customCount: items.where((t) => t.isCustom).length,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded),
                    hintText: l10n.trainingSearchExercisesHint,
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: AppSpacing.md),
                _MuscleFilter(
                  selected: _muscleGroup,
                  onChanged: (value) => setState(() => _muscleGroup = value),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (filtered.isEmpty)
                  const _EmptyLibrary()
                else
                  XnSectionList(
                    children: [
                      for (final template in filtered)
                        _ExerciseTemplateCard(
                          template: template,
                          unit: unit,
                          pr: prByTemplate[template.id],
                          onPrTap: prByTemplate[template.id] == null
                              ? null
                              : () => _openPr(prByTemplate[template.id]!),
                          onEdit: template.isCustom
                              ? () => _editTemplate(template)
                              : null,
                          onDelete: template.isCustom
                              ? () => _deleteTemplate(template)
                              : null,
                        ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LibraryHeader extends StatelessWidget {
  const _LibraryHeader({required this.total, required this.customCount});

  final int total;
  final int customCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      color: AppColors.bg3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.trainingExerciseLibraryEyebrow,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.trainingTemplatesCount(total),
            style: AppTypography.display(26, letterSpacing: 0),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.trainingCustomExercisesAvailable(customCount),
            style: const TextStyle(color: AppColors.fg2),
          ),
        ],
      ),
    );
  }
}

class _MuscleFilter extends StatelessWidget {
  const _MuscleFilter({required this.selected, required this.onChanged});

  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(l10n.commonAll),
              selected: selected == null,
              onSelected: (_) => onChanged(null),
            ),
          ),
          for (final group in muscleGroupOptions)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(muscleGroupLabel(group, l10n)),
                selected: selected == group,
                onSelected: (_) => onChanged(group),
              ),
            ),
        ],
      ),
    );
  }
}

class _ExerciseTemplateCard extends StatelessWidget {
  const _ExerciseTemplateCard({
    required this.template,
    required this.unit,
    this.pr,
    this.onPrTap,
    this.onEdit,
    this.onDelete,
  });

  final ExerciseTemplate template;
  final WeightUnit unit;
  final ExercisePr? pr;
  final VoidCallback? onPrTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExerciseThumbnail(
                imageUrl: template.imageUrl,
                exerciseKind: template.exerciseKind,
                size: 64,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.name,
                      style: AppTypography.display(18, letterSpacing: 0),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.description?.isNotEmpty == true
                          ? template.description!
                          : '${muscleGroupLabel(template.primaryMuscleGroup, l10n)} '
                                '${l10n.trainingPrimaryMovementSuffix}',
                      style: const TextStyle(
                        color: AppColors.fg2,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              if (onEdit != null || onDelete != null)
                PopupMenuButton<_TemplateAction>(
                  icon: const Icon(Icons.more_horiz_rounded),
                  itemBuilder: (_) => [
                    if (onEdit != null)
                      PopupMenuItem(
                        value: _TemplateAction.edit,
                        child: Text(l10n.commonEdit),
                      ),
                    if (onDelete != null)
                      PopupMenuItem(
                        value: _TemplateAction.delete,
                        child: Text(l10n.commonDelete),
                      ),
                  ],
                  onSelected: (action) {
                    switch (action) {
                      case _TemplateAction.edit:
                        onEdit?.call();
                      case _TemplateAction.delete:
                        onDelete?.call();
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (pr != null)
                _PrPill(pr: pr!, unit: unit, onTap: onPrTap ?? () {}),
              XnChip(
                label: muscleGroupLabel(template.primaryMuscleGroup, l10n),
              ),
              XnChip(
                label: exerciseKindLabel(template.exerciseKind, l10n),
                tone: template.exerciseKind == 'Cardio'
                    ? XnChipTone.info
                    : XnChipTone.sage,
              ),
              if (template.isCustom)
                XnChip(label: l10n.trainingCustomLabel, tone: XnChipTone.warn),
              for (final group in template.secondaryMuscleGroups.take(3))
                XnChip(
                  label: muscleGroupLabel(group, l10n),
                  tone: XnChipTone.neutral,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Tappable pill surfacing an exercise's current personal record. Opens the
/// shared [PrHistorySheet] for progression and sharing.
class _PrPill extends StatelessWidget {
  const _PrPill({required this.pr, required this.unit, required this.onTap});

  final ExercisePr pr;
  final WeightUnit unit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 14,
                color: AppColors.accent,
              ),
              const SizedBox(width: 6),
              Text(
                AppLocalizations.of(context).trainingPrWeightLabel(
                  formatWeight(unit.fromKg(pr.currentWeight)),
                  unit.suffix,
                ),
                style: const TextStyle(
                  color: AppColors.clay900,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.chevron_right_rounded,
                size: 14,
                color: AppColors.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyLibrary extends StatelessWidget {
  const _EmptyLibrary();

  @override
  Widget build(BuildContext context) {
    return XnCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              color: AppColors.fg3,
              size: 42,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppLocalizations.of(
                context,
              ).trainingNoExercisesMatchFilterMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.fg2),
            ),
          ],
        ),
      ),
    );
  }
}

enum _TemplateAction { edit, delete }
