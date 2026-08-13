import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/competition_models.dart';
import 'competition_labels.dart';
import 'competition_providers.dart';

class OrganizerEventManageScreen extends ConsumerWidget {
  const OrganizerEventManageScreen({
    required this.eventId,
    required this.slug,
    super.key,
  });

  final String eventId;
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final detail = ref.watch(competitionDetailProvider(slug));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.organizerManageEvent),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: l10n.organizerOverviewTab),
              Tab(text: l10n.organizerCategoriesTab),
              Tab(text: l10n.organizerStaffTab),
            ],
          ),
        ),
        body: AsyncValueView(
          value: detail,
          onRetry: () => ref.invalidate(competitionDetailProvider(slug)),
          data: (event) => TabBarView(
            children: [
              _OverviewTab(event: event),
              _CategoriesTab(event: event),
              _StaffTab(eventId: eventId),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewTab extends ConsumerWidget {
  const _OverviewTab({required this.event});
  final CompetitionEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          decoration: BoxDecoration(
            color: AppColors.clay100,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  Chip(
                    label: Text(
                      competitionEventStatusLabel(l10n, event.status),
                    ),
                  ),
                  Chip(
                    label: Text(
                      competitionDisciplineLabel(l10n, event.discipline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                event.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(event.description),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        XnCard(
          child: Column(
            children: [
              _FactRow(
                icon: Icons.location_on_outlined,
                value: '${event.venueName} · ${event.address}',
              ),
              _FactRow(
                icon: Icons.schedule_outlined,
                value:
                    '${_date(event.startsAtUtc)} — ${_date(event.endsAtUtc)}',
              ),
              _FactRow(
                icon: Icons.groups_outlined,
                value: '${event.confirmedCount}/${event.capacity}',
              ),
              _FactRow(
                icon: Icons.payments_outlined,
                value:
                    '${event.registrationFee.toStringAsFixed(0)} ${event.currency}',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            FilledButton.tonalIcon(
              onPressed: () => _edit(context, ref),
              icon: const Icon(Icons.edit_outlined),
              label: Text(l10n.organizerEditEvent),
            ),
            if (event.status == 'Draft')
              FilledButton.icon(
                onPressed: () => _publish(context, ref),
                icon: const Icon(Icons.publish_rounded),
                label: Text(l10n.organizerPublish),
              ),
            if (event.status == 'Published')
              FilledButton.tonalIcon(
                onPressed: () => _closeRegistration(context, ref),
                icon: const Icon(Icons.lock_clock_outlined),
                label: Text(l10n.organizerCloseRegistration),
              ),
            if (event.status != 'Completed' && event.status != 'Cancelled')
              OutlinedButton.icon(
                onPressed: () => _cancel(context, ref),
                icon: const Icon(Icons.event_busy_outlined),
                label: Text(l10n.organizerCancelEvent),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxl),
        OutlinedButton.icon(
          onPressed: event.status == 'Draft'
              ? () => _delete(context, ref)
              : null,
          icon: const Icon(Icons.delete_outline_rounded),
          label: Text(l10n.organizerDeleteEvent),
        ),
      ],
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => _EditEventDialog(event: event),
    );
    if (saved == true) {
      ref
        ..invalidate(competitionDetailProvider(event.slug))
        ..invalidate(managedCompetitionsProvider);
    }
  }

  Future<void> _publish(BuildContext context, WidgetRef ref) async {
    await ref.read(competitionRepositoryProvider).publishEvent(event.id);
    ref
      ..invalidate(competitionDetailProvider(event.slug))
      ..invalidate(managedCompetitionsProvider);
    if (context.mounted) {
      _message(context, AppLocalizations.of(context).organizerEventPublished);
    }
  }

  Future<void> _closeRegistration(
    BuildContext context,
    WidgetRef ref,
  ) async {
    await ref.read(competitionRepositoryProvider).closeRegistration(event.id);
    ref
      ..invalidate(competitionDetailProvider(event.slug))
      ..invalidate(managedCompetitionsProvider);
    if (context.mounted) {
      _message(
        context,
        AppLocalizations.of(context).organizerRegistrationClosed,
      );
    }
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final reason = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.organizerCancelEvent),
        content: TextField(
          controller: reason,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(labelText: l10n.organizerCancelReason),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () {
              if (reason.text.trim().isNotEmpty) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: Text(l10n.organizerCancelEvent),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(competitionRepositoryProvider)
          .cancelEvent(event.id, reason.text.trim());
      ref
        ..invalidate(competitionDetailProvider(event.slug))
        ..invalidate(managedCompetitionsProvider);
      if (context.mounted) _message(context, l10n.organizerEventCancelled);
    }
    reason.dispose();
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.organizerDeleteEvent),
        content: Text(event.title),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(competitionRepositoryProvider).deleteEvent(event.id);
      ref.invalidate(managedCompetitionsProvider);
      if (context.mounted) {
        _message(context, l10n.organizerEventDeleted);
        context.pop();
      }
    }
  }
}

class _CategoriesTab extends ConsumerWidget {
  const _CategoriesTab({required this.event});
  final CompetitionEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        FilledButton.icon(
          onPressed: () => _add(context, ref),
          icon: const Icon(Icons.add_rounded),
          label: Text(l10n.organizerAddCategory),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (event.categories.isEmpty)
          _PanelMessage(
            icon: Icons.layers_clear_outlined,
            message: l10n.organizerNoCategories,
          ),
        for (final category in event.categories) ...[
          XnCard(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.clay100,
                  child: Text(category.code.isEmpty ? '?' : category.code[0]),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text('${category.code} · ${category.capacity}'),
                      if (category.eligibilityNotes?.isNotEmpty == true)
                        Text(category.eligibilityNotes!),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.commonDelete,
                  onPressed: () => _remove(context, ref, category),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<_CategoryDraft>(
      context: context,
      builder: (_) => const _CategoryDialog(),
    );
    if (result == null) return;
    await ref
        .read(competitionRepositoryProvider)
        .addCategory(
          event.id,
          code: result.code,
          name: result.name,
          capacity: result.capacity,
          displayOrder: event.categories.length,
        );
    ref.invalidate(competitionDetailProvider(event.slug));
    if (context.mounted) {
      _message(context, AppLocalizations.of(context).organizerCategoryAdded);
    }
  }

  Future<void> _remove(
    BuildContext context,
    WidgetRef ref,
    CompetitionCategory category,
  ) async {
    await ref
        .read(competitionRepositoryProvider)
        .deleteCategory(event.id, category.id);
    ref.invalidate(competitionDetailProvider(event.slug));
    if (context.mounted) {
      _message(context, AppLocalizations.of(context).organizerCategoryRemoved);
    }
  }
}

class _StaffTab extends ConsumerStatefulWidget {
  const _StaffTab({required this.eventId});
  final String eventId;

  @override
  ConsumerState<_StaffTab> createState() => _StaffTabState();
}

class _StaffTabState extends ConsumerState<_StaffTab> {
  static const _available = [
    'ManageEvent',
    'ManageCategories',
    'ReviewRegistrations',
    'ReviewPayments',
    'ManageResults',
    'ManageStaff',
  ];
  final _userId = TextEditingController();
  final _selected = <String>{'ReviewRegistrations'};
  bool _saving = false;

  @override
  void dispose() {
    _userId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        XnCard(
          color: AppColors.sage100,
          child: Row(
            children: [
              const Icon(Icons.security_rounded, color: AppColors.sage700),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(l10n.organizerStaffPermissions)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: _userId,
          decoration: InputDecoration(
            labelText: l10n.organizerStaffUserId,
            prefixIcon: const Icon(Icons.badge_outlined),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final permission in _available)
          CheckboxListTile(
            value: _selected.contains(permission),
            title: Text(organizerPermissionLabel(l10n, permission)),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (checked) => setState(() {
              if (checked == true) {
                _selected.add(permission);
              } else {
                _selected.remove(permission);
              }
            }),
          ),
        const SizedBox(height: AppSpacing.md),
        FilledButton.icon(
          onPressed: _saving ? null : _save,
          icon: const Icon(Icons.save_outlined),
          label: Text(l10n.organizerSaveStaff),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: _saving ? null : _remove,
          icon: const Icon(Icons.person_remove_outlined),
          label: Text(l10n.organizerRemoveStaff),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    if (_userId.text.trim().isEmpty || _selected.isEmpty) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(competitionRepositoryProvider)
          .setStaff(
            widget.eventId,
            _userId.text.trim(),
            _selected.toList(),
          );
      if (mounted) _message(context, l10n.organizerStaffSaved);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _remove() async {
    final l10n = AppLocalizations.of(context);
    if (_userId.text.trim().isEmpty) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(competitionRepositoryProvider)
          .removeStaff(widget.eventId, _userId.text.trim());
      if (mounted) _message(context, l10n.organizerStaffRemoved);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _EditEventDialog extends ConsumerStatefulWidget {
  const _EditEventDialog({required this.event});
  final CompetitionEvent event;

  @override
  ConsumerState<_EditEventDialog> createState() => _EditEventDialogState();
}

class _EditEventDialogState extends ConsumerState<_EditEventDialog> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _venue;
  late final TextEditingController _address;
  late final TextEditingController _capacity;
  late final TextEditingController _fee;
  late final TextEditingController _currency;
  late final TextEditingController _contact;
  late DateTime _starts;
  late DateTime _ends;
  late DateTime _registrationOpens;
  late DateTime _registrationCloses;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final event = widget.event;
    _title = TextEditingController(text: event.title);
    _description = TextEditingController(text: event.description);
    _venue = TextEditingController(text: event.venueName);
    _address = TextEditingController(text: event.address);
    _capacity = TextEditingController(text: '${event.capacity}');
    _fee = TextEditingController(text: '${event.registrationFee}');
    _currency = TextEditingController(text: event.currency);
    _contact = TextEditingController(text: event.organizerContact);
    _starts = event.startsAtUtc;
    _ends = event.endsAtUtc;
    _registrationOpens = event.registrationOpensAtUtc ?? DateTime.now();
    _registrationCloses = event.registrationClosesAtUtc ?? event.startsAtUtc;
  }

  @override
  void dispose() {
    for (final controller in [
      _title,
      _description,
      _venue,
      _address,
      _capacity,
      _fee,
      _currency,
      _contact,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.organizerEditEvent),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field(_title, l10n.competitionTitleLabel),
              _field(_description, l10n.organizerEventDescription, lines: 3),
              _field(_venue, l10n.organizerVenueName),
              _field(_address, l10n.organizerAddress),
              _dateTile(
                l10n.organizerStartsAt,
                _starts,
                (value) => _starts = value,
              ),
              _dateTile(l10n.organizerEndsAt, _ends, (value) => _ends = value),
              _dateTile(
                l10n.organizerRegistrationOpens,
                _registrationOpens,
                (value) => _registrationOpens = value,
              ),
              _dateTile(
                l10n.organizerRegistrationCloses,
                _registrationCloses,
                (value) => _registrationCloses = value,
              ),
              _field(_capacity, l10n.organizerCapacity, numeric: true),
              _field(_fee, l10n.organizerRegistrationFee, numeric: true),
              _field(_currency, l10n.organizerCurrency),
              _field(_contact, l10n.organizerContactEmail),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context, false),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int lines = 1,
    bool numeric = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: TextField(
      controller: controller,
      maxLines: lines,
      keyboardType: numeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      decoration: InputDecoration(labelText: label),
    ),
  );

  Widget _dateTile(
    String label,
    DateTime value,
    ValueChanged<DateTime> onChanged,
  ) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const Icon(Icons.calendar_month_outlined),
    title: Text(label),
    subtitle: Text(_date(value)),
    onTap: () async {
      final selected = await showDatePicker(
        context: context,
        initialDate: value.toLocal(),
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 3650)),
      );
      if (selected != null) {
        setState(() {
          onChanged(
            DateTime(
              selected.year,
              selected.month,
              selected.day,
              value.hour,
              value.minute,
            ).toUtc(),
          );
        });
      }
    },
  );

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final capacity = int.tryParse(_capacity.text);
    final fee = double.tryParse(_fee.text);
    if (_title.text.trim().isEmpty || capacity == null || fee == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(competitionRepositoryProvider)
          .updateEvent(
            widget.event.id,
            CompetitionEventInput(
              title: _title.text.trim(),
              description: _description.text.trim(),
              bannerUrl: null,
              discipline: widget.event.discipline,
              venueName: _venue.text.trim(),
              address: _address.text.trim(),
              timeZoneId: widget.event.timeZoneId,
              startsAtUtc: _starts,
              endsAtUtc: _ends,
              registrationOpensAtUtc: _registrationOpens,
              registrationClosesAtUtc: _registrationCloses,
              capacity: capacity,
              registrationFee: fee,
              currency: _currency.text.trim(),
              organizerContact: _contact.text.trim(),
              bankName: widget.event.bankName,
              bankAccountNumber: widget.event.bankAccountNumber,
              bankAccountName: widget.event.bankAccountName,
              transferInstructions: widget.event.transferInstructions,
              powerliftingScoringFormula:
                  widget.event.powerliftingScoringFormula,
            ),
          );
      if (mounted) {
        _message(context, l10n.organizerEventUpdated);
        Navigator.pop(context, true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _CategoryDialog extends StatefulWidget {
  const _CategoryDialog();

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _capacity = TextEditingController(text: '50');

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _capacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.organizerAddCategory),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _code,
            decoration: InputDecoration(labelText: l10n.organizerCategoryCode),
          ),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: l10n.organizerCategoryName),
          ),
          TextField(
            controller: _capacity,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: l10n.organizerCapacity),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () {
            final capacity = int.tryParse(_capacity.text);
            if (_code.text.trim().isNotEmpty &&
                _name.text.trim().isNotEmpty &&
                capacity != null &&
                capacity > 0) {
              Navigator.pop(
                context,
                _CategoryDraft(
                  code: _code.text.trim().toUpperCase(),
                  name: _name.text.trim(),
                  capacity: capacity,
                ),
              );
            }
          },
          child: Text(l10n.organizerAddCategory),
        ),
      ],
    );
  }
}

class _CategoryDraft {
  const _CategoryDraft({
    required this.code,
    required this.name,
    required this.capacity,
  });
  final String code;
  final String name;
  final int capacity;
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.icon, required this.value});
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    child: Row(
      children: [
        Icon(icon, color: AppColors.clay800),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

class _PanelMessage extends StatelessWidget {
  const _PanelMessage({required this.icon, required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpacing.xxl),
    child: Column(
      children: [
        Icon(icon, size: 44, color: AppColors.fg3),
        const SizedBox(height: AppSpacing.md),
        Text(message, textAlign: TextAlign.center),
      ],
    ),
  );
}

String _date(DateTime value) {
  final local = value.toLocal();
  return '${local.day.toString().padLeft(2, '0')}/${local.month.toString().padLeft(2, '0')}/${local.year}';
}

void _message(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
