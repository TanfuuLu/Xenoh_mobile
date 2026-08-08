import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../data/challenge_remote_data_source.dart';
import '../data/challenge_repository_impl.dart';
import '../domain/challenge_models.dart';
import '../domain/challenge_repository.dart';

final challengeRepositoryProvider = Provider<ChallengeRepository>((ref) {
  return ChallengeRepositoryImpl(
    ChallengeRemoteDataSource(ref.watch(dioProvider)),
  );
});

final myChallengesProvider = FutureProvider.autoDispose<List<Challenge>>((ref) {
  return ref.watch(challengeRepositoryProvider).getMine();
});

final discoverChallengesProvider =
    FutureProvider.autoDispose<List<ChallengeSummary>>((ref) {
      return ref.watch(challengeRepositoryProvider).discover();
    });

final challengeDetailProvider = FutureProvider.autoDispose
    .family<Challenge, String>((ref, id) {
      return ref.watch(challengeRepositoryProvider).getById(id);
    });

final challengeInviteesProvider =
    FutureProvider.autoDispose<List<ChallengeInvitee>>((ref) {
      return ref.watch(challengeRepositoryProvider).getInvitees();
    });

class ChallengeActionController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  ChallengeRepository get _repository => ref.read(challengeRepositoryProvider);

  Future<bool> run(Future<void> Function(ChallengeRepository) action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => action(_repository));
    if (!state.hasError) {
      ref
        ..invalidate(myChallengesProvider)
        ..invalidate(discoverChallengesProvider)
        ..invalidate(challengeDetailProvider);
    }
    return !state.hasError;
  }
}

final challengeActionControllerProvider =
    NotifierProvider<ChallengeActionController, AsyncValue<void>>(
      ChallengeActionController.new,
    );
