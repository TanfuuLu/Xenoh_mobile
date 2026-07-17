// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonalDashboard {

 DashboardProfile get profile; NutritionToday get nutritionToday; ProInsights get proInsights; List<NextAction> get nextActions; DashboardPlan? get activePlan; TodayWorkout? get todayWorkout;
/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDashboardCopyWith<PersonalDashboard> get copyWith => _$PersonalDashboardCopyWithImpl<PersonalDashboard>(this as PersonalDashboard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDashboard&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.nutritionToday, nutritionToday) || other.nutritionToday == nutritionToday)&&(identical(other.proInsights, proInsights) || other.proInsights == proInsights)&&const DeepCollectionEquality().equals(other.nextActions, nextActions)&&(identical(other.activePlan, activePlan) || other.activePlan == activePlan)&&(identical(other.todayWorkout, todayWorkout) || other.todayWorkout == todayWorkout));
}


@override
int get hashCode => Object.hash(runtimeType,profile,nutritionToday,proInsights,const DeepCollectionEquality().hash(nextActions),activePlan,todayWorkout);

@override
String toString() {
  return 'PersonalDashboard(profile: $profile, nutritionToday: $nutritionToday, proInsights: $proInsights, nextActions: $nextActions, activePlan: $activePlan, todayWorkout: $todayWorkout)';
}


}

/// @nodoc
abstract mixin class $PersonalDashboardCopyWith<$Res>  {
  factory $PersonalDashboardCopyWith(PersonalDashboard value, $Res Function(PersonalDashboard) _then) = _$PersonalDashboardCopyWithImpl;
@useResult
$Res call({
 DashboardProfile profile, NutritionToday nutritionToday, ProInsights proInsights, List<NextAction> nextActions, DashboardPlan? activePlan, TodayWorkout? todayWorkout
});


$DashboardProfileCopyWith<$Res> get profile;$NutritionTodayCopyWith<$Res> get nutritionToday;$ProInsightsCopyWith<$Res> get proInsights;$DashboardPlanCopyWith<$Res>? get activePlan;$TodayWorkoutCopyWith<$Res>? get todayWorkout;

}
/// @nodoc
class _$PersonalDashboardCopyWithImpl<$Res>
    implements $PersonalDashboardCopyWith<$Res> {
  _$PersonalDashboardCopyWithImpl(this._self, this._then);

  final PersonalDashboard _self;
  final $Res Function(PersonalDashboard) _then;

/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? nutritionToday = null,Object? proInsights = null,Object? nextActions = null,Object? activePlan = freezed,Object? todayWorkout = freezed,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DashboardProfile,nutritionToday: null == nutritionToday ? _self.nutritionToday : nutritionToday // ignore: cast_nullable_to_non_nullable
as NutritionToday,proInsights: null == proInsights ? _self.proInsights : proInsights // ignore: cast_nullable_to_non_nullable
as ProInsights,nextActions: null == nextActions ? _self.nextActions : nextActions // ignore: cast_nullable_to_non_nullable
as List<NextAction>,activePlan: freezed == activePlan ? _self.activePlan : activePlan // ignore: cast_nullable_to_non_nullable
as DashboardPlan?,todayWorkout: freezed == todayWorkout ? _self.todayWorkout : todayWorkout // ignore: cast_nullable_to_non_nullable
as TodayWorkout?,
  ));
}
/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardProfileCopyWith<$Res> get profile {
  
  return $DashboardProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionTodayCopyWith<$Res> get nutritionToday {
  
  return $NutritionTodayCopyWith<$Res>(_self.nutritionToday, (value) {
    return _then(_self.copyWith(nutritionToday: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProInsightsCopyWith<$Res> get proInsights {
  
  return $ProInsightsCopyWith<$Res>(_self.proInsights, (value) {
    return _then(_self.copyWith(proInsights: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardPlanCopyWith<$Res>? get activePlan {
    if (_self.activePlan == null) {
    return null;
  }

  return $DashboardPlanCopyWith<$Res>(_self.activePlan!, (value) {
    return _then(_self.copyWith(activePlan: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayWorkoutCopyWith<$Res>? get todayWorkout {
    if (_self.todayWorkout == null) {
    return null;
  }

  return $TodayWorkoutCopyWith<$Res>(_self.todayWorkout!, (value) {
    return _then(_self.copyWith(todayWorkout: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonalDashboard].
extension PersonalDashboardPatterns on PersonalDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalDashboard value)  $default,){
final _that = this;
switch (_that) {
case _PersonalDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DashboardProfile profile,  NutritionToday nutritionToday,  ProInsights proInsights,  List<NextAction> nextActions,  DashboardPlan? activePlan,  TodayWorkout? todayWorkout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDashboard() when $default != null:
return $default(_that.profile,_that.nutritionToday,_that.proInsights,_that.nextActions,_that.activePlan,_that.todayWorkout);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DashboardProfile profile,  NutritionToday nutritionToday,  ProInsights proInsights,  List<NextAction> nextActions,  DashboardPlan? activePlan,  TodayWorkout? todayWorkout)  $default,) {final _that = this;
switch (_that) {
case _PersonalDashboard():
return $default(_that.profile,_that.nutritionToday,_that.proInsights,_that.nextActions,_that.activePlan,_that.todayWorkout);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DashboardProfile profile,  NutritionToday nutritionToday,  ProInsights proInsights,  List<NextAction> nextActions,  DashboardPlan? activePlan,  TodayWorkout? todayWorkout)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDashboard() when $default != null:
return $default(_that.profile,_that.nutritionToday,_that.proInsights,_that.nextActions,_that.activePlan,_that.todayWorkout);case _:
  return null;

}
}

}

/// @nodoc


class _PersonalDashboard implements PersonalDashboard {
  const _PersonalDashboard({required this.profile, required this.nutritionToday, required this.proInsights, final  List<NextAction> nextActions = const <NextAction>[], this.activePlan, this.todayWorkout}): _nextActions = nextActions;
  

@override final  DashboardProfile profile;
@override final  NutritionToday nutritionToday;
@override final  ProInsights proInsights;
 final  List<NextAction> _nextActions;
@override@JsonKey() List<NextAction> get nextActions {
  if (_nextActions is EqualUnmodifiableListView) return _nextActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nextActions);
}

@override final  DashboardPlan? activePlan;
@override final  TodayWorkout? todayWorkout;

/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalDashboardCopyWith<_PersonalDashboard> get copyWith => __$PersonalDashboardCopyWithImpl<_PersonalDashboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDashboard&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.nutritionToday, nutritionToday) || other.nutritionToday == nutritionToday)&&(identical(other.proInsights, proInsights) || other.proInsights == proInsights)&&const DeepCollectionEquality().equals(other._nextActions, _nextActions)&&(identical(other.activePlan, activePlan) || other.activePlan == activePlan)&&(identical(other.todayWorkout, todayWorkout) || other.todayWorkout == todayWorkout));
}


@override
int get hashCode => Object.hash(runtimeType,profile,nutritionToday,proInsights,const DeepCollectionEquality().hash(_nextActions),activePlan,todayWorkout);

@override
String toString() {
  return 'PersonalDashboard(profile: $profile, nutritionToday: $nutritionToday, proInsights: $proInsights, nextActions: $nextActions, activePlan: $activePlan, todayWorkout: $todayWorkout)';
}


}

/// @nodoc
abstract mixin class _$PersonalDashboardCopyWith<$Res> implements $PersonalDashboardCopyWith<$Res> {
  factory _$PersonalDashboardCopyWith(_PersonalDashboard value, $Res Function(_PersonalDashboard) _then) = __$PersonalDashboardCopyWithImpl;
@override @useResult
$Res call({
 DashboardProfile profile, NutritionToday nutritionToday, ProInsights proInsights, List<NextAction> nextActions, DashboardPlan? activePlan, TodayWorkout? todayWorkout
});


@override $DashboardProfileCopyWith<$Res> get profile;@override $NutritionTodayCopyWith<$Res> get nutritionToday;@override $ProInsightsCopyWith<$Res> get proInsights;@override $DashboardPlanCopyWith<$Res>? get activePlan;@override $TodayWorkoutCopyWith<$Res>? get todayWorkout;

}
/// @nodoc
class __$PersonalDashboardCopyWithImpl<$Res>
    implements _$PersonalDashboardCopyWith<$Res> {
  __$PersonalDashboardCopyWithImpl(this._self, this._then);

  final _PersonalDashboard _self;
  final $Res Function(_PersonalDashboard) _then;

/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? nutritionToday = null,Object? proInsights = null,Object? nextActions = null,Object? activePlan = freezed,Object? todayWorkout = freezed,}) {
  return _then(_PersonalDashboard(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DashboardProfile,nutritionToday: null == nutritionToday ? _self.nutritionToday : nutritionToday // ignore: cast_nullable_to_non_nullable
as NutritionToday,proInsights: null == proInsights ? _self.proInsights : proInsights // ignore: cast_nullable_to_non_nullable
as ProInsights,nextActions: null == nextActions ? _self._nextActions : nextActions // ignore: cast_nullable_to_non_nullable
as List<NextAction>,activePlan: freezed == activePlan ? _self.activePlan : activePlan // ignore: cast_nullable_to_non_nullable
as DashboardPlan?,todayWorkout: freezed == todayWorkout ? _self.todayWorkout : todayWorkout // ignore: cast_nullable_to_non_nullable
as TodayWorkout?,
  ));
}

/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardProfileCopyWith<$Res> get profile {
  
  return $DashboardProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionTodayCopyWith<$Res> get nutritionToday {
  
  return $NutritionTodayCopyWith<$Res>(_self.nutritionToday, (value) {
    return _then(_self.copyWith(nutritionToday: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProInsightsCopyWith<$Res> get proInsights {
  
  return $ProInsightsCopyWith<$Res>(_self.proInsights, (value) {
    return _then(_self.copyWith(proInsights: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardPlanCopyWith<$Res>? get activePlan {
    if (_self.activePlan == null) {
    return null;
  }

  return $DashboardPlanCopyWith<$Res>(_self.activePlan!, (value) {
    return _then(_self.copyWith(activePlan: value));
  });
}/// Create a copy of PersonalDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayWorkoutCopyWith<$Res>? get todayWorkout {
    if (_self.todayWorkout == null) {
    return null;
  }

  return $TodayWorkoutCopyWith<$Res>(_self.todayWorkout!, (value) {
    return _then(_self.copyWith(todayWorkout: value));
  });
}
}

/// @nodoc
mixin _$DashboardProfile {

 String get firstName; int get currentStreak; int get level; int get totalXp; int get xpToNextLevel; String get title; String? get avatarUrl; double? get latestBodyweight; double? get bmi; String? get bmiCategory; double? get dotsScore;
/// Create a copy of DashboardProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardProfileCopyWith<DashboardProfile> get copyWith => _$DashboardProfileCopyWithImpl<DashboardProfile>(this as DashboardProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardProfile&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,currentStreak,level,totalXp,xpToNextLevel,title,avatarUrl,latestBodyweight,bmi,bmiCategory,dotsScore);

@override
String toString() {
  return 'DashboardProfile(firstName: $firstName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, avatarUrl: $avatarUrl, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore)';
}


}

/// @nodoc
abstract mixin class $DashboardProfileCopyWith<$Res>  {
  factory $DashboardProfileCopyWith(DashboardProfile value, $Res Function(DashboardProfile) _then) = _$DashboardProfileCopyWithImpl;
@useResult
$Res call({
 String firstName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, String? avatarUrl, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore
});




}
/// @nodoc
class _$DashboardProfileCopyWithImpl<$Res>
    implements $DashboardProfileCopyWith<$Res> {
  _$DashboardProfileCopyWithImpl(this._self, this._then);

  final DashboardProfile _self;
  final $Res Function(DashboardProfile) _then;

/// Create a copy of DashboardProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? currentStreak = null,Object? level = null,Object? totalXp = null,Object? xpToNextLevel = null,Object? title = null,Object? avatarUrl = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? dotsScore = freezed,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,xpToNextLevel: null == xpToNextLevel ? _self.xpToNextLevel : xpToNextLevel // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardProfile].
extension DashboardProfilePatterns on DashboardProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardProfile value)  $default,){
final _that = this;
switch (_that) {
case _DashboardProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardProfile value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  String? avatarUrl,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardProfile() when $default != null:
return $default(_that.firstName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.avatarUrl,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  String? avatarUrl,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore)  $default,) {final _that = this;
switch (_that) {
case _DashboardProfile():
return $default(_that.firstName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.avatarUrl,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  int currentStreak,  int level,  int totalXp,  int xpToNextLevel,  String title,  String? avatarUrl,  double? latestBodyweight,  double? bmi,  String? bmiCategory,  double? dotsScore)?  $default,) {final _that = this;
switch (_that) {
case _DashboardProfile() when $default != null:
return $default(_that.firstName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.avatarUrl,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardProfile implements DashboardProfile {
  const _DashboardProfile({required this.firstName, required this.currentStreak, required this.level, required this.totalXp, required this.xpToNextLevel, required this.title, this.avatarUrl, this.latestBodyweight, this.bmi, this.bmiCategory, this.dotsScore});
  

@override final  String firstName;
@override final  int currentStreak;
@override final  int level;
@override final  int totalXp;
@override final  int xpToNextLevel;
@override final  String title;
@override final  String? avatarUrl;
@override final  double? latestBodyweight;
@override final  double? bmi;
@override final  String? bmiCategory;
@override final  double? dotsScore;

/// Create a copy of DashboardProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardProfileCopyWith<_DashboardProfile> get copyWith => __$DashboardProfileCopyWithImpl<_DashboardProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardProfile&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,currentStreak,level,totalXp,xpToNextLevel,title,avatarUrl,latestBodyweight,bmi,bmiCategory,dotsScore);

@override
String toString() {
  return 'DashboardProfile(firstName: $firstName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, avatarUrl: $avatarUrl, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore)';
}


}

/// @nodoc
abstract mixin class _$DashboardProfileCopyWith<$Res> implements $DashboardProfileCopyWith<$Res> {
  factory _$DashboardProfileCopyWith(_DashboardProfile value, $Res Function(_DashboardProfile) _then) = __$DashboardProfileCopyWithImpl;
@override @useResult
$Res call({
 String firstName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, String? avatarUrl, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore
});




}
/// @nodoc
class __$DashboardProfileCopyWithImpl<$Res>
    implements _$DashboardProfileCopyWith<$Res> {
  __$DashboardProfileCopyWithImpl(this._self, this._then);

  final _DashboardProfile _self;
  final $Res Function(_DashboardProfile) _then;

/// Create a copy of DashboardProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? currentStreak = null,Object? level = null,Object? totalXp = null,Object? xpToNextLevel = null,Object? title = null,Object? avatarUrl = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? dotsScore = freezed,}) {
  return _then(_DashboardProfile(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,xpToNextLevel: null == xpToNextLevel ? _self.xpToNextLevel : xpToNextLevel // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,latestBodyweight: freezed == latestBodyweight ? _self.latestBodyweight : latestBodyweight // ignore: cast_nullable_to_non_nullable
as double?,bmi: freezed == bmi ? _self.bmi : bmi // ignore: cast_nullable_to_non_nullable
as double?,bmiCategory: freezed == bmiCategory ? _self.bmiCategory : bmiCategory // ignore: cast_nullable_to_non_nullable
as String?,dotsScore: freezed == dotsScore ? _self.dotsScore : dotsScore // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$DashboardPlan {

 String get id; String get name; DateTime get startDate; DateTime get endDate; int get totalDays; int get completedDays; int get progressPercent; DashboardWeek? get currentWeek;
/// Create a copy of DashboardPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardPlanCopyWith<DashboardPlan> get copyWith => _$DashboardPlanCopyWithImpl<DashboardPlan>(this as DashboardPlan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.currentWeek, currentWeek) || other.currentWeek == currentWeek));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,totalDays,completedDays,progressPercent,currentWeek);

@override
String toString() {
  return 'DashboardPlan(id: $id, name: $name, startDate: $startDate, endDate: $endDate, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent, currentWeek: $currentWeek)';
}


}

/// @nodoc
abstract mixin class $DashboardPlanCopyWith<$Res>  {
  factory $DashboardPlanCopyWith(DashboardPlan value, $Res Function(DashboardPlan) _then) = _$DashboardPlanCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime startDate, DateTime endDate, int totalDays, int completedDays, int progressPercent, DashboardWeek? currentWeek
});


$DashboardWeekCopyWith<$Res>? get currentWeek;

}
/// @nodoc
class _$DashboardPlanCopyWithImpl<$Res>
    implements $DashboardPlanCopyWith<$Res> {
  _$DashboardPlanCopyWithImpl(this._self, this._then);

  final DashboardPlan _self;
  final $Res Function(DashboardPlan) _then;

/// Create a copy of DashboardPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? totalDays = null,Object? completedDays = null,Object? progressPercent = null,Object? currentWeek = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,currentWeek: freezed == currentWeek ? _self.currentWeek : currentWeek // ignore: cast_nullable_to_non_nullable
as DashboardWeek?,
  ));
}
/// Create a copy of DashboardPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardWeekCopyWith<$Res>? get currentWeek {
    if (_self.currentWeek == null) {
    return null;
  }

  return $DashboardWeekCopyWith<$Res>(_self.currentWeek!, (value) {
    return _then(_self.copyWith(currentWeek: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardPlan].
extension DashboardPlanPatterns on DashboardPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardPlan value)  $default,){
final _that = this;
switch (_that) {
case _DashboardPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardPlan value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startDate,  DateTime endDate,  int totalDays,  int completedDays,  int progressPercent,  DashboardWeek? currentWeek)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardPlan() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.totalDays,_that.completedDays,_that.progressPercent,_that.currentWeek);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startDate,  DateTime endDate,  int totalDays,  int completedDays,  int progressPercent,  DashboardWeek? currentWeek)  $default,) {final _that = this;
switch (_that) {
case _DashboardPlan():
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.totalDays,_that.completedDays,_that.progressPercent,_that.currentWeek);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DateTime startDate,  DateTime endDate,  int totalDays,  int completedDays,  int progressPercent,  DashboardWeek? currentWeek)?  $default,) {final _that = this;
switch (_that) {
case _DashboardPlan() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.totalDays,_that.completedDays,_that.progressPercent,_that.currentWeek);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardPlan implements DashboardPlan {
  const _DashboardPlan({required this.id, required this.name, required this.startDate, required this.endDate, required this.totalDays, required this.completedDays, required this.progressPercent, this.currentWeek});
  

@override final  String id;
@override final  String name;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  int totalDays;
@override final  int completedDays;
@override final  int progressPercent;
@override final  DashboardWeek? currentWeek;

/// Create a copy of DashboardPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardPlanCopyWith<_DashboardPlan> get copyWith => __$DashboardPlanCopyWithImpl<_DashboardPlan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.currentWeek, currentWeek) || other.currentWeek == currentWeek));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,totalDays,completedDays,progressPercent,currentWeek);

@override
String toString() {
  return 'DashboardPlan(id: $id, name: $name, startDate: $startDate, endDate: $endDate, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent, currentWeek: $currentWeek)';
}


}

/// @nodoc
abstract mixin class _$DashboardPlanCopyWith<$Res> implements $DashboardPlanCopyWith<$Res> {
  factory _$DashboardPlanCopyWith(_DashboardPlan value, $Res Function(_DashboardPlan) _then) = __$DashboardPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime startDate, DateTime endDate, int totalDays, int completedDays, int progressPercent, DashboardWeek? currentWeek
});


@override $DashboardWeekCopyWith<$Res>? get currentWeek;

}
/// @nodoc
class __$DashboardPlanCopyWithImpl<$Res>
    implements _$DashboardPlanCopyWith<$Res> {
  __$DashboardPlanCopyWithImpl(this._self, this._then);

  final _DashboardPlan _self;
  final $Res Function(_DashboardPlan) _then;

/// Create a copy of DashboardPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? totalDays = null,Object? completedDays = null,Object? progressPercent = null,Object? currentWeek = freezed,}) {
  return _then(_DashboardPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,currentWeek: freezed == currentWeek ? _self.currentWeek : currentWeek // ignore: cast_nullable_to_non_nullable
as DashboardWeek?,
  ));
}

/// Create a copy of DashboardPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardWeekCopyWith<$Res>? get currentWeek {
    if (_self.currentWeek == null) {
    return null;
  }

  return $DashboardWeekCopyWith<$Res>(_self.currentWeek!, (value) {
    return _then(_self.copyWith(currentWeek: value));
  });
}
}

/// @nodoc
mixin _$DashboardWeek {

 String get id; String get name; int get totalDays; int get completedDays; int get progressPercent;
/// Create a copy of DashboardWeek
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardWeekCopyWith<DashboardWeek> get copyWith => _$DashboardWeekCopyWithImpl<DashboardWeek>(this as DashboardWeek, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardWeek&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,totalDays,completedDays,progressPercent);

@override
String toString() {
  return 'DashboardWeek(id: $id, name: $name, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent)';
}


}

/// @nodoc
abstract mixin class $DashboardWeekCopyWith<$Res>  {
  factory $DashboardWeekCopyWith(DashboardWeek value, $Res Function(DashboardWeek) _then) = _$DashboardWeekCopyWithImpl;
@useResult
$Res call({
 String id, String name, int totalDays, int completedDays, int progressPercent
});




}
/// @nodoc
class _$DashboardWeekCopyWithImpl<$Res>
    implements $DashboardWeekCopyWith<$Res> {
  _$DashboardWeekCopyWithImpl(this._self, this._then);

  final DashboardWeek _self;
  final $Res Function(DashboardWeek) _then;

/// Create a copy of DashboardWeek
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? totalDays = null,Object? completedDays = null,Object? progressPercent = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardWeek].
extension DashboardWeekPatterns on DashboardWeek {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardWeek value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardWeek() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardWeek value)  $default,){
final _that = this;
switch (_that) {
case _DashboardWeek():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardWeek value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardWeek() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int totalDays,  int completedDays,  int progressPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardWeek() when $default != null:
return $default(_that.id,_that.name,_that.totalDays,_that.completedDays,_that.progressPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int totalDays,  int completedDays,  int progressPercent)  $default,) {final _that = this;
switch (_that) {
case _DashboardWeek():
return $default(_that.id,_that.name,_that.totalDays,_that.completedDays,_that.progressPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int totalDays,  int completedDays,  int progressPercent)?  $default,) {final _that = this;
switch (_that) {
case _DashboardWeek() when $default != null:
return $default(_that.id,_that.name,_that.totalDays,_that.completedDays,_that.progressPercent);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardWeek implements DashboardWeek {
  const _DashboardWeek({required this.id, required this.name, required this.totalDays, required this.completedDays, required this.progressPercent});
  

@override final  String id;
@override final  String name;
@override final  int totalDays;
@override final  int completedDays;
@override final  int progressPercent;

/// Create a copy of DashboardWeek
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardWeekCopyWith<_DashboardWeek> get copyWith => __$DashboardWeekCopyWithImpl<_DashboardWeek>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardWeek&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,totalDays,completedDays,progressPercent);

@override
String toString() {
  return 'DashboardWeek(id: $id, name: $name, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent)';
}


}

/// @nodoc
abstract mixin class _$DashboardWeekCopyWith<$Res> implements $DashboardWeekCopyWith<$Res> {
  factory _$DashboardWeekCopyWith(_DashboardWeek value, $Res Function(_DashboardWeek) _then) = __$DashboardWeekCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int totalDays, int completedDays, int progressPercent
});




}
/// @nodoc
class __$DashboardWeekCopyWithImpl<$Res>
    implements _$DashboardWeekCopyWith<$Res> {
  __$DashboardWeekCopyWithImpl(this._self, this._then);

  final _DashboardWeek _self;
  final $Res Function(_DashboardWeek) _then;

/// Create a copy of DashboardWeek
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? totalDays = null,Object? completedDays = null,Object? progressPercent = null,}) {
  return _then(_DashboardWeek(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TodayWorkout {

 String get id; String get weeklyWorkoutId; String get dayOfWeek; DateTime get date; String get status; bool get isCompleted; int get totalExercises; int get completedExercises; int get totalSets; int get completedSets; double get plannedVolume; String get route; List<String> get muscleGroups;
/// Create a copy of TodayWorkout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayWorkoutCopyWith<TodayWorkout> get copyWith => _$TodayWorkoutCopyWithImpl<TodayWorkout>(this as TodayWorkout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayWorkout&&(identical(other.id, id) || other.id == id)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.plannedVolume, plannedVolume) || other.plannedVolume == plannedVolume)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other.muscleGroups, muscleGroups));
}


@override
int get hashCode => Object.hash(runtimeType,id,weeklyWorkoutId,dayOfWeek,date,status,isCompleted,totalExercises,completedExercises,totalSets,completedSets,plannedVolume,route,const DeepCollectionEquality().hash(muscleGroups));

@override
String toString() {
  return 'TodayWorkout(id: $id, weeklyWorkoutId: $weeklyWorkoutId, dayOfWeek: $dayOfWeek, date: $date, status: $status, isCompleted: $isCompleted, totalExercises: $totalExercises, completedExercises: $completedExercises, totalSets: $totalSets, completedSets: $completedSets, plannedVolume: $plannedVolume, route: $route, muscleGroups: $muscleGroups)';
}


}

/// @nodoc
abstract mixin class $TodayWorkoutCopyWith<$Res>  {
  factory $TodayWorkoutCopyWith(TodayWorkout value, $Res Function(TodayWorkout) _then) = _$TodayWorkoutCopyWithImpl;
@useResult
$Res call({
 String id, String weeklyWorkoutId, String dayOfWeek, DateTime date, String status, bool isCompleted, int totalExercises, int completedExercises, int totalSets, int completedSets, double plannedVolume, String route, List<String> muscleGroups
});




}
/// @nodoc
class _$TodayWorkoutCopyWithImpl<$Res>
    implements $TodayWorkoutCopyWith<$Res> {
  _$TodayWorkoutCopyWithImpl(this._self, this._then);

  final TodayWorkout _self;
  final $Res Function(TodayWorkout) _then;

/// Create a copy of TodayWorkout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weeklyWorkoutId = null,Object? dayOfWeek = null,Object? date = null,Object? status = null,Object? isCompleted = null,Object? totalExercises = null,Object? completedExercises = null,Object? totalSets = null,Object? completedSets = null,Object? plannedVolume = null,Object? route = null,Object? muscleGroups = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weeklyWorkoutId: null == weeklyWorkoutId ? _self.weeklyWorkoutId : weeklyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,totalExercises: null == totalExercises ? _self.totalExercises : totalExercises // ignore: cast_nullable_to_non_nullable
as int,completedExercises: null == completedExercises ? _self.completedExercises : completedExercises // ignore: cast_nullable_to_non_nullable
as int,totalSets: null == totalSets ? _self.totalSets : totalSets // ignore: cast_nullable_to_non_nullable
as int,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,plannedVolume: null == plannedVolume ? _self.plannedVolume : plannedVolume // ignore: cast_nullable_to_non_nullable
as double,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,muscleGroups: null == muscleGroups ? _self.muscleGroups : muscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayWorkout].
extension TodayWorkoutPatterns on TodayWorkout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayWorkout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayWorkout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayWorkout value)  $default,){
final _that = this;
switch (_that) {
case _TodayWorkout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayWorkout value)?  $default,){
final _that = this;
switch (_that) {
case _TodayWorkout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String weeklyWorkoutId,  String dayOfWeek,  DateTime date,  String status,  bool isCompleted,  int totalExercises,  int completedExercises,  int totalSets,  int completedSets,  double plannedVolume,  String route,  List<String> muscleGroups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayWorkout() when $default != null:
return $default(_that.id,_that.weeklyWorkoutId,_that.dayOfWeek,_that.date,_that.status,_that.isCompleted,_that.totalExercises,_that.completedExercises,_that.totalSets,_that.completedSets,_that.plannedVolume,_that.route,_that.muscleGroups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String weeklyWorkoutId,  String dayOfWeek,  DateTime date,  String status,  bool isCompleted,  int totalExercises,  int completedExercises,  int totalSets,  int completedSets,  double plannedVolume,  String route,  List<String> muscleGroups)  $default,) {final _that = this;
switch (_that) {
case _TodayWorkout():
return $default(_that.id,_that.weeklyWorkoutId,_that.dayOfWeek,_that.date,_that.status,_that.isCompleted,_that.totalExercises,_that.completedExercises,_that.totalSets,_that.completedSets,_that.plannedVolume,_that.route,_that.muscleGroups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String weeklyWorkoutId,  String dayOfWeek,  DateTime date,  String status,  bool isCompleted,  int totalExercises,  int completedExercises,  int totalSets,  int completedSets,  double plannedVolume,  String route,  List<String> muscleGroups)?  $default,) {final _that = this;
switch (_that) {
case _TodayWorkout() when $default != null:
return $default(_that.id,_that.weeklyWorkoutId,_that.dayOfWeek,_that.date,_that.status,_that.isCompleted,_that.totalExercises,_that.completedExercises,_that.totalSets,_that.completedSets,_that.plannedVolume,_that.route,_that.muscleGroups);case _:
  return null;

}
}

}

/// @nodoc


class _TodayWorkout implements TodayWorkout {
  const _TodayWorkout({required this.id, required this.weeklyWorkoutId, required this.dayOfWeek, required this.date, required this.status, required this.isCompleted, required this.totalExercises, required this.completedExercises, required this.totalSets, required this.completedSets, required this.plannedVolume, required this.route, final  List<String> muscleGroups = const <String>[]}): _muscleGroups = muscleGroups;
  

@override final  String id;
@override final  String weeklyWorkoutId;
@override final  String dayOfWeek;
@override final  DateTime date;
@override final  String status;
@override final  bool isCompleted;
@override final  int totalExercises;
@override final  int completedExercises;
@override final  int totalSets;
@override final  int completedSets;
@override final  double plannedVolume;
@override final  String route;
 final  List<String> _muscleGroups;
@override@JsonKey() List<String> get muscleGroups {
  if (_muscleGroups is EqualUnmodifiableListView) return _muscleGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_muscleGroups);
}


/// Create a copy of TodayWorkout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayWorkoutCopyWith<_TodayWorkout> get copyWith => __$TodayWorkoutCopyWithImpl<_TodayWorkout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayWorkout&&(identical(other.id, id) || other.id == id)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.plannedVolume, plannedVolume) || other.plannedVolume == plannedVolume)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other._muscleGroups, _muscleGroups));
}


@override
int get hashCode => Object.hash(runtimeType,id,weeklyWorkoutId,dayOfWeek,date,status,isCompleted,totalExercises,completedExercises,totalSets,completedSets,plannedVolume,route,const DeepCollectionEquality().hash(_muscleGroups));

@override
String toString() {
  return 'TodayWorkout(id: $id, weeklyWorkoutId: $weeklyWorkoutId, dayOfWeek: $dayOfWeek, date: $date, status: $status, isCompleted: $isCompleted, totalExercises: $totalExercises, completedExercises: $completedExercises, totalSets: $totalSets, completedSets: $completedSets, plannedVolume: $plannedVolume, route: $route, muscleGroups: $muscleGroups)';
}


}

/// @nodoc
abstract mixin class _$TodayWorkoutCopyWith<$Res> implements $TodayWorkoutCopyWith<$Res> {
  factory _$TodayWorkoutCopyWith(_TodayWorkout value, $Res Function(_TodayWorkout) _then) = __$TodayWorkoutCopyWithImpl;
@override @useResult
$Res call({
 String id, String weeklyWorkoutId, String dayOfWeek, DateTime date, String status, bool isCompleted, int totalExercises, int completedExercises, int totalSets, int completedSets, double plannedVolume, String route, List<String> muscleGroups
});




}
/// @nodoc
class __$TodayWorkoutCopyWithImpl<$Res>
    implements _$TodayWorkoutCopyWith<$Res> {
  __$TodayWorkoutCopyWithImpl(this._self, this._then);

  final _TodayWorkout _self;
  final $Res Function(_TodayWorkout) _then;

/// Create a copy of TodayWorkout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weeklyWorkoutId = null,Object? dayOfWeek = null,Object? date = null,Object? status = null,Object? isCompleted = null,Object? totalExercises = null,Object? completedExercises = null,Object? totalSets = null,Object? completedSets = null,Object? plannedVolume = null,Object? route = null,Object? muscleGroups = null,}) {
  return _then(_TodayWorkout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weeklyWorkoutId: null == weeklyWorkoutId ? _self.weeklyWorkoutId : weeklyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,totalExercises: null == totalExercises ? _self.totalExercises : totalExercises // ignore: cast_nullable_to_non_nullable
as int,completedExercises: null == completedExercises ? _self.completedExercises : completedExercises // ignore: cast_nullable_to_non_nullable
as int,totalSets: null == totalSets ? _self.totalSets : totalSets // ignore: cast_nullable_to_non_nullable
as int,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,plannedVolume: null == plannedVolume ? _self.plannedVolume : plannedVolume // ignore: cast_nullable_to_non_nullable
as double,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,muscleGroups: null == muscleGroups ? _self._muscleGroups : muscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$NutritionToday {

 int get loggedCalories; double get loggedProteinG; double get loggedCarbsG; double get loggedFatG; int? get calorieTarget; double? get proteinTargetG; double? get carbsTargetG; double? get fatTargetG; int? get remainingCalories; double? get remainingProteinG; double? get remainingCarbsG; double? get remainingFatG; List<String> get missingProfileFields;
/// Create a copy of NutritionToday
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionTodayCopyWith<NutritionToday> get copyWith => _$NutritionTodayCopyWithImpl<NutritionToday>(this as NutritionToday, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionToday&&(identical(other.loggedCalories, loggedCalories) || other.loggedCalories == loggedCalories)&&(identical(other.loggedProteinG, loggedProteinG) || other.loggedProteinG == loggedProteinG)&&(identical(other.loggedCarbsG, loggedCarbsG) || other.loggedCarbsG == loggedCarbsG)&&(identical(other.loggedFatG, loggedFatG) || other.loggedFatG == loggedFatG)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinTargetG, proteinTargetG) || other.proteinTargetG == proteinTargetG)&&(identical(other.carbsTargetG, carbsTargetG) || other.carbsTargetG == carbsTargetG)&&(identical(other.fatTargetG, fatTargetG) || other.fatTargetG == fatTargetG)&&(identical(other.remainingCalories, remainingCalories) || other.remainingCalories == remainingCalories)&&(identical(other.remainingProteinG, remainingProteinG) || other.remainingProteinG == remainingProteinG)&&(identical(other.remainingCarbsG, remainingCarbsG) || other.remainingCarbsG == remainingCarbsG)&&(identical(other.remainingFatG, remainingFatG) || other.remainingFatG == remainingFatG)&&const DeepCollectionEquality().equals(other.missingProfileFields, missingProfileFields));
}


@override
int get hashCode => Object.hash(runtimeType,loggedCalories,loggedProteinG,loggedCarbsG,loggedFatG,calorieTarget,proteinTargetG,carbsTargetG,fatTargetG,remainingCalories,remainingProteinG,remainingCarbsG,remainingFatG,const DeepCollectionEquality().hash(missingProfileFields));

@override
String toString() {
  return 'NutritionToday(loggedCalories: $loggedCalories, loggedProteinG: $loggedProteinG, loggedCarbsG: $loggedCarbsG, loggedFatG: $loggedFatG, calorieTarget: $calorieTarget, proteinTargetG: $proteinTargetG, carbsTargetG: $carbsTargetG, fatTargetG: $fatTargetG, remainingCalories: $remainingCalories, remainingProteinG: $remainingProteinG, remainingCarbsG: $remainingCarbsG, remainingFatG: $remainingFatG, missingProfileFields: $missingProfileFields)';
}


}

/// @nodoc
abstract mixin class $NutritionTodayCopyWith<$Res>  {
  factory $NutritionTodayCopyWith(NutritionToday value, $Res Function(NutritionToday) _then) = _$NutritionTodayCopyWithImpl;
@useResult
$Res call({
 int loggedCalories, double loggedProteinG, double loggedCarbsG, double loggedFatG, int? calorieTarget, double? proteinTargetG, double? carbsTargetG, double? fatTargetG, int? remainingCalories, double? remainingProteinG, double? remainingCarbsG, double? remainingFatG, List<String> missingProfileFields
});




}
/// @nodoc
class _$NutritionTodayCopyWithImpl<$Res>
    implements $NutritionTodayCopyWith<$Res> {
  _$NutritionTodayCopyWithImpl(this._self, this._then);

  final NutritionToday _self;
  final $Res Function(NutritionToday) _then;

/// Create a copy of NutritionToday
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loggedCalories = null,Object? loggedProteinG = null,Object? loggedCarbsG = null,Object? loggedFatG = null,Object? calorieTarget = freezed,Object? proteinTargetG = freezed,Object? carbsTargetG = freezed,Object? fatTargetG = freezed,Object? remainingCalories = freezed,Object? remainingProteinG = freezed,Object? remainingCarbsG = freezed,Object? remainingFatG = freezed,Object? missingProfileFields = null,}) {
  return _then(_self.copyWith(
loggedCalories: null == loggedCalories ? _self.loggedCalories : loggedCalories // ignore: cast_nullable_to_non_nullable
as int,loggedProteinG: null == loggedProteinG ? _self.loggedProteinG : loggedProteinG // ignore: cast_nullable_to_non_nullable
as double,loggedCarbsG: null == loggedCarbsG ? _self.loggedCarbsG : loggedCarbsG // ignore: cast_nullable_to_non_nullable
as double,loggedFatG: null == loggedFatG ? _self.loggedFatG : loggedFatG // ignore: cast_nullable_to_non_nullable
as double,calorieTarget: freezed == calorieTarget ? _self.calorieTarget : calorieTarget // ignore: cast_nullable_to_non_nullable
as int?,proteinTargetG: freezed == proteinTargetG ? _self.proteinTargetG : proteinTargetG // ignore: cast_nullable_to_non_nullable
as double?,carbsTargetG: freezed == carbsTargetG ? _self.carbsTargetG : carbsTargetG // ignore: cast_nullable_to_non_nullable
as double?,fatTargetG: freezed == fatTargetG ? _self.fatTargetG : fatTargetG // ignore: cast_nullable_to_non_nullable
as double?,remainingCalories: freezed == remainingCalories ? _self.remainingCalories : remainingCalories // ignore: cast_nullable_to_non_nullable
as int?,remainingProteinG: freezed == remainingProteinG ? _self.remainingProteinG : remainingProteinG // ignore: cast_nullable_to_non_nullable
as double?,remainingCarbsG: freezed == remainingCarbsG ? _self.remainingCarbsG : remainingCarbsG // ignore: cast_nullable_to_non_nullable
as double?,remainingFatG: freezed == remainingFatG ? _self.remainingFatG : remainingFatG // ignore: cast_nullable_to_non_nullable
as double?,missingProfileFields: null == missingProfileFields ? _self.missingProfileFields : missingProfileFields // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionToday].
extension NutritionTodayPatterns on NutritionToday {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionToday value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionToday() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionToday value)  $default,){
final _that = this;
switch (_that) {
case _NutritionToday():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionToday value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionToday() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int loggedCalories,  double loggedProteinG,  double loggedCarbsG,  double loggedFatG,  int? calorieTarget,  double? proteinTargetG,  double? carbsTargetG,  double? fatTargetG,  int? remainingCalories,  double? remainingProteinG,  double? remainingCarbsG,  double? remainingFatG,  List<String> missingProfileFields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionToday() when $default != null:
return $default(_that.loggedCalories,_that.loggedProteinG,_that.loggedCarbsG,_that.loggedFatG,_that.calorieTarget,_that.proteinTargetG,_that.carbsTargetG,_that.fatTargetG,_that.remainingCalories,_that.remainingProteinG,_that.remainingCarbsG,_that.remainingFatG,_that.missingProfileFields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int loggedCalories,  double loggedProteinG,  double loggedCarbsG,  double loggedFatG,  int? calorieTarget,  double? proteinTargetG,  double? carbsTargetG,  double? fatTargetG,  int? remainingCalories,  double? remainingProteinG,  double? remainingCarbsG,  double? remainingFatG,  List<String> missingProfileFields)  $default,) {final _that = this;
switch (_that) {
case _NutritionToday():
return $default(_that.loggedCalories,_that.loggedProteinG,_that.loggedCarbsG,_that.loggedFatG,_that.calorieTarget,_that.proteinTargetG,_that.carbsTargetG,_that.fatTargetG,_that.remainingCalories,_that.remainingProteinG,_that.remainingCarbsG,_that.remainingFatG,_that.missingProfileFields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int loggedCalories,  double loggedProteinG,  double loggedCarbsG,  double loggedFatG,  int? calorieTarget,  double? proteinTargetG,  double? carbsTargetG,  double? fatTargetG,  int? remainingCalories,  double? remainingProteinG,  double? remainingCarbsG,  double? remainingFatG,  List<String> missingProfileFields)?  $default,) {final _that = this;
switch (_that) {
case _NutritionToday() when $default != null:
return $default(_that.loggedCalories,_that.loggedProteinG,_that.loggedCarbsG,_that.loggedFatG,_that.calorieTarget,_that.proteinTargetG,_that.carbsTargetG,_that.fatTargetG,_that.remainingCalories,_that.remainingProteinG,_that.remainingCarbsG,_that.remainingFatG,_that.missingProfileFields);case _:
  return null;

}
}

}

/// @nodoc


class _NutritionToday implements NutritionToday {
  const _NutritionToday({required this.loggedCalories, required this.loggedProteinG, required this.loggedCarbsG, required this.loggedFatG, this.calorieTarget, this.proteinTargetG, this.carbsTargetG, this.fatTargetG, this.remainingCalories, this.remainingProteinG, this.remainingCarbsG, this.remainingFatG, final  List<String> missingProfileFields = const <String>[]}): _missingProfileFields = missingProfileFields;
  

@override final  int loggedCalories;
@override final  double loggedProteinG;
@override final  double loggedCarbsG;
@override final  double loggedFatG;
@override final  int? calorieTarget;
@override final  double? proteinTargetG;
@override final  double? carbsTargetG;
@override final  double? fatTargetG;
@override final  int? remainingCalories;
@override final  double? remainingProteinG;
@override final  double? remainingCarbsG;
@override final  double? remainingFatG;
 final  List<String> _missingProfileFields;
@override@JsonKey() List<String> get missingProfileFields {
  if (_missingProfileFields is EqualUnmodifiableListView) return _missingProfileFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missingProfileFields);
}


/// Create a copy of NutritionToday
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionTodayCopyWith<_NutritionToday> get copyWith => __$NutritionTodayCopyWithImpl<_NutritionToday>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionToday&&(identical(other.loggedCalories, loggedCalories) || other.loggedCalories == loggedCalories)&&(identical(other.loggedProteinG, loggedProteinG) || other.loggedProteinG == loggedProteinG)&&(identical(other.loggedCarbsG, loggedCarbsG) || other.loggedCarbsG == loggedCarbsG)&&(identical(other.loggedFatG, loggedFatG) || other.loggedFatG == loggedFatG)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinTargetG, proteinTargetG) || other.proteinTargetG == proteinTargetG)&&(identical(other.carbsTargetG, carbsTargetG) || other.carbsTargetG == carbsTargetG)&&(identical(other.fatTargetG, fatTargetG) || other.fatTargetG == fatTargetG)&&(identical(other.remainingCalories, remainingCalories) || other.remainingCalories == remainingCalories)&&(identical(other.remainingProteinG, remainingProteinG) || other.remainingProteinG == remainingProteinG)&&(identical(other.remainingCarbsG, remainingCarbsG) || other.remainingCarbsG == remainingCarbsG)&&(identical(other.remainingFatG, remainingFatG) || other.remainingFatG == remainingFatG)&&const DeepCollectionEquality().equals(other._missingProfileFields, _missingProfileFields));
}


@override
int get hashCode => Object.hash(runtimeType,loggedCalories,loggedProteinG,loggedCarbsG,loggedFatG,calorieTarget,proteinTargetG,carbsTargetG,fatTargetG,remainingCalories,remainingProteinG,remainingCarbsG,remainingFatG,const DeepCollectionEquality().hash(_missingProfileFields));

@override
String toString() {
  return 'NutritionToday(loggedCalories: $loggedCalories, loggedProteinG: $loggedProteinG, loggedCarbsG: $loggedCarbsG, loggedFatG: $loggedFatG, calorieTarget: $calorieTarget, proteinTargetG: $proteinTargetG, carbsTargetG: $carbsTargetG, fatTargetG: $fatTargetG, remainingCalories: $remainingCalories, remainingProteinG: $remainingProteinG, remainingCarbsG: $remainingCarbsG, remainingFatG: $remainingFatG, missingProfileFields: $missingProfileFields)';
}


}

/// @nodoc
abstract mixin class _$NutritionTodayCopyWith<$Res> implements $NutritionTodayCopyWith<$Res> {
  factory _$NutritionTodayCopyWith(_NutritionToday value, $Res Function(_NutritionToday) _then) = __$NutritionTodayCopyWithImpl;
@override @useResult
$Res call({
 int loggedCalories, double loggedProteinG, double loggedCarbsG, double loggedFatG, int? calorieTarget, double? proteinTargetG, double? carbsTargetG, double? fatTargetG, int? remainingCalories, double? remainingProteinG, double? remainingCarbsG, double? remainingFatG, List<String> missingProfileFields
});




}
/// @nodoc
class __$NutritionTodayCopyWithImpl<$Res>
    implements _$NutritionTodayCopyWith<$Res> {
  __$NutritionTodayCopyWithImpl(this._self, this._then);

  final _NutritionToday _self;
  final $Res Function(_NutritionToday) _then;

/// Create a copy of NutritionToday
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loggedCalories = null,Object? loggedProteinG = null,Object? loggedCarbsG = null,Object? loggedFatG = null,Object? calorieTarget = freezed,Object? proteinTargetG = freezed,Object? carbsTargetG = freezed,Object? fatTargetG = freezed,Object? remainingCalories = freezed,Object? remainingProteinG = freezed,Object? remainingCarbsG = freezed,Object? remainingFatG = freezed,Object? missingProfileFields = null,}) {
  return _then(_NutritionToday(
loggedCalories: null == loggedCalories ? _self.loggedCalories : loggedCalories // ignore: cast_nullable_to_non_nullable
as int,loggedProteinG: null == loggedProteinG ? _self.loggedProteinG : loggedProteinG // ignore: cast_nullable_to_non_nullable
as double,loggedCarbsG: null == loggedCarbsG ? _self.loggedCarbsG : loggedCarbsG // ignore: cast_nullable_to_non_nullable
as double,loggedFatG: null == loggedFatG ? _self.loggedFatG : loggedFatG // ignore: cast_nullable_to_non_nullable
as double,calorieTarget: freezed == calorieTarget ? _self.calorieTarget : calorieTarget // ignore: cast_nullable_to_non_nullable
as int?,proteinTargetG: freezed == proteinTargetG ? _self.proteinTargetG : proteinTargetG // ignore: cast_nullable_to_non_nullable
as double?,carbsTargetG: freezed == carbsTargetG ? _self.carbsTargetG : carbsTargetG // ignore: cast_nullable_to_non_nullable
as double?,fatTargetG: freezed == fatTargetG ? _self.fatTargetG : fatTargetG // ignore: cast_nullable_to_non_nullable
as double?,remainingCalories: freezed == remainingCalories ? _self.remainingCalories : remainingCalories // ignore: cast_nullable_to_non_nullable
as int?,remainingProteinG: freezed == remainingProteinG ? _self.remainingProteinG : remainingProteinG // ignore: cast_nullable_to_non_nullable
as double?,remainingCarbsG: freezed == remainingCarbsG ? _self.remainingCarbsG : remainingCarbsG // ignore: cast_nullable_to_non_nullable
as double?,remainingFatG: freezed == remainingFatG ? _self.remainingFatG : remainingFatG // ignore: cast_nullable_to_non_nullable
as double?,missingProfileFields: null == missingProfileFields ? _self._missingProfileFields : missingProfileFields // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$NextAction {

 String get type; String get label; String get description; String get route; int get priority;
/// Create a copy of NextAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextActionCopyWith<NextAction> get copyWith => _$NextActionCopyWithImpl<NextAction>(this as NextAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextAction&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.route, route) || other.route == route)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,type,label,description,route,priority);

@override
String toString() {
  return 'NextAction(type: $type, label: $label, description: $description, route: $route, priority: $priority)';
}


}

/// @nodoc
abstract mixin class $NextActionCopyWith<$Res>  {
  factory $NextActionCopyWith(NextAction value, $Res Function(NextAction) _then) = _$NextActionCopyWithImpl;
@useResult
$Res call({
 String type, String label, String description, String route, int priority
});




}
/// @nodoc
class _$NextActionCopyWithImpl<$Res>
    implements $NextActionCopyWith<$Res> {
  _$NextActionCopyWithImpl(this._self, this._then);

  final NextAction _self;
  final $Res Function(NextAction) _then;

/// Create a copy of NextAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? label = null,Object? description = null,Object? route = null,Object? priority = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NextAction].
extension NextActionPatterns on NextAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextAction value)  $default,){
final _that = this;
switch (_that) {
case _NextAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextAction value)?  $default,){
final _that = this;
switch (_that) {
case _NextAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String label,  String description,  String route,  int priority)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NextAction() when $default != null:
return $default(_that.type,_that.label,_that.description,_that.route,_that.priority);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String label,  String description,  String route,  int priority)  $default,) {final _that = this;
switch (_that) {
case _NextAction():
return $default(_that.type,_that.label,_that.description,_that.route,_that.priority);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String label,  String description,  String route,  int priority)?  $default,) {final _that = this;
switch (_that) {
case _NextAction() when $default != null:
return $default(_that.type,_that.label,_that.description,_that.route,_that.priority);case _:
  return null;

}
}

}

/// @nodoc


class _NextAction implements NextAction {
  const _NextAction({required this.type, required this.label, required this.description, required this.route, required this.priority});
  

@override final  String type;
@override final  String label;
@override final  String description;
@override final  String route;
@override final  int priority;

/// Create a copy of NextAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextActionCopyWith<_NextAction> get copyWith => __$NextActionCopyWithImpl<_NextAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextAction&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.route, route) || other.route == route)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,type,label,description,route,priority);

@override
String toString() {
  return 'NextAction(type: $type, label: $label, description: $description, route: $route, priority: $priority)';
}


}

/// @nodoc
abstract mixin class _$NextActionCopyWith<$Res> implements $NextActionCopyWith<$Res> {
  factory _$NextActionCopyWith(_NextAction value, $Res Function(_NextAction) _then) = __$NextActionCopyWithImpl;
@override @useResult
$Res call({
 String type, String label, String description, String route, int priority
});




}
/// @nodoc
class __$NextActionCopyWithImpl<$Res>
    implements _$NextActionCopyWith<$Res> {
  __$NextActionCopyWithImpl(this._self, this._then);

  final _NextAction _self;
  final $Res Function(_NextAction) _then;

/// Create a copy of NextAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? label = null,Object? description = null,Object? route = null,Object? priority = null,}) {
  return _then(_NextAction(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ProInsights {

 bool get isUnlocked; String? get ctaLabel; String? get ctaRoute; List<ProInsightItem> get items;
/// Create a copy of ProInsights
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProInsightsCopyWith<ProInsights> get copyWith => _$ProInsightsCopyWithImpl<ProInsights>(this as ProInsights, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProInsights&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.ctaLabel, ctaLabel) || other.ctaLabel == ctaLabel)&&(identical(other.ctaRoute, ctaRoute) || other.ctaRoute == ctaRoute)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,isUnlocked,ctaLabel,ctaRoute,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ProInsights(isUnlocked: $isUnlocked, ctaLabel: $ctaLabel, ctaRoute: $ctaRoute, items: $items)';
}


}

/// @nodoc
abstract mixin class $ProInsightsCopyWith<$Res>  {
  factory $ProInsightsCopyWith(ProInsights value, $Res Function(ProInsights) _then) = _$ProInsightsCopyWithImpl;
@useResult
$Res call({
 bool isUnlocked, String? ctaLabel, String? ctaRoute, List<ProInsightItem> items
});




}
/// @nodoc
class _$ProInsightsCopyWithImpl<$Res>
    implements $ProInsightsCopyWith<$Res> {
  _$ProInsightsCopyWithImpl(this._self, this._then);

  final ProInsights _self;
  final $Res Function(ProInsights) _then;

/// Create a copy of ProInsights
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isUnlocked = null,Object? ctaLabel = freezed,Object? ctaRoute = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,ctaLabel: freezed == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String?,ctaRoute: freezed == ctaRoute ? _self.ctaRoute : ctaRoute // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProInsightItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProInsights].
extension ProInsightsPatterns on ProInsights {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProInsights value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProInsights() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProInsights value)  $default,){
final _that = this;
switch (_that) {
case _ProInsights():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProInsights value)?  $default,){
final _that = this;
switch (_that) {
case _ProInsights() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isUnlocked,  String? ctaLabel,  String? ctaRoute,  List<ProInsightItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProInsights() when $default != null:
return $default(_that.isUnlocked,_that.ctaLabel,_that.ctaRoute,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isUnlocked,  String? ctaLabel,  String? ctaRoute,  List<ProInsightItem> items)  $default,) {final _that = this;
switch (_that) {
case _ProInsights():
return $default(_that.isUnlocked,_that.ctaLabel,_that.ctaRoute,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isUnlocked,  String? ctaLabel,  String? ctaRoute,  List<ProInsightItem> items)?  $default,) {final _that = this;
switch (_that) {
case _ProInsights() when $default != null:
return $default(_that.isUnlocked,_that.ctaLabel,_that.ctaRoute,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _ProInsights implements ProInsights {
  const _ProInsights({required this.isUnlocked, this.ctaLabel, this.ctaRoute, final  List<ProInsightItem> items = const <ProInsightItem>[]}): _items = items;
  

@override final  bool isUnlocked;
@override final  String? ctaLabel;
@override final  String? ctaRoute;
 final  List<ProInsightItem> _items;
@override@JsonKey() List<ProInsightItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ProInsights
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProInsightsCopyWith<_ProInsights> get copyWith => __$ProInsightsCopyWithImpl<_ProInsights>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProInsights&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.ctaLabel, ctaLabel) || other.ctaLabel == ctaLabel)&&(identical(other.ctaRoute, ctaRoute) || other.ctaRoute == ctaRoute)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,isUnlocked,ctaLabel,ctaRoute,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ProInsights(isUnlocked: $isUnlocked, ctaLabel: $ctaLabel, ctaRoute: $ctaRoute, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ProInsightsCopyWith<$Res> implements $ProInsightsCopyWith<$Res> {
  factory _$ProInsightsCopyWith(_ProInsights value, $Res Function(_ProInsights) _then) = __$ProInsightsCopyWithImpl;
@override @useResult
$Res call({
 bool isUnlocked, String? ctaLabel, String? ctaRoute, List<ProInsightItem> items
});




}
/// @nodoc
class __$ProInsightsCopyWithImpl<$Res>
    implements _$ProInsightsCopyWith<$Res> {
  __$ProInsightsCopyWithImpl(this._self, this._then);

  final _ProInsights _self;
  final $Res Function(_ProInsights) _then;

/// Create a copy of ProInsights
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isUnlocked = null,Object? ctaLabel = freezed,Object? ctaRoute = freezed,Object? items = null,}) {
  return _then(_ProInsights(
isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,ctaLabel: freezed == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String?,ctaRoute: freezed == ctaRoute ? _self.ctaRoute : ctaRoute // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProInsightItem>,
  ));
}


}

/// @nodoc
mixin _$ProInsightItem {

 String get type; String get severity; String get title; String get message;
/// Create a copy of ProInsightItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProInsightItemCopyWith<ProInsightItem> get copyWith => _$ProInsightItemCopyWithImpl<ProInsightItem>(this as ProInsightItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProInsightItem&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message);

@override
String toString() {
  return 'ProInsightItem(type: $type, severity: $severity, title: $title, message: $message)';
}


}

/// @nodoc
abstract mixin class $ProInsightItemCopyWith<$Res>  {
  factory $ProInsightItemCopyWith(ProInsightItem value, $Res Function(ProInsightItem) _then) = _$ProInsightItemCopyWithImpl;
@useResult
$Res call({
 String type, String severity, String title, String message
});




}
/// @nodoc
class _$ProInsightItemCopyWithImpl<$Res>
    implements $ProInsightItemCopyWith<$Res> {
  _$ProInsightItemCopyWithImpl(this._self, this._then);

  final ProInsightItem _self;
  final $Res Function(ProInsightItem) _then;

/// Create a copy of ProInsightItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? severity = null,Object? title = null,Object? message = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProInsightItem].
extension ProInsightItemPatterns on ProInsightItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProInsightItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProInsightItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProInsightItem value)  $default,){
final _that = this;
switch (_that) {
case _ProInsightItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProInsightItem value)?  $default,){
final _that = this;
switch (_that) {
case _ProInsightItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String severity,  String title,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProInsightItem() when $default != null:
return $default(_that.type,_that.severity,_that.title,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String severity,  String title,  String message)  $default,) {final _that = this;
switch (_that) {
case _ProInsightItem():
return $default(_that.type,_that.severity,_that.title,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String severity,  String title,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ProInsightItem() when $default != null:
return $default(_that.type,_that.severity,_that.title,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ProInsightItem implements ProInsightItem {
  const _ProInsightItem({required this.type, required this.severity, required this.title, required this.message});
  

@override final  String type;
@override final  String severity;
@override final  String title;
@override final  String message;

/// Create a copy of ProInsightItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProInsightItemCopyWith<_ProInsightItem> get copyWith => __$ProInsightItemCopyWithImpl<_ProInsightItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProInsightItem&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message);

@override
String toString() {
  return 'ProInsightItem(type: $type, severity: $severity, title: $title, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProInsightItemCopyWith<$Res> implements $ProInsightItemCopyWith<$Res> {
  factory _$ProInsightItemCopyWith(_ProInsightItem value, $Res Function(_ProInsightItem) _then) = __$ProInsightItemCopyWithImpl;
@override @useResult
$Res call({
 String type, String severity, String title, String message
});




}
/// @nodoc
class __$ProInsightItemCopyWithImpl<$Res>
    implements _$ProInsightItemCopyWith<$Res> {
  __$ProInsightItemCopyWithImpl(this._self, this._then);

  final _ProInsightItem _self;
  final $Res Function(_ProInsightItem) _then;

/// Create a copy of ProInsightItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? severity = null,Object? title = null,Object? message = null,}) {
  return _then(_ProInsightItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
