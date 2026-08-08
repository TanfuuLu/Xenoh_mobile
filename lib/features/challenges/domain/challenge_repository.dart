import 'challenge_models.dart';

abstract interface class ChallengeRepository {
  Future<List<Challenge>> getMine();
  Future<List<ChallengeSummary>> discover();
  Future<List<ChallengeInvitee>> getInvitees();
  Future<Challenge> getById(String id);
  Future<Challenge> create(ChallengeInput input);
  Future<Challenge> accept(String id);
  Future<void> decline(String id);
  Future<Challenge> join(String id);
  Future<void> leave(String id);
  Future<void> cancel(String id);
  Future<Challenge> checkIn(String id, String? note);
  Future<Challenge> undoCheckIn(String id);
  Future<Challenge> invite(String id, List<String> userIds);
  Future<void> removeMember(String id, String userId);
}
