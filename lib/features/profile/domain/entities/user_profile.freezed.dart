// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 String get id; String get email; String get firstName; String get lastName; int get currentStreak; int get level; int get totalXp; int get xpToNextLevel; String get title; Big3Prs get big3Prs; String? get avatarUrl; String? get bio; double? get height; String? get gender; DateTime? get dateOfBirth; String? get developmentDirection; String? get trainingDiscipline; double? get latestBodyweight; double? get bmi; String? get bmiCategory; double? get dotsScore; String? get facebookUrl; String? get instagramUrl; String? get zaloUrl;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.height, height) || other.height == height)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.facebookUrl, facebookUrl) || other.facebookUrl == facebookUrl)&&(identical(other.instagramUrl, instagramUrl) || other.instagramUrl == instagramUrl)&&(identical(other.zaloUrl, zaloUrl) || other.zaloUrl == zaloUrl));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,email,firstName,lastName,currentStreak,level,totalXp,xpToNextLevel,title,big3Prs,avatarUrl,bio,height,gender,dateOfBirth,developmentDirection,trainingDiscipline,latestBodyweight,bmi,bmiCategory,dotsScore,facebookUrl,instagramUrl,zaloUrl]);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, firstName: $firstName, lastName: $lastName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, big3Prs: $big3Prs, avatarUrl: $avatarUrl, bio: $bio, height: $height, gender: $gender, dateOfBirth: $dateOfBirth, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore, facebookUrl: $facebookUrl, instagramUrl: $instagramUrl, zaloUrl: $zaloUrl)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String email, String firstName, String lastName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, Big3Prs big3Prs, String? avatarUrl, String? bio, double? height, String? gender, DateTime? dateOfBirth, String? developmentDirection, String? trainingDiscipline, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore, String? facebookUrl, String? instagramUrl, String? zaloUrl
});


$Big3PrsCopyWith<$Res> get big3Prs;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? currentStreak = null,Object? level = null,Object? totalXp = null,Object? xpToNextLevel = null,Object? title = null,Object? big3Prs = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? height = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? dotsScore = freezed,Object? facebookUrl = freezed,Object? instagramUrl = freezed,Object? zaloUrl = freezed,}) {
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
as String,big3Prs: null == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3Prs,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
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
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Big3PrsCopyWith<$Res> get big3Prs {
  
  return $Big3PrsCopyWith<$Res>(_self.big3Prs, (value) {
    return _then(_self.copyWith(big3Prs: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  Big3Prs big3Prs,  String? avatarUrl,  String? bio,  double? height,  String? gender,  DateTime? dateOfBirth,  String? developmentDirection,  String? trainingDiscipline,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore,  String? facebookUrl,  String? instagramUrl,  String? zaloUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  Big3Prs big3Prs,  String? avatarUrl,  String? bio,  double? height,  String? gender,  DateTime? dateOfBirth,  String? developmentDirection,  String? trainingDiscipline,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore,  String? facebookUrl,  String? instagramUrl,  String? zaloUrl)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String firstName,  String lastName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  Big3Prs big3Prs,  String? avatarUrl,  String? bio,  double? height,  String? gender,  DateTime? dateOfBirth,  String? developmentDirection,  String? trainingDiscipline,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore,  String? facebookUrl,  String? instagramUrl,  String? zaloUrl)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.big3Prs,_that.avatarUrl,_that.bio,_that.height,_that.gender,_that.dateOfBirth,_that.developmentDirection,_that.trainingDiscipline,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore,_that.facebookUrl,_that.instagramUrl,_that.zaloUrl);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile extends UserProfile {
  const _UserProfile({required this.id, required this.email, required this.firstName, required this.lastName, required this.currentStreak, required this.level, required this.totalXp, required this.xpToNextLevel, required this.title, required this.big3Prs, this.avatarUrl, this.bio, this.height, this.gender, this.dateOfBirth, this.developmentDirection, this.trainingDiscipline, this.latestBodyweight, this.bmi, this.bmiCategory, this.dotsScore, this.facebookUrl, this.instagramUrl, this.zaloUrl}): super._();
  

@override final  String id;
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  int currentStreak;
@override final  int level;
@override final  int totalXp;
@override final  int xpToNextLevel;
@override final  String title;
@override final  Big3Prs big3Prs;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  double? height;
@override final  String? gender;
@override final  DateTime? dateOfBirth;
@override final  String? developmentDirection;
@override final  String? trainingDiscipline;
@override final  double? latestBodyweight;
@override final  double? bmi;
@override final  String? bmiCategory;
@override final  double? dotsScore;
@override final  String? facebookUrl;
@override final  String? instagramUrl;
@override final  String? zaloUrl;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.big3Prs, big3Prs) || other.big3Prs == big3Prs)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.height, height) || other.height == height)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.developmentDirection, developmentDirection) || other.developmentDirection == developmentDirection)&&(identical(other.trainingDiscipline, trainingDiscipline) || other.trainingDiscipline == trainingDiscipline)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore)&&(identical(other.facebookUrl, facebookUrl) || other.facebookUrl == facebookUrl)&&(identical(other.instagramUrl, instagramUrl) || other.instagramUrl == instagramUrl)&&(identical(other.zaloUrl, zaloUrl) || other.zaloUrl == zaloUrl));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,email,firstName,lastName,currentStreak,level,totalXp,xpToNextLevel,title,big3Prs,avatarUrl,bio,height,gender,dateOfBirth,developmentDirection,trainingDiscipline,latestBodyweight,bmi,bmiCategory,dotsScore,facebookUrl,instagramUrl,zaloUrl]);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, firstName: $firstName, lastName: $lastName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, big3Prs: $big3Prs, avatarUrl: $avatarUrl, bio: $bio, height: $height, gender: $gender, dateOfBirth: $dateOfBirth, developmentDirection: $developmentDirection, trainingDiscipline: $trainingDiscipline, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore, facebookUrl: $facebookUrl, instagramUrl: $instagramUrl, zaloUrl: $zaloUrl)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String firstName, String lastName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, Big3Prs big3Prs, String? avatarUrl, String? bio, double? height, String? gender, DateTime? dateOfBirth, String? developmentDirection, String? trainingDiscipline, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore, String? facebookUrl, String? instagramUrl, String? zaloUrl
});


@override $Big3PrsCopyWith<$Res> get big3Prs;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? currentStreak = null,Object? level = null,Object? totalXp = null,Object? xpToNextLevel = null,Object? title = null,Object? big3Prs = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? height = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? developmentDirection = freezed,Object? trainingDiscipline = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? dotsScore = freezed,Object? facebookUrl = freezed,Object? instagramUrl = freezed,Object? zaloUrl = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,xpToNextLevel: null == xpToNextLevel ? _self.xpToNextLevel : xpToNextLevel // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,big3Prs: null == big3Prs ? _self.big3Prs : big3Prs // ignore: cast_nullable_to_non_nullable
as Big3Prs,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,developmentDirection: freezed == developmentDirection ? _self.developmentDirection : developmentDirection // ignore: cast_nullable_to_non_nullable
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

/// Create a copy of UserProfile
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

// dart format on
