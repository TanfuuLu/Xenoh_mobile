import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/repositories/profile_background_repository.dart';
import '../../data/repositories/profile_repository_provider.dart';
import '../../domain/entities/bodyweight_log.dart';
import '../../domain/entities/training_activity.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/preferences_provider.dart';
import '../providers/profile_controller.dart';
import '../widgets/background_position_picker.dart';
import '../widgets/bodyweight_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late DateTime _calendarMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );

  void _shiftMonth(int delta) {
    setState(() {
      _calendarMonth = DateTime(
        _calendarMonth.year,
        _calendarMonth.month + delta,
      );
    });
  }

  void _showHistory(List<BodyweightLog> logs) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.bgPage,
        showDragHandle: true,
        builder: (_) => _BodyweightHistorySheet(
          logs: logs,
          unit: ref.read(weightUnitProvider),
          onDelete: _deleteBodyweightLog,
        ),
      ),
    );
  }

  Future<void> _deleteBodyweightLog(String id) async {
    try {
      await ref.read(profileRepositoryProvider).deleteBodyweightLog(id);
      ref.invalidate(bodyweightHistoryProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  Future<void> _uploadAvatar() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 88,
    );
    if (image == null) return;
    try {
      await ref
          .read(myProfileControllerProvider.notifier)
          .uploadAvatar(image.path);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).profileAvatarUpdatedSnackbar,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  Future<void> _showBackgroundActions(UserProfile profile) async {
    final l10n = AppLocalizations.of(context);
    final action = await showModalBottomSheet<_BackgroundAction>(
      context: context,
      backgroundColor: AppColors.bgPage,
      showDragHandle: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(l10n.profileChooseBackgroundImage),
                onTap: () => Navigator.pop(
                  context,
                  _BackgroundAction.change,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.restore_rounded),
                title: Text(l10n.profileUseDefaultBackground),
                onTap: () => Navigator.pop(
                  context,
                  _BackgroundAction.remove,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (action == _BackgroundAction.change) {
      await _changeBackground(profile);
    } else if (action == _BackgroundAction.remove) {
      await _removeBackground(profile);
    }
  }

  Future<void> _changeBackground(UserProfile profile) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 2400,
      imageQuality: 88,
    );
    if (image == null) return;
    if (!mounted) return;

    final alignment = await Navigator.of(context).push<Alignment>(
      MaterialPageRoute(
        builder: (_) => BackgroundPositionPicker(imagePath: image.path),
      ),
    );
    if (alignment == null) return;

    try {
      await ref
          .read(profileBackgroundRepositoryProvider)
          .saveFromPath(
            userId: profile.id,
            sourcePath: image.path,
            alignment: alignment,
          );
      ref
        ..invalidate(profileBackgroundPathProvider(profile.id))
        ..invalidate(
          profileBackgroundPathProvider(ProfileBackgroundRepository.deviceKey),
        )
        ..invalidate(profileBackgroundAlignmentProvider(profile.id))
        ..invalidate(
          profileBackgroundAlignmentProvider(
            ProfileBackgroundRepository.deviceKey,
          ),
        );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).profilePreferencesBackgroundUpdated,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  Future<void> _removeBackground(UserProfile profile) async {
    try {
      await ref.read(profileBackgroundRepositoryProvider).clear(profile.id);
      ref
        ..invalidate(profileBackgroundPathProvider(profile.id))
        ..invalidate(
          profileBackgroundPathProvider(ProfileBackgroundRepository.deviceKey),
        )
        ..invalidate(profileBackgroundAlignmentProvider(profile.id))
        ..invalidate(
          profileBackgroundAlignmentProvider(
            ProfileBackgroundRepository.deviceKey,
          ),
        );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).profileBackgroundResetSnackbar,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(myProfileControllerProvider);
    final activity = ref.watch(
      trainingActivityProvider(
        year: _calendarMonth.year,
        month: _calendarMonth.month,
      ),
    );
    final bodyweight = ref.watch(bodyweightHistoryProvider);
    final unit = ref.watch(weightUnitProvider);
    final latestWeight =
        bodyweight.value?.lastOrNull?.weight ?? profile.value?.latestBodyweight;
    final backgroundPath = profile.value == null
        ? null
        : ref.watch(profileBackgroundPathProvider(profile.value!.id)).value;
    final backgroundAlignment = profile.value == null
        ? Alignment.center
        : ref
                  .watch(profileBackgroundAlignmentProvider(profile.value!.id))
                  .value ??
              Alignment.center;

    return Scaffold(
      appBar: AppBar(
        leading: const HomeShellMenuButton(),
        title: Text(l10n.profileAccountProfile),
        actions: [
          IconButton(
            tooltip: l10n.settingsTitle,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          await ref.read(myProfileControllerProvider.notifier).refresh();
          ref.invalidate(
            trainingActivityProvider(
              year: _calendarMonth.year,
              month: _calendarMonth.month,
            ),
          );
        },
        child: AsyncValueView(
          value: profile,
          onRetry: () => ref.invalidate(myProfileControllerProvider),
          data: (data) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              96,
            ),
            children: [
              _ProfileHeader(
                profile: data,
                backgroundImagePath: backgroundPath,
                backgroundAlignment: backgroundAlignment,
                onChangeBackground: () => _showBackgroundActions(data),
                onChangeAvatar: _uploadAvatar,
                onEditProfile: () => context.push('/profile/edit', extra: data),
              ),
              const SizedBox(height: AppSpacing.md),
              _LevelCard(
                profile: data,
                latestWeight: latestWeight,
                unit: unit,
                onShowHistory: bodyweight.value?.isNotEmpty ?? false
                    ? () => _showHistory(bodyweight.value!)
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),
              XnSectionGroup(
                children: [
                  _DetailsCard(profile: data),
                  const XnSectionDivider(),
                  XnSection(
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _TotalCard(
                              icon: Icons.schedule_rounded,
                              label: l10n.profileTotalTrainedTimeLabel,
                              value: activity.value == null ? '00:00:00' : null,
                              animatedValue: activity
                                  .value
                                  ?.totalDurationSeconds
                                  .toDouble(),
                              formatter: formatAnimatedDuration,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xl),
                          Expanded(
                            child: _TotalCard(
                              icon: Icons.fitness_center_rounded,
                              label: l10n.profileTotalWeightLabel,
                              value: activity.value == null
                                  ? '— ${unit.suffix}'
                                  : null,
                              animatedValue: activity.value == null
                                  ? null
                                  : unit.fromKg(
                                      activity.value!.totalWeightTrainedKg,
                                    ),
                              formatter: (value) =>
                                  '${formatWeight(value)} ${unit.suffix}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const XnSectionDivider(),
                  _CalendarCard(
                    month: _calendarMonth,
                    activity: activity,
                    onPrev: () => _shiftMonth(-1),
                    onNext: () => _shiftMonth(1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _BackgroundAction { change, remove }

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.profile,
    this.backgroundImagePath,
    this.backgroundAlignment = Alignment.center,
    this.onChangeBackground,
    this.onChangeAvatar,
    this.onEditProfile,
  });

  final UserProfile profile;
  final String? backgroundImagePath;
  final Alignment backgroundAlignment;
  final VoidCallback? onChangeBackground;
  final VoidCallback? onChangeAvatar;
  final VoidCallback? onEditProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final avatar = profile.avatarUrl;
    final hasAvatar = avatar != null && avatar.isNotEmpty;
    final backgroundFile = backgroundImagePath == null
        ? null
        : File(backgroundImagePath!);
    final hasBackground = backgroundFile != null && backgroundFile.existsSync();
    final primaryColor = hasBackground ? AppColors.fgOnClay : AppColors.fg1;
    final secondaryColor = hasBackground
        ? AppColors.fgOnClay.withValues(alpha: 0.78)
        : AppColors.fg3;
    final bodyColor = hasBackground
        ? AppColors.fgOnClay.withValues(alpha: 0.88)
        : AppColors.fg2;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: AppLayout.heroCardMinHeight),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(
          color: AppColors.surfaceBorderSoft.withValues(alpha: 0.82),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDeep,
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (hasBackground) ...[
            Positioned.fill(
              child: Image.file(
                backgroundFile,
                fit: BoxFit.cover,
                alignment: backgroundAlignment,
                filterQuality: FilterQuality.medium,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.clay900.withValues(alpha: 0.78),
                      AppColors.clay900.withValues(alpha: 0.56),
                    ],
                  ),
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onChangeAvatar,
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor: hasBackground
                            ? AppColors.fgOnClay.withValues(alpha: 0.18)
                            : AppColors.accentSoft,
                        backgroundImage: hasAvatar
                            ? NetworkImage(avatar)
                            : null,
                        child: hasAvatar
                            ? null
                            : Text(
                                _initials(profile.fullName),
                                style: TextStyle(
                                  color: hasBackground
                                      ? AppColors.fgOnClay
                                      : AppColors.clay900,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  profile.fullName.isEmpty
                                      ? 'Xenoh'
                                      : profile.fullName,
                                  style: AppTypography.display(
                                    26,
                                    letterSpacing: 0,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (onEditProfile != null)
                                IconButton(
                                  tooltip: l10n.profileEditTitle,
                                  icon: const Icon(Icons.edit_outlined),
                                  iconSize: 16,
                                  color: primaryColor,
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: onEditProfile,
                                ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            profile.email,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.profileChangeBackgroundTooltip,
                      icon: const Icon(Icons.wallpaper_rounded),
                      color: primaryColor,
                      onPressed: onChangeBackground,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.profileBioLabel,
                  style: _eyebrow.copyWith(
                    color: hasBackground
                        ? AppColors.fgOnClay.withValues(alpha: 0.68)
                        : AppColors.fg3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  profile.bio?.isNotEmpty == true
                      ? profile.bio!
                      : l10n.profileNoBioYet,
                  style: TextStyle(color: bodyColor, fontSize: 14, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.profile,
    required this.unit,
    this.latestWeight,
    this.onShowHistory,
  });

  final UserProfile profile;
  final double? latestWeight;
  final WeightUnit unit;
  final VoidCallback? onShowHistory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percent = (profile.levelProgress * 100).round();
    return XnCard(
      color: AppColors.bg3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.bg2,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: XnAnimatedNumber(
                  value: profile.level.toDouble(),
                  formatter: formatAnimatedInt,
                  style: AppTypography.display(26),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.profileLevelEyebrow, style: _eyebrow),
                    Text(
                      profile.title,
                      style: AppTypography.display(22, letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              if (latestWeight != null)
                _WeightPill(
                  weight: latestWeight!,
                  unit: unit,
                  onTap: onShowHistory,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.profileXpEyebrow, style: _eyebrow),
          const SizedBox(height: 2),
          Row(
            children: [
              XnAnimatedNumber(
                value: profile.totalXp.toDouble(),
                formatter: formatAnimatedThousands,
                style: AppTypography.mono(15, weight: FontWeight.w500),
              ),
              Text(
                ' / ',
                style: AppTypography.mono(15, weight: FontWeight.w500),
              ),
              XnAnimatedNumber(
                value: (profile.totalXp + profile.xpToNextLevel).toDouble(),
                formatter: formatAnimatedThousands,
                style: AppTypography.mono(15, weight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: profile.levelProgress,
                    minHeight: 8,
                    backgroundColor: AppColors.bg2,
                    valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              XnAnimatedNumber(
                value: percent.toDouble(),
                formatter: (value) => '${value.round()}%',
                style: AppTypography.mono(12, color: AppColors.fg3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Latest-bodyweight pill shown at the top-right of the level card; taps open
/// the full history sheet.
class _WeightPill extends StatelessWidget {
  const _WeightPill({required this.weight, required this.unit, this.onTap});

  final double weight;
  final WeightUnit unit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bg2,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.monitor_weight_outlined,
                size: 14,
                color: AppColors.fg3,
              ),
              const SizedBox(width: 4),
              XnAnimatedNumber(
                value: unit.fromKg(weight),
                formatter: (value) => '${formatWeight(value)} ${unit.suffix}',
                style: AppTypography.mono(12, weight: FontWeight.w500),
              ),
              if (onTap != null)
                const Icon(
                  Icons.history_rounded,
                  size: 14,
                  color: AppColors.fg3,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BodyweightHistorySheet extends StatelessWidget {
  const _BodyweightHistorySheet({
    required this.logs,
    required this.unit,
    required this.onDelete,
  });

  final List<BodyweightLog> logs;
  final WeightUnit unit;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Newest first for the list.
    final ordered = logs.reversed.toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.profileBodyweightHistoryTitle,
              style: AppTypography.display(20, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.sm),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: ordered.length,
                separatorBuilder: (_, _) => const Divider(
                  height: 1,
                  color: AppColors.surfaceBorderSoft,
                ),
                itemBuilder: (_, i) {
                  final log = ordered[i];
                  final prev = i + 1 < ordered.length ? ordered[i + 1] : null;
                  final delta = prev == null ? null : log.weight - prev.weight;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateOnly.format(log.date),
                            style: AppTypography.mono(13, color: AppColors.fg2),
                          ),
                        ),
                        if (delta != null && delta != 0) ...[
                          DeltaChip(delta: delta, unit: unit),
                          const SizedBox(width: AppSpacing.md),
                        ],
                        Text(
                          '${formatWeight(unit.fromKg(log.weight))} ${unit.suffix}',
                          style: AppTypography.mono(
                            14,
                            weight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.profileDeleteEntryTooltip,
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => onDelete(log.id),
                        ),
                      ],
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

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <(String, String)>[
      (
        l10n.profileDetailHeight,
        profile.height == null ? '—' : '${_compact(profile.height!)} cm',
      ),
      (
        l10n.profileDetailGender,
        profile.gender == null ? '—' : _profileEnumLabel(profile.gender!, l10n),
      ),
      (l10n.profileDetailDateOfBirth, _formatDob(profile.dateOfBirth)),
      (
        l10n.profileDetailDevelopmentDirection,
        profile.developmentDirection == null
            ? '—'
            : _profileEnumLabel(profile.developmentDirection!, l10n),
      ),
      (
        l10n.profileDetailTrainingDiscipline,
        profile.trainingDiscipline == null
            ? '—'
            : _profileEnumLabel(profile.trainingDiscipline!, l10n),
      ),
      (
        l10n.profileDetailBmi,
        profile.bmi == null
            ? '—'
            : profile.bmi!.toStringAsFixed(1) +
                  (profile.bmiCategory == null
                      ? ''
                      : ' · ${profile.bmiCategory}'),
      ),
      (
        l10n.profileDetailDotsScore,
        profile.dotsScore?.toStringAsFixed(1) ?? '—',
      ),
      (
        l10n.profileDetailStreak,
        l10n.profileStreakDays(profile.currentStreak),
      ),
    ];

    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i += 2) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _DetailItem(
                    label: items[i].$1,
                    value: items[i].$2,
                  ),
                ),
                Expanded(
                  child: i + 1 < items.length
                      ? _DetailItem(
                          label: items[i + 1].$1,
                          value: items[i + 1].$2,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            if (i + 2 < items.length) const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: _eyebrow),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.fg1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({
    required this.icon,
    required this.label,
    this.value,
    this.animatedValue,
    this.formatter,
  });

  final IconData icon;
  final String label;
  final String? value;
  final double? animatedValue;
  final XnNumberFormatter? formatter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.fg3),
            const SizedBox(width: 6),
            Expanded(child: Text(label, style: _eyebrow)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (animatedValue != null && formatter != null)
          XnAnimatedNumber(
            value: animatedValue!,
            formatter: formatter!,
            style: AppTypography.mono(20, weight: FontWeight.w500),
          )
        else
          Text(
            value ?? '',
            style: AppTypography.mono(20, weight: FontWeight.w500),
          ),
      ],
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({
    required this.month,
    required this.activity,
    required this.onPrev,
    required this.onNext,
  });

  final DateTime month;
  final AsyncValue<TrainingActivity> activity;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                size: 18,
                color: AppColors.fg3,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.profileTrainingCalendarTitle, style: _eyebrow),
                    Text(
                      '${DateFormat.MMMM(locale).format(month)} ${month.year}',
                      style: AppTypography.display(18, letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded),
                onPressed: onPrev,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: onNext,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          activity.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                l10n.profileActivityMonthError,
                style: const TextStyle(color: AppColors.fg3),
              ),
            ),
            data: (data) =>
                _MonthGrid(month: month, trained: data.trainedDaysOfMonth),
          ),
        ],
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({required this.month, required this.trained});

  final DateTime month;
  final Set<int> trained;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final labels = [
      for (var i = 0; i < 7; i++)
        DateFormat.E(locale).format(DateTime(2024, 1, 1 + i)),
    ];
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // weekday: Mon=1..Sun=7 → leading empty cells before day 1.
    final leading = DateTime(month.year, month.month, 1).weekday - 1;
    final now = DateTime.now();

    final cells = <Widget>[
      for (var i = 0; i < leading; i++) const SizedBox.shrink(),
      for (var day = 1; day <= daysInMonth; day++)
        _DayCell(
          day: day,
          trained: trained.contains(day),
          isToday:
              now.year == month.year &&
              now.month == month.month &&
              now.day == day,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            for (final l in labels)
              Expanded(
                child: Center(
                  child: Text(
                    l,
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: cells,
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.trained,
    required this.isToday,
  });

  final int day;
  final bool trained;
  final bool isToday;

  static const _markedDayRed = Color(0xFFFF0000);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: trained ? _markedDayRed : AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: trained
              ? _markedDayRed
              : isToday
              ? AppColors.accent
              : AppColors.surfaceBorderSoft,
          width: isToday ? 1.5 : 1,
        ),
      ),
      child: Text(
        '$day',
        style: AppTypography.mono(
          12,
          weight: FontWeight.w500,
          color: trained ? AppColors.fgOnClay : AppColors.fg2,
        ),
      ),
    );
  }
}

const _eyebrow = TextStyle(
  color: AppColors.fg3,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.7,
);

String _initials(String fullName) {
  final parts = fullName.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

/// Drops a trailing `.0` for whole numbers (e.g. `180.0` → `180`).
String _compact(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

String _profileEnumLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Male' => l10n.authGenderMale,
      'Female' => l10n.authGenderFemale,
      'Strength' => l10n.authDevStrength,
      'Hypertrophy' => l10n.authDevHypertrophy,
      'FatLoss' => l10n.authDevFatLoss,
      'Recomposition' => l10n.authDevRecomposition,
      'Endurance' => l10n.authDevEndurance,
      'GeneralHealth' => l10n.authDevGeneralHealth,
      'Powerlifting' => l10n.authDisciplinePowerlifting,
      'Bodybuilding' => l10n.authDisciplineBodybuilding,
      'Weightlifting' => l10n.authDisciplineWeightlifting,
      'Calisthenics' => l10n.authDisciplineCalisthenics,
      'CrossFit' => l10n.authDisciplineCrossFit,
      'Running' => l10n.authDisciplineRunning,
      'GeneralFitness' => l10n.authDisciplineGeneralFitness,
      _ => value.replaceAllMapped(
        RegExp('([a-z])([A-Z])'),
        (m) => '${m[1]} ${m[2]}',
      ),
    };

String _formatDob(DateTime? date) {
  if (date == null) return '—';
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(date.day)}/${two(date.month)}/${date.year}';
}
