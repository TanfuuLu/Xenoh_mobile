import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/xn_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../shared_api/xenoh_api.dart';
import '../domain/challenge_models.dart';
import 'challenge_providers.dart';

class CreateChallengeScreen extends ConsumerStatefulWidget {
  const CreateChallengeScreen({super.key});

  @override
  ConsumerState<CreateChallengeScreen> createState() =>
      _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends ConsumerState<CreateChallengeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _prompt = TextEditingController();
  var _metric = 'TrainingSessions';
  var _access = 'Connections';
  var _target = 3;
  var _capacity = 10;
  var _start = DateTime.now().add(const Duration(days: 1));
  var _end = DateTime.now().add(const Duration(days: 8));
  final _lifts = <String>{'Squat', 'Bench', 'Deadlift'};
  var _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _prompt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.challengesCreate)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            TextFormField(
              controller: _title,
              maxLength: 80,
              decoration: InputDecoration(labelText: l10n.challengeTitleLabel),
              validator: (value) => (value?.trim().length ?? 0) < 3
                  ? l10n.challengeTitleValidation
                  : null,
            ),
            TextFormField(
              controller: _description,
              maxLength: 1000,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.challengeDescriptionLabel,
              ),
            ),
            DropdownButtonFormField<String>(
              initialValue: _metric,
              decoration: InputDecoration(labelText: l10n.challengeMetricLabel),
              items: const [
                DropdownMenuItem(
                  value: 'TrainingSessions',
                  child: Text('Training sessions'),
                ),
                DropdownMenuItem(
                  value: 'TrainingStreak',
                  child: Text('Training streak'),
                ),
                DropdownMenuItem(
                  value: 'SbdImprovement',
                  child: Text('SBD improvement'),
                ),
                DropdownMenuItem(
                  value: 'CustomCheckIns',
                  child: Text('Custom check-ins'),
                ),
              ],
              onChanged: (value) => setState(() => _metric = value!),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _access,
              decoration: InputDecoration(labelText: l10n.challengeAccessLabel),
              items: const [
                DropdownMenuItem(
                  value: 'InviteOnly',
                  child: Text('Invite only'),
                ),
                DropdownMenuItem(
                  value: 'Connections',
                  child: Text('Connections'),
                ),
                DropdownMenuItem(value: 'Community', child: Text('Community')),
              ],
              onChanged: (value) => setState(() => _access = value!),
            ),
            if (_metric == 'TrainingSessions') ...[
              const SizedBox(height: AppSpacing.md),
              _IntSelector(
                label: l10n.challengeWeeklyTarget,
                value: _target,
                min: 1,
                max: 7,
                onChanged: (value) => setState(() => _target = value),
              ),
            ],
            if (_metric == 'SbdImprovement') ...[
              const SizedBox(height: AppSpacing.md),
              Wrap(
                children: [
                  for (final lift in const ['Squat', 'Bench', 'Deadlift'])
                    FilterChip(
                      label: Text(lift),
                      selected: _lifts.contains(lift),
                      onSelected: (selected) => setState(() {
                        selected ? _lifts.add(lift) : _lifts.remove(lift);
                      }),
                    ),
                ],
              ),
            ],
            if (_metric == 'CustomCheckIns') ...[
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _prompt,
                maxLength: 160,
                decoration: InputDecoration(
                  labelText: l10n.challengeCheckInPrompt,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            _IntSelector(
              label: l10n.challengeCapacity,
              value: _capacity,
              min: 2,
              max: 25,
              onChanged: (value) => setState(() => _capacity = value),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.challengeStartDate),
              subtitle: Text(_start.toLocal().toString().split(' ').first),
              onTap: () => _pickDate(start: true),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.challengeEndDate),
              subtitle: Text(_end.toLocal().toString().split(' ').first),
              onTap: () => _pickDate(start: false),
            ),
            const SizedBox(height: AppSpacing.xl),
            XnButton(
              label: l10n.challengesCreate,
              loading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate({required bool start}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: start ? _start : _end,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    setState(() {
      final value = DateTime(picked.year, picked.month, picked.day, 9);
      if (start) {
        _start = value;
        if (_end.isBefore(_start.add(const Duration(days: 1)))) {
          _end = _start.add(const Duration(days: 7));
        }
      } else {
        _end = value;
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final input = ChallengeInput(
      title: _title.text.trim(),
      description: _description.text.trim(),
      metricType: _metric,
      accessType: _access,
      targetSessionsPerWeek: _metric == 'TrainingSessions' ? _target : 0,
      selectedLifts: _metric == 'SbdImprovement' ? _lifts.toList() : const [],
      checkInPrompt: _metric == 'CustomCheckIns' ? _prompt.text.trim() : null,
      capacity: _capacity,
      startsAtUtc: _start.toUtc(),
      endsAtUtc: _end.toUtc(),
    );
    try {
      await ref.read(challengeRepositoryProvider).create(input);
      ref
        ..invalidate(myChallengesProvider)
        ..invalidate(discoverChallengesProvider);
      if (mounted) Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _IntSelector extends StatelessWidget {
  const _IntSelector({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(label)),
      IconButton(
        onPressed: value > min ? () => onChanged(value - 1) : null,
        icon: const Icon(Icons.remove),
      ),
      Text('$value'),
      IconButton(
        onPressed: value < max ? () => onChanged(value + 1) : null,
        icon: const Icon(Icons.add),
      ),
    ],
  );
}
