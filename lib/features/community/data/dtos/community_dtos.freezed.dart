// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityUserSummaryDto {

 String get id; String get fullName; String? get email; String? get avatarUrl; String? get bio; String? get gender; String? get friendStatus; String? get friendshipId; String? get requestDirection;
/// Create a copy of CommunityUserSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUserSummaryDtoCopyWith<CommunityUserSummaryDto> get copyWith => _$CommunityUserSummaryDtoCopyWithImpl<CommunityUserSummaryDto>(this as CommunityUserSummaryDto, _$identity);

  /// Serializes this CommunityUserSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUserSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,avatarUrl,bio,gender,friendStatus,friendshipId,requestDirection);

@override
String toString() {
  return 'CommunityUserSummaryDto(id: $id, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendStatus: $friendStatus, friendshipId: $friendshipId, requestDirection: $requestDirection)';
}


}

/// @nodoc
abstract mixin class $CommunityUserSummaryDtoCopyWith<$Res>  {
  factory $CommunityUserSummaryDtoCopyWith(CommunityUserSummaryDto value, $Res Function(CommunityUserSummaryDto) _then) = _$CommunityUserSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String? email, String? avatarUrl, String? bio, String? gender, String? friendStatus, String? friendshipId, String? requestDirection
});




}
/// @nodoc
class _$CommunityUserSummaryDtoCopyWithImpl<$Res>
    implements $CommunityUserSummaryDtoCopyWith<$Res> {
  _$CommunityUserSummaryDtoCopyWithImpl(this._self, this._then);

  final CommunityUserSummaryDto _self;
  final $Res Function(CommunityUserSummaryDto) _then;

/// Create a copy of CommunityUserSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendStatus = freezed,Object? friendshipId = freezed,Object? requestDirection = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: freezed == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityUserSummaryDto].
extension CommunityUserSummaryDtoPatterns on CommunityUserSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityUserSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityUserSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityUserSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityUserSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityUserSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityUserSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendStatus,  String? friendshipId,  String? requestDirection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityUserSummaryDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendStatus,  String? friendshipId,  String? requestDirection)  $default,) {final _that = this;
switch (_that) {
case _CommunityUserSummaryDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendStatus,  String? friendshipId,  String? requestDirection)?  $default,) {final _that = this;
switch (_that) {
case _CommunityUserSummaryDto() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendStatus,_that.friendshipId,_that.requestDirection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityUserSummaryDto extends CommunityUserSummaryDto {
  const _CommunityUserSummaryDto({required this.id, required this.fullName, this.email, this.avatarUrl, this.bio, this.gender, this.friendStatus, this.friendshipId, this.requestDirection}): super._();
  factory _CommunityUserSummaryDto.fromJson(Map<String, dynamic> json) => _$CommunityUserSummaryDtoFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String? email;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? gender;
@override final  String? friendStatus;
@override final  String? friendshipId;
@override final  String? requestDirection;

/// Create a copy of CommunityUserSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityUserSummaryDtoCopyWith<_CommunityUserSummaryDto> get copyWith => __$CommunityUserSummaryDtoCopyWithImpl<_CommunityUserSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityUserSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityUserSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,avatarUrl,bio,gender,friendStatus,friendshipId,requestDirection);

@override
String toString() {
  return 'CommunityUserSummaryDto(id: $id, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendStatus: $friendStatus, friendshipId: $friendshipId, requestDirection: $requestDirection)';
}


}

/// @nodoc
abstract mixin class _$CommunityUserSummaryDtoCopyWith<$Res> implements $CommunityUserSummaryDtoCopyWith<$Res> {
  factory _$CommunityUserSummaryDtoCopyWith(_CommunityUserSummaryDto value, $Res Function(_CommunityUserSummaryDto) _then) = __$CommunityUserSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String? email, String? avatarUrl, String? bio, String? gender, String? friendStatus, String? friendshipId, String? requestDirection
});




}
/// @nodoc
class __$CommunityUserSummaryDtoCopyWithImpl<$Res>
    implements _$CommunityUserSummaryDtoCopyWith<$Res> {
  __$CommunityUserSummaryDtoCopyWithImpl(this._self, this._then);

  final _CommunityUserSummaryDto _self;
  final $Res Function(_CommunityUserSummaryDto) _then;

/// Create a copy of CommunityUserSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendStatus = freezed,Object? friendshipId = freezed,Object? requestDirection = freezed,}) {
  return _then(_CommunityUserSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: freezed == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CommunityUserProfileDto {

 String get id; String get fullName; int get level; bool get canViewStats; Big3PrsDto? get big3Prs; int get totalTrainingDurationSeconds; double get totalTrainingVolume; String? get email; String? get avatarUrl; String? get bio; String? get gender; String? get friendStatus; String? get friendshipId; String? get requestDirection; String? get developmentDirection; String? get trainingDiscipline; double? get height; double? get latestBodyweight; double? get bmi; String? get bmiCategory; int? get currentStreak; double? get dotsScore; double? get big3Total;
/// Create a copy of CommunityUserProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUserProfileDtoCopyWith<CommunityUserProfileDto> get copyWith => _$CommunityUserProfileDtoCopyWithImpl<CommunityUserProfileDto>(this as CommunityUserProfileDto, _$identity);

  /// Serializes this CommunityUserProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.level, level) || other.level == level)&&(identical(other.canViewStats, canViewStats) || other.canViewStats == canViewStats)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.totalTrainingDurationSeconds, totalTrainingDurationSeconds) || other.totalTrainingDurationSeconds == totalTrainingDurationSeconds)&&(identical(other.totalTrainingVolume, totalTrainingVolume) || other.totalTrainingVolume == totalTrainingVolume)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.height, height) || other.height == height)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.big3Total, big3Total) || other.big3Total == big3Total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,level,canViewStats,big3Prs,totalTrainingDurationSeconds,totalTrainingVolume,email,avatarUrl,bio,gender,friendStatus,friendshipId,requestDirection,developmentDirection,trainingDiscipline,height,latestBodyweight,bmi,bmiCategory,currentStreak,dotsScore,big3Total]);

@override
String toString() {
  return 'CommunityUserProfileDto(id: $id, fullName: $fullName, level: $level, canViewStats: $canViewStats, big3Prs: $big3Prs, totalTrainingDurationSeconds: $totalTrainingDurationSeconds, totalTrainingVolume: $totalTrainingVolume, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendStatus: $friendStatus, friendshipId: $friendshipId, requestDirection: $requestDirection, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, height: $height, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, currentStreak: $currentStreak, dotsScore: $dotsScore, big3Total: $big3Total)';
}


}

/// @nodoc
abstract mixin class $CommunityUserProfileDtoCopyWith<$Res>  {
  factory $CommunityUserProfileDtoCopyWith(CommunityUserProfileDto value, $Res Function(CommunityUserProfileDto) _then) = _$CommunityUserProfileDtoCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, int level, bool canViewStats, Big3PrsDto? big3Prs, int totalTrainingDurationSeconds, double totalTrainingVolume, String? email, String? avatarUrl, String? bio, String? gender, String? friendStatus, String? friendshipId, String? requestDirection, String? developmentDirection, String? trainingDiscipline, double? height, double? latestBodyweight, double? bmi, String? bmiCategory, int? currentStreak, double? dotsScore, double? big3Total
});


$Big3PrsDtoCopyWith<$Res>? get big3Prs;

}
/// @nodoc
class _$CommunityUserProfileDtoCopyWithImpl<$Res>
    implements $CommunityUserProfileDtoCopyWith<$Res> {
  _$CommunityUserProfileDtoCopyWithImpl(this._self, this._then);

  final CommunityUserProfileDto _self;
  final $Res Function(CommunityUserProfileDto) _then;

/// Create a copy of CommunityUserProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? level = null,Object? canViewStats = null,Object? big3Prs = freezed,Object? totalTrainingDurationSeconds = null,Object? totalTrainingVolume = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendStatus = freezed,Object? friendshipId = freezed,Object? requestDirection = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? height = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? currentStreak = freezed,Object? dotsScore = freezed,Object? big3Total = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,canViewStats: null == canViewStats ? _self.canViewStats : canViewStats // ignore: cast_nullable_to_non_nullable
as bool,big3Prs: freezed == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3PrsDto?,totalTrainingDurationSeconds: null == totalTrainingDurationSeconds ? _self.totalTrainingDurationSeconds : totalTrainingDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalTrainingVolume: null == totalTrainingVolume ? _self.totalTrainingVolume : totalTrainingVolume // ignore: cast_nullable_to_non_nullable
as double,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: freezed == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
as String?,trainingDiscipline: freezed == trainingDiscipline ? _self.trainingDiscipline : trainingDiscipline // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,currentStreak: freezed == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,big3Total: freezed == big3Total ? _self.big3Total : big3Total // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of CommunityUserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Big3PrsDtoCopyWith<$Res>? get big3Prs {
    if (_self.big3Prs == null) {
    return null;
  }

  return $Big3PrsDtoCopyWith<$Res>(_self.big3Prs!, (value) {
    return _then(_self.copyWith(big3Prs: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityUserProfileDto].
extension CommunityUserProfileDtoPatterns on CommunityUserProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityUserProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityUserProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityUserProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityUserProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityUserProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityUserProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  int level,  bool canViewStats,  Big3PrsDto? big3Prs,  int totalTrainingDurationSeconds,  double totalTrainingVolume,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendStatus,  String? friendshipId,  String? requestDirection,  String? developmentDirection,  String? trainingDiscipline,  double? height,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  int? currentStreak,  double? dotsScore,  double? big3Total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityUserProfileDto() when $default != null:
return $default(_that.id,_that.fullName,_that.level,_that.canViewStats,_that.big3Prs,_that.totalTrainingDurationSeconds,_that.totalTrainingVolume,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendStatus,_that.friendshipId,_that.requestDirection,_that.developmentDirection,_that.trainingDiscipline,_that.height,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.currentStreak,_that.dotsScore,_that.big3Total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  int level,  bool canViewStats,  Big3PrsDto? big3Prs,  int totalTrainingDurationSeconds,  double totalTrainingVolume,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendStatus,  String? friendshipId,  String? requestDirection,  String? developmentDirection,  String? trainingDiscipline,  double? height,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  int? currentStreak,  double? dotsScore,  double? big3Total)  $default,) {final _that = this;
switch (_that) {
case _CommunityUserProfileDto():
return $default(_that.id,_that.fullName,_that.level,_that.canViewStats,_that.big3Prs,_that.totalTrainingDurationSeconds,_that.totalTrainingVolume,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendStatus,_that.friendshipId,_that.requestDirection,_that.developmentDirection,_that.trainingDiscipline,_that.height,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.currentStreak,_that.dotsScore,_that.big3Total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  int level,  bool canViewStats,  Big3PrsDto? big3Prs,  int totalTrainingDurationSeconds,  double totalTrainingVolume,  String? email,  String? avatarUrl,  String? bio,  String? gender,  String? friendStatus,  String? friendshipId,  String? requestDirection,  String? developmentDirection,  String? trainingDiscipline,  double? height,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  int? currentStreak,  double? dotsScore,  double? big3Total)?  $default,) {final _that = this;
switch (_that) {
case _CommunityUserProfileDto() when $default != null:
return $default(_that.id,_that.fullName,_that.level,_that.canViewStats,_that.big3Prs,_that.totalTrainingDurationSeconds,_that.totalTrainingVolume,_that.email,_that.avatarUrl,_that.bio,_that.gender,_that.friendStatus,_that.friendshipId,_that.requestDirection,_that.developmentDirection,_that.trainingDiscipline,_that.height,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.currentStreak,_that.dotsScore,_that.big3Total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityUserProfileDto extends CommunityUserProfileDto {
  const _CommunityUserProfileDto({required this.id, required this.fullName, this.level = 1, this.canViewStats = false, this.big3Prs, this.totalTrainingDurationSeconds = 0, this.totalTrainingVolume = 0, this.email, this.avatarUrl, this.bio, this.gender, this.friendStatus, this.friendshipId, this.requestDirection, this.developmentDirection, this.trainingDiscipline, this.height, this.latestBodyweight, this.bmi, this.bmiCategory, this.currentStreak, this.dotsScore, this.big3Total}): super._();
  factory _CommunityUserProfileDto.fromJson(Map<String, dynamic> json) => _$CommunityUserProfileDtoFromJson(json);

@override final  String id;
@override final  String fullName;
@override@JsonKey() final  int level;
@override@JsonKey() final  bool canViewStats;
@override final  Big3PrsDto? big3Prs;
@override@JsonKey() final  int totalTrainingDurationSeconds;
@override@JsonKey() final  double totalTrainingVolume;
@override final  String? email;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? gender;
@override final  String? friendStatus;
@override final  String? friendshipId;
@override final  String? requestDirection;
@override final  String? developmentDirection;
@override final  String? trainingDiscipline;
@override final  double? height;
@override final  double? latestBodyweight;
@override final  double? bmi;
@override final  String? bmiCategory;
@override final  int? currentStreak;
@override final  double? dotsScore;
@override final  double? big3Total;

/// Create a copy of CommunityUserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityUserProfileDtoCopyWith<_CommunityUserProfileDto> get copyWith => __$CommunityUserProfileDtoCopyWithImpl<_CommunityUserProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityUserProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityUserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.level, level) || other.level == level)&&(identical(other.canViewStats, canViewStats) || other.canViewStats == canViewStats)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.totalTrainingDurationSeconds, totalTrainingDurationSeconds) || other.totalTrainingDurationSeconds == totalTrainingDurationSeconds)&&(identical(other.totalTrainingVolume, totalTrainingVolume) || other.totalTrainingVolume == totalTrainingVolume)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.friendStatus, friendStatus) || other.friendStatus == friendStatus)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.height, height) || other.height == height)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.big3Total, big3Total) || other.big3Total == big3Total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,level,canViewStats,big3Prs,totalTrainingDurationSeconds,totalTrainingVolume,email,avatarUrl,bio,gender,friendStatus,friendshipId,requestDirection,developmentDirection,trainingDiscipline,height,latestBodyweight,bmi,bmiCategory,currentStreak,dotsScore,big3Total]);

@override
String toString() {
  return 'CommunityUserProfileDto(id: $id, fullName: $fullName, level: $level, canViewStats: $canViewStats, big3Prs: $big3Prs, totalTrainingDurationSeconds: $totalTrainingDurationSeconds, totalTrainingVolume: $totalTrainingVolume, email: $email, avatarUrl: $avatarUrl, bio: $bio, gender: $gender, friendStatus: $friendStatus, friendshipId: $friendshipId, requestDirection: $requestDirection, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, height: $height, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, currentStreak: $currentStreak, dotsScore: $dotsScore, big3Total: $big3Total)';
}


}

/// @nodoc
abstract mixin class _$CommunityUserProfileDtoCopyWith<$Res> implements $CommunityUserProfileDtoCopyWith<$Res> {
  factory _$CommunityUserProfileDtoCopyWith(_CommunityUserProfileDto value, $Res Function(_CommunityUserProfileDto) _then) = __$CommunityUserProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, int level, bool canViewStats, Big3PrsDto? big3Prs, int totalTrainingDurationSeconds, double totalTrainingVolume, String? email, String? avatarUrl, String? bio, String? gender, String? friendStatus, String? friendshipId, String? requestDirection, String? developmentDirection, String? trainingDiscipline, double? height, double? latestBodyweight, double? bmi, String? bmiCategory, int? currentStreak, double? dotsScore, double? big3Total
});


@override $Big3PrsDtoCopyWith<$Res>? get big3Prs;

}
/// @nodoc
class __$CommunityUserProfileDtoCopyWithImpl<$Res>
    implements _$CommunityUserProfileDtoCopyWith<$Res> {
  __$CommunityUserProfileDtoCopyWithImpl(this._self, this._then);

  final _CommunityUserProfileDto _self;
  final $Res Function(_CommunityUserProfileDto) _then;

/// Create a copy of CommunityUserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? level = null,Object? canViewStats = null,Object? big3Prs = freezed,Object? totalTrainingDurationSeconds = null,Object? totalTrainingVolume = null,Object? email = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? gender = freezed,Object? friendStatus = freezed,Object? friendshipId = freezed,Object? requestDirection = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? height = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? currentStreak = freezed,Object? dotsScore = freezed,Object? big3Total = freezed,}) {
  return _then(_CommunityUserProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,canViewStats: null == canViewStats ? _self.canViewStats : canViewStats // ignore: cast_nullable_to_non_nullable
as bool,big3Prs: freezed == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3PrsDto?,totalTrainingDurationSeconds: null == totalTrainingDurationSeconds ? _self.totalTrainingDurationSeconds : totalTrainingDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalTrainingVolume: null == totalTrainingVolume ? _self.totalTrainingVolume : totalTrainingVolume // ignore: cast_nullable_to_non_nullable
as double,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,friendStatus: freezed == friendStatus ? _self.friendStatus : friendStatus // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
as String?,trainingDiscipline: freezed == trainingDiscipline ? _self.trainingDiscipline : trainingDiscipline // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,currentStreak: freezed == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,big3Total: freezed == big3Total ? _self.big3Total : big3Total // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of CommunityUserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Big3PrsDtoCopyWith<$Res>? get big3Prs {
    if (_self.big3Prs == null) {
    return null;
  }

  return $Big3PrsDtoCopyWith<$Res>(_self.big3Prs!, (value) {
    return _then(_self.copyWith(big3Prs: value));
  });
}
}


/// @nodoc
mixin _$Big3PrsDto {

 double? get squat; double? get bench; double? get deadlift;
/// Create a copy of Big3PrsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Big3PrsDtoCopyWith<Big3PrsDto> get copyWith => _$Big3PrsDtoCopyWithImpl<Big3PrsDto>(this as Big3PrsDto, _$identity);

  /// Serializes this Big3PrsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Big3PrsDto&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift);

@override
String toString() {
  return 'Big3PrsDto(squat: $squat, bench: $bench, deadlift: $deadlift)';
}


}

/// @nodoc
abstract mixin class $Big3PrsDtoCopyWith<$Res>  {
  factory $Big3PrsDtoCopyWith(Big3PrsDto value, $Res Function(Big3PrsDto) _then) = _$Big3PrsDtoCopyWithImpl;
@useResult
$Res call({
 double? squat, double? bench, double? deadlift
});




}
/// @nodoc
class _$Big3PrsDtoCopyWithImpl<$Res>
    implements $Big3PrsDtoCopyWith<$Res> {
  _$Big3PrsDtoCopyWithImpl(this._self, this._then);

  final Big3PrsDto _self;
  final $Res Function(Big3PrsDto) _then;

/// Create a copy of Big3PrsDto
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


/// Adds pattern-matching-related methods to [Big3PrsDto].
extension Big3PrsDtoPatterns on Big3PrsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Big3PrsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Big3PrsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Big3PrsDto value)  $default,){
final _that = this;
switch (_that) {
case _Big3PrsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Big3PrsDto value)?  $default,){
final _that = this;
switch (_that) {
case _Big3PrsDto() when $default != null:
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
case _Big3PrsDto() when $default != null:
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
case _Big3PrsDto():
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
case _Big3PrsDto() when $default != null:
return $default(_that.squat,_that.bench,_that.deadlift);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Big3PrsDto extends Big3PrsDto {
  const _Big3PrsDto({this.squat, this.bench, this.deadlift}): super._();
  factory _Big3PrsDto.fromJson(Map<String, dynamic> json) => _$Big3PrsDtoFromJson(json);

@override final  double? squat;
@override final  double? bench;
@override final  double? deadlift;

/// Create a copy of Big3PrsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Big3PrsDtoCopyWith<_Big3PrsDto> get copyWith => __$Big3PrsDtoCopyWithImpl<_Big3PrsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Big3PrsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Big3PrsDto&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift);

@override
String toString() {
  return 'Big3PrsDto(squat: $squat, bench: $bench, deadlift: $deadlift)';
}


}

/// @nodoc
abstract mixin class _$Big3PrsDtoCopyWith<$Res> implements $Big3PrsDtoCopyWith<$Res> {
  factory _$Big3PrsDtoCopyWith(_Big3PrsDto value, $Res Function(_Big3PrsDto) _then) = __$Big3PrsDtoCopyWithImpl;
@override @useResult
$Res call({
 double? squat, double? bench, double? deadlift
});




}
/// @nodoc
class __$Big3PrsDtoCopyWithImpl<$Res>
    implements _$Big3PrsDtoCopyWith<$Res> {
  __$Big3PrsDtoCopyWithImpl(this._self, this._then);

  final _Big3PrsDto _self;
  final $Res Function(_Big3PrsDto) _then;

/// Create a copy of Big3PrsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? squat = freezed,Object? bench = freezed,Object? deadlift = freezed,}) {
  return _then(_Big3PrsDto(
squat: freezed == squat ? _self.squat : squat // ignore: cast_nullable_to_non_nullable
as double?,bench: freezed == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as double?,deadlift: freezed == deadlift ? _self.deadlift : deadlift // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$FriendDto {

 String get userId; String get fullName; String get email; String get friendsSince; String? get avatarUrl; String? get bio;
/// Create a copy of FriendDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendDtoCopyWith<FriendDto> get copyWith => _$FriendDtoCopyWithImpl<FriendDto>(this as FriendDto, _$identity);

  /// Serializes this FriendDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.friendsSince, friendsSince) || other.friendsSince == friendsSince)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,email,friendsSince,avatarUrl,bio);

@override
String toString() {
  return 'FriendDto(userId: $userId, fullName: $fullName, email: $email, friendsSince: $friendsSince, avatarUrl: $avatarUrl, bio: $bio)';
}


}

/// @nodoc
abstract mixin class $FriendDtoCopyWith<$Res>  {
  factory $FriendDtoCopyWith(FriendDto value, $Res Function(FriendDto) _then) = _$FriendDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String fullName, String email, String friendsSince, String? avatarUrl, String? bio
});




}
/// @nodoc
class _$FriendDtoCopyWithImpl<$Res>
    implements $FriendDtoCopyWith<$Res> {
  _$FriendDtoCopyWithImpl(this._self, this._then);

  final FriendDto _self;
  final $Res Function(FriendDto) _then;

/// Create a copy of FriendDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? fullName = null,Object? email = null,Object? friendsSince = null,Object? avatarUrl = freezed,Object? bio = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,friendsSince: null == friendsSince ? _self.friendsSince : friendsSince // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendDto].
extension FriendDtoPatterns on FriendDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendDto value)  $default,){
final _that = this;
switch (_that) {
case _FriendDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendDto value)?  $default,){
final _that = this;
switch (_that) {
case _FriendDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String fullName,  String email,  String friendsSince,  String? avatarUrl,  String? bio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String fullName,  String email,  String friendsSince,  String? avatarUrl,  String? bio)  $default,) {final _that = this;
switch (_that) {
case _FriendDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String fullName,  String email,  String friendsSince,  String? avatarUrl,  String? bio)?  $default,) {final _that = this;
switch (_that) {
case _FriendDto() when $default != null:
return $default(_that.userId,_that.fullName,_that.email,_that.friendsSince,_that.avatarUrl,_that.bio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendDto extends FriendDto {
  const _FriendDto({required this.userId, required this.fullName, required this.email, required this.friendsSince, this.avatarUrl, this.bio}): super._();
  factory _FriendDto.fromJson(Map<String, dynamic> json) => _$FriendDtoFromJson(json);

@override final  String userId;
@override final  String fullName;
@override final  String email;
@override final  String friendsSince;
@override final  String? avatarUrl;
@override final  String? bio;

/// Create a copy of FriendDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendDtoCopyWith<_FriendDto> get copyWith => __$FriendDtoCopyWithImpl<_FriendDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.friendsSince, friendsSince) || other.friendsSince == friendsSince)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,email,friendsSince,avatarUrl,bio);

@override
String toString() {
  return 'FriendDto(userId: $userId, fullName: $fullName, email: $email, friendsSince: $friendsSince, avatarUrl: $avatarUrl, bio: $bio)';
}


}

/// @nodoc
abstract mixin class _$FriendDtoCopyWith<$Res> implements $FriendDtoCopyWith<$Res> {
  factory _$FriendDtoCopyWith(_FriendDto value, $Res Function(_FriendDto) _then) = __$FriendDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String fullName, String email, String friendsSince, String? avatarUrl, String? bio
});




}
/// @nodoc
class __$FriendDtoCopyWithImpl<$Res>
    implements _$FriendDtoCopyWith<$Res> {
  __$FriendDtoCopyWithImpl(this._self, this._then);

  final _FriendDto _self;
  final $Res Function(_FriendDto) _then;

/// Create a copy of FriendDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? fullName = null,Object? email = null,Object? friendsSince = null,Object? avatarUrl = freezed,Object? bio = freezed,}) {
  return _then(_FriendDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,friendsSince: null == friendsSince ? _self.friendsSince : friendsSince // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FriendRequestDto {

 String get id; String get userId; String get fullName; String get email; String get direction; String get status; String get createdAt; String? get avatarUrl; String? get respondedAt;
/// Create a copy of FriendRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestDtoCopyWith<FriendRequestDto> get copyWith => _$FriendRequestDtoCopyWithImpl<FriendRequestDto>(this as FriendRequestDto, _$identity);

  /// Serializes this FriendRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,email,direction,status,createdAt,avatarUrl,respondedAt);

@override
String toString() {
  return 'FriendRequestDto(id: $id, userId: $userId, fullName: $fullName, email: $email, direction: $direction, status: $status, createdAt: $createdAt, avatarUrl: $avatarUrl, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class $FriendRequestDtoCopyWith<$Res>  {
  factory $FriendRequestDtoCopyWith(FriendRequestDto value, $Res Function(FriendRequestDto) _then) = _$FriendRequestDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String fullName, String email, String direction, String status, String createdAt, String? avatarUrl, String? respondedAt
});




}
/// @nodoc
class _$FriendRequestDtoCopyWithImpl<$Res>
    implements $FriendRequestDtoCopyWith<$Res> {
  _$FriendRequestDtoCopyWithImpl(this._self, this._then);

  final FriendRequestDto _self;
  final $Res Function(FriendRequestDto) _then;

/// Create a copy of FriendRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? email = null,Object? direction = null,Object? status = null,Object? createdAt = null,Object? avatarUrl = freezed,Object? respondedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendRequestDto].
extension FriendRequestDtoPatterns on FriendRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String fullName,  String email,  String direction,  String status,  String createdAt,  String? avatarUrl,  String? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequestDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String fullName,  String email,  String direction,  String status,  String createdAt,  String? avatarUrl,  String? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _FriendRequestDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String fullName,  String email,  String direction,  String status,  String createdAt,  String? avatarUrl,  String? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequestDto() when $default != null:
return $default(_that.id,_that.userId,_that.fullName,_that.email,_that.direction,_that.status,_that.createdAt,_that.avatarUrl,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendRequestDto extends FriendRequestDto {
  const _FriendRequestDto({required this.id, required this.userId, required this.fullName, required this.email, required this.direction, required this.status, required this.createdAt, this.avatarUrl, this.respondedAt}): super._();
  factory _FriendRequestDto.fromJson(Map<String, dynamic> json) => _$FriendRequestDtoFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String fullName;
@override final  String email;
@override final  String direction;
@override final  String status;
@override final  String createdAt;
@override final  String? avatarUrl;
@override final  String? respondedAt;

/// Create a copy of FriendRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestDtoCopyWith<_FriendRequestDto> get copyWith => __$FriendRequestDtoCopyWithImpl<_FriendRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,email,direction,status,createdAt,avatarUrl,respondedAt);

@override
String toString() {
  return 'FriendRequestDto(id: $id, userId: $userId, fullName: $fullName, email: $email, direction: $direction, status: $status, createdAt: $createdAt, avatarUrl: $avatarUrl, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestDtoCopyWith<$Res> implements $FriendRequestDtoCopyWith<$Res> {
  factory _$FriendRequestDtoCopyWith(_FriendRequestDto value, $Res Function(_FriendRequestDto) _then) = __$FriendRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String fullName, String email, String direction, String status, String createdAt, String? avatarUrl, String? respondedAt
});




}
/// @nodoc
class __$FriendRequestDtoCopyWithImpl<$Res>
    implements _$FriendRequestDtoCopyWith<$Res> {
  __$FriendRequestDtoCopyWithImpl(this._self, this._then);

  final _FriendRequestDto _self;
  final $Res Function(_FriendRequestDto) _then;

/// Create a copy of FriendRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? email = null,Object? direction = null,Object? status = null,Object? createdAt = null,Object? avatarUrl = freezed,Object? respondedAt = freezed,}) {
  return _then(_FriendRequestDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TrainingDayShareDto {

 String get id; String get userId; String get userFullName; String get sourceDailyWorkoutId; String get workoutDate; String get dayOfWeek; String get dayStatus; String get createdAt; int get exerciseCount; int get completedSets; double get totalVolume; int get totalDurationSeconds; bool get hasPersonalRecord; int get loveCount; bool get lovedByCurrentUser; List<TrainingDayShareExerciseDto> get exercises; bool get isReusable; String? get userAvatarUrl; double? get averageRpe; String? get caption;
/// Create a copy of TrainingDayShareDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingDayShareDtoCopyWith<TrainingDayShareDto> get copyWith => _$TrainingDayShareDtoCopyWithImpl<TrainingDayShareDto>(this as TrainingDayShareDto, _$identity);

  /// Serializes this TrainingDayShareDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingDayShareDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.sourceDailyWorkoutId, sourceDailyWorkoutId) || other.sourceDailyWorkoutId == sourceDailyWorkoutId)&&(identical(other.workoutDate, workoutDate) || other.workoutDate == workoutDate)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.dayStatus, dayStatus) || other.dayStatus == dayStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.exerciseCount, exerciseCount) || other.exerciseCount == exerciseCount)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.hasPersonalRecord, hasPersonalRecord) || other.hasPersonalRecord == hasPersonalRecord)&&(identical(other.loveCount, loveCount) || other.loveCount == loveCount)&&(identical(other.lovedByCurrentUser, lovedByCurrentUser) || other.lovedByCurrentUser == lovedByCurrentUser)&&const DeepCollectionEquality().equals(other.exercises, exercises)&&(identical(other.isReusable, isReusable) || other.isReusable == isReusable)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl)&&(identical(other.averageRpe, averageRpe) || other.averageRpe == averageRpe)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userFullName,sourceDailyWorkoutId,workoutDate,dayOfWeek,dayStatus,createdAt,exerciseCount,completedSets,totalVolume,totalDurationSeconds,hasPersonalRecord,loveCount,lovedByCurrentUser,const DeepCollectionEquality().hash(exercises),isReusable,userAvatarUrl,averageRpe,caption]);

@override
String toString() {
  return 'TrainingDayShareDto(id: $id, userId: $userId, userFullName: $userFullName, sourceDailyWorkoutId: $sourceDailyWorkoutId, workoutDate: $workoutDate, dayOfWeek: $dayOfWeek, dayStatus: $dayStatus, createdAt: $createdAt, exerciseCount: $exerciseCount, completedSets: $completedSets, totalVolume: $totalVolume, totalDurationSeconds: $totalDurationSeconds, hasPersonalRecord: $hasPersonalRecord, loveCount: $loveCount, lovedByCurrentUser: $lovedByCurrentUser, exercises: $exercises, isReusable: $isReusable, userAvatarUrl: $userAvatarUrl, averageRpe: $averageRpe, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $TrainingDayShareDtoCopyWith<$Res>  {
  factory $TrainingDayShareDtoCopyWith(TrainingDayShareDto value, $Res Function(TrainingDayShareDto) _then) = _$TrainingDayShareDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userFullName, String sourceDailyWorkoutId, String workoutDate, String dayOfWeek, String dayStatus, String createdAt, int exerciseCount, int completedSets, double totalVolume, int totalDurationSeconds, bool hasPersonalRecord, int loveCount, bool lovedByCurrentUser, List<TrainingDayShareExerciseDto> exercises, bool isReusable, String? userAvatarUrl, double? averageRpe, String? caption
});




}
/// @nodoc
class _$TrainingDayShareDtoCopyWithImpl<$Res>
    implements $TrainingDayShareDtoCopyWith<$Res> {
  _$TrainingDayShareDtoCopyWithImpl(this._self, this._then);

  final TrainingDayShareDto _self;
  final $Res Function(TrainingDayShareDto) _then;

/// Create a copy of TrainingDayShareDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? sourceDailyWorkoutId = null,Object? workoutDate = null,Object? dayOfWeek = null,Object? dayStatus = null,Object? createdAt = null,Object? exerciseCount = null,Object? completedSets = null,Object? totalVolume = null,Object? totalDurationSeconds = null,Object? hasPersonalRecord = null,Object? loveCount = null,Object? lovedByCurrentUser = null,Object? exercises = null,Object? isReusable = null,Object? userAvatarUrl = freezed,Object? averageRpe = freezed,Object? caption = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,sourceDailyWorkoutId: null == sourceDailyWorkoutId ? _self.sourceDailyWorkoutId : sourceDailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,workoutDate: null == workoutDate ? _self.workoutDate : workoutDate // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,dayStatus: null == dayStatus ? _self.dayStatus : dayStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,exerciseCount: null == exerciseCount ? _self.exerciseCount : exerciseCount // ignore: cast_nullable_to_non_nullable
as int,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,hasPersonalRecord: null == hasPersonalRecord ? _self.hasPersonalRecord : hasPersonalRecord // ignore: cast_nullable_to_non_nullable
as bool,loveCount: null == loveCount ? _self.loveCount : loveCount // ignore: cast_nullable_to_non_nullable
as int,lovedByCurrentUser: null == lovedByCurrentUser ? _self.lovedByCurrentUser : lovedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<TrainingDayShareExerciseDto>,isReusable: null == isReusable ? _self.isReusable : isReusable // ignore: cast_nullable_to_non_nullable
as bool,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,averageRpe: freezed == averageRpe ? _self.averageRpe : averageRpe // ignore: cast_nullable_to_non_nullable
as double?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingDayShareDto].
extension TrainingDayShareDtoPatterns on TrainingDayShareDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingDayShareDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingDayShareDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingDayShareDto value)  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingDayShareDto value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userFullName,  String sourceDailyWorkoutId,  String workoutDate,  String dayOfWeek,  String dayStatus,  String createdAt,  int exerciseCount,  int completedSets,  double totalVolume,  int totalDurationSeconds,  bool hasPersonalRecord,  int loveCount,  bool lovedByCurrentUser,  List<TrainingDayShareExerciseDto> exercises,  bool isReusable,  String? userAvatarUrl,  double? averageRpe,  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingDayShareDto() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.sourceDailyWorkoutId,_that.workoutDate,_that.dayOfWeek,_that.dayStatus,_that.createdAt,_that.exerciseCount,_that.completedSets,_that.totalVolume,_that.totalDurationSeconds,_that.hasPersonalRecord,_that.loveCount,_that.lovedByCurrentUser,_that.exercises,_that.isReusable,_that.userAvatarUrl,_that.averageRpe,_that.caption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userFullName,  String sourceDailyWorkoutId,  String workoutDate,  String dayOfWeek,  String dayStatus,  String createdAt,  int exerciseCount,  int completedSets,  double totalVolume,  int totalDurationSeconds,  bool hasPersonalRecord,  int loveCount,  bool lovedByCurrentUser,  List<TrainingDayShareExerciseDto> exercises,  bool isReusable,  String? userAvatarUrl,  double? averageRpe,  String? caption)  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareDto():
return $default(_that.id,_that.userId,_that.userFullName,_that.sourceDailyWorkoutId,_that.workoutDate,_that.dayOfWeek,_that.dayStatus,_that.createdAt,_that.exerciseCount,_that.completedSets,_that.totalVolume,_that.totalDurationSeconds,_that.hasPersonalRecord,_that.loveCount,_that.lovedByCurrentUser,_that.exercises,_that.isReusable,_that.userAvatarUrl,_that.averageRpe,_that.caption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userFullName,  String sourceDailyWorkoutId,  String workoutDate,  String dayOfWeek,  String dayStatus,  String createdAt,  int exerciseCount,  int completedSets,  double totalVolume,  int totalDurationSeconds,  bool hasPersonalRecord,  int loveCount,  bool lovedByCurrentUser,  List<TrainingDayShareExerciseDto> exercises,  bool isReusable,  String? userAvatarUrl,  double? averageRpe,  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareDto() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.sourceDailyWorkoutId,_that.workoutDate,_that.dayOfWeek,_that.dayStatus,_that.createdAt,_that.exerciseCount,_that.completedSets,_that.totalVolume,_that.totalDurationSeconds,_that.hasPersonalRecord,_that.loveCount,_that.lovedByCurrentUser,_that.exercises,_that.isReusable,_that.userAvatarUrl,_that.averageRpe,_that.caption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingDayShareDto extends TrainingDayShareDto {
  const _TrainingDayShareDto({required this.id, required this.userId, required this.userFullName, required this.sourceDailyWorkoutId, required this.workoutDate, required this.dayOfWeek, required this.dayStatus, required this.createdAt, this.exerciseCount = 0, this.completedSets = 0, this.totalVolume = 0, this.totalDurationSeconds = 0, this.hasPersonalRecord = false, this.loveCount = 0, this.lovedByCurrentUser = false, final  List<TrainingDayShareExerciseDto> exercises = const <TrainingDayShareExerciseDto>[], this.isReusable = false, this.userAvatarUrl, this.averageRpe, this.caption}): _exercises = exercises,super._();
  factory _TrainingDayShareDto.fromJson(Map<String, dynamic> json) => _$TrainingDayShareDtoFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String userFullName;
@override final  String sourceDailyWorkoutId;
@override final  String workoutDate;
@override final  String dayOfWeek;
@override final  String dayStatus;
@override final  String createdAt;
@override@JsonKey() final  int exerciseCount;
@override@JsonKey() final  int completedSets;
@override@JsonKey() final  double totalVolume;
@override@JsonKey() final  int totalDurationSeconds;
@override@JsonKey() final  bool hasPersonalRecord;
@override@JsonKey() final  int loveCount;
@override@JsonKey() final  bool lovedByCurrentUser;
 final  List<TrainingDayShareExerciseDto> _exercises;
@override@JsonKey() List<TrainingDayShareExerciseDto> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@override@JsonKey() final  bool isReusable;
@override final  String? userAvatarUrl;
@override final  double? averageRpe;
@override final  String? caption;

/// Create a copy of TrainingDayShareDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingDayShareDtoCopyWith<_TrainingDayShareDto> get copyWith => __$TrainingDayShareDtoCopyWithImpl<_TrainingDayShareDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingDayShareDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingDayShareDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.sourceDailyWorkoutId, sourceDailyWorkoutId) || other.sourceDailyWorkoutId == sourceDailyWorkoutId)&&(identical(other.workoutDate, workoutDate) || other.workoutDate == workoutDate)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.dayStatus, dayStatus) || other.dayStatus == dayStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.exerciseCount, exerciseCount) || other.exerciseCount == exerciseCount)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.hasPersonalRecord, hasPersonalRecord) || other.hasPersonalRecord == hasPersonalRecord)&&(identical(other.loveCount, loveCount) || other.loveCount == loveCount)&&(identical(other.lovedByCurrentUser, lovedByCurrentUser) || other.lovedByCurrentUser == lovedByCurrentUser)&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.isReusable, isReusable) || other.isReusable == isReusable)&&(identical(other.userAvatarUrl, userAvatarUrl) || other.userAvatarUrl == userAvatarUrl)&&(identical(other.averageRpe, averageRpe) || other.averageRpe == averageRpe)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userFullName,sourceDailyWorkoutId,workoutDate,dayOfWeek,dayStatus,createdAt,exerciseCount,completedSets,totalVolume,totalDurationSeconds,hasPersonalRecord,loveCount,lovedByCurrentUser,const DeepCollectionEquality().hash(_exercises),isReusable,userAvatarUrl,averageRpe,caption]);

@override
String toString() {
  return 'TrainingDayShareDto(id: $id, userId: $userId, userFullName: $userFullName, sourceDailyWorkoutId: $sourceDailyWorkoutId, workoutDate: $workoutDate, dayOfWeek: $dayOfWeek, dayStatus: $dayStatus, createdAt: $createdAt, exerciseCount: $exerciseCount, completedSets: $completedSets, totalVolume: $totalVolume, totalDurationSeconds: $totalDurationSeconds, hasPersonalRecord: $hasPersonalRecord, loveCount: $loveCount, lovedByCurrentUser: $lovedByCurrentUser, exercises: $exercises, isReusable: $isReusable, userAvatarUrl: $userAvatarUrl, averageRpe: $averageRpe, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$TrainingDayShareDtoCopyWith<$Res> implements $TrainingDayShareDtoCopyWith<$Res> {
  factory _$TrainingDayShareDtoCopyWith(_TrainingDayShareDto value, $Res Function(_TrainingDayShareDto) _then) = __$TrainingDayShareDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userFullName, String sourceDailyWorkoutId, String workoutDate, String dayOfWeek, String dayStatus, String createdAt, int exerciseCount, int completedSets, double totalVolume, int totalDurationSeconds, bool hasPersonalRecord, int loveCount, bool lovedByCurrentUser, List<TrainingDayShareExerciseDto> exercises, bool isReusable, String? userAvatarUrl, double? averageRpe, String? caption
});




}
/// @nodoc
class __$TrainingDayShareDtoCopyWithImpl<$Res>
    implements _$TrainingDayShareDtoCopyWith<$Res> {
  __$TrainingDayShareDtoCopyWithImpl(this._self, this._then);

  final _TrainingDayShareDto _self;
  final $Res Function(_TrainingDayShareDto) _then;

/// Create a copy of TrainingDayShareDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? sourceDailyWorkoutId = null,Object? workoutDate = null,Object? dayOfWeek = null,Object? dayStatus = null,Object? createdAt = null,Object? exerciseCount = null,Object? completedSets = null,Object? totalVolume = null,Object? totalDurationSeconds = null,Object? hasPersonalRecord = null,Object? loveCount = null,Object? lovedByCurrentUser = null,Object? exercises = null,Object? isReusable = null,Object? userAvatarUrl = freezed,Object? averageRpe = freezed,Object? caption = freezed,}) {
  return _then(_TrainingDayShareDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,sourceDailyWorkoutId: null == sourceDailyWorkoutId ? _self.sourceDailyWorkoutId : sourceDailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,workoutDate: null == workoutDate ? _self.workoutDate : workoutDate // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,dayStatus: null == dayStatus ? _self.dayStatus : dayStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,exerciseCount: null == exerciseCount ? _self.exerciseCount : exerciseCount // ignore: cast_nullable_to_non_nullable
as int,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,hasPersonalRecord: null == hasPersonalRecord ? _self.hasPersonalRecord : hasPersonalRecord // ignore: cast_nullable_to_non_nullable
as bool,loveCount: null == loveCount ? _self.loveCount : loveCount // ignore: cast_nullable_to_non_nullable
as int,lovedByCurrentUser: null == lovedByCurrentUser ? _self.lovedByCurrentUser : lovedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<TrainingDayShareExerciseDto>,isReusable: null == isReusable ? _self.isReusable : isReusable // ignore: cast_nullable_to_non_nullable
as bool,userAvatarUrl: freezed == userAvatarUrl ? _self.userAvatarUrl : userAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,averageRpe: freezed == averageRpe ? _self.averageRpe : averageRpe // ignore: cast_nullable_to_non_nullable
as double?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TrainingDayShareExerciseDto {

 String get id; String get name; String get primaryMuscleGroup; String get exerciseKind; int get sortOrder; bool get isSkipped; bool get isPersonalRecord; List<TrainingDayShareSetDto> get sets; int? get durationSeconds; String? get notes;
/// Create a copy of TrainingDayShareExerciseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingDayShareExerciseDtoCopyWith<TrainingDayShareExerciseDto> get copyWith => _$TrainingDayShareExerciseDtoCopyWithImpl<TrainingDayShareExerciseDto>(this as TrainingDayShareExerciseDto, _$identity);

  /// Serializes this TrainingDayShareExerciseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingDayShareExerciseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isPersonalRecord, isPersonalRecord) || other.isPersonalRecord == isPersonalRecord)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,primaryMuscleGroup,exerciseKind,sortOrder,isSkipped,isPersonalRecord,const DeepCollectionEquality().hash(sets),durationSeconds,notes);

@override
String toString() {
  return 'TrainingDayShareExerciseDto(id: $id, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, sortOrder: $sortOrder, isSkipped: $isSkipped, isPersonalRecord: $isPersonalRecord, sets: $sets, durationSeconds: $durationSeconds, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $TrainingDayShareExerciseDtoCopyWith<$Res>  {
  factory $TrainingDayShareExerciseDtoCopyWith(TrainingDayShareExerciseDto value, $Res Function(TrainingDayShareExerciseDto) _then) = _$TrainingDayShareExerciseDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String primaryMuscleGroup, String exerciseKind, int sortOrder, bool isSkipped, bool isPersonalRecord, List<TrainingDayShareSetDto> sets, int? durationSeconds, String? notes
});




}
/// @nodoc
class _$TrainingDayShareExerciseDtoCopyWithImpl<$Res>
    implements $TrainingDayShareExerciseDtoCopyWith<$Res> {
  _$TrainingDayShareExerciseDtoCopyWithImpl(this._self, this._then);

  final TrainingDayShareExerciseDto _self;
  final $Res Function(TrainingDayShareExerciseDto) _then;

/// Create a copy of TrainingDayShareExerciseDto
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
as List<TrainingDayShareSetDto>,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingDayShareExerciseDto].
extension TrainingDayShareExerciseDtoPatterns on TrainingDayShareExerciseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingDayShareExerciseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingDayShareExerciseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingDayShareExerciseDto value)  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareExerciseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingDayShareExerciseDto value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareExerciseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  int sortOrder,  bool isSkipped,  bool isPersonalRecord,  List<TrainingDayShareSetDto> sets,  int? durationSeconds,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingDayShareExerciseDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  int sortOrder,  bool isSkipped,  bool isPersonalRecord,  List<TrainingDayShareSetDto> sets,  int? durationSeconds,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareExerciseDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  int sortOrder,  bool isSkipped,  bool isPersonalRecord,  List<TrainingDayShareSetDto> sets,  int? durationSeconds,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _TrainingDayShareExerciseDto() when $default != null:
return $default(_that.id,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.sortOrder,_that.isSkipped,_that.isPersonalRecord,_that.sets,_that.durationSeconds,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingDayShareExerciseDto extends TrainingDayShareExerciseDto {
  const _TrainingDayShareExerciseDto({required this.id, required this.name, required this.primaryMuscleGroup, required this.exerciseKind, this.sortOrder = 0, this.isSkipped = false, this.isPersonalRecord = false, final  List<TrainingDayShareSetDto> sets = const <TrainingDayShareSetDto>[], this.durationSeconds, this.notes}): _sets = sets,super._();
  factory _TrainingDayShareExerciseDto.fromJson(Map<String, dynamic> json) => _$TrainingDayShareExerciseDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String primaryMuscleGroup;
@override final  String exerciseKind;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isSkipped;
@override@JsonKey() final  bool isPersonalRecord;
 final  List<TrainingDayShareSetDto> _sets;
@override@JsonKey() List<TrainingDayShareSetDto> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override final  int? durationSeconds;
@override final  String? notes;

/// Create a copy of TrainingDayShareExerciseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingDayShareExerciseDtoCopyWith<_TrainingDayShareExerciseDto> get copyWith => __$TrainingDayShareExerciseDtoCopyWithImpl<_TrainingDayShareExerciseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingDayShareExerciseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingDayShareExerciseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isPersonalRecord, isPersonalRecord) || other.isPersonalRecord == isPersonalRecord)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,primaryMuscleGroup,exerciseKind,sortOrder,isSkipped,isPersonalRecord,const DeepCollectionEquality().hash(_sets),durationSeconds,notes);

@override
String toString() {
  return 'TrainingDayShareExerciseDto(id: $id, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, sortOrder: $sortOrder, isSkipped: $isSkipped, isPersonalRecord: $isPersonalRecord, sets: $sets, durationSeconds: $durationSeconds, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$TrainingDayShareExerciseDtoCopyWith<$Res> implements $TrainingDayShareExerciseDtoCopyWith<$Res> {
  factory _$TrainingDayShareExerciseDtoCopyWith(_TrainingDayShareExerciseDto value, $Res Function(_TrainingDayShareExerciseDto) _then) = __$TrainingDayShareExerciseDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String primaryMuscleGroup, String exerciseKind, int sortOrder, bool isSkipped, bool isPersonalRecord, List<TrainingDayShareSetDto> sets, int? durationSeconds, String? notes
});




}
/// @nodoc
class __$TrainingDayShareExerciseDtoCopyWithImpl<$Res>
    implements _$TrainingDayShareExerciseDtoCopyWith<$Res> {
  __$TrainingDayShareExerciseDtoCopyWithImpl(this._self, this._then);

  final _TrainingDayShareExerciseDto _self;
  final $Res Function(_TrainingDayShareExerciseDto) _then;

/// Create a copy of TrainingDayShareExerciseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? primaryMuscleGroup = null,Object? exerciseKind = null,Object? sortOrder = null,Object? isSkipped = null,Object? isPersonalRecord = null,Object? sets = null,Object? durationSeconds = freezed,Object? notes = freezed,}) {
  return _then(_TrainingDayShareExerciseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscleGroup: null == primaryMuscleGroup ? _self.primaryMuscleGroup : primaryMuscleGroup // ignore: cast_nullable_to_non_nullable
as String,exerciseKind: null == exerciseKind ? _self.exerciseKind : exerciseKind // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,isPersonalRecord: null == isPersonalRecord ? _self.isPersonalRecord : isPersonalRecord // ignore: cast_nullable_to_non_nullable
as bool,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<TrainingDayShareSetDto>,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TrainingDayShareSetDto {

 String get id; int get setNumber; bool get isCompleted; int? get actualReps; double? get actualWeight; double? get rpe;
/// Create a copy of TrainingDayShareSetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingDayShareSetDtoCopyWith<TrainingDayShareSetDto> get copyWith => _$TrainingDayShareSetDtoCopyWithImpl<TrainingDayShareSetDto>(this as TrainingDayShareSetDto, _$identity);

  /// Serializes this TrainingDayShareSetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingDayShareSetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.actualWeight, actualWeight) || other.actualWeight == actualWeight)&&(identical(other.rpe, rpe) || other.rpe == rpe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,setNumber,isCompleted,actualReps,actualWeight,rpe);

@override
String toString() {
  return 'TrainingDayShareSetDto(id: $id, setNumber: $setNumber, isCompleted: $isCompleted, actualReps: $actualReps, actualWeight: $actualWeight, rpe: $rpe)';
}


}

/// @nodoc
abstract mixin class $TrainingDayShareSetDtoCopyWith<$Res>  {
  factory $TrainingDayShareSetDtoCopyWith(TrainingDayShareSetDto value, $Res Function(TrainingDayShareSetDto) _then) = _$TrainingDayShareSetDtoCopyWithImpl;
@useResult
$Res call({
 String id, int setNumber, bool isCompleted, int? actualReps, double? actualWeight, double? rpe
});




}
/// @nodoc
class _$TrainingDayShareSetDtoCopyWithImpl<$Res>
    implements $TrainingDayShareSetDtoCopyWith<$Res> {
  _$TrainingDayShareSetDtoCopyWithImpl(this._self, this._then);

  final TrainingDayShareSetDto _self;
  final $Res Function(TrainingDayShareSetDto) _then;

/// Create a copy of TrainingDayShareSetDto
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


/// Adds pattern-matching-related methods to [TrainingDayShareSetDto].
extension TrainingDayShareSetDtoPatterns on TrainingDayShareSetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingDayShareSetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingDayShareSetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingDayShareSetDto value)  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareSetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingDayShareSetDto value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingDayShareSetDto() when $default != null:
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
case _TrainingDayShareSetDto() when $default != null:
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
case _TrainingDayShareSetDto():
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
case _TrainingDayShareSetDto() when $default != null:
return $default(_that.id,_that.setNumber,_that.isCompleted,_that.actualReps,_that.actualWeight,_that.rpe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingDayShareSetDto extends TrainingDayShareSetDto {
  const _TrainingDayShareSetDto({required this.id, this.setNumber = 0, this.isCompleted = false, this.actualReps, this.actualWeight, this.rpe}): super._();
  factory _TrainingDayShareSetDto.fromJson(Map<String, dynamic> json) => _$TrainingDayShareSetDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  int setNumber;
@override@JsonKey() final  bool isCompleted;
@override final  int? actualReps;
@override final  double? actualWeight;
@override final  double? rpe;

/// Create a copy of TrainingDayShareSetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingDayShareSetDtoCopyWith<_TrainingDayShareSetDto> get copyWith => __$TrainingDayShareSetDtoCopyWithImpl<_TrainingDayShareSetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingDayShareSetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingDayShareSetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.actualWeight, actualWeight) || other.actualWeight == actualWeight)&&(identical(other.rpe, rpe) || other.rpe == rpe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,setNumber,isCompleted,actualReps,actualWeight,rpe);

@override
String toString() {
  return 'TrainingDayShareSetDto(id: $id, setNumber: $setNumber, isCompleted: $isCompleted, actualReps: $actualReps, actualWeight: $actualWeight, rpe: $rpe)';
}


}

/// @nodoc
abstract mixin class _$TrainingDayShareSetDtoCopyWith<$Res> implements $TrainingDayShareSetDtoCopyWith<$Res> {
  factory _$TrainingDayShareSetDtoCopyWith(_TrainingDayShareSetDto value, $Res Function(_TrainingDayShareSetDto) _then) = __$TrainingDayShareSetDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int setNumber, bool isCompleted, int? actualReps, double? actualWeight, double? rpe
});




}
/// @nodoc
class __$TrainingDayShareSetDtoCopyWithImpl<$Res>
    implements _$TrainingDayShareSetDtoCopyWith<$Res> {
  __$TrainingDayShareSetDtoCopyWithImpl(this._self, this._then);

  final _TrainingDayShareSetDto _self;
  final $Res Function(_TrainingDayShareSetDto) _then;

/// Create a copy of TrainingDayShareSetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? setNumber = null,Object? isCompleted = null,Object? actualReps = freezed,Object? actualWeight = freezed,Object? rpe = freezed,}) {
  return _then(_TrainingDayShareSetDto(
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
