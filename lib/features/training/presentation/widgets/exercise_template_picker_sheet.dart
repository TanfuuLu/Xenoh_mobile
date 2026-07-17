import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/exercise_thumbnail.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/exercise_template.dart';
import '../providers/exercise_templates_controller.dart';
import 'exercise_template_form_sheet.dart';

enum _TemplateAction { select, edit, delete }

class ExerciseTemplatePickerSheet extends ConsumerStatefulWidget {
  const ExerciseTemplatePickerSheet({super.key});

  @override
  ConsumerState<ExerciseTemplatePickerSheet> createState() =>
      _ExerciseTemplatePickerSheetState();
}

class _ExerciseTemplatePickerSheetState
    extends ConsumerState<ExerciseTemplatePickerSheet> {
  String? _muscle;
  String _query = '';

  Future<void> _createCustom() async {
    final l10n = AppLocalizations.of(context);
    final form = await showModalBottomSheet<ExerciseTemplateFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseTemplateFormSheet(
        title: l10n.trainingCustomExerciseTitle,
        submitLabel: l10n.trainingCreateExerciseCta,
      ),
    );
    if (form == null) return;
    try {
      await ref
          .read(
            exerciseTemplatesControllerProvider(
              muscleGroup: _muscle,
            ).notifier,
          )
          .createCustom(
            name: form.name,
            primaryMuscleGroup: form.primaryMuscleGroup,
            secondaryMuscleGroups: form.secondaryMuscleGroups,
            exerciseKind: form.exerciseKind,
            description: form.description,
          );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final templates = ref.watch(
      exerciseTemplatesControllerProvider(muscleGroup: _muscle),
    );

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.85,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.trainingAddExerciseCta,
              style: AppTypography.display(20, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton.icon(
              onPressed: _createCustom,
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.trainingNewCustomExerciseCta),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              autofocus: false,
              decoration: InputDecoration(
                hintText: l10n.trainingSearchExercisesHint,
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: muscleGroupOptions.length + 1,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return _FilterChip(
                      label: l10n.commonAll,
                      selected: _muscle == null,
                      onSelected: () => setState(() => _muscle = null),
                    );
                  }
                  final group = muscleGroupOptions[i - 1];
                  return _FilterChip(
                    label: muscleGroupLabel(group, l10n),
                    selected: _muscle == group,
                    onSelected: () => setState(() => _muscle = group),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: templates.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => ErrorView.from(
                  e,
                  context,
                  onRetry: () => ref.invalidate(
                    exerciseTemplatesControllerProvider(muscleGroup: _muscle),
                  ),
                ),
                data: (items) {
                  final filtered = _query.isEmpty
                      ? items
                      : items
                            .where((t) => t.name.toLowerCase().contains(_query))
                            .toList();
                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.trainingNoExercisesFoundMessage,
                        style: const TextStyle(color: AppColors.fg2),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: AppColors.border1),
                    itemBuilder: (_, i) => _TemplateTile(
                      template: filtered[i],
                      muscleGroup: _muscle,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
    );
  }
}

class _TemplateTile extends ConsumerWidget {
  const _TemplateTile({required this.template, required this.muscleGroup});

  final ExerciseTemplate template;
  final String? muscleGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ExerciseThumbnail(
        imageUrl: template.imageUrl,
        exerciseKind: template.exerciseKind,
      ),
      title: Text(
        template.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${muscleGroupLabel(template.primaryMuscleGroup, l10n)} - '
        '${exerciseKindLabel(template.exerciseKind, l10n)}'
        '${template.isCustom ? ' - ${l10n.trainingCustomLabel}' : ''}',
        style: const TextStyle(color: AppColors.fg2, fontSize: 13),
      ),
      trailing: template.isCustom
          ? PopupMenuButton<_TemplateAction>(
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (action) => switch (action) {
                _TemplateAction.select => Navigator.pop(context, template),
                _TemplateAction.edit => _edit(context, ref),
                _TemplateAction.delete => _delete(context, ref),
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: _TemplateAction.select,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.add_circle_outline_rounded),
                    title: Text(l10n.trainingUseExerciseCta),
                  ),
                ),
                PopupMenuItem(
                  value: _TemplateAction.edit,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.edit_outlined),
                    title: Text(l10n.commonEdit),
                  ),
                ),
                PopupMenuItem(
                  value: _TemplateAction.delete,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.danger,
                    ),
                    title: Text(
                      l10n.commonDelete,
                      style: const TextStyle(color: AppColors.danger),
                    ),
                  ),
                ),
              ],
            )
          : const Icon(Icons.add_circle_outline_rounded),
      onTap: () => Navigator.pop(context, template),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final form = await showModalBottomSheet<ExerciseTemplateFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseTemplateFormSheet(
        title: l10n.trainingEditExerciseTitle,
        submitLabel: l10n.commonSaveChanges,
        initial: template,
      ),
    );
    if (form == null) return;
    try {
      await ref
          .read(
            exerciseTemplatesControllerProvider(
              muscleGroup: muscleGroup,
            ).notifier,
          )
          .updateCustom(
            id: template.id,
            name: form.name,
            primaryMuscleGroup: form.primaryMuscleGroup,
            secondaryMuscleGroups: form.secondaryMuscleGroups,
            exerciseKind: form.exerciseKind,
            description: form.description,
          );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.trainingDeleteCustomExerciseTitle),
        content: Text(
          l10n.trainingDeleteCustomExerciseMessage(template.name),
        ),
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
    if (confirmed != true) return;
    try {
      await ref
          .read(
            exerciseTemplatesControllerProvider(
              muscleGroup: muscleGroup,
            ).notifier,
          )
          .deleteCustom(template.id);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }
}
