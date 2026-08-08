import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/profile_repository_provider.dart';
import '../../domain/entities/bodyweight_log.dart';
import '../../domain/entities/training_activity.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/volume_history_point.dart';

part 'profile_controller.g.dart';

/// The signed-in user's full profile (`GET /users/me`).
@riverpod
class MyProfileController extends _$MyProfileController {
  @override
  Future<UserProfile> build() => ref.watch(profileRepositoryProvider).getMe();

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      () => ref.read(profileRepositoryProvider).getMe(),
    );
  }

  /// Persist profile edits and update state with the server's response.
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? bio,
    double? height,
    String? gender,
    DateTime? dateOfBirth,
    String? developmentDirection,
    String? trainingDiscipline,
    String? facebookUrl,
    String? instagramUrl,
    String? zaloUrl,
  }) async {
    final updated = await ref
        .read(profileRepositoryProvider)
        .updateProfile(
          firstName: firstName,
          lastName: lastName,
          bio: bio,
          height: height,
          gender: gender,
          dateOfBirth: dateOfBirth,
          developmentDirection: developmentDirection,
          trainingDiscipline: trainingDiscipline,
          facebookUrl: facebookUrl,
          instagramUrl: instagramUrl,
          zaloUrl: zaloUrl,
        );
    state = AsyncValue.data(updated);
  }

  Future<void> uploadAvatar(String filePath) async {
    final previousUrl = state.value?.avatarUrl;
    final updated = await ref
        .read(profileRepositoryProvider)
        .uploadAvatar(
          filePath,
        );
    for (final url in {previousUrl, updated.avatarUrl}) {
      if (url?.trim().isNotEmpty == true) {
        await NetworkImage(url!.trim()).evict();
      }
    }
    state = AsyncValue.data(updated);
  }
}

/// Bodyweight history (oldest → newest) for the profile chart.
@riverpod
Future<List<BodyweightLog>> bodyweightHistory(Ref ref) =>
    ref.watch(profileRepositoryProvider).getBodyweightHistory();

Future<void> deleteBodyweightLog(Ref ref, String id) =>
    ref.read(profileRepositoryProvider).deleteBodyweightLog(id);

/// Monthly training activity (calendar + totals), keyed by year/month.
@riverpod
Future<TrainingActivity> trainingActivity(
  Ref ref, {
  required int year,
  required int month,
}) => ref
    .watch(profileRepositoryProvider)
    .getTrainingActivity(year: year, month: month);

final volumeHistoryProvider = FutureProvider.autoDispose
    .family<List<VolumeHistoryPoint>, int>((ref, months) {
      return ref
          .watch(profileRepositoryProvider)
          .getVolumeHistory(months: months);
    });
