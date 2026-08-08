import 'package:dio/dio.dart';

import '../domain/challenge_models.dart';

class ChallengeRemoteDataSource {
  ChallengeRemoteDataSource(this._dio);

  final Dio _dio;
  static const _base = '/community/challenges';

  Future<List<Challenge>> getMine() async => _list(_base, Challenge.fromJson);
  Future<List<ChallengeSummary>> discover() async =>
      _list('$_base/discover', ChallengeSummary.fromJson);
  Future<List<ChallengeInvitee>> getInvitees() async =>
      _list('$_base/invitees', ChallengeInvitee.fromJson);

  Future<Challenge> getById(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('$_base/$id');
    return Challenge.fromJson(response.data!);
  }

  Future<Challenge> create(ChallengeInput input) =>
      _challengePost(_base, input.toJson());
  Future<Challenge> accept(String id) => _challengePost('$_base/$id/accept');
  Future<Challenge> join(String id) => _challengePost('$_base/$id/join');
  Future<Challenge> checkIn(String id, String? note) =>
      _challengePost('$_base/$id/check-ins', {'note': note});
  Future<Challenge> undoCheckIn(String id) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '$_base/$id/check-ins/today',
    );
    return Challenge.fromJson(response.data!);
  }

  Future<Challenge> invite(String id, List<String> userIds) =>
      _challengePost('$_base/$id/invites', {'userIds': userIds});

  Future<void> decline(String id) => _dio.post<void>('$_base/$id/decline');
  Future<void> leave(String id) => _dio.post<void>('$_base/$id/leave');
  Future<void> cancel(String id) => _dio.post<void>('$_base/$id/cancel');
  Future<void> removeMember(String id, String userId) =>
      _dio.delete<void>('$_base/$id/members/$userId');

  Future<Challenge> _challengePost(
    String path, [
    Map<String, dynamic>? data,
  ]) async {
    final response = await _dio.post<Map<String, dynamic>>(path, data: data);
    return Challenge.fromJson(response.data!);
  }

  Future<List<T>> _list<T>(
    String path,
    T Function(Map<String, dynamic>) parse,
  ) async {
    final response = await _dio.get<List<dynamic>>(path);
    return (response.data ?? const [])
        .map((item) => parse(item as Map<String, dynamic>))
        .toList();
  }
}
