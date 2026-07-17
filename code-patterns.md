# Code Patterns — Riverpod 3 / freezed 3 (current syntax)

Copy-ready templates using the **current** API (Flutter 3.44, Riverpod 3.0, freezed 3.2).
Adjust names; keep the structure. All examples assume feature-first Clean Architecture.

## Contents
1. pubspec.yaml (dependencies + codegen)
2. analysis_options.yaml (strict)
3. Domain entity + repository interface
4. Data DTO (freezed + json) + mapping
5. core/error: sealed Failure + Result
6. core/network: Dio provider + auth interceptor
7. Data source + repository implementation
8. Riverpod notifier (AsyncNotifier) view model
9. Sealed state union (freezed)
10. go_router provider with auth guard
11. ConsumerWidget screen
12. Tests: notifier unit test + widget test (mocktail)

---

## 1. pubspec.yaml

```yaml
name: my_app
environment:
  sdk: ^3.12.0
  flutter: ">=3.44.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.0.0
  riverpod_annotation: ^3.0.0
  freezed_annotation: ^3.2.0
  json_annotation: ^4.9.0
  go_router: ^16.0.0
  dio: ^5.7.0
  flutter_secure_storage: ^9.2.0
  shared_preferences: ^2.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.10.0
  riverpod_generator: ^3.0.0
  riverpod_lint: ^3.0.0
  custom_lint: ^0.8.0
  freezed: ^3.2.0
  json_serializable: ^6.9.0
  very_good_analysis: ^9.0.0
  mocktail: ^1.0.0
```

> Verify each version on pub.dev at scaffold time — ranges above are a June 2026 baseline.

## 2. analysis_options.yaml

```yaml
include: package:very_good_analysis/analysis_options.yaml

analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
  plugins:
    - custom_lint
  errors:
    invalid_annotation_target: ignore   # freezed/json codegen noise

linter:
  rules:
    prefer_const_constructors: true
    require_trailing_commas: true
```

## 3. Domain entity + repository interface (pure Dart)

```dart
// features/feed/domain/entities/post.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    required String body,
  }) = _Post;
}
```

```dart
// features/feed/domain/repositories/post_repository.dart
import '../entities/post.dart';

abstract interface class PostRepository {
  Future<List<Post>> fetchFeed();
  Future<Post> fetchById(String id);
}
```

## 4. Data DTO (freezed + json) + mapping

```dart
// features/feed/data/dtos/post_dto.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post.dart';
part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@freezed
abstract class PostDto with _$PostDto {
  const PostDto._();
  const factory PostDto({
    required String id,
    required String title,
    required String body,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);

  Post toEntity() => Post(id: id, title: title, body: body);
}
```

## 5. core/error: sealed Failure + Result

```dart
// core/error/failure.dart
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error']);
}
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong']);
}
```

```dart
// core/error/result.dart
sealed class Result<T> {
  const Result();
}
class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}
class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}
```

## 6. core/network: Dio provider + auth interceptor

```dart
// core/network/dio_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/token_storage.dart';
part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));
  dio.interceptors.add(AuthInterceptor(ref.watch(tokenStorageProvider)));
  return dio;
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokens);
  final TokenStorage _tokens;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokens.accessToken();
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  // Implement onError to refresh on 401 and retry the request.
}
```

## 7. Data source + repository implementation

```dart
// features/feed/data/datasources/post_remote_data_source.dart
import 'package:dio/dio.dart';
import '../dtos/post_dto.dart';

class PostRemoteDataSource {
  PostRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<PostDto>> getFeed() async {
    final res = await _dio.get<List<dynamic>>('/posts');
    return (res.data ?? [])
        .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
```

```dart
// features/feed/data/repositories/post_repository_impl.dart
import 'package:dio/dio.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';
import '../../../../core/error/failure.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._remote);
  final PostRemoteDataSource _remote;

  @override
  Future<List<Post>> fetchFeed() async {
    try {
      final dtos = await _remote.getFeed();
      return dtos.map((d) => d.toEntity()).toList();
    } on DioException catch (e) {
      throw e.response?.statusCode == 401
          ? const AuthFailure()
          : const NetworkFailure();
    }
  }

  @override
  Future<Post> fetchById(String id) async {
    // ...
    throw UnimplementedError();
  }
}
```

```dart
// features/feed/data/repositories/post_repository_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';
import 'post_repository_impl.dart';
part 'post_repository_provider.g.dart';

@riverpod
PostRepository postRepository(Ref ref) =>
    PostRepositoryImpl(PostRemoteDataSource(ref.watch(dioProvider)));
```

## 8. Riverpod notifier (AsyncNotifier) view model

```dart
// features/feed/presentation/providers/feed_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/post.dart';
import '../../data/repositories/post_repository_provider.dart';
part 'feed_controller.g.dart';

@riverpod
class FeedController extends _$FeedController {
  @override
  Future<List<Post>> build() async {
    return ref.watch(postRepositoryProvider).fetchFeed();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(postRepositoryProvider).fetchFeed(),
    );
  }
}
```

## 9. Sealed state union (freezed) — pattern matching

```dart
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(User user) = Authenticated;
  const factory AuthState.error(String message) = AuthErrorState;
}

// usage
final label = switch (state) {
  AuthInitial() => 'Welcome',
  AuthLoading() => 'Signing in…',
  Authenticated(:final user) => 'Hi ${user.name}',
  AuthErrorState(:final message) => message,
};
```

## 10. go_router provider with auth guard

```dart
// app/router/router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final isAuthed = ref.watch(authControllerProvider.select((s) => s.isAuthed));
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final goingToLogin = state.matchedLocation == '/login';
      if (!isAuthed && !goingToLogin) return '/login';
      if (isAuthed && goingToLogin) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const FeedScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    ],
  );
}
```

```dart
// app/app.dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(routerConfig: ref.watch(routerProvider));
  }
}
```

## 11. ConsumerWidget screen — render AsyncValue

```dart
class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(feedControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(feedControllerProvider.notifier).refresh(),
        child: feed.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ErrorView(
            message: '$e',
            onRetry: () => ref.invalidate(feedControllerProvider),
          ),
          data: (posts) => ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) => ListTile(title: Text(posts[i].title)),
          ),
        ),
      ),
    );
  }
}
```

## 12. Tests — notifier unit test + widget test (mocktail)

```dart
// test/features/feed/feed_controller_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  test('FeedController emits posts from repository', () async {
    final repo = MockPostRepository();
    when(repo.fetchFeed).thenAnswer((_) async => const [
          Post(id: '1', title: 'Hello', body: 'World'),
        ]);

    final container = ProviderContainer(
      overrides: [postRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);

    final result = await container.read(feedControllerProvider.future);
    expect(result, hasLength(1));
    expect(result.first.title, 'Hello');
  });
}
```

```dart
// test/features/feed/feed_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FeedScreen shows list when data loads', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          feedControllerProvider.overrideWith(
            () => _FakeFeed(const [Post(id: '1', title: 'Hi', body: 'b')]),
          ),
        ],
        child: const MaterialApp(home: FeedScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Hi'), findsOneWidget);
  });
}
```

> Override notifiers in tests with `overrideWith` and providers with `overrideWithValue`.
> Use `container.read(provider.future)` to await async providers. Prefer `mocktail`
> (no codegen) over `mockito`.

## Async rendering — keep data visible during refresh (APP STANDARD)

Never render a full-screen spinner when stale data is available. For screen/section
content, render from the latest **value** so an `invalidate`/`refresh` updates in place
instead of flashing a spinner. Use `core/widgets/async_value_view.dart`:

```dart
// In a screen body (inside RefreshIndicator):
child: AsyncValueView(
  value: someAsyncValue,                 // AsyncValue<T> from ref.watch(...)
  onRetry: () => ref.invalidate(someProvider),
  data: (items) => ListView(...),        // built from the (possibly stale) value
),
```

`AsyncValueView` shows the spinner/error **only on the first load** (no value yet);
afterwards it keeps showing `value.value` during reloads.

For inline sections inside a card, do the same by hand: branch on `x.value == null`
(first-load spinner/error) else render the value.

Notifier `refresh()` must NOT blank the state — do **not** write
`state = const AsyncValue.loading()`. Just reassign via guard so the old value stays
visible while re-fetching (the RefreshIndicator shows its own progress):

```dart
Future<void> refresh() async {
  state = await AsyncValue.guard(() => ref.read(repoProvider).fetch());
}
```

Mutations (add/edit/delete) should `ref.invalidate(theProvider)` (not set loading);
combined with the above, the UI updates smoothly with no reload flash.
