import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../data/competition_remote_data_source.dart';
import '../data/competition_repository_impl.dart';
import '../domain/competition_models.dart';
import '../domain/competition_repository.dart';

final competitionRepositoryProvider = Provider<CompetitionRepository>(
  (ref) => CompetitionRepositoryImpl(
    CompetitionRemoteDataSource(ref.watch(dioProvider)),
  ),
);
final competitionsProvider = FutureProvider.autoDispose
    .family<List<CompetitionSummary>, String?>(
      (ref, discipline) =>
          ref.watch(competitionRepositoryProvider).list(discipline: discipline),
    );
final competitionDetailProvider = FutureProvider.autoDispose
    .family<CompetitionEvent, String>(
      (ref, slug) => ref.watch(competitionRepositoryProvider).getBySlug(slug),
    );
final myCompetitionsProvider =
    FutureProvider.autoDispose<List<CompetitionRegistration>>(
      (ref) => ref.watch(competitionRepositoryProvider).mine(),
    );
final organizerProfileProvider = FutureProvider.autoDispose<OrganizerProfile?>(
  (ref) => ref.watch(competitionRepositoryProvider).getOrganizerProfile(),
);
final managedCompetitionsProvider =
    FutureProvider.autoDispose<List<CompetitionSummary>>(
      (ref) => ref.watch(competitionRepositoryProvider).getManagedEvents(),
    );

final organizerRosterProvider = FutureProvider.autoDispose
    .family<List<CompetitionRegistration>, String>(
      (ref, eventId) =>
          ref.watch(competitionRepositoryProvider).getRoster(eventId),
    );

final adminOrganizerApplicationsProvider = FutureProvider.autoDispose
    .family<List<OrganizerProfile>, String?>(
      (ref, status) => ref
          .watch(competitionRepositoryProvider)
          .getOrganizerApplications(status: status),
    );
