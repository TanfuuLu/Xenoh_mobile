import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';
import '../domain/challenge_models.dart';
import '../domain/challenge_repository.dart';
import 'challenge_remote_data_source.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {
  ChallengeRepositoryImpl(this._remote);

  final ChallengeRemoteDataSource _remote;

  Future<T> _call<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw failureFromDio(error);
    }
  }

  @override
  Future<List<Challenge>> getMine() => _call(_remote.getMine);
  @override
  Future<List<ChallengeSummary>> discover() => _call(_remote.discover);
  @override
  Future<List<ChallengeInvitee>> getInvitees() => _call(_remote.getInvitees);
  @override
  Future<Challenge> getById(String id) => _call(() => _remote.getById(id));
  @override
  Future<Challenge> create(ChallengeInput input) =>
      _call(() => _remote.create(input));
  @override
  Future<Challenge> update(String id, ChallengeInput input) =>
      _call(() => _remote.update(id, input));
  @override
  Future<Challenge> accept(String id) => _call(() => _remote.accept(id));
  @override
  Future<void> decline(String id) => _call(() => _remote.decline(id));
  @override
  Future<Challenge> join(String id) => _call(() => _remote.join(id));
  @override
  Future<void> leave(String id) => _call(() => _remote.leave(id));
  @override
  Future<void> cancel(String id) => _call(() => _remote.cancel(id));
  @override
  Future<Challenge> checkIn(String id, String? note) =>
      _call(() => _remote.checkIn(id, note));
  @override
  Future<Challenge> undoCheckIn(String id) =>
      _call(() => _remote.undoCheckIn(id));
  @override
  Future<Challenge> invite(String id, List<String> userIds) =>
      _call(() => _remote.invite(id, userIds));
  @override
  Future<void> removeMember(String id, String userId) =>
      _call(() => _remote.removeMember(id, userId));
}
