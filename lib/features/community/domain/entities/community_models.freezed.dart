// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityUserSummary {

 String get id; String get fullName; String? get email; String? get avatarUrl; String? get bio; String? get gender; FriendStatus get friendStatus; String? get friendshipId; RequestDirection? get requestDirection;
/// Create a copy of CommunityUserSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUserSummaryCopyWith<CommunityUserSummary> get copyWith => _$CommunityUserSummaryCopyWithImpl<CommunityUserSummary>(this as CommunityUserSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUserSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,avatarUrl,bio,gender,friendStatus,friendshipId,requestDirection);

@override
String toString() {
  return 'CommunityUserSummary(id: $id, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendStatus: $friendStatus, friendshipId: $friendshipId, requestDirection: $requestDirection)';
}


}

/// @nodoc
abstract mixin class $CommunityUserSummaryCopyWith<$Res>  {
  factory $CommunityUserSummaryCopyWith(CommunityUserSummary value, $Res Function(CommunityUserSummary) _then) = _$CommunityUserSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String? email, String? avatarUrl, String? bio, String? gender, FriendStatus friendStatus, String? friendshipId, RequestDirection? requestDirection
});




}
/// @nodoc
class _$CommunityUserSummaryCopyWithImpl<$Res>
    implements $CommunityUserSummaryCopyWith<$Res> {
  _$CommunityUserSummaryCopyWithImpl(this._self, this._then);

  final CommunityUserSummary _self;
  final $Res Function(CommunityUserSummary) _then;

/// Create a copy of CommunityUserSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendStatus = null,Object? friendshipId = freezed,Object? requestDirection = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: null == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as FriendStatus,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as RequestDirection?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityUserSummary].
extension CommunityUserSummaryPatterns on CommunityUserSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityUserSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityUserSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityUserSummary value)  $default,){
final _that = this;
switch (_that) {
case _CommunityUserSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityUserSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityUserSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String? email,  String? avatarUrl,  String? bio,  String? gender,  FriendStatus friendStatus,  String? friendshipId,  RequestDirection? requestDirection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityUserSummary() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendStatus,_that.friendshipId,_that.requestDirection);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String? email,  String? avatarUrl,  String? bio,  String? gender,  FriendStatus friendStatus,  String? friendshipId,  RequestDirection? requestDirection)  $default,) {final _that = this;
switch (_that) {
case _CommunityUserSummary():
return $default(_that.id,_that.fullName,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendStatus,_that.friendshipId,_that.requestDirection);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String? email,  String? avatarUrl,  String? bio,  String? gender,  FriendStatus friendStatus,  String? friendshipId,  RequestDirection? requestDirection)?  $default,) {final _that = this;
switch (_that) {
case _CommunityUserSummary() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendStatus,_that.friendshipId,_that.requestDirection);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityUserSummary extends CommunityUserSummary {
  const _CommunityUserSummary({required this.id, required this.fullName, this.email, this.avatarUrl, this.bio, this.gender, this.friendStatus = FriendStatus.none, this.friendshipId, this.requestDirection}): super._();
  

@override final  String id;
@override final  String fullName;
@override final  String? email;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? gender;
@override@JsonKey() final  FriendStatus friendStatus;
@override final  String? friendshipId;
@override final  RequestDirection? requestDirection;

/// Create a copy of CommunityUserSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityUserSummaryCopyWith<_CommunityUserSummary> get copyWith => __$CommunityUserSummaryCopyWithImpl<_CommunityUserSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityUserSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,avatarUrl,bio,gender,friendStatus,friendshipId,requestDirection);

@override
String toString() {
  return 'CommunityUserSummary(id: $id, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendStatus: $friendStatus, friendshipId: $friendshipId, requestDirection: $requestDirection)';
}


}

/// @nodoc
abstract mixin class _$CommunityUserSummaryCopyWith<$Res> implements $CommunityUserSummaryCopyWith<$Res> {
  factory _$CommunityUserSummaryCopyWith(_CommunityUserSummary value, $Res Function(_CommunityUserSummary) _then) = __$CommunityUserSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String? email, String? avatarUrl, String? bio, String? gender, FriendStatus friendStatus, String? friendshipId, RequestDirection? requestDirection
});




}
/// @nodoc
class __$CommunityUserSummaryCopyWithImpl<$Res>
    implements _$CommunityUserSummaryCopyWith<$Res> {
  __$CommunityUserSummaryCopyWithImpl(this._self, this._then);

  final _CommunityUserSummary _self;
  final $Res Function(_CommunityUserSummary) _then;

/// Create a copy of CommunityUserSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendStatus = null,Object? friendshipId = freezed,Object? requestDirection = freezed,}) {
  return _then(_CommunityUserSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: null == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as FriendStatus,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as RequestDirection?,
  ));
}


}

/// @nodoc
mixin _$CommunityUserProfile {

 String get id; String get fullName; int get level; bool get canViewStats; Big3Prs get big3Prs; int get totalTrainingDurationSeconds; double get totalTrainingVolume; String? get email; String? get avatarUrl; String? get bio; String? get gender; String? get friendshipId; String? get developmentDirection; String? get trainingDiscipline; FriendStatus get friendStatus; RequestDirection? get requestDirection; double? get height; double? get latestBodyweight; double? get bmi; String? get bmiCategory; int? get currentStreak; double? get dotsScore; double? get big3Total;
/// Create a copy of CommunityUserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUserProfileCopyWith<CommunityUserProfile> get copyWith => _$CommunityUserProfileCopyWithImpl<CommunityUserProfile>(this as CommunityUserProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.level, level) || other.level == level)&&(identical(other.canViewStats, canViewStats) || other.canViewStats == canViewStats)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.totalTrainingDurationSeconds, totalTrainingDurationSeconds) || other.totalTrainingDurationSeconds == totalTrainingDurationSeconds)&&(identical(other.totalTrainingVolume, totalTrainingVolume) || other.totalTrainingVolume == totalTrainingVolume)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection)&&(identical(other.height, height) || other.height == height)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.big3Total, big3Total) || other.big3Total == big3Total));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,level,canViewStats,big3Prs,totalTrainingDurationSeconds,totalTrainingVolume,email,avatarUrl,bio,gender,friendshipId,developmentDirection,trainingDiscipline,friendStatus,requestDirection,height,latestBodyweight,bmi,bmiCategory,currentStreak,dotsScore,big3Total]);

@override
String toString() {
  return 'CommunityUserProfile(id: $id, fullName: $fullName, level: $level, canViewStats: $canViewStats, big3Prs: $big3Prs, totalTrainingDurationSeconds: $totalTrainingDurationSeconds, totalTrainingVolume: $totalTrainingVolume, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendshipId: $friendshipId, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, friendStatus: $friendStatus, requestDirection: $requestDirection, height: $height, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, currentStreak: $currentStreak, dotsScore: $dotsScore, big3Total: $big3Total)';
}


}

/// @nodoc
abstract mixin class $CommunityUserProfileCopyWith<$Res>  {
  factory $CommunityUserProfileCopyWith(CommunityUserProfile value, $Res Function(CommunityUserProfile) _then) = _$CommunityUserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, int level, bool canViewStats, Big3Prs big3Prs, int totalTrainingDurationSeconds, double totalTrainingVolume, String? email, String? avatarUrl, String? bio, String? gender, String? friendshipId, String? developmentDirection, String? trainingDiscipline, FriendStatus friendStatus, RequestDirection? requestDirection, double? height, double? latestBodyweight, double? bmi, String? bmiCategory, int? currentStreak, double? dotsScore, double? big3Total
});


$Big3PrsCopyWith<$Res> get big3Prs;

}
/// @nodoc
class _$CommunityUserProfileCopyWithImpl<$Res>
    implements $CommunityUserProfileCopyWith<$Res> {
  _$CommunityUserProfileCopyWithImpl(this._self, this._then);

  final CommunityUserProfile _self;
  final $Res Function(CommunityUserProfile) _then;

/// Create a copy of CommunityUserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? level = null,Object? canViewStats = null,Object? big3Prs = null,Object? totalTrainingDurationSeconds = null,Object? totalTrainingVolume = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendshipId = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? friendStatus = null,Object? requestDirection = freezed,Object? height = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? currentStreak = freezed,Object? dotsScore = freezed,Object? big3Total = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,canViewStats: null == canViewStats ? _self.canViewStats : canViewStats // ignore: cast_nullable_to_non_nullable
as bool,big3Prs: null == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3Prs,totalTrainingDurationSeconds: null == totalTrainingDurationSeconds ? _self.totalTrainingDurationSeconds : totalTrainingDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalTrainingVolume: null == totalTrainingVolume ? _self.totalTrainingVolume : totalTrainingVolume // ignore: cast_nullable_to_non_nullable
as double,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
as String?,trainingDiscipline: freezed == trainingDiscipline ? _self.trainingDiscipline : trainingDiscipline // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: null == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as FriendStatus,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as RequestDirection?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,currentStreak: freezed == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,big3Total: freezed == big3Total ? _self.big3Total : big3Total // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of CommunityUserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Big3PrsCopyWith<$Res> get big3Prs {
  
  return $Big3PrsCopyWith<$Res>(_self.big3Prs, (value) {
    return _then(_self.copyWith(big3Prs: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityUserProfile].
extension CommunityUserProfilePatterns on CommunityUserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityUserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityUserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityUserProfile value)  $default,){
final _that = this;
switch (_that) {
case _CommunityUserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityUserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityUserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  int level,  bool canViewStats,  Big3Prs big3Prs,  int totalTrainingDurationSeconds,  double totalTrainingVolume,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendshipId,  String? developmentDirection,  String? trainingDiscipline,  FriendStatus friendStatus,  RequestDirection? requestDirection,  double? height,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  int? currentStreak,  double? dotsScore,  double? big3Total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityUserProfile() when $default != null:
return $default(_that.id,_that.fullName,_that.level,_that.canViewStats,_that.big3Prs,_that.totalTrainingDurationSeconds,_that.totalTrainingVolume,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendshipId,_that.developmentDirection,_that.trainingDiscipline,_that.friendStatus,_that.requestDirection,_that.height,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.currentStreak,_that.dotsScore,_that.big3Total);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  int level,  bool canViewStats,  Big3Prs big3Prs,  int totalTrainingDurationSeconds,  double totalTrainingVolume,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendshipId,  String? developmentDirection,  String? trainingDiscipline,  FriendStatus friendStatus,  RequestDirection? requestDirection,  double? height,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  int? currentStreak,  double? dotsScore,  double? big3Total)  $default,) {final _that = this;
switch (_that) {
case _CommunityUserProfile():
return $default(_that.id,_that.fullName,_that.level,_that.canViewStats,_that.big3Prs,_that.totalTrainingDurationSeconds,_that.totalTrainingVolume,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendshipId,_that.developmentDirection,_that.trainingDiscipline,_that.friendStatus,_that.requestDirection,_that.height,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.currentStreak,_that.dotsScore,_that.big3Total);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  int level,  bool canViewStats,  Big3Prs big3Prs,  int totalTrainingDurationSeconds,  double totalTrainingVolume,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendshipId,  String? developmentDirection,  String? trainingDiscipline,  FriendStatus friendStatus,  RequestDirection? requestDirection,  double? height,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  int? currentStreak,  double? dotsScore,  double? big3Total)?  $default,) {final _that = this;
switch (_that) {
case _CommunityUserProfile() when $default != null:
return $default(_that.id,_that.fullName,_that.level,_that.canViewStats,_that.big3Prs,_that.totalTrainingDurationSeconds,_that.totalTrainingVolume,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendshipId,_that.developmentDirection,_that.trainingDiscipline,_that.friendStatus,_that.requestDirection,_that.height,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.currentStreak,_that.dotsScore,_that.big3Total);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityUserProfile extends CommunityUserProfile {
  const _CommunityUserProfile({required this.id, required this.fullName, required this.level, required this.canViewStats, required this.big3Prs, required this.totalTrainingDurationSeconds, required this.totalTrainingVolume, this.email, this.avatarUrl, this.bio, this.gender, this.friendshipId, this.developmentDirection, this.trainingDiscipline, this.friendStatus = FriendStatus.none, this.requestDirection, this.height, this.latestBodyweight, this.bmi, this.bmiCategory, this.currentStreak, this.dotsScore, this.big3Total}): super._();
  

@override final  String id;
@override final  String fullName;
@override final  int level;
@override final  bool canViewStats;
@override final  Big3Prs big3Prs;
@override final  int totalTrainingDurationSeconds;
@override final  double totalTrainingVolume;
@override final  String? email;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? gender;
@override final  String? friendshipId;
@override final  String? developmentDirection;
@override final  String? trainingDiscipline;
@override@JsonKey() final  FriendStatus friendStatus;
@override final  RequestDirection? requestDirection;
@override final  double? height;
@override final  double? latestBodyweight;
@override final  double? bmi;
@override final  String? bmiCategory;
@override final  int? currentStreak;
@override final  double? dotsScore;
@override final  double? big3Total;

/// Create a copy of CommunityUserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityUserProfileCopyWith<_CommunityUserProfile> get copyWith => __$CommunityUserProfileCopyWithImpl<_CommunityUserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityUserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.level, level) || other.level == level)&&(identical(other.canViewStats, canViewStats) || other.canViewStats == canViewStats)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.totalTrainingDurationSeconds, totalTrainingDurationSeconds) || other.totalTrainingDurationSeconds == totalTrainingDurationSeconds)&&(identical(other.totalTrainingVolume, totalTrainingVolume) || other.totalTrainingVolume == totalTrainingVolume)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection)&&(identical(other.height, height) || other.height == height)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.big3Total, big3Total) || other.big3Total == big3Total));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,level,canViewStats,big3Prs,totalTrainingDurationSeconds,totalTrainingVolume,email,avatarUrl,bio,gender,friendshipId,developmentDirection,trainingDiscipline,friendStatus,requestDirection,height,latestBodyweight,bmi,bmiCategory,currentStreak,dotsScore,big3Total]);

@override
String toString() {
  return 'CommunityUserProfile(id: $id, fullName: $fullName, level: $level, canViewStats: $canViewStats, big3Prs: $big3Prs, totalTrainingDurationSeconds: $totalTrainingDurationSeconds, totalTrainingVolume: $totalTrainingVolume, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendshipId: $friendshipId, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, friendStatus: $friendStatus, requestDirection: $requestDirection, height: $height, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, currentStreak: $currentStreak, dotsScore: $dotsScore, big3Total: $big3Total)';
}


}

/// @nodoc
abstract mixin class _$CommunityUserProfileCopyWith<$Res> implements $CommunityUserProfileCopyWith<$Res> {
  factory _$CommunityUserProfileCopyWith(_CommunityUserProfile value, $Res Function(_CommunityUserProfile) _then) = __$CommunityUserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, int level, bool canViewStats, Big3Prs big3Prs, int totalTrainingDurationSeconds, double totalTrainingVolume, String? email, String? avatarUrl, String? bio, String? gender, String? friendshipId, String? developmentDirection, String? trainingDiscipline, FriendStatus friendStatus, RequestDirection? requestDirection, double? height, double? latestBodyweight, double? bmi, String? bmiCategory, int? currentStreak, double? dotsScore, double? big3Total
});


@override $Big3PrsCopyWith<$Res> get big3Prs;

}
/// @nodoc
class __$CommunityUserProfileCopyWithImpl<$Res>
    implements _$CommunityUserProfileCopyWith<$Res> {
  __$CommunityUserProfileCopyWithImpl(this._self, this._then);

  final _CommunityUserProfile _self;
  final $Res Function(_CommunityUserProfile) _then;

/// Create a copy of CommunityUserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? level = null,Object? canViewStats = null,Object? big3Prs = null,Object? totalTrainingDurationSeconds = null,Object? totalTrainingVolume = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendshipId = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? friendStatus = null,Object? requestDirection = freezed,Object? height = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? currentStreak = freezed,Object? dotsScore = freezed,Object? big3Total = freezed,}) {
  return _then(_CommunityUserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,canViewStats: null == canViewStats ? _self.canViewStats : canViewStats // ignore: cast_nullable_to_non_nullable
as bool,big3Prs: null == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3Prs,totalTrainingDurationSeconds: null == totalTrainingDurationSeconds ? _self.totalTrainingDurationSeconds : totalTrainingDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalTrainingVolume: null == totalTrainingVolume ? _self.totalTrainingVolume : totalTrainingVolume // ignore: cast_nullable_to_non_nullable
as double,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
as String?,trainingDiscipline: freezed == trainingDiscipline ? _self.trainingDiscipline : trainingDiscipline // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: null == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as FriendStatus,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as RequestDirection?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,currentStreak: freezed == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,big3Total: freezed == big3Total ? _self.big3Total : big3Total // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of CommunityUserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Big3PrsCopyWith<$Res> get big3Prs {
  
  return $Big3PrsCopyWith<$Res>(_self.big3Prs, (value) {
    return _then(_self.copyWith(big3Prs: value));
  });
}
}

/// @nodoc
mixin _$Big3Prs {

 double? get squat; double? get bench; double? get deadlift;
/// Create a copy of Big3Prs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Big3PrsCopyWith<Big3Prs> get copyWith => _$Big3PrsCopyWithImpl<Big3Prs>(this as Big3Prs, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Big3Prs&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift));
}


@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift);

@override
String toString() {
  return 'Big3Prs(squat: $squat, bench: $bench, deadlift: $deadlift)';
}


}

/// @nodoc
abstract mixin class $Big3PrsCopyWith<$Res>  {
  factory $Big3PrsCopyWith(Big3Prs value, $Res Function(Big3Prs) _then) = _$Big3PrsCopyWithImpl;
@useResult
$Res call({
 double? squat, double? bench, double? deadlift
});




}
/// @nodoc
class _$Big3PrsCopyWithImpl<$Res>
    implements $Big3PrsCopyWith<$Res> {
  _$Big3PrsCopyWithImpl(this._self, this._then);

  final Big3Prs _self;
  final $Res Function(Big3Prs) _then;

/// Create a copy of Big3Prs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? squat = freezed,Object? bench = freezed,Object? deadlift = freezed,}) {
  return _then(_self.copyWith(
squat: freezed == squat ? _self.squat : squat // ignore: cast_nullable_to_non_nullable
as double?,bench: freezed == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as double?,deadlift: freezed == deadlift ? _self.deadlift : deadlift // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Big3Prs].
extension Big3PrsPatterns on Big3Prs {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Big3Prs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Big3Prs() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Big3Prs value)  $default,){
final _that = this;
switch (_that) {
case _Big3Prs():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Big3Prs value)?  $default,){
final _that = this;
switch (_that) {
case _Big3Prs() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? squat,  double? bench,  double? deadlift)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Big3Prs() when $default != null:
return $default(_that.squat,_that.bench,_that.deadlift);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? squat,  double? bench,  double? deadlift)  $default,) {final _that = this;
switch (_that) {
case _Big3Prs():
return $default(_that.squat,_that.bench,_that.deadlift);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? squat,  double? bench,  double? deadlift)?  $default,) {final _that = this;
switch (_that) {
case _Big3Prs() when $default != null:
return $default(_that.squat,_that.bench,_that.deadlift);case _:
  return null;

}
}

}

/// @nodoc


class _Big3Prs implements Big3Prs {
  const _Big3Prs({this.squat, this.bench, this.deadlift});
  

@override final  double? squat;
@override final  double? bench;
@override final  double? deadlift;

/// Create a copy of Big3Prs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Big3PrsCopyWith<_Big3Prs> get copyWith => __$Big3PrsCopyWithImpl<_Big3Prs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Big3Prs&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift));
}


@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift);

@override
String toString() {
  return 'Big3Prs(squat: $squat, bench: $bench, deadlift: $deadlift)';
}


}

/// @nodoc
abstract mixin class _$Big3PrsCopyWith<$Res> implements $Big3PrsCopyWith<$Res> {
  factory _$Big3PrsCopyWith(_Big3Prs value, $Res Function(_Big3Prs) _then) = __$Big3PrsCopyWithImpl;
@override @useResult
$Res call({
 double? squat, double? bench, double? deadlift
});




}
/// @nodoc
class __$Big3PrsCopyWithImpl<$Res>
    implements _$Big3PrsCopyWith<$Res> {
  __$Big3PrsCopyWithImpl(this._self, this._then);

  final _Big3Prs _self;
  final $Res Function(_Big3Prs) _then;

/// Create a copy of Big3Prs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? squat = freezed,Object? bench = freezed,Object? deadlift = freezed,}) {
  return _then(_Big3Prs(
squat: freezed == squat ? _self.squat : squat // ignore: cast_nullable_to_non_nullable
as double?,bench: freezed == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as double?,deadlift: freezed == deadlift ? _self.deadlift : deadlift // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$Friend {

 String get userId; String get fullName; String get email; DateTime get friendsSince; String? get avatarUrl; String? get bio;
/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendCopyWith<Friend> get copyWith => _$FriendCopyWithImpl<Friend>(this as Friend, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Friend&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.friendsSince, friendsSince) || other.friendsSince == friendsSince)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio));
}


@override
int get hashCode => Object.hash(runtimeType,userId,fullName,email,friendsSince,avatarUrl,bio);

@override
String toString() {
  return 'Friend(userId: $userId, fullName: $fullName, email: $email, friendsSince: $friendsSince, avatarUrl: $avatarUrl, bio: $bio)';
}


}

/// @nodoc
abstract mixin class $FriendCopyWith<$Res>  {
  factory $FriendCopyWith(Friend value, $Res Function(Friend) _then) = _$FriendCopyWithImpl;
@useResult
$Res call({
 String userId, String fullName, String email, DateTime friendsSince, String? avatarUrl, String? bio
});




}
/// @nodoc
class _$FriendCopyWithImpl<$Res>
    implements $FriendCopyWith<$Res> {
  _$FriendCopyWithImpl(this._self, this._then);

  final Friend _self;
  final $Res Function(Friend) _then;

/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? fullName = null,Object? email = null,Object? friendsSince = null,Object? avatarUrl = freezed,Object? bio = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,friendsSince: null == friendsSince ? _self.friendsSince : friendsSince // ignore: cast_nullable_to_non_nullable
as DateTime,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Friend].
extension FriendPatterns on Friend {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Friend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Friend() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Friend value)  $default,){
final _that = this;
switch (_that) {
case _Friend():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Friend value)?  $default,){
final _that = this;
switch (_that) {
case _Friend() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String fullName,  String email,  DateTime friendsSince,  String? avatarUrl,  String? bio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Friend() when $default != null:
return $default(_that.userId,_that.fullName,_that.email,_that.friendsSince,_that.avatarUrl,_that.bio);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String fullName,  String email,  DateTime friendsSince,  String? avatarUrl,  String? bio)  $default,) {final _that = this;
switch (_that) {
case _Friend():
return $default(_that.userId,_that.fullName,_that.email,_that.friendsSince,_that.avatarUrl,_that.bio);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String fullName,  String email,  DateTime friendsSince,  String? avatarUrl,  String? bio)?  $default,) {final _that = this;
switch (_that) {
case _Friend() when $default != null:
return $default(_that.userId,_that.fullName,_that.email,_that.friendsSince,_that.avatarUrl,_that.bio);case _:
  return null;

}
}

}

/// @nodoc


class _Friend implements Friend {
  const _Friend({required this.userId, required this.fullName, required this.email, required this.friendsSince, this.avatarUrl, this.bio});
  

@override final  String userId;
@override final  String fullName;
@override final  String email;
@override final  DateTime friendsSince;
@override final  String? avatarUrl;
@override final  String? bio;

/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendCopyWith<_Friend> get copyWith => __$FriendCopyWithImpl<_Friend>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Friend&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.friendsSince, friendsSince) || other.friendsSince == friendsSince)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio));
}


@override
int get hashCode => Object.hash(runtimeType,userId,fullName,email,friendsSince,avatarUrl,bio);

@override
String toString() {
  return 'Friend(userId: $userId, fullName: $fullName, email: $email, friendsSince: $friendsSince, avatarUrl: $avatarUrl, bio: $bio)';
}


}

/// @nodoc
abstract mixin class _$FriendCopyWith<$Res> implements $FriendCopyWith<$Res> {
  factory _$FriendCopyWith(_Friend value, $Res Function(_Friend) _then) = __$FriendCopyWithImpl;
@override @useResult
$Res call({
 String userId, String fullName, String email, DateTime friendsSince, String? avatarUrl, String? bio
});




}
/// @nodoc
class __$FriendCopyWithImpl<$Res>
    implements _$FriendCopyWith<$Res> {
  __$FriendCopyWithImpl(this._self, this._then);

  final _Friend _self;
  final $Res Function(_Friend) _then;

/// Create a copy of Friend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? fullName = null,Object? email = null,Object? friendsSince = null,Object? avatarUrl = freezed,Object? bio = freezed,}) {
  return _then(_Friend(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,friendsSince: null == friendsSince ? _self.friendsSince : friendsSince // ignore: cast_nullable_to_non_nullable
as DateTime,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FriendRequest {

 String get id; String get userId; String get fullName; String get email; RequestDirection get direction; FriendStatus get status; DateTime get createdAt; String? get avatarUrl; DateTime? get respondedAt;
/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCopyWith<FriendRequest> get copyWith => _$FriendRequestCopyWithImpl<FriendRequest>(this as FriendRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,email,direction,status,createdAt,avatarUrl,respondedAt);

@override
String toString() {
  return 'FriendRequest(id: $id, userId: $userId, fullName: $fullName, email: $email, direction: $direction, status: $status, createdAt: $createdAt, avatarUrl: $avatarUrl, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class $FriendRequestCopyWith<$Res>  {
  factory $FriendRequestCopyWith(FriendRequest value, $Res Function(FriendRequest) _then) = _$FriendRequestCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String fullName, String email, RequestDirection direction, FriendStatus status, DateTime createdAt, String? avatarUrl, DateTime? respondedAt
});




}
/// @nodoc
class _$FriendRequestCopyWithImpl<$Res>
    implements $FriendRequestCopyWith<$Res> {
  _$FriendRequestCopyWithImpl(this._self, this._then);

  final FriendRequest _self;
  final $Res Function(FriendRequest) _then;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? email = null,Object? direction = null,Object? status = null,Object? createdAt = null,Object? avatarUrl = freezed,Object? respondedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as RequestDirection,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendRequest].
extension FriendRequestPatterns on FriendRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequest value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String fullName,  String email,  RequestDirection direction,  FriendStatus status,  DateTime createdAt,  String? avatarUrl,  DateTime? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that.id,_that.userId,_that.fullName,_that.email,_that.direction,_that.status,_that.createdAt,_that.avatarUrl,_that.respondedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String fullName,  String email,  RequestDirection direction,  FriendStatus status,  DateTime createdAt,  String? avatarUrl,  DateTime? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _FriendRequest():
return $default(_that.id,_that.userId,_that.fullName,_that.email,_that.direction,_that.status,_that.createdAt,_that.avatarUrl,_that.respondedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String fullName,  String email,  RequestDirection direction,  FriendStatus status,  DateTime createdAt,  String? avatarUrl,  DateTime? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that.id,_that.userId,_that.fullName,_that.email,_that.direction,_that.status,_that.createdAt,_that.avatarUrl,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FriendRequest implements FriendRequest {
  const _FriendRequest({required this.id, required this.userId, required this.fullName, required this.email, required this.direction, required this.status, required this.createdAt, this.avatarUrl, this.respondedAt});
  

@override final  String id;
@override final  String userId;
@override final  String fullName;
@override final  String email;
@override final  RequestDirection direction;
@override final  FriendStatus status;
@override final  DateTime createdAt;
@override final  String? avatarUrl;
@override final  DateTime? respondedAt;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestCopyWith<_FriendRequest> get copyWith => __$FriendRequestCopyWithImpl<_FriendRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,email,direction,status,createdAt,avatarUrl,respondedAt);

@override
String toString() {
  return 'FriendRequest(id: $id, userId: $userId, fullName: $fullName, email: $email, direction: $direction, status: $status, createdAt: $createdAt, avatarUrl: $avatarUrl, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestCopyWith<$Res> implements $FriendRequestCopyWith<$Res> {
  factory _$FriendRequestCopyWith(_FriendRequest value, $Res Function(_FriendRequest) _then) = __$FriendRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String fullName, String email, RequestDirection direction, FriendStatus status, DateTime createdAt, String? avatarUrl, DateTime? respondedAt
});




}
/// @nodoc
class __$FriendRequestCopyWithImpl<$Res>
    implements _$FriendRequestCopyWith<$Res> {
  __$FriendRequestCopyWithImpl(this._self, this._then);

  final _FriendRequest _self;
  final $Res Function(_FriendRequest) _then;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? email = null,Object? direction = null,Object? status = null,Object? createdAt = null,Object? avatarUrl = freezed,Object? respondedAt = freezed,}) {
  return _then(_FriendRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as RequestDirection,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$TrainingDayShare {

 String get id; String get userId; String get userFullName; String get sourceDailyWorkoutId; DateTime get workoutDate; String get dayOfWeek; String get dayStatus; int get exerciseCount; int get completedSets; double get totalVolume; int get totalDurationSeconds; bool get hasPersonalRecord; int get loveCount; bool get lovedByCurrentUser; DateTime get createdAt; List<TrainingDayShareExercise> get exercises; bool get isReusable; String? get userAvatarUrl; double? get averageRpe; String? get caption;
/// Create a copy of TrainingDayShare
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingDayShareCopyWith<TrainingDayShare> get copyWith => _$TrainingDayShareCopyWithImpl<TrainingDayShare>(this as TrainingDayShare, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingDayShare&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.sourceDailyWorkoutId, sourceDailyWorkoutId) || other.sourceDailyWorkoutId == sourceDailyWorkoutId)&&(identical(other.workoutDate, workoutDate) || other.workoutDate == workoutDate)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.dayStatus, dayStatus) || other.dayStatus == dayStatus)&&(identical(other.exerciseCount, exerciseCount) || other.exerciseCount == exerciseCount)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.hasPersonalRecord, hasPersonalRecord) || other.hasPersonalRecord == hasPersonalRecord)&&(identical(other.loveCount, loveCount) || other.loveCount == loveCount)&&(identical(other.lovedByCurrentUser, lovedByCurrentUser) || other.lovedByCurrentUser == lovedByCurrentUser)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.exercises, exercises)&&(identical(other.isReusable, isReusable) || other.isReusable == isReusable)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl)&&(identical(other.averageRpe, averageRpe) || other.averageRpe == averageRpe)&&(identical(other.caption, caption) || other.caption == caption));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userFullName,sourceDailyWorkoutId,workoutDate,dayOfWeek,dayStatus,exerciseCount,completedSets,totalVolume,totalDurationSeconds,hasPersonalRecord,loveCount,lovedByCurrentUser,createdAt,const DeepCollectionEquality().hash(exercises),isReusable,userAvatarUrl,averageRpe,caption]);

@override
String toString() {
  return 'TrainingDayShare(id: $id, userId: $userId, userFullName: $userFullName, sourceDailyWorkoutId: $sourceDailyWorkoutId, workoutDate: $workoutDate, dayOfWeek: $dayOfWeek, dayStatus: $dayStatus, exerciseCount: $exerciseCount, completedSets: $completedSets, totalVolume: $totalVolume, totalDurationSeconds: $totalDurationSeconds, hasPersonalRecord: $hasPersonalRecord, loveCount: $loveCount, lovedByCurrentUser: $lovedByCurrentUser, createdAt: $createdAt, exercises: $exercises, isReusable: $isReusable, userAvatarUrl: $userAvatarUrl, averageRpe: $averageRpe, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $TrainingDayShareCopyWith<$Res>  {
  factory $TrainingDayShareCopyWith(TrainingDayShare value, $Res Function(TrainingDayShare) _then) = _$TrainingDayShareCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userFullName, String sourceDailyWorkoutId, DateTime workoutDate, String dayOfWeek, String dayStatus, int exerciseCount, int completedSets, double totalVolume, int totalDurationSeconds, bool hasPersonalRecord, int loveCount, bool lovedByCurrentUser, DateTime createdAt, List<TrainingDayShareExercise> exercises, bool isReusable, String? userAvatarUrl, double? averageRpe, String? caption
});




}
/// @nodoc
class _$TrainingDayShareCopyWithImpl<$Res>
    implements $TrainingDayShareCopyWith<$Res> {
  _$TrainingDayShareCopyWithImpl(this._self, this._then);

  final TrainingDayShare _self;
  final $Res Function(TrainingDayShare) _then;

/// Create a copy of TrainingDayShare
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? sourceDailyWorkoutId = null,Object? workoutDate = null,Object? dayOfWeek = null,Object? dayStatus = null,Object? exerciseCount = null,Object? completedSets = null,Object? totalVolume = null,Object? totalDurationSeconds = null,Object? hasPersonalRecord = null,Object? loveCount = null,Object? lovedByCurrentUser = null,Object? createdAt = null,Object? exercises = null,Object? isReusable = null,Object? userAvatarUrl = freezed,Object? averageRpe = freezed,Object? caption = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,sourceDailyWorkoutId: null == sourceDailyWorkoutId ? _self.sourceDailyWorkoutId : sourceDailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,workoutDate: null == workoutDate ? _self.workoutDate : workoutDate // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,dayStatus: null == dayStatus ? _self.dayStatus : dayStatus // ignore: cast_nullable_to_non_nullable
as String,exerciseCount: null == exerciseCount ? _self.exerciseCount : exerciseCount // ignore: cast_nullable_to_non_nullable
as int,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,hasPersonalRecord: null == hasPersonalRecord ? _self.hasPersonalRecord : hasPersonalRecord // ignore: cast_nullable_to_non_nullable
as bool,loveCount: null == loveCount ? _self.loveCount : loveCount // ignore: cast_nullable_to_non_nullable
as int,lovedByCurrentUser: null == lovedByCurrentUser ? _self.lovedByCurrentUser : lovedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<TrainingDayShareExercise>,isReusable: null == isReusable ? _self.isReusable : isReusable // ignore: cast_nullable_to_non_nullable
as bool,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,averageRpe: freezed == averageRpe ? _self.averageRpe : averageRpe // ignore: cast_nullable_to_non_nullable
as double?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingDayShare].
extension TrainingDaySharePatterns on TrainingDayShare {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingDayShare value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingDayShare() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingDayShare value)  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShare():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingDayShare value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShare() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userFullName,  String sourceDailyWorkoutId,  DateTime workoutDate,  String dayOfWeek,  String dayStatus,  int exerciseCount,  int completedSets,  double totalVolume,  int totalDurationSeconds,  bool hasPersonalRecord,  int loveCount,  bool lovedByCurrentUser,  DateTime createdAt,  List<TrainingDayShareExercise> exercises,  bool isReusable,  String? userAvatarUrl,  double? averageRpe,  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingDayShare() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.sourceDailyWorkoutId,_that.workoutDate,_that.dayOfWeek,_that.dayStatus,_that.exerciseCount,_that.completedSets,_that.totalVolume,_that.totalDurationSeconds,_that.hasPersonalRecord,_that.loveCount,_that.lovedByCurrentUser,_that.createdAt,_that.exercises,_that.isReusable,_that.userAvatarUrl,_that.averageRpe,_that.caption);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userFullName,  String sourceDailyWorkoutId,  DateTime workoutDate,  String dayOfWeek,  String dayStatus,  int exerciseCount,  int completedSets,  double totalVolume,  int totalDurationSeconds,  bool hasPersonalRecord,  int loveCount,  bool lovedByCurrentUser,  DateTime createdAt,  List<TrainingDayShareExercise> exercises,  bool isReusable,  String? userAvatarUrl,  double? averageRpe,  String? caption)  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShare():
return $default(_that.id,_that.userId,_that.userFullName,_that.sourceDailyWorkoutId,_that.workoutDate,_that.dayOfWeek,_that.dayStatus,_that.exerciseCount,_that.completedSets,_that.totalVolume,_that.totalDurationSeconds,_that.hasPersonalRecord,_that.loveCount,_that.lovedByCurrentUser,_that.createdAt,_that.exercises,_that.isReusable,_that.userAvatarUrl,_that.averageRpe,_that.caption);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userFullName,  String sourceDailyWorkoutId,  DateTime workoutDate,  String dayOfWeek,  String dayStatus,  int exerciseCount,  int completedSets,  double totalVolume,  int totalDurationSeconds,  bool hasPersonalRecord,  int loveCount,  bool lovedByCurrentUser,  DateTime createdAt,  List<TrainingDayShareExercise> exercises,  bool isReusable,  String? userAvatarUrl,  double? averageRpe,  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShare() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.sourceDailyWorkoutId,_that.workoutDate,_that.dayOfWeek,_that.dayStatus,_that.exerciseCount,_that.completedSets,_that.totalVolume,_that.totalDurationSeconds,_that.hasPersonalRecord,_that.loveCount,_that.lovedByCurrentUser,_that.createdAt,_that.exercises,_that.isReusable,_that.userAvatarUrl,_that.averageRpe,_that.caption);case _:
  return null;

}
}

}

/// @nodoc


class _TrainingDayShare implements TrainingDayShare {
  const _TrainingDayShare({required this.id, required this.userId, required this.userFullName, required this.sourceDailyWorkoutId, required this.workoutDate, required this.dayOfWeek, required this.dayStatus, required this.exerciseCount, required this.completedSets, required this.totalVolume, required this.totalDurationSeconds, required this.hasPersonalRecord, required this.loveCount, required this.lovedByCurrentUser, required this.createdAt, required final  List<TrainingDayShareExercise> exercises, this.isReusable = false, this.userAvatarUrl, this.averageRpe, this.caption}): _exercises = exercises;
  

@override final  String id;
@override final  String userId;
@override final  String userFullName;
@override final  String sourceDailyWorkoutId;
@override final  DateTime workoutDate;
@override final  String dayOfWeek;
@override final  String dayStatus;
@override final  int exerciseCount;
@override final  int completedSets;
@override final  double totalVolume;
@override final  int totalDurationSeconds;
@override final  bool hasPersonalRecord;
@override final  int loveCount;
@override final  bool lovedByCurrentUser;
@override final  DateTime createdAt;
 final  List<TrainingDayShareExercise> _exercises;
@override List<TrainingDayShareExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@override@JsonKey() final  bool isReusable;
@override final  String? userAvatarUrl;
@override final  double? averageRpe;
@override final  String? caption;

/// Create a copy of TrainingDayShare
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingDayShareCopyWith<_TrainingDayShare> get copyWith => __$TrainingDayShareCopyWithImpl<_TrainingDayShare>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingDayShare&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.sourceDailyWorkoutId, sourceDailyWorkoutId) || other.sourceDailyWorkoutId == sourceDailyWorkoutId)&&(identical(other.workoutDate, workoutDate) || other.workoutDate == workoutDate)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.dayStatus, dayStatus) || other.dayStatus == dayStatus)&&(identical(other.exerciseCount, exerciseCount) || other.exerciseCount == exerciseCount)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.hasPersonalRecord, hasPersonalRecord) || other.hasPersonalRecord == hasPersonalRecord)&&(identical(other.loveCount, loveCount) || other.loveCount == loveCount)&&(identical(other.lovedByCurrentUser, lovedByCurrentUser) || other.lovedByCurrentUser == lovedByCurrentUser)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.isReusable, isReusable) || other.isReusable == isReusable)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl)&&(identical(other.averageRpe, averageRpe) || other.averageRpe == averageRpe)&&(identical(other.caption, caption) || other.caption == caption));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userFullName,sourceDailyWorkoutId,workoutDate,dayOfWeek,dayStatus,exerciseCount,completedSets,totalVolume,totalDurationSeconds,hasPersonalRecord,loveCount,lovedByCurrentUser,createdAt,const DeepCollectionEquality().hash(_exercises),isReusable,userAvatarUrl,averageRpe,caption]);

@override
String toString() {
  return 'TrainingDayShare(id: $id, userId: $userId, userFullName: $userFullName, sourceDailyWorkoutId: $sourceDailyWorkoutId, workoutDate: $workoutDate, dayOfWeek: $dayOfWeek, dayStatus: $dayStatus, exerciseCount: $exerciseCount, completedSets: $completedSets, totalVolume: $totalVolume, totalDurationSeconds: $totalDurationSeconds, hasPersonalRecord: $hasPersonalRecord, loveCount: $loveCount, lovedByCurrentUser: $lovedByCurrentUser, createdAt: $createdAt, exercises: $exercises, isReusable: $isReusable, userAvatarUrl: $userAvatarUrl, averageRpe: $averageRpe, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$TrainingDayShareCopyWith<$Res> implements $TrainingDayShareCopyWith<$Res> {
  factory _$TrainingDayShareCopyWith(_TrainingDayShare value, $Res Function(_TrainingDayShare) _then) = __$TrainingDayShareCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userFullName, String sourceDailyWorkoutId, DateTime workoutDate, String dayOfWeek, String dayStatus, int exerciseCount, int completedSets, double totalVolume, int totalDurationSeconds, bool hasPersonalRecord, int loveCount, bool lovedByCurrentUser, DateTime createdAt, List<TrainingDayShareExercise> exercises, bool isReusable, String? userAvatarUrl, double? averageRpe, String? caption
});




}
/// @nodoc
class __$TrainingDayShareCopyWithImpl<$Res>
    implements _$TrainingDayShareCopyWith<$Res> {
  __$TrainingDayShareCopyWithImpl(this._self, this._then);

  final _TrainingDayShare _self;
  final $Res Function(_TrainingDayShare) _then;

/// Create a copy of TrainingDayShare
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? sourceDailyWorkoutId = null,Object? workoutDate = null,Object? dayOfWeek = null,Object? dayStatus = null,Object? exerciseCount = null,Object? completedSets = null,Object? totalVolume = null,Object? totalDurationSeconds = null,Object? hasPersonalRecord = null,Object? loveCount = null,Object? lovedByCurrentUser = null,Object? createdAt = null,Object? exercises = null,Object? isReusable = null,Object? userAvatarUrl = freezed,Object? averageRpe = freezed,Object? caption = freezed,}) {
  return _then(_TrainingDayShare(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,sourceDailyWorkoutId: null == sourceDailyWorkoutId ? _self.sourceDailyWorkoutId : sourceDailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,workoutDate: null == workoutDate ? _self.workoutDate : workoutDate // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,dayStatus: null == dayStatus ? _self.dayStatus : dayStatus // ignore: cast_nullable_to_non_nullable
as String,exerciseCount: null == exerciseCount ? _self.exerciseCount : exerciseCount // ignore: cast_nullable_to_non_nullable
as int,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,hasPersonalRecord: null == hasPersonalRecord ? _self.hasPersonalRecord : hasPersonalRecord // ignore: cast_nullable_to_non_nullable
as bool,loveCount: null == loveCount ? _self.loveCount : loveCount // ignore: cast_nullable_to_non_nullable
as int,lovedByCurrentUser: null == lovedByCurrentUser ? _self.lovedByCurrentUser : lovedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<TrainingDayShareExercise>,isReusable: null == isReusable ? _self.isReusable : isReusable // ignore: cast_nullable_to_non_nullable
as bool,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,averageRpe: freezed == averageRpe ? _self.averageRpe : averageRpe // ignore: cast_nullable_to_non_nullable
as double?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TrainingDayShareExercise {

 String get id; String get name; String get primaryMuscleGroup; String get exerciseKind; int get sortOrder; bool get isSkipped; bool get isPersonalRecord; List<TrainingDayShareSet> get sets; int? get durationSeconds; String? get notes;
/// Create a copy of TrainingDayShareExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingDayShareExerciseCopyWith<TrainingDayShareExercise> get copyWith => _$TrainingDayShareExerciseCopyWithImpl<TrainingDayShareExercise>(this as TrainingDayShareExercise, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingDayShareExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isPersonalRecord, isPersonalRecord) || other.isPersonalRecord == isPersonalRecord)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,primaryMuscleGroup,exerciseKind,sortOrder,isSkipped,isPersonalRecord,const DeepCollectionEquality().hash(sets),durationSeconds,notes);

@override
String toString() {
  return 'TrainingDayShareExercise(id: $id, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, sortOrder: $sortOrder, isSkipped: $isSkipped, isPersonalRecord: $isPersonalRecord, sets: $sets, durationSeconds: $durationSeconds, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $TrainingDayShareExerciseCopyWith<$Res>  {
  factory $TrainingDayShareExerciseCopyWith(TrainingDayShareExercise value, $Res Function(TrainingDayShareExercise) _then) = _$TrainingDayShareExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String primaryMuscleGroup, String exerciseKind, int sortOrder, bool isSkipped, bool isPersonalRecord, List<TrainingDayShareSet> sets, int? durationSeconds, String? notes
});




}
/// @nodoc
class _$TrainingDayShareExerciseCopyWithImpl<$Res>
    implements $TrainingDayShareExerciseCopyWith<$Res> {
  _$TrainingDayShareExerciseCopyWithImpl(this._self, this._then);

  final TrainingDayShareExercise _self;
  final $Res Function(TrainingDayShareExercise) _then;

/// Create a copy of TrainingDayShareExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? primaryMuscleGroup = null,Object? exerciseKind = null,Object? sortOrder = null,Object? isSkipped = null,Object? isPersonalRecord = null,Object? sets = null,Object? durationSeconds = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscleGroup: null == primaryMuscleGroup ? _self.primaryMuscleGroup : primaryMuscleGroup // ignore: cast_nullable_to_non_nullable
as String,exerciseKind: null == exerciseKind ? _self.exerciseKind : exerciseKind // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,isPersonalRecord: null == isPersonalRecord ? _self.isPersonalRecord : isPersonalRecord // ignore: cast_nullable_to_non_nullable
as bool,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<TrainingDayShareSet>,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingDayShareExercise].
extension TrainingDayShareExercisePatterns on TrainingDayShareExercise {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingDayShareExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingDayShareExercise() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingDayShareExercise value)  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareExercise():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingDayShareExercise value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareExercise() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  int sortOrder,  bool isSkipped,  bool isPersonalRecord,  List<TrainingDayShareSet> sets,  int? durationSeconds,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingDayShareExercise() when $default != null:
return $default(_that.id,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.sortOrder,_that.isSkipped,_that.isPersonalRecord,_that.sets,_that.durationSeconds,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  int sortOrder,  bool isSkipped,  bool isPersonalRecord,  List<TrainingDayShareSet> sets,  int? durationSeconds,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareExercise():
return $default(_that.id,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.sortOrder,_that.isSkipped,_that.isPersonalRecord,_that.sets,_that.durationSeconds,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  int sortOrder,  bool isSkipped,  bool isPersonalRecord,  List<TrainingDayShareSet> sets,  int? durationSeconds,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareExercise() when $default != null:
return $default(_that.id,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.sortOrder,_that.isSkipped,_that.isPersonalRecord,_that.sets,_that.durationSeconds,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _TrainingDayShareExercise implements TrainingDayShareExercise {
  const _TrainingDayShareExercise({required this.id, required this.name, required this.primaryMuscleGroup, required this.exerciseKind, required this.sortOrder, required this.isSkipped, required this.isPersonalRecord, required final  List<TrainingDayShareSet> sets, this.durationSeconds, this.notes}): _sets = sets;
  

@override final  String id;
@override final  String name;
@override final  String primaryMuscleGroup;
@override final  String exerciseKind;
@override final  int sortOrder;
@override final  bool isSkipped;
@override final  bool isPersonalRecord;
 final  List<TrainingDayShareSet> _sets;
@override List<TrainingDayShareSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override final  int? durationSeconds;
@override final  String? notes;

/// Create a copy of TrainingDayShareExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingDayShareExerciseCopyWith<_TrainingDayShareExercise> get copyWith => __$TrainingDayShareExerciseCopyWithImpl<_TrainingDayShareExercise>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingDayShareExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isPersonalRecord, isPersonalRecord) || other.isPersonalRecord == isPersonalRecord)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,primaryMuscleGroup,exerciseKind,sortOrder,isSkipped,isPersonalRecord,const DeepCollectionEquality().hash(_sets),durationSeconds,notes);

@override
String toString() {
  return 'TrainingDayShareExercise(id: $id, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, sortOrder: $sortOrder, isSkipped: $isSkipped, isPersonalRecord: $isPersonalRecord, sets: $sets, durationSeconds: $durationSeconds, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$TrainingDayShareExerciseCopyWith<$Res> implements $TrainingDayShareExerciseCopyWith<$Res> {
  factory _$TrainingDayShareExerciseCopyWith(_TrainingDayShareExercise value, $Res Function(_TrainingDayShareExercise) _then) = __$TrainingDayShareExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String primaryMuscleGroup, String exerciseKind, int sortOrder, bool isSkipped, bool isPersonalRecord, List<TrainingDayShareSet> sets, int? durationSeconds, String? notes
});




}
/// @nodoc
class __$TrainingDayShareExerciseCopyWithImpl<$Res>
    implements _$TrainingDayShareExerciseCopyWith<$Res> {
  __$TrainingDayShareExerciseCopyWithImpl(this._self, this._then);

  final _TrainingDayShareExercise _self;
  final $Res Function(_TrainingDayShareExercise) _then;

/// Create a copy of TrainingDayShareExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? primaryMuscleGroup = null,Object? exerciseKind = null,Object? sortOrder = null,Object? isSkipped = null,Object? isPersonalRecord = null,Object? sets = null,Object? durationSeconds = freezed,Object? notes = freezed,}) {
  return _then(_TrainingDayShareExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscleGroup: null == primaryMuscleGroup ? _self.primaryMuscleGroup : primaryMuscleGroup // ignore: cast_nullable_to_non_nullable
as String,exerciseKind: null == exerciseKind ? _self.exerciseKind : exerciseKind // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,isPersonalRecord: null == isPersonalRecord ? _self.isPersonalRecord : isPersonalRecord // ignore: cast_nullable_to_non_nullable
as bool,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<TrainingDayShareSet>,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TrainingDayShareSet {

 String get id; int get setNumber; bool get isCompleted; int? get actualReps; double? get actualWeight; double? get rpe;
/// Create a copy of TrainingDayShareSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingDayShareSetCopyWith<TrainingDayShareSet> get copyWith => _$TrainingDayShareSetCopyWithImpl<TrainingDayShareSet>(this as TrainingDayShareSet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingDayShareSet&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.actualWeight, actualWeight) || other.actualWeight == actualWeight)&&(identical(other.rpe, rpe) || other.rpe == rpe));
}


@override
int get hashCode => Object.hash(runtimeType,id,setNumber,isCompleted,actualReps,actualWeight,rpe);

@override
String toString() {
  return 'TrainingDayShareSet(id: $id, setNumber: $setNumber, isCompleted: $isCompleted, actualReps: $actualReps, actualWeight: $actualWeight, rpe: $rpe)';
}


}

/// @nodoc
abstract mixin class $TrainingDayShareSetCopyWith<$Res>  {
  factory $TrainingDayShareSetCopyWith(TrainingDayShareSet value, $Res Function(TrainingDayShareSet) _then) = _$TrainingDayShareSetCopyWithImpl;
@useResult
$Res call({
 String id, int setNumber, bool isCompleted, int? actualReps, double? actualWeight, double? rpe
});




}
/// @nodoc
class _$TrainingDayShareSetCopyWithImpl<$Res>
    implements $TrainingDayShareSetCopyWith<$Res> {
  _$TrainingDayShareSetCopyWithImpl(this._self, this._then);

  final TrainingDayShareSet _self;
  final $Res Function(TrainingDayShareSet) _then;

/// Create a copy of TrainingDayShareSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? setNumber = null,Object? isCompleted = null,Object? actualReps = freezed,Object? actualWeight = freezed,Object? rpe = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,actualReps: freezed == actualReps ? _self.actualReps : actualReps // ignore: cast_nullable_to_non_nullable
as int?,actualWeight: freezed == actualWeight ? _self.actualWeight : actualWeight // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingDayShareSet].
extension TrainingDayShareSetPatterns on TrainingDayShareSet {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingDayShareSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingDayShareSet() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingDayShareSet value)  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareSet():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingDayShareSet value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareSet() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int setNumber,  bool isCompleted,  int? actualReps,  double? actualWeight,  double? rpe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingDayShareSet() when $default != null:
return $default(_that.id,_that.setNumber,_that.isCompleted,_that.actualReps,_that.actualWeight,_that.rpe);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int setNumber,  bool isCompleted,  int? actualReps,  double? actualWeight,  double? rpe)  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareSet():
return $default(_that.id,_that.setNumber,_that.isCompleted,_that.actualReps,_that.actualWeight,_that.rpe);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int setNumber,  bool isCompleted,  int? actualReps,  double? actualWeight,  double? rpe)?  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareSet() when $default != null:
return $default(_that.id,_that.setNumber,_that.isCompleted,_that.actualReps,_that.actualWeight,_that.rpe);case _:
  return null;

}
}

}

/// @nodoc


class _TrainingDayShareSet implements TrainingDayShareSet {
  const _TrainingDayShareSet({required this.id, required this.setNumber, required this.isCompleted, this.actualReps, this.actualWeight, this.rpe});
  

@override final  String id;
@override final  int setNumber;
@override final  bool isCompleted;
@override final  int? actualReps;
@override final  double? actualWeight;
@override final  double? rpe;

/// Create a copy of TrainingDayShareSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingDayShareSetCopyWith<_TrainingDayShareSet> get copyWith => __$TrainingDayShareSetCopyWithImpl<_TrainingDayShareSet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingDayShareSet&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.actualWeight, actualWeight) || other.actualWeight == actualWeight)&&(identical(other.rpe, rpe) || other.rpe == rpe));
}


@override
int get hashCode => Object.hash(runtimeType,id,setNumber,isCompleted,actualReps,actualWeight,rpe);

@override
String toString() {
  return 'TrainingDayShareSet(id: $id, setNumber: $setNumber, isCompleted: $isCompleted, actualReps: $actualReps, actualWeight: $actualWeight, rpe: $rpe)';
}


}

/// @nodoc
abstract mixin class _$TrainingDayShareSetCopyWith<$Res> implements $TrainingDayShareSetCopyWith<$Res> {
  factory _$TrainingDayShareSetCopyWith(_TrainingDayShareSet value, $Res Function(_TrainingDayShareSet) _then) = __$TrainingDayShareSetCopyWithImpl;
@override @useResult
$Res call({
 String id, int setNumber, bool isCompleted, int? actualReps, double? actualWeight, double? rpe
});




}
/// @nodoc
class __$TrainingDayShareSetCopyWithImpl<$Res>
    implements _$TrainingDayShareSetCopyWith<$Res> {
  __$TrainingDayShareSetCopyWithImpl(this._self, this._then);

  final _TrainingDayShareSet _self;
  final $Res Function(_TrainingDayShareSet) _then;

/// Create a copy of TrainingDayShareSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? setNumber = null,Object? isCompleted = null,Object? actualReps = freezed,Object? actualWeight = freezed,Object? rpe = freezed,}) {
  return _then(_TrainingDayShareSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,actualReps: freezed == actualReps ? _self.actualReps : actualReps // ignore: cast_nullable_to_non_nullable
as int?,actualWeight: freezed == actualWeight ? _self.actualWeight : actualWeight // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
