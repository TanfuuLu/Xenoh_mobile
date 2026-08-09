import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/community/data/repositories/community_repository_provider.dart';
import 'package:xenoh_mobile/features/community/domain/entities/community_models.dart';
import 'package:xenoh_mobile/features/community/domain/repositories/community_repository.dart';
import 'package:xenoh_mobile/features/community/presentation/providers/community_controllers.dart';

void main() {
  test('loads the first feed page and exposes the next cursor', () async {
    final repository = _FeedRepository([
      TrainingDayFeedPage(
        items: [_share('share-1')],
        nextCursor: 'cursor-1',
      ),
    ]);
    final container = ProviderContainer(
      overrides: [communityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final state = await container.read(communityFeedControllerProvider.future);

    expect(state.items.map((item) => item.id), ['share-1']);
    expect(state.nextCursor, 'cursor-1');
    expect(state.hasMore, isTrue);
  });

  test('loadMore deduplicates shares and stops without a cursor', () async {
    final repository = _FeedRepository([
      TrainingDayFeedPage(
        items: [_share('share-1')],
        nextCursor: 'cursor-1',
      ),
      TrainingDayFeedPage(
        items: [_share('share-1'), _share('share-2')],
        nextCursor: null,
      ),
    ]);
    final container = ProviderContainer(
      overrides: [communityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    await container.read(communityFeedControllerProvider.future);

    await container.read(communityFeedControllerProvider.notifier).loadMore();
    final state = container.read(communityFeedControllerProvider).value!;

    expect(state.items.map((item) => item.id), ['share-1', 'share-2']);
    expect(state.hasMore, isFalse);
    expect(repository.cursors, [null, 'cursor-1']);
  });

  test('loadMore keeps current items and exposes a retryable error', () async {
    final repository = _FeedRepository([
      TrainingDayFeedPage(
        items: [_share('share-1')],
        nextCursor: 'cursor-1',
      ),
      StateError('network down'),
    ]);
    final container = ProviderContainer(
      overrides: [communityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    await container.read(communityFeedControllerProvider.future);

    await container.read(communityFeedControllerProvider.notifier).loadMore();
    final state = container.read(communityFeedControllerProvider).value!;

    expect(state.items.single.id, 'share-1');
    expect(state.loadMoreError, isA<StateError>());
    expect(state.isLoadingMore, isFalse);
  });

  test('refresh replaces existing pages and resets the cursor', () async {
    final repository = _FeedRepository([
      TrainingDayFeedPage(
        items: [_share('share-1')],
        nextCursor: 'cursor-1',
      ),
      TrainingDayFeedPage(
        items: [_share('share-3')],
        nextCursor: null,
      ),
    ]);
    final container = ProviderContainer(
      overrides: [communityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    await container.read(communityFeedControllerProvider.future);

    await container.read(communityFeedControllerProvider.notifier).refresh();
    final state = container.read(communityFeedControllerProvider).value!;

    expect(state.items.map((item) => item.id), ['share-3']);
    expect(repository.cursors, [null, null]);
  });

  test('a stale loadMore response cannot overwrite refreshed data', () async {
    final stalePage = Completer<TrainingDayFeedPage>();
    final repository = _FeedRepository([
      TrainingDayFeedPage(
        items: [_share('share-1')],
        nextCursor: 'cursor-1',
      ),
      stalePage.future,
      TrainingDayFeedPage(items: [_share('share-3')], nextCursor: null),
    ]);
    final container = ProviderContainer(
      overrides: [communityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    await container.read(communityFeedControllerProvider.future);

    final loadMore = container
        .read(communityFeedControllerProvider.notifier)
        .loadMore();
    await container.read(communityFeedControllerProvider.notifier).refresh();
    stalePage.complete(
      TrainingDayFeedPage(items: [_share('share-2')], nextCursor: null),
    );
    await loadMore;

    final state = container.read(communityFeedControllerProvider).value!;
    expect(state.items.map((item) => item.id), ['share-3']);
  });
}

TrainingDayShare _share(String id) => TrainingDayShare(
  id: id,
  userId: 'user-1',
  userFullName: 'Demo Athlete',
  sourceDailyWorkoutId: 'workout-1',
  workoutDate: DateTime(2026, 8, 8),
  dayOfWeek: 'Saturday',
  dayStatus: 'Completed',
  exerciseCount: 0,
  completedSets: 0,
  totalVolume: 0,
  totalDurationSeconds: 0,
  hasPersonalRecord: false,
  loveCount: 0,
  lovedByCurrentUser: false,
  createdAt: DateTime(2026, 8, 8),
  exercises: const [],
);

class _FeedRepository implements CommunityRepository {
  _FeedRepository(this.responses);

  final List<Object> responses;
  final List<String?> cursors = [];

  @override
  Future<TrainingDayFeedPage> getFeed({
    String scope = 'friends',
    String? cursor,
    int pageSize = 20,
  }) async {
    cursors.add(cursor);
    final response = responses.removeAt(0);
    if (response is Error) throw response;
    if (response is Future<TrainingDayFeedPage>) return response;
    return response as TrainingDayFeedPage;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
