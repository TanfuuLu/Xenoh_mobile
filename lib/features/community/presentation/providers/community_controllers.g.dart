// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(communityUserSearch)
final communityUserSearchProvider = CommunityUserSearchFamily._();

final class CommunityUserSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<PagedResult<CommunityUserSummary>>,
          PagedResult<CommunityUserSummary>,
          FutureOr<PagedResult<CommunityUserSummary>>
        >
    with
        $FutureModifier<PagedResult<CommunityUserSummary>>,
        $FutureProvider<PagedResult<CommunityUserSummary>> {
  CommunityUserSearchProvider._({
    required CommunityUserSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityUserSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityUserSearchHash();

  @override
  String toString() {
    return r'communityUserSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PagedResult<CommunityUserSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PagedResult<CommunityUserSummary>> create(Ref ref) {
    final argument = this.argument as String;
    return communityUserSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityUserSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityUserSearchHash() =>
    r'78c01c8f7c69482e87af9728033df04f00d858ec';

final class CommunityUserSearchFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PagedResult<CommunityUserSummary>>,
          String
        > {
  CommunityUserSearchFamily._()
    : super(
        retry: null,
        name: r'communityUserSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityUserSearchProvider call(String query) =>
      CommunityUserSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'communityUserSearchProvider';
}

@ProviderFor(communityProfile)
final communityProfileProvider = CommunityProfileFamily._();

final class CommunityProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<CommunityUserProfile>,
          CommunityUserProfile,
          FutureOr<CommunityUserProfile>
        >
    with
        $FutureModifier<CommunityUserProfile>,
        $FutureProvider<CommunityUserProfile> {
  CommunityProfileProvider._({
    required CommunityProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityProfileHash();

  @override
  String toString() {
    return r'communityProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CommunityUserProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CommunityUserProfile> create(Ref ref) {
    final argument = this.argument as String;
    return communityProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityProfileHash() => r'0129f5ea2d1118a81df48120d17360f75c439884';

final class CommunityProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CommunityUserProfile>, String> {
  CommunityProfileFamily._()
    : super(
        retry: null,
        name: r'communityProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityProfileProvider call(String userId) =>
      CommunityProfileProvider._(argument: userId, from: this);

  @override
  String toString() => r'communityProfileProvider';
}

@ProviderFor(CommunitySettingsController)
final communitySettingsControllerProvider =
    CommunitySettingsControllerProvider._();

final class CommunitySettingsControllerProvider
    extends
        $AsyncNotifierProvider<CommunitySettingsController, CommunitySettings> {
  CommunitySettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communitySettingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communitySettingsControllerHash();

  @$internal
  @override
  CommunitySettingsController create() => CommunitySettingsController();
}

String _$communitySettingsControllerHash() =>
    r'040f395f71df28c53634e7bd79793dcf233439ad';

abstract class _$CommunitySettingsController
    extends $AsyncNotifier<CommunitySettings> {
  FutureOr<CommunitySettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CommunitySettings>, CommunitySettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CommunitySettings>, CommunitySettings>,
              AsyncValue<CommunitySettings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(userTrainingDayShares)
final userTrainingDaySharesProvider = UserTrainingDaySharesFamily._();

final class UserTrainingDaySharesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TrainingDayShare>>,
          List<TrainingDayShare>,
          FutureOr<List<TrainingDayShare>>
        >
    with
        $FutureModifier<List<TrainingDayShare>>,
        $FutureProvider<List<TrainingDayShare>> {
  UserTrainingDaySharesProvider._({
    required UserTrainingDaySharesFamily super.from,
    required (String, {bool enabled}) super.argument,
  }) : super(
         retry: null,
         name: r'userTrainingDaySharesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userTrainingDaySharesHash();

  @override
  String toString() {
    return r'userTrainingDaySharesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<TrainingDayShare>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TrainingDayShare>> create(Ref ref) {
    final argument = this.argument as (String, {bool enabled});
    return userTrainingDayShares(ref, argument.$1, enabled: argument.enabled);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTrainingDaySharesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userTrainingDaySharesHash() =>
    r'352af26f916fd90049ea7b4666a739be346fb378';

final class UserTrainingDaySharesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<TrainingDayShare>>,
          (String, {bool enabled})
        > {
  UserTrainingDaySharesFamily._()
    : super(
        retry: null,
        name: r'userTrainingDaySharesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserTrainingDaySharesProvider call(String userId, {required bool enabled}) =>
      UserTrainingDaySharesProvider._(
        argument: (userId, enabled: enabled),
        from: this,
      );

  @override
  String toString() => r'userTrainingDaySharesProvider';
}

@ProviderFor(CommunityFeedController)
final communityFeedControllerProvider = CommunityFeedControllerProvider._();

final class CommunityFeedControllerProvider
    extends
        $AsyncNotifierProvider<CommunityFeedController, CommunityFeedState> {
  CommunityFeedControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityFeedControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityFeedControllerHash();

  @$internal
  @override
  CommunityFeedController create() => CommunityFeedController();
}

String _$communityFeedControllerHash() =>
    r'f1c6d42f581f6b84ab9f447345760ee0f59cb104';

abstract class _$CommunityFeedController
    extends $AsyncNotifier<CommunityFeedState> {
  FutureOr<CommunityFeedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CommunityFeedState>, CommunityFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CommunityFeedState>, CommunityFeedState>,
              AsyncValue<CommunityFeedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FriendsController)
final friendsControllerProvider = FriendsControllerProvider._();

final class FriendsControllerProvider
    extends $AsyncNotifierProvider<FriendsController, List<Friend>> {
  FriendsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendsControllerHash();

  @$internal
  @override
  FriendsController create() => FriendsController();
}

String _$friendsControllerHash() => r'e5c21b8a67bee97e79aa227d98d8b3ce6338ca4e';

abstract class _$FriendsController extends $AsyncNotifier<List<Friend>> {
  FutureOr<List<Friend>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Friend>>, List<Friend>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Friend>>, List<Friend>>,
              AsyncValue<List<Friend>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(friendRequests)
final friendRequestsProvider = FriendRequestsFamily._();

final class FriendRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FriendRequest>>,
          List<FriendRequest>,
          FutureOr<List<FriendRequest>>
        >
    with
        $FutureModifier<List<FriendRequest>>,
        $FutureProvider<List<FriendRequest>> {
  FriendRequestsProvider._({
    required FriendRequestsFamily super.from,
    required RequestDirection super.argument,
  }) : super(
         retry: null,
         name: r'friendRequestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$friendRequestsHash();

  @override
  String toString() {
    return r'friendRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FriendRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FriendRequest>> create(Ref ref) {
    final argument = this.argument as RequestDirection;
    return friendRequests(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendRequestsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$friendRequestsHash() => r'acf66e1b22d9a6353febaf4fa8a011701c35ba82';

final class FriendRequestsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<FriendRequest>>,
          RequestDirection
        > {
  FriendRequestsFamily._()
    : super(
        retry: null,
        name: r'friendRequestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FriendRequestsProvider call(RequestDirection direction) =>
      FriendRequestsProvider._(argument: direction, from: this);

  @override
  String toString() => r'friendRequestsProvider';
}

@ProviderFor(FriendActionController)
final friendActionControllerProvider = FriendActionControllerProvider._();

final class FriendActionControllerProvider
    extends $AsyncNotifierProvider<FriendActionController, void> {
  FriendActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendActionControllerHash();

  @$internal
  @override
  FriendActionController create() => FriendActionController();
}

String _$friendActionControllerHash() =>
    r'4a35f6f6db601891a95ddbd6f2d2e773efe055ef';

abstract class _$FriendActionController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ShareActionController)
final shareActionControllerProvider = ShareActionControllerProvider._();

final class ShareActionControllerProvider
    extends $AsyncNotifierProvider<ShareActionController, void> {
  ShareActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shareActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shareActionControllerHash();

  @$internal
  @override
  ShareActionController create() => ShareActionController();
}

String _$shareActionControllerHash() =>
    r'c1fd35aca26995705cab32fb5c0f91c64f4d5f6f';

abstract class _$ShareActionController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
