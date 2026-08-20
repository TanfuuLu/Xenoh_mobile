import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/pro_locked_view.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/supplement_models.dart';
import '../providers/supplement_controllers.dart';

class SupplementsScreen extends ConsumerStatefulWidget {
  const SupplementsScreen({this.clientId, super.key});

  final String? clientId;

  @override
  ConsumerState<SupplementsScreen> createState() => _SupplementsScreenState();
}

class _SupplementsScreenState extends ConsumerState<SupplementsScreen> {
  DateTime _date = DateOnly.truncate(DateTime.now());
  bool _includeArchived = false;

  bool get _isClient => widget.clientId != null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: _isClient ? const BackButton() : const HomeShellMenuButton(),
          title: Text(
            _isClient ? l10n.supplementsClientTitle : l10n.supplementsTitle,
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.supplementsTodayTab),
              Tab(text: l10n.supplementsRegimensTab),
              Tab(text: l10n.supplementsHistoryTab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _DailyTab(
              date: _date,
              clientId: widget.clientId,
              onDateChanged: (value) => setState(() => _date = value),
            ),
            _RegimensTab(
              clientId: widget.clientId,
              includeArchived: _includeArchived,
              onArchivedChanged: (value) =>
                  setState(() => _includeArchived = value),
            ),
            _HistoryTab(clientId: widget.clientId),
          ],
        ),
      ),
    );
  }
}

class _DailyTab extends ConsumerWidget {
  const _DailyTab({
    required this.date,
    required this.clientId,
    required this.onDateChanged,
  });

  final DateTime date;
  final String? clientId;
  final ValueChanged<DateTime> onDateChanged;

  /// The server rejects a dose recorded ahead of its day, so the actions are
  /// hidden rather than offered and failed.
  bool get _isFuture => date.isAfter(DateOnly.truncate(DateTime.now()));

  bool get _canRecord => clientId == null && !_isFuture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final value = ref.watch(
      supplementDailyProvider(date: date, clientId: clientId),
    );
    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () async {
        ref.invalidate(
          supplementDailyProvider(date: date, clientId: clientId),
        );
        await ref.read(
          supplementDailyProvider(date: date, clientId: clientId).future,
        );
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _DateSelector(
            date: date,
            onChanged: onDateChanged,
          ),
          const SizedBox(height: AppSpacing.md),
          switch (value) {
            AsyncData(:final value) => _DailyContent(
              daily: value,
              canRecord: _canRecord,
              onStatus: (dose, status) => _record(context, ref, dose, status),
              onReset: (dose) => _reset(context, ref, dose),
              onNote: (dose) => _editNote(context, ref, dose),
            ),
            AsyncError(:final error) => _errorPanel(
              context,
              error,
              () => ref.invalidate(
                supplementDailyProvider(date: date, clientId: clientId),
              ),
            ),
            _ => const SizedBox(
              height: 420,
              child: Center(child: CircularProgressIndicator()),
            ),
          },
          if (_footerMessage(l10n) case final message?)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.fg3, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  String? _footerMessage(AppLocalizations l10n) {
    if (clientId != null) return l10n.supplementsCoachReadOnlyMessage;
    if (_isFuture) return l10n.supplementsFutureDoseMessage;
    return null;
  }

  Future<void> _record(
    BuildContext context,
    WidgetRef ref,
    SupplementDailyDose dose,
    SupplementIntakeStatus status, {
    String? note,
  }) async {
    final controller = ref.read(supplementMutationControllerProvider.notifier);
    final success = await controller.recordDose(
      doseSlotId: dose.doseSlotId,
      date: date,
      status: status,
      note: note,
    );
    if (!success && context.mounted) _showMutationError(context, ref);
  }

  /// Notes ride along with a status, so an existing dose is simply re-recorded
  /// with the same status and the new note.
  Future<void> _editNote(
    BuildContext context,
    WidgetRef ref,
    SupplementDailyDose dose,
  ) async {
    final status = switch (dose.status) {
      SupplementDoseStatus.skipped => SupplementIntakeStatus.skipped,
      _ => SupplementIntakeStatus.taken,
    };
    final note = await _promptNote(context, initial: dose.note);
    if (note == null || !context.mounted) return;
    await _record(
      context,
      ref,
      dose,
      status,
      note: note.isEmpty ? null : note,
    );
  }

  Future<void> _reset(
    BuildContext context,
    WidgetRef ref,
    SupplementDailyDose dose,
  ) async {
    final success = await ref
        .read(supplementMutationControllerProvider.notifier)
        .resetDose(doseSlotId: dose.doseSlotId, date: date);
    if (!success && context.mounted) _showMutationError(context, ref);
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({required this.date, required this.onChanged});

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final today = DateOnly.truncate(DateTime.now());
    return XnSection(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: l10n.supplementsPreviousDayTooltip,
            onPressed: () => onChanged(date.subtract(const Duration(days: 1))),
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.md),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: date,
                );
                if (picked != null) onChanged(picked);
              },
              child: Column(
                children: [
                  Text(
                    date == today
                        ? l10n.supplementsTodayLabel
                        : DateFormat.EEEE(locale).format(date),
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd(locale).format(date),
                    style: AppTypography.mono(14, weight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: l10n.supplementsNextDayTooltip,
            onPressed: () => onChanged(date.add(const Duration(days: 1))),
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}

class _DailyContent extends StatelessWidget {
  const _DailyContent({
    required this.daily,
    required this.canRecord,
    required this.onStatus,
    required this.onReset,
    required this.onNote,
  });

  final SupplementDaily daily;
  final bool canRecord;
  final void Function(SupplementDailyDose, SupplementIntakeStatus) onStatus;
  final ValueChanged<SupplementDailyDose> onReset;
  final ValueChanged<SupplementDailyDose> onNote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        _AdherenceSummary(totals: daily.totals),
        const SizedBox(height: AppSpacing.md),
        if (daily.doses.isEmpty)
          _EmptyPanel(
            icon: Icons.medication_outlined,
            title: l10n.supplementsNoDosesTitle,
            message: l10n.supplementsNoDosesMessage,
          )
        else
          XnCardStack(
            children: [
              for (final dose in daily.doses)
                _DoseRow(
                  dose: dose,
                  enabled: canRecord,
                  onStatus: (status) => onStatus(dose, status),
                  onReset: () => onReset(dose),
                  onNote: () => onNote(dose),
                ),
            ],
          ),
      ],
    );
  }
}

class _AdherenceSummary extends StatelessWidget {
  const _AdherenceSummary({required this.totals});

  final SupplementAdherenceTotals totals;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percent = totals.adherencePercentage;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.clay900,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.supplementsAdherenceLabel,
            style: TextStyle(
              color: AppColors.fgOnClay.withValues(alpha: 0.72),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                percent == null ? '—' : '${percent.toStringAsFixed(1)}%',
                style: AppTypography.display(
                  34,
                  color: AppColors.fgOnClay,
                  weight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
              const Spacer(),
              Text(
                l10n.supplementsTakenOfPlanned(
                  totals.taken,
                  totals.planned,
                ),
                style: AppTypography.mono(
                  12,
                  color: AppColors.fgOnClay.withValues(alpha: 0.78),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: totals.planned == 0
                  ? 0
                  : (totals.taken / totals.planned).clamp(0, 1),
              minHeight: 8,
              backgroundColor: AppColors.fgOnClay.withValues(alpha: 0.14),
              valueColor: const AlwaysStoppedAnimation(AppColors.sage500),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoseRow extends StatelessWidget {
  const _DoseRow({
    required this.dose,
    required this.enabled,
    required this.onStatus,
    required this.onReset,
    required this.onNote,
  });

  final SupplementDailyDose dose;
  final bool enabled;
  final ValueChanged<SupplementIntakeStatus> onStatus;
  final VoidCallback onReset;
  final VoidCallback onNote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final completed =
        dose.status == SupplementDoseStatus.taken ||
        dose.status == SupplementDoseStatus.skipped;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                alignment: Alignment.center,
                child: Text(
                  _shortTime(dose.time),
                  style: AppTypography.mono(
                    13,
                    color: AppColors.accent,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dose.regimenName,
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${_amount(dose.amount)} ${dose.unit}'
                      '${dose.form == null ? '' : ' · ${dose.form}'}',
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              XnChip(
                label: _statusLabel(dose.status, l10n),
                tone: _statusTone(dose.status),
              ),
            ],
          ),
          if (dose.recordedAt case final recordedAt?)
            Padding(
              padding: const EdgeInsets.only(left: 60, top: 4),
              child: Text(
                l10n.supplementsRecordedAtLabel(
                  DateFormat.jm(locale).format(recordedAt.toLocal()),
                ),
                style: const TextStyle(color: AppColors.fg3, fontSize: 11),
              ),
            ),
          if (dose.note case final note? when note.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 60, top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.sticky_note_2_outlined,
                    size: 13,
                    color: AppColors.fg3,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      note,
                      style: const TextStyle(
                        color: AppColors.fg2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (enabled) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: dose.status == SupplementDoseStatus.taken
                        ? null
                        : () => onStatus(SupplementIntakeStatus.taken),
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: Text(l10n.supplementsMarkTakenButton),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: dose.status == SupplementDoseStatus.skipped
                        ? null
                        : () => onStatus(SupplementIntakeStatus.skipped),
                    icon: const Icon(Icons.skip_next_rounded, size: 18),
                    label: Text(l10n.supplementsSkipButton),
                  ),
                ),
                if (completed) ...[
                  const SizedBox(width: AppSpacing.xs),
                  IconButton(
                    tooltip: dose.note == null
                        ? l10n.supplementsAddNoteTooltip
                        : l10n.supplementsEditNoteTooltip,
                    onPressed: onNote,
                    icon: const Icon(Icons.edit_note_rounded),
                  ),
                  IconButton(
                    tooltip: l10n.supplementsResetDoseTooltip,
                    onPressed: onReset,
                    icon: const Icon(Icons.undo_rounded),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _RegimensTab extends ConsumerWidget {
  const _RegimensTab({
    required this.clientId,
    required this.includeArchived,
    required this.onArchivedChanged,
  });

  final String? clientId;
  final bool includeArchived;
  final ValueChanged<bool> onArchivedChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final value = ref.watch(
      supplementRegimensProvider(
        clientId: clientId,
        includeArchived: includeArchived,
      ),
    );
    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () async {
        ref.invalidate(
          supplementRegimensProvider(
            clientId: clientId,
            includeArchived: includeArchived,
          ),
        );
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Row(
            children: [
              Expanded(
                child: FilterChip(
                  selected: includeArchived,
                  label: Text(l10n.supplementsShowArchivedLabel),
                  onSelected: onArchivedChanged,
                ),
              ),
              FilledButton.icon(
                onPressed: () => unawaited(
                  _openForm(context, ref),
                ),
                icon: const Icon(Icons.add_rounded),
                label: Text(l10n.supplementsAddRegimenButton),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          switch (value) {
            AsyncData(:final value) when value.isEmpty => _EmptyPanel(
              icon: Icons.medication_liquid_outlined,
              title: l10n.supplementsNoRegimensTitle,
              message: l10n.supplementsNoRegimensMessage,
            ),
            AsyncData(:final value) => XnCardStack(
              children: [
                for (final regimen in value)
                  _RegimenRow(
                    regimen: regimen,
                    onEdit: regimen.isArchived
                        ? null
                        : () => unawaited(
                            _openForm(context, ref, regimen: regimen),
                          ),
                    onArchive: regimen.isArchived
                        ? null
                        : () => unawaited(
                            _archive(context, ref, regimen),
                          ),
                    onDelete: () => unawaited(_delete(context, ref, regimen)),
                  ),
              ],
            ),
            AsyncError(:final error) => _errorPanel(
              context,
              error,
              () => ref.invalidate(
                supplementRegimensProvider(
                  clientId: clientId,
                  includeArchived: includeArchived,
                ),
              ),
            ),
            _ => const SizedBox(
              height: 420,
              child: Center(child: CircularProgressIndicator()),
            ),
          },
        ],
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context,
    WidgetRef ref, {
    SupplementRegimen? regimen,
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => SupplementRegimenSheet(
        initial: regimen,
        clientId: clientId,
      ),
    );
    if (saved == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            regimen == null
                ? AppLocalizations.of(context).supplementsCreatedMessage
                : AppLocalizations.of(context).supplementsUpdatedMessage,
          ),
        ),
      );
    }
  }

  Future<void> _archive(
    BuildContext context,
    WidgetRef ref,
    SupplementRegimen regimen,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.supplementsArchiveTitle),
        content: Text(l10n.supplementsArchiveMessage(regimen.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.supplementsArchiveButton),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final success = await ref
        .read(supplementMutationControllerProvider.notifier)
        .archive(regimen.id, clientId: clientId);
    if (!success && context.mounted) _showMutationError(context, ref);
  }

  /// Permanent removal — the schedule and every recorded dose go with it, so
  /// the confirmation spells that out and the action is styled as destructive.
  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    SupplementRegimen regimen,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.supplementsDeleteTitle),
        content: Text(l10n.supplementsDeleteMessage(regimen.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.danger,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.supplementsDeleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final success = await ref
        .read(supplementMutationControllerProvider.notifier)
        .delete(regimen.id, clientId: clientId);
    if (!context.mounted) return;
    if (!success) {
      _showMutationError(context, ref);
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.supplementsDeletedMessage)),
      );
  }
}

class _RegimenRow extends StatelessWidget {
  const _RegimenRow({
    required this.regimen,
    required this.onEdit,
    required this.onArchive,
    required this.onDelete,
  });

  final SupplementRegimen regimen;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.accentSoft,
            foregroundColor: AppColors.accent,
            child: Icon(Icons.medication_outlined),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        regimen.name,
                        style: const TextStyle(
                          color: AppColors.fg1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (regimen.isArchived)
                      XnChip(
                        label: l10n.supplementsArchivedLabel,
                        tone: XnChipTone.neutral,
                      ),
                  ],
                ),
                if (regimen.brand case final brand?)
                  Text(
                    brand,
                    style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                  ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.supplementsDoseSlotCount(regimen.doseSlots.length),
                  style: AppTypography.mono(11, color: AppColors.fg3),
                ),
                for (final slot in regimen.doseSlots)
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      '${_shortTime(slot.time)} · ${_amount(slot.amount)} '
                      '${slot.unit} · ${_daysLabel(context, slot.daysOfWeek)}',
                      style: const TextStyle(
                        color: AppColors.fg2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                if (_scheduleLabel(l10n, locale) case final label?)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (regimen.createdBy case final creator?
                    when creator.id != regimen.userId)
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      l10n.supplementsCreatedByLabel(creator.fullName),
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') onEdit?.call();
              if (value == 'archive') onArchive?.call();
              if (value == 'delete') onDelete();
            },
            itemBuilder: (_) => [
              if (onEdit != null)
                PopupMenuItem(
                  value: 'edit',
                  child: Text(l10n.commonEdit),
                ),
              if (onArchive != null)
                PopupMenuItem(
                  value: 'archive',
                  child: Text(l10n.supplementsArchiveButton),
                ),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  l10n.supplementsDeleteButton,
                  style: const TextStyle(color: AppColors.danger),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// The API returns the upcoming schedule version when one is pending, so the
  /// row says which window the listed dose times belong to.
  String? _scheduleLabel(AppLocalizations l10n, String locale) {
    final from = regimen.scheduleEffectiveFrom;
    if (from == null) return null;
    final format = DateFormat.yMMMd(locale);
    final today = DateOnly.truncate(DateTime.now());
    if (from.isAfter(today)) {
      return l10n.supplementsScheduleUpcomingLabel(format.format(from));
    }
    if (regimen.scheduleEffectiveTo case final to?) {
      return l10n.supplementsScheduleEndsLabel(format.format(to));
    }
    return l10n.supplementsScheduleActiveLabel(format.format(from));
  }
}

/// Ranges the history endpoint accepts (it caps requests at 90 days).
const _historyRanges = [7, 30, 90];

class _HistoryTab extends ConsumerStatefulWidget {
  const _HistoryTab({required this.clientId});

  final String? clientId;

  @override
  ConsumerState<_HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends ConsumerState<_HistoryTab> {
  int _days = 30;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final to = DateOnly.truncate(DateTime.now());
    final from = to.subtract(Duration(days: _days - 1));
    final family = supplementHistoryProvider(
      from: from,
      to: to,
      clientId: widget.clientId,
    );
    final value = ref.watch(family);
    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () async {
        ref.invalidate(family);
        await ref.read(family.future);
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.supplementsHistoryRangeLabel(_days),
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              for (final days in _historyRanges)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.xs),
                  child: ChoiceChip(
                    selected: _days == days,
                    label: Text(l10n.supplementsRangeDaysLabel(days)),
                    onSelected: (selected) {
                      if (selected) setState(() => _days = days);
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          switch (value) {
            AsyncData(:final value) => Column(
              children: [
                _AdherenceSummary(totals: value.totals),
                const SizedBox(height: AppSpacing.md),
                if (value.days.isEmpty)
                  _EmptyPanel(
                    icon: Icons.query_stats_outlined,
                    title: l10n.supplementsNoHistoryTitle,
                    message: l10n.supplementsNoHistoryMessage,
                  )
                else
                  XnCardStack(
                    children: [
                      for (final day in value.days.reversed)
                        _HistoryRow(day: day),
                    ],
                  ),
              ],
            ),
            AsyncError(:final error) => _errorPanel(
              context,
              error,
              () => ref.invalidate(family),
            ),
            _ => const SizedBox(
              height: 420,
              child: Center(child: CircularProgressIndicator()),
            ),
          },
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.day});

  final SupplementHistoryDay day;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.MMMEd(locale).format(day.date),
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  l10n.supplementsTakenOfPlanned(
                    day.totals.taken,
                    day.totals.planned,
                  ),
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            day.totals.adherencePercentage == null
                ? '—'
                : '${day.totals.adherencePercentage!.toStringAsFixed(1)}%',
            style: AppTypography.mono(15, weight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class SupplementRegimenSheet extends ConsumerStatefulWidget {
  const SupplementRegimenSheet({
    required this.clientId,
    this.initial,
    super.key,
  });

  final String? clientId;
  final SupplementRegimen? initial;

  @override
  ConsumerState<SupplementRegimenSheet> createState() =>
      _SupplementRegimenSheetState();
}

class _SupplementRegimenSheetState
    extends ConsumerState<SupplementRegimenSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _brand;
  late final TextEditingController _form;
  late final TextEditingController _instructions;
  late final TextEditingController _notes;
  late DateTime _effectiveDate;
  late List<_EditableDoseSlot> _slots;

  bool get _editing => widget.initial != null;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _name = TextEditingController(text: initial?.name);
    _brand = TextEditingController(text: initial?.brand);
    _form = TextEditingController(text: initial?.form);
    _instructions = TextEditingController(text: initial?.instructions);
    _notes = TextEditingController(text: initial?.notes);
    // Creating starts today; editing writes a new schedule version, which the
    // server refuses to date earlier than tomorrow.
    _effectiveDate = _firstEffectiveDate;
    _slots =
        initial?.doseSlots
            .map(_EditableDoseSlot.fromModel)
            .toList(growable: true) ??
        [_EditableDoseSlot.defaultValue()];
  }

  @override
  void dispose() {
    _name.dispose();
    _brand.dispose();
    _form.dispose();
    _instructions.dispose();
    _notes.dispose();
    for (final slot in _slots) {
      slot.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mutation = ref.watch(supplementMutationControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: Text(
          _editing
              ? l10n.supplementsEditRegimenTitle
              : l10n.supplementsCreateRegimenTitle,
        ),
        actions: [
          TextButton(
            onPressed: mutation.isLoading ? null : _save,
            child: mutation.isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.commonSave),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xxl,
          ),
          children: [
            TextFormField(
              controller: _name,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: l10n.supplementsNameLabel,
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? l10n.supplementsRequiredMessage
                  : null,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brand,
                    maxLength: 100,
                    decoration: InputDecoration(
                      labelText: l10n.supplementsBrandLabel,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextFormField(
                    controller: _form,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: l10n.supplementsFormLabel,
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _instructions,
              maxLength: 500,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: l10n.supplementsInstructionsLabel,
              ),
            ),
            TextFormField(
              controller: _notes,
              maxLength: 500,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: l10n.supplementsNotesLabel,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _editing
                    ? l10n.supplementsEffectiveFromLabel
                    : l10n.supplementsStartDateLabel,
              ),
              subtitle: Text(DateOnly.format(_effectiveDate)),
              trailing: const Icon(Icons.calendar_month_outlined),
              onTap: _pickEffectiveDate,
            ),
            if (_editing)
              Text(
                l10n.supplementsEffectiveFromHint,
                style: const TextStyle(color: AppColors.fg3, fontSize: 11),
              ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.supplementsDoseSlotsTitle,
                    style: AppTypography.display(
                      22,
                      weight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _slots.length >= 20
                      ? null
                      : () => setState(
                          () => _slots.add(_EditableDoseSlot.defaultValue()),
                        ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 40),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(l10n.supplementsAddDoseButton),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            for (var index = 0; index < _slots.length; index++) ...[
              _DoseSlotEditor(
                key: ValueKey(_slots[index].key),
                index: index,
                slot: _slots[index],
                onChanged: () => setState(() {}),
                onRemove: _slots.length == 1
                    ? null
                    : () => setState(() {
                        _slots.removeAt(index).dispose();
                      }),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (mutation.hasError)
              Text(
                '${mutation.error}',
                style: const TextStyle(color: AppColors.danger),
              ),
          ],
        ),
      ),
    );
  }

  DateTime get _firstEffectiveDate {
    final today = DateOnly.truncate(DateTime.now());
    return _editing ? today.add(const Duration(days: 1)) : today;
  }

  Future<void> _pickEffectiveDate() async {
    final first = _firstEffectiveDate;
    final picked = await showDatePicker(
      context: context,
      firstDate: first,
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      initialDate: _effectiveDate.isBefore(first) ? first : _effectiveDate,
    );
    if (picked != null) setState(() => _effectiveDate = picked);
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() != true) return;
    final l10n = AppLocalizations.of(context);
    if (_slots.any((slot) => slot.days.isEmpty)) {
      _warn(l10n.supplementsSelectWeekdayMessage);
      return;
    }
    if (_slots.length > _maxDoseSlots) {
      _warn(l10n.supplementsMaxDoseSlotsMessage);
      return;
    }
    final inputs = <SupplementDoseSlotInput>[];
    for (final slot in _slots) {
      final amount = double.tryParse(slot.amount.text.trim());
      if (amount == null ||
          amount <= 0 ||
          amount > _maxDoseAmount ||
          slot.unit.text.trim().isEmpty) {
        _warn(l10n.supplementsInvalidDoseMessage);
        return;
      }
      inputs.add(
        SupplementDoseSlotInput(
          amount: amount,
          unit: slot.unit.text,
          time: _wireTime(slot.time),
          daysOfWeek: slot.days.toList(growable: false),
        ),
      );
    }
    if (_hasOverlap(inputs)) {
      _warn(l10n.supplementsOverlapDoseMessage);
      return;
    }
    final input = SupplementRegimenInput(
      name: _name.text,
      brand: _brand.text,
      form: _form.text,
      instructions: _instructions.text,
      notes: _notes.text,
      effectiveDate: _effectiveDate,
      doseSlots: inputs,
    );
    final controller = ref.read(supplementMutationControllerProvider.notifier);
    final initial = widget.initial;
    final success = initial == null
        ? await controller.create(input, clientId: widget.clientId)
        : await controller.updateRegimen(
            initial.id,
            input,
            clientId: widget.clientId,
          );
    if (success && mounted) Navigator.pop(context, true);
  }

  /// Same rule the server enforces: two slots may share a time only when their
  /// weekdays are disjoint.
  bool _hasOverlap(List<SupplementDoseSlotInput> slots) {
    for (var i = 0; i < slots.length; i++) {
      for (var j = i + 1; j < slots.length; j++) {
        if (slots[i].time != slots[j].time) continue;
        if (slots[i].daysOfWeek.any(slots[j].daysOfWeek.contains)) return true;
      }
    }
    return false;
  }

  void _warn(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _EditableDoseSlot {
  _EditableDoseSlot({
    required this.amount,
    required this.unit,
    required this.time,
    required this.days,
  });

  factory _EditableDoseSlot.defaultValue() => _EditableDoseSlot(
    amount: TextEditingController(text: '1'),
    unit: TextEditingController(text: 'capsule'),
    time: const TimeOfDay(hour: 8, minute: 0),
    days: SupplementWeekday.values.toSet(),
  );

  factory _EditableDoseSlot.fromModel(SupplementDoseSlot slot) =>
      _EditableDoseSlot(
        amount: TextEditingController(text: _amount(slot.amount)),
        unit: TextEditingController(text: slot.unit),
        time: _parseTime(slot.time),
        days: slot.daysOfWeek.toSet(),
      );

  final Object key = Object();
  final TextEditingController amount;
  final TextEditingController unit;
  TimeOfDay time;
  final Set<SupplementWeekday> days;

  void dispose() {
    amount.dispose();
    unit.dispose();
  }
}

class _DoseSlotEditor extends StatelessWidget {
  const _DoseSlotEditor({
    required this.index,
    required this.slot,
    required this.onChanged,
    required this.onRemove,
    super.key,
  });

  final int index;
  final _EditableDoseSlot slot;
  final VoidCallback onChanged;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      key: ValueKey('dose-slot-card-$index'),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.surfaceBorderSoft),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.accentSoft,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${index + 1}',
                  style: AppTypography.mono(
                    13,
                    color: AppColors.accent,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _DoseTimeButton(
                  label: l10n.supplementsTimeLabel,
                  time: slot.time,
                  onTap: () => _pickTime(context),
                ),
              ),
              if (onRemove != null) ...[
                const SizedBox(width: AppSpacing.xs),
                IconButton(
                  tooltip: l10n.commonRemove,
                  onPressed: onRemove,
                  style: IconButton.styleFrom(
                    foregroundColor: AppColors.danger,
                    backgroundColor: AppColors.dangerBg,
                  ),
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: slot.amount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.supplementsAmountLabel,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: TextFormField(
                  controller: slot.unit,
                  maxLength: 30,
                  decoration: InputDecoration(
                    labelText: l10n.supplementsUnitLabel,
                    counterText: '',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.supplementsWeekdaysLabel,
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              for (
                var dayIndex = 0;
                dayIndex < SupplementWeekday.values.length;
                dayIndex++
              ) ...[
                if (dayIndex > 0) const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: _WeekdayButton(
                    key: ValueKey('dose-slot-day-$index-$dayIndex'),
                    label: _shortDay(
                      context,
                      SupplementWeekday.values[dayIndex],
                    ),
                    selected: slot.days.contains(
                      SupplementWeekday.values[dayIndex],
                    ),
                    onSelected: (selected) {
                      final day = SupplementWeekday.values[dayIndex];
                      selected ? slot.days.add(day) : slot.days.remove(day);
                      onChanged();
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: slot.time,
    );
    if (picked != null) {
      slot.time = picked;
      onChanged();
    }
  }
}

class _DoseTimeButton extends StatelessWidget {
  const _DoseTimeButton({
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showLabel = constraints.maxWidth >= 180;
        final formattedTime = time.format(context);
        return Semantics(
          button: true,
          label: '$label $formattedTime',
          child: ExcludeSemantics(
            child: Material(
              color: AppColors.bg3.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 42),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          size: 18,
                          color: AppColors.accent,
                        ),
                        if (showLabel) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            label,
                            style: const TextStyle(
                              color: AppColors.fg3,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        const Spacer(),
                        Text(
                          formattedTime,
                          style: AppTypography.mono(
                            14,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WeekdayButton extends StatelessWidget {
  const _WeekdayButton({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? AppColors.accent2Soft : AppColors.bgPage,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          side: BorderSide(
            color: selected ? AppColors.sage500 : AppColors.surfaceBorderSoft,
          ),
        ),
        child: InkWell(
          onTap: () => onSelected(!selected),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: SizedBox(
            height: 38,
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  color: selected ? AppColors.sage700 : AppColors.fg3,
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
        child: Column(
          children: [
            Icon(icon, size: 36, color: AppColors.fg3),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.fg1,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.fg3),
            ),
          ],
        ),
      ),
    );
  }
}

/// Server-side dose-slot limits, mirrored so invalid input never round-trips.
const _maxDoseSlots = 20;
const _maxDoseAmount = 1000000.0;

/// A 403 here means a coach without Pro is looking at client data — offer the
/// upgrade instead of a retry that can never succeed.
Widget _errorPanel(
  BuildContext context,
  Object error,
  VoidCallback onRetry,
) => SizedBox(
  height: 420,
  child: error is ForbiddenFailure
      ? ProLockedView(
          title: AppLocalizations.of(context).supplementsProFeatureTitle,
          message: error.message,
          onUpgrade: () => context.push('/subscription'),
        )
      : ErrorView.from(error, context, onRetry: onRetry),
);

/// Returns the entered note ('' clears it), or null when dismissed.
Future<String?> _promptNote(BuildContext context, {String? initial}) =>
    showDialog<String>(
      context: context,
      builder: (_) => _NoteDialog(initial: initial),
    );

/// Owns the note field's controller for exactly as long as the dialog is
/// mounted. Disposing it right after `showDialog` completes is too early — the
/// route is still running its exit animation with the field alive.
class _NoteDialog extends StatefulWidget {
  const _NoteDialog({this.initial});

  final String? initial;

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.supplementsNoteTitle),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 300,
        maxLines: 3,
        decoration: InputDecoration(hintText: l10n.supplementsNoteHint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}

void _showMutationError(BuildContext context, WidgetRef ref) {
  final error = ref.read(supplementMutationControllerProvider).error;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$error')));
}

String _shortTime(String value) =>
    value.length >= 5 ? value.substring(0, 5) : value;

String _amount(double value) =>
    value == value.roundToDouble() ? value.toInt().toString() : '$value';

String _wireTime(TimeOfDay time) =>
    '${time.hour.toString().padLeft(2, '0')}:'
    '${time.minute.toString().padLeft(2, '0')}:00';

TimeOfDay _parseTime(String value) {
  final parts = value.split(':');
  return TimeOfDay(
    hour: int.tryParse(parts.first) ?? 8,
    minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
  );
}

String _statusLabel(
  SupplementDoseStatus status,
  AppLocalizations l10n,
) => switch (status) {
  SupplementDoseStatus.pending => l10n.supplementsStatusPending,
  SupplementDoseStatus.taken => l10n.supplementsStatusTaken,
  SupplementDoseStatus.skipped => l10n.supplementsStatusSkipped,
  SupplementDoseStatus.missed => l10n.supplementsStatusMissed,
};

XnChipTone _statusTone(SupplementDoseStatus status) => switch (status) {
  SupplementDoseStatus.pending => XnChipTone.neutral,
  SupplementDoseStatus.taken => XnChipTone.sage,
  SupplementDoseStatus.skipped => XnChipTone.info,
  SupplementDoseStatus.missed => XnChipTone.warn,
};

String _shortDay(BuildContext context, SupplementWeekday day) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  final sunday = DateTime(2026, 7, 19);
  return DateFormat.E(locale).format(sunday.add(Duration(days: day.index)));
}

String _daysLabel(
  BuildContext context,
  List<SupplementWeekday> days,
) {
  final l10n = AppLocalizations.of(context);
  if (days.length == SupplementWeekday.values.length) {
    return l10n.supplementsEveryDayLabel;
  }
  return days.map((day) => _shortDay(context, day)).join(', ');
}
