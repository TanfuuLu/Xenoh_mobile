import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../training/data/repositories/training_repository_provider.dart';
import '../../../training/presentation/navigation/training_route_scope.dart';
import '../../domain/client_today_workout_resolver.dart';

class ClientTodayWorkoutScreen extends ConsumerStatefulWidget {
  const ClientTodayWorkoutScreen({
    required this.clientId,
    required this.planId,
    this.onResolved,
    super.key,
  });

  static const emptyStateKey = ValueKey('client-today-workout-empty');

  static String coachDayLocation({
    required String dayId,
    required String clientId,
  }) => trainingRouteLocation(
    '/days/$dayId',
    coachView: true,
    clientId: clientId,
  );

  final String clientId;
  final String planId;
  final ValueChanged<String>? onResolved;

  @override
  ConsumerState<ClientTodayWorkoutScreen> createState() =>
      _ClientTodayWorkoutScreenState();
}

class _ClientTodayWorkoutScreenState
    extends ConsumerState<ClientTodayWorkoutScreen> {
  late Future<ClientTodayWorkoutTarget?> _target;
  var _resolved = false;

  @override
  void initState() {
    super.initState();
    _target = _load();
  }

  Future<ClientTodayWorkoutTarget?> _load() {
    if (widget.planId.isEmpty) return Future.value();
    return resolveClientTodayWorkout(
      repository: ref.read(trainingRepositoryProvider),
      planId: widget.planId,
      today: DateTime.now(),
    );
  }

  void _retry() {
    setState(() {
      _resolved = false;
      _target = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.coachClientTodayWorkoutTitle)),
      body: FutureBuilder<ClientTodayWorkoutTarget?>(
        future: _target,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                FeatureError(error: snapshot.error!, onRetry: _retry),
              ],
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final target = snapshot.data;
          if (target == null) return _emptyState(l10n);
          _resolve(target.dayId);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _resolve(String dayId) {
    if (_resolved) return;
    _resolved = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final callback = widget.onResolved;
      if (callback != null) {
        callback(dayId);
      } else {
        context.go(
          ClientTodayWorkoutScreen.coachDayLocation(
            dayId: dayId,
            clientId: widget.clientId,
          ),
        );
      }
    });
  }

  Widget _emptyState(AppLocalizations l10n) {
    final noPlan = widget.planId.isEmpty;
    return Center(
      child: ListView(
        key: ClientTodayWorkoutScreen.emptyStateKey,
        shrinkWrap: true,
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          XnCard(
            child: Column(
              children: [
                const Icon(
                  Icons.fitness_center_rounded,
                  size: 42,
                  color: AppColors.fg3,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  noPlan
                      ? l10n.coachClientNoActivePlanMessage
                      : l10n.coachClientNoWorkoutDayMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.fg2),
                ),
                const SizedBox(height: AppSpacing.md),
                XnButton(
                  label: l10n.commonBack,
                  variant: XnButtonVariant.secondary,
                  onPressed: () => context.canPop()
                      ? context.pop()
                      : context.go('/coach/clients/${widget.clientId}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
