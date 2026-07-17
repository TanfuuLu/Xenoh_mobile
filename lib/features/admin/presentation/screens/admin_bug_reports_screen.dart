import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

const _statuses = ['', 'Open', 'InProgress', 'Resolved', 'Dismissed'];
const _severities = ['', 'Low', 'Medium', 'High', 'Critical'];

String _statusLabel(String value, AppLocalizations l10n) => switch (value) {
  'Open' => l10n.adminBugStatusOpen,
  'InProgress' => l10n.adminBugStatusInProgress,
  'Resolved' => l10n.adminBugStatusResolved,
  'Dismissed' => l10n.adminBugStatusDismissed,
  _ => value,
};

String _severityLabel(String value, AppLocalizations l10n) => switch (value) {
  'Low' => l10n.reportBugSeverityLow,
  'Medium' => l10n.reportBugSeverityMedium,
  'High' => l10n.reportBugSeverityHigh,
  'Critical' => l10n.reportBugSeverityCritical,
  _ => value,
};

typedef AdminBugReportFilters = ({String status, String severity});

final adminBugReportsProvider = FutureProvider.autoDispose
    .family<List<JsonMap>, AdminBugReportFilters>((
      ref,
      filters,
    ) {
      final params = <String>[
        if (filters.status.isNotEmpty) 'status=${filters.status}',
        if (filters.severity.isNotEmpty) 'severity=${filters.severity}',
      ];
      final query = params.isEmpty ? '' : '?${params.join('&')}';
      return ref.watch(xenohApiProvider).getList('/admin/bug-reports$query');
    });

class AdminBugReportsScreen extends ConsumerStatefulWidget {
  const AdminBugReportsScreen({super.key});

  @override
  ConsumerState<AdminBugReportsScreen> createState() =>
      _AdminBugReportsScreenState();
}

class _AdminBugReportsScreenState extends ConsumerState<AdminBugReportsScreen> {
  var _filters = (status: 'Open', severity: '');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reports = ref.watch(adminBugReportsProvider(_filters));

    return FeatureScreenFrame(
      title: l10n.adminBugReportsTitle,
      onRefresh: () => ref.refresh(adminBugReportsProvider(_filters).future),
      children: [
        FeatureHeader(
          title: l10n.adminBugReportsTitle,
          subtitle: l10n.adminBugReportsSubtitle,
          icon: Icons.bug_report_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        XnCard(
          child: Column(
            children: [
              _FilterDropdown(
                label: l10n.adminStatusLabel,
                value: _filters.status,
                values: _statuses,
                labelOf: (v) => _statusLabel(v, l10n),
                onChanged: (value) {
                  setState(() {
                    _filters = (status: value, severity: _filters.severity);
                  });
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _FilterDropdown(
                label: l10n.reportBugSeverityLabel,
                value: _filters.severity,
                values: _severities,
                labelOf: (v) => _severityLabel(v, l10n),
                onChanged: (value) {
                  setState(() {
                    _filters = (status: _filters.status, severity: value);
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (reports) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.adminNoBugReportsTitle,
            message: l10n.adminNoBugReportsMessage,
            icon: Icons.bug_report_outlined,
          ),
          AsyncData(:final value) => XnSectionList(
            children: [
              for (final item in value)
                _BugReportCard(item: item, filters: _filters),
            ],
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(adminBugReportsProvider(_filters)),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.labelOf,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> values;
  final String Function(String value) labelOf;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnDropdown<String>(
      label: label,
      value: value,
      options: [
        for (final item in values)
          XnDropdownOption(
            value: item,
            label: item.isEmpty ? l10n.adminAllFilterLabel : labelOf(item),
          ),
      ],
      onChanged: (value) => onChanged(value ?? ''),
    );
  }
}

class _BugReportCard extends ConsumerStatefulWidget {
  const _BugReportCard({required this.item, required this.filters});

  final JsonMap item;
  final AdminBugReportFilters filters;

  @override
  ConsumerState<_BugReportCard> createState() => _BugReportCardState();
}

class _BugReportCardState extends ConsumerState<_BugReportCard> {
  late final TextEditingController _noteController;
  var _submitting = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(
      text: optionalTextOf(widget.item, ['adminNote']) ?? '',
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _review(String status) async {
    setState(() => _submitting = true);
    try {
      await ref.read(xenohApiProvider).patchObject(
        '/admin/bug-reports/${widget.item['id']}',
        {
          'status': status,
          'adminNote': _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        },
      );
      ref.invalidate(adminBugReportsProvider(widget.filters));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final item = widget.item;
    final severity = textOf(item, ['severity']);
    final isCritical = severity == 'Critical';

    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.bug_report_outlined,
                color: isCritical ? AppColors.danger : AppColors.fg3,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textOf(item, ['title']),
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${textOf(item, ['userName'])} - ${textOf(item, ['userEmail'])}',
                      style: const TextStyle(color: AppColors.fg3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            textOf(item, ['description']),
            style: const TextStyle(color: AppColors.fg2, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.md),
          KeyValueGrid(
            items: {
              l10n.reportBugSeverityLabel: _severityLabel(severity, l10n),
              l10n.adminStatusLabel: _statusLabel(
                textOf(item, ['status']),
                l10n,
              ),
              l10n.adminScreenLabel: textOf(item, ['pageUrl']),
              l10n.adminDeviceLabel: textOf(item, ['browserInfo']),
            },
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _noteController,
            enabled: !_submitting,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: l10n.adminNoteLabel,
              hintText: l10n.adminNoteHint,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _ReviewButton(
                label: l10n.adminInProgressAction,
                icon: Icons.pending_actions_outlined,
                disabled: _submitting,
                onPressed: () => _review('InProgress'),
              ),
              _ReviewButton(
                label: l10n.adminResolveAction,
                icon: Icons.check_circle_outline,
                disabled: _submitting,
                onPressed: () => _review('Resolved'),
              ),
              _ReviewButton(
                label: l10n.adminDismissAction,
                icon: Icons.cancel_outlined,
                disabled: _submitting,
                onPressed: () => _review('Dismissed'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewButton extends StatelessWidget {
  const _ReviewButton({
    required this.label,
    required this.icon,
    required this.disabled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool disabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: disabled ? null : onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
