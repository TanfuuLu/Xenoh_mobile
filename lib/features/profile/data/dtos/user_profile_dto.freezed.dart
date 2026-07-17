// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDto {

 String get id; String get email; String get firstName; String get lastName; int get currentStreak; int get level; int get totalXp; int get xpToNextLevel; String get title; Big3PrsDto? get big3Prs; String? get avatarUrl; String? get bio; double? get height; String? get gender; String? get dateOfBirth; String? get developmentDirection; String? get trainingDiscipline; double? get latestBodyweight; double? get bmi; String? get bmiCategory; double? get dotsScore; String? get facebookUrl; String? get instagramUrl; String? get zaloUrl;
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDtoCopyWith<UserProfileDto> get copyWith => _$UserProfileDtoCopyWithImpl<UserProfileDto>(this as UserProfileDto, _$identity);

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.height, height) || other.height == height)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.facebookUrl, facebookUrl) || other.facebookUrl == facebookUrl)&&(identical(other.instagramUrl, instagramUrl) || other.instagramUrl == instagramUrl)&&(identical(other.zaloUrl, zaloUrl) || other.zaloUrl == zaloUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,firstName,lastName,currentStreak,level,totalXp,xpToNextLevel,title,big3Prs,avatarUrl,bio,height,gender,dateOfBirth,developmentDirection,trainingDiscipline,latestBodyweight,bmi,bmiCategory,dotsScore,facebookUrl,instagramUrl,zaloUrl]);

@override
String toString() {
  return 'UserProfileDto(id: $id, email: $email, firstName: $firstName, lastName: $lastName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, big3Prs: $big3Prs, avatarUrl: $avatarUrl, bio: $bio, height: $height, gender: $gender, dateOfBirth: $dateOfBirth, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore, facebookUrl: $facebookUrl, instagramUrl: $instagramUrl, zaloUrl: $zaloUrl)';
}


}

/// @nodoc
abstract mixin class $UserProfileDtoCopyWith<$Res>  {
  factory $UserProfileDtoCopyWith(UserProfileDto value, $Res Function(UserProfileDto) _then) = _$UserProfileDtoCopyWithImpl;
@useResult
$Res call({
 String id, String email, String firstName, String lastName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, Big3PrsDto? big3Prs, String? avatarUrl, String? bio, double? height, String? gender, String? dateOfBirth, String? developmentDirection, String? trainingDiscipline, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore, String? facebookUrl, String? instagramUrl, String? zaloUrl
});


$Big3PrsDtoCopyWith<$Res>? get big3Prs;

}
/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._self, this._then);

  final UserProfileDto _self;
  final $Res Function(UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? currentStreak = null,Object? level = null,Object? totalXp = null,Object? xpToNextLevel = null,Object? title = null,Object? big3Prs = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? height = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? dotsScore = freezed,Object? facebookUrl = freezed,Object? instagramUrl = freezed,Object? zaloUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,xpToNextLevel: null == xpToNextLevel ? _self.xpToNextLevel : xpToNextLevel // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,big3Prs: freezed == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3PrsDto?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
as String?,trainingDiscipline: freezed == trainingDiscipline ? _self.trainingDiscipline : trainingDiscipline // ignore: cast_nullable_to_non_nullable
as String?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,facebookUrl: freezed == facebookUrl ? _self.facebookUrl : facebookUrl // ignore: cast_nullable_to_non_nullable
as String?,instagramUrl: freezed == instagramUrl ? _self.instagramUrl : instagramUrl // ignore: cast_nullable_to_non_nullable
as String?,zaloUrl: freezed == zaloUrl ? _self.zaloUrl : zaloUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserProfileDto
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


/// Adds pattern-matching-related methods to [UserProfileDto].
extension UserProfileDtoPatterns on UserProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  Big3PrsDto? big3Prs,  String? avatarUrl,  String? bio,  double? height,  String? gender,  String? dateOfBirth,  String? developmentDirection,  String? trainingDiscipline,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore,  String? facebookUrl,  String? instagramUrl,  String? zaloUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.big3Prs,_that.avatarUrl,_that.bio,_that.height,_that.gender,_that.dateOfBirth,_that.developmentDirection,_that.trainingDiscipline,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore,_that.facebookUrl,_that.instagramUrl,_that.zaloUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  Big3PrsDto? big3Prs,  String? avatarUrl,  String? bio,  double? height,  String? gender,  String? dateOfBirth,  String? developmentDirection,  String? trainingDiscipline,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore,  String? facebookUrl,  String? instagramUrl,  String? zaloUrl)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.big3Prs,_that.avatarUrl,_that.bio,_that.height,_that.gender,_that.dateOfBirth,_that.developmentDirection,_that.trainingDiscipline,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore,_that.facebookUrl,_that.instagramUrl,_that.zaloUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String firstName,  String lastName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  Big3PrsDto? big3Prs,  String? avatarUrl,  String? bio,  double? height,  String? gender,  String? dateOfBirth,  String? developmentDirection,  String? trainingDiscipline,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore,  String? facebookUrl,  String? instagramUrl,  String? zaloUrl)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.big3Prs,_that.avatarUrl,_that.bio,_that.height,_that.gender,_that.dateOfBirth,_that.developmentDirection,_that.trainingDiscipline,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore,_that.facebookUrl,_that.instagramUrl,_that.zaloUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileDto extends UserProfileDto {
  const _UserProfileDto({required this.id, required this.email, required this.firstName, required this.lastName, required this.currentStreak, required this.level, required this.totalXp, required this.xpToNextLevel, required this.title, this.big3Prs, this.avatarUrl, this.bio, this.height, this.gender, this.dateOfBirth, this.developmentDirection, this.trainingDiscipline, this.latestBodyweight, this.bmi, this.bmiCategory, this.dotsScore, this.facebookUrl, this.instagramUrl, this.zaloUrl}): super._();
  factory _UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

@override final  String id;
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  int currentStreak;
@override final  int level;
@override final  int totalXp;
@override final  int xpToNextLevel;
@override final  String title;
@override final  Big3PrsDto? big3Prs;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  double? height;
@override final  String? gender;
@override final  String? dateOfBirth;
@override final  String? developmentDirection;
@override final  String? trainingDiscipline;
@override final  double? latestBodyweight;
@override final  double? bmi;
@override final  String? bmiCategory;
@override final  double? dotsScore;
@override final  String? facebookUrl;
@override final  String? instagramUrl;
@override final  String? zaloUrl;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDtoCopyWith<_UserProfileDto> get copyWith => __$UserProfileDtoCopyWithImpl<_UserProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.height, height) || other.height == height)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.facebookUrl, facebookUrl) || other.facebookUrl == facebookUrl)&&(identical(other.instagramUrl, instagramUrl) || other.instagramUrl == instagramUrl)&&(identical(other.zaloUrl, zaloUrl) || other.zaloUrl == zaloUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,firstName,lastName,currentStreak,level,totalXp,xpToNextLevel,title,big3Prs,avatarUrl,bio,height,gender,dateOfBirth,developmentDirection,trainingDiscipline,latestBodyweight,bmi,bmiCategory,dotsScore,facebookUrl,instagramUrl,zaloUrl]);

@override
String toString() {
  return 'UserProfileDto(id: $id, email: $email, firstName: $firstName, lastName: $lastName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, big3Prs: $big3Prs, avatarUrl: $avatarUrl, bio: $bio, height: $height, gender: $gender, dateOfBirth: $dateOfBirth, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore, facebookUrl: $facebookUrl, instagramUrl: $instagramUrl, zaloUrl: $zaloUrl)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDtoCopyWith<$Res> implements $UserProfileDtoCopyWith<$Res> {
  factory _$UserProfileDtoCopyWith(_UserProfileDto value, $Res Function(_UserProfileDto) _then) = __$UserProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String firstName, String lastName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, Big3PrsDto? big3Prs, String? avatarUrl, String? bio, double? height, String? gender, String? dateOfBirth, String? developmentDirection, String? trainingDiscipline, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore, String? facebookUrl, String? instagramUrl, String? zaloUrl
});


@override $Big3PrsDtoCopyWith<$Res>? get big3Prs;

}
/// @nodoc
class __$UserProfileDtoCopyWithImpl<$Res>
    implements _$UserProfileDtoCopyWith<$Res> {
  __$UserProfileDtoCopyWithImpl(this._self, this._then);

  final _UserProfileDto _self;
  final $Res Function(_UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? currentStreak = null,Object? level = null,Object? totalXp = null,Object? xpToNextLevel = null,Object? title = null,Object? big3Prs = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? height = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? dotsScore = freezed,Object? facebookUrl = freezed,Object? instagramUrl = freezed,Object? zaloUrl = freezed,}) {
  return _then(_UserProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,xpToNextLevel: null == xpToNextLevel ? _self.xpToNextLevel : xpToNextLevel // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,big3Prs: freezed == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3PrsDto?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
as String?,trainingDiscipline: freezed == trainingDiscipline ? _self.trainingDiscipline : trainingDiscipline // ignore: cast_nullable_to_non_nullable
as String?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,facebookUrl: freezed == facebookUrl ? _self.facebookUrl : facebookUrl // ignore: cast_nullable_to_non_nullable
as String?,instagramUrl: freezed == instagramUrl ? _self.instagramUrl : instagramUrl // ignore: cast_nullable_to_non_nullable
as String?,zaloUrl: freezed == zaloUrl ? _self.zaloUrl : zaloUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserProfileDto
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

// dart format on
