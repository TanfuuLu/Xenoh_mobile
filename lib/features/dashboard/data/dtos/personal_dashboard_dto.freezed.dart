// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_dashboard_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonalDashboardDto {

 DashboardProfileDto get profile; NutritionTodayDto get nutritionToday; ProInsightsDto get proInsights; List<NextActionDto> get nextActions; DashboardPlanDto? get activePlan; TodayWorkoutDto? get todayWorkout;
/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDashboardDtoCopyWith<PersonalDashboardDto> get copyWith => _$PersonalDashboardDtoCopyWithImpl<PersonalDashboardDto>(this as PersonalDashboardDto, _$identity);

  /// Serializes this PersonalDashboardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDashboardDto&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.nutritionToday, nutritionToday) || other.nutritionToday == nutritionToday)&&(identical(other.proInsights, proInsights) || other.proInsights == proInsights)&&const DeepCollectionEquality().equals(other.nextActions, nextActions)&&(identical(other.activePlan, activePlan) || other.activePlan == activePlan)&&(identical(other.todayWorkout, todayWorkout) || other.todayWorkout == todayWorkout));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profile,nutritionToday,proInsights,const DeepCollectionEquality().hash(nextActions),activePlan,todayWorkout);

@override
String toString() {
  return 'PersonalDashboardDto(profile: $profile, nutritionToday: $nutritionToday, proInsights: $proInsights, nextActions: $nextActions, activePlan: $activePlan, todayWorkout: $todayWorkout)';
}


}

/// @nodoc
abstract mixin class $PersonalDashboardDtoCopyWith<$Res>  {
  factory $PersonalDashboardDtoCopyWith(PersonalDashboardDto value, $Res Function(PersonalDashboardDto) _then) = _$PersonalDashboardDtoCopyWithImpl;
@useResult
$Res call({
 DashboardProfileDto profile, NutritionTodayDto nutritionToday, ProInsightsDto proInsights, List<NextActionDto> nextActions, DashboardPlanDto? activePlan, TodayWorkoutDto? todayWorkout
});


$DashboardProfileDtoCopyWith<$Res> get profile;$NutritionTodayDtoCopyWith<$Res> get nutritionToday;$ProInsightsDtoCopyWith<$Res> get proInsights;$DashboardPlanDtoCopyWith<$Res>? get activePlan;$TodayWorkoutDtoCopyWith<$Res>? get todayWorkout;

}
/// @nodoc
class _$PersonalDashboardDtoCopyWithImpl<$Res>
    implements $PersonalDashboardDtoCopyWith<$Res> {
  _$PersonalDashboardDtoCopyWithImpl(this._self, this._then);

  final PersonalDashboardDto _self;
  final $Res Function(PersonalDashboardDto) _then;

/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? nutritionToday = null,Object? proInsights = null,Object? nextActions = null,Object? activePlan = freezed,Object? todayWorkout = freezed,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DashboardProfileDto,nutritionToday: null == nutritionToday ? _self.nutritionToday : nutritionToday // ignore: cast_nullable_to_non_nullable
as NutritionTodayDto,proInsights: null == proInsights ? _self.proInsights : proInsights // ignore: cast_nullable_to_non_nullable
as ProInsightsDto,nextActions: null == nextActions ? _self.nextActions : nextActions // ignore: cast_nullable_to_non_nullable
as List<NextActionDto>,activePlan: freezed == activePlan ? _self.activePlan : activePlan // ignore: cast_nullable_to_non_nullable
as DashboardPlanDto?,todayWorkout: freezed == todayWorkout ? _self.todayWorkout : todayWorkout // ignore: cast_nullable_to_non_nullable
as TodayWorkoutDto?,
  ));
}
/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardProfileDtoCopyWith<$Res> get profile {
  
  return $DashboardProfileDtoCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionTodayDtoCopyWith<$Res> get nutritionToday {
  
  return $NutritionTodayDtoCopyWith<$Res>(_self.nutritionToday, (value) {
    return _then(_self.copyWith(nutritionToday: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProInsightsDtoCopyWith<$Res> get proInsights {
  
  return $ProInsightsDtoCopyWith<$Res>(_self.proInsights, (value) {
    return _then(_self.copyWith(proInsights: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardPlanDtoCopyWith<$Res>? get activePlan {
    if (_self.activePlan == null) {
    return null;
  }

  return $DashboardPlanDtoCopyWith<$Res>(_self.activePlan!, (value) {
    return _then(_self.copyWith(activePlan: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayWorkoutDtoCopyWith<$Res>? get todayWorkout {
    if (_self.todayWorkout == null) {
    return null;
  }

  return $TodayWorkoutDtoCopyWith<$Res>(_self.todayWorkout!, (value) {
    return _then(_self.copyWith(todayWorkout: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonalDashboardDto].
extension PersonalDashboardDtoPatterns on PersonalDashboardDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalDashboardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalDashboardDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalDashboardDto value)  $default,){
final _that = this;
switch (_that) {
case _PersonalDashboardDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalDashboardDto value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalDashboardDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DashboardProfileDto profile,  NutritionTodayDto nutritionToday,  ProInsightsDto proInsights,  List<NextActionDto> nextActions,  DashboardPlanDto? activePlan,  TodayWorkoutDto? todayWorkout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDashboardDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DashboardProfileDto profile,  NutritionTodayDto nutritionToday,  ProInsightsDto proInsights,  List<NextActionDto> nextActions,  DashboardPlanDto? activePlan,  TodayWorkoutDto? todayWorkout)  $default,) {final _that = this;
switch (_that) {
case _PersonalDashboardDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DashboardProfileDto profile,  NutritionTodayDto nutritionToday,  ProInsightsDto proInsights,  List<NextActionDto> nextActions,  DashboardPlanDto? activePlan,  TodayWorkoutDto? todayWorkout)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDashboardDto() when $default != null:
return $default(_that.profile,_that.nutritionToday,_that.proInsights,_that.nextActions,_that.activePlan,_that.todayWorkout);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalDashboardDto extends PersonalDashboardDto {
  const _PersonalDashboardDto({required this.profile, required this.nutritionToday, required this.proInsights, final  List<NextActionDto> nextActions = const <NextActionDto>[], this.activePlan, this.todayWorkout}): _nextActions = nextActions,super._();
  factory _PersonalDashboardDto.fromJson(Map<String, dynamic> json) => _$PersonalDashboardDtoFromJson(json);

@override final  DashboardProfileDto profile;
@override final  NutritionTodayDto nutritionToday;
@override final  ProInsightsDto proInsights;
 final  List<NextActionDto> _nextActions;
@override@JsonKey() List<NextActionDto> get nextActions {
  if (_nextActions is EqualUnmodifiableListView) return _nextActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nextActions);
}

@override final  DashboardPlanDto? activePlan;
@override final  TodayWorkoutDto? todayWorkout;

/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalDashboardDtoCopyWith<_PersonalDashboardDto> get copyWith => __$PersonalDashboardDtoCopyWithImpl<_PersonalDashboardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalDashboardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDashboardDto&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.nutritionToday, nutritionToday) || other.nutritionToday == nutritionToday)&&(identical(other.proInsights, proInsights) || other.proInsights == proInsights)&&const DeepCollectionEquality().equals(other._nextActions, _nextActions)&&(identical(other.activePlan, activePlan) || other.activePlan == activePlan)&&(identical(other.todayWorkout, todayWorkout) || other.todayWorkout == todayWorkout));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profile,nutritionToday,proInsights,const DeepCollectionEquality().hash(_nextActions),activePlan,todayWorkout);

@override
String toString() {
  return 'PersonalDashboardDto(profile: $profile, nutritionToday: $nutritionToday, proInsights: $proInsights, nextActions: $nextActions, activePlan: $activePlan, todayWorkout: $todayWorkout)';
}


}

/// @nodoc
abstract mixin class _$PersonalDashboardDtoCopyWith<$Res> implements $PersonalDashboardDtoCopyWith<$Res> {
  factory _$PersonalDashboardDtoCopyWith(_PersonalDashboardDto value, $Res Function(_PersonalDashboardDto) _then) = __$PersonalDashboardDtoCopyWithImpl;
@override @useResult
$Res call({
 DashboardProfileDto profile, NutritionTodayDto nutritionToday, ProInsightsDto proInsights, List<NextActionDto> nextActions, DashboardPlanDto? activePlan, TodayWorkoutDto? todayWorkout
});


@override $DashboardProfileDtoCopyWith<$Res> get profile;@override $NutritionTodayDtoCopyWith<$Res> get nutritionToday;@override $ProInsightsDtoCopyWith<$Res> get proInsights;@override $DashboardPlanDtoCopyWith<$Res>? get activePlan;@override $TodayWorkoutDtoCopyWith<$Res>? get todayWorkout;

}
/// @nodoc
class __$PersonalDashboardDtoCopyWithImpl<$Res>
    implements _$PersonalDashboardDtoCopyWith<$Res> {
  __$PersonalDashboardDtoCopyWithImpl(this._self, this._then);

  final _PersonalDashboardDto _self;
  final $Res Function(_PersonalDashboardDto) _then;

/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? nutritionToday = null,Object? proInsights = null,Object? nextActions = null,Object? activePlan = freezed,Object? todayWorkout = freezed,}) {
  return _then(_PersonalDashboardDto(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DashboardProfileDto,nutritionToday: null == nutritionToday ? _self.nutritionToday : nutritionToday // ignore: cast_nullable_to_non_nullable
as NutritionTodayDto,proInsights: null == proInsights ? _self.proInsights : proInsights // ignore: cast_nullable_to_non_nullable
as ProInsightsDto,nextActions: null == nextActions ? _self._nextActions : nextActions // ignore: cast_nullable_to_non_nullable
as List<NextActionDto>,activePlan: freezed == activePlan ? _self.activePlan : activePlan // ignore: cast_nullable_to_non_nullable
as DashboardPlanDto?,todayWorkout: freezed == todayWorkout ? _self.todayWorkout : todayWorkout // ignore: cast_nullable_to_non_nullable
as TodayWorkoutDto?,
  ));
}

/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardProfileDtoCopyWith<$Res> get profile {
  
  return $DashboardProfileDtoCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionTodayDtoCopyWith<$Res> get nutritionToday {
  
  return $NutritionTodayDtoCopyWith<$Res>(_self.nutritionToday, (value) {
    return _then(_self.copyWith(nutritionToday: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProInsightsDtoCopyWith<$Res> get proInsights {
  
  return $ProInsightsDtoCopyWith<$Res>(_self.proInsights, (value) {
    return _then(_self.copyWith(proInsights: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardPlanDtoCopyWith<$Res>? get activePlan {
    if (_self.activePlan == null) {
    return null;
  }

  return $DashboardPlanDtoCopyWith<$Res>(_self.activePlan!, (value) {
    return _then(_self.copyWith(activePlan: value));
  });
}/// Create a copy of PersonalDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayWorkoutDtoCopyWith<$Res>? get todayWorkout {
    if (_self.todayWorkout == null) {
    return null;
  }

  return $TodayWorkoutDtoCopyWith<$Res>(_self.todayWorkout!, (value) {
    return _then(_self.copyWith(todayWorkout: value));
  });
}
}


/// @nodoc
mixin _$DashboardProfileDto {

 String get firstName; int get currentStreak; int get level; int get totalXp; int get xpToNextLevel; String get title; String? get avatarUrl; double? get latestBodyweight; double? get bmi; String? get bmiCategory; double? get dotsScore;
/// Create a copy of DashboardProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardProfileDtoCopyWith<DashboardProfileDto> get copyWith => _$DashboardProfileDtoCopyWithImpl<DashboardProfileDto>(this as DashboardProfileDto, _$identity);

  /// Serializes this DashboardProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardProfileDto&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,currentStreak,level,totalXp,xpToNextLevel,title,avatarUrl,latestBodyweight,bmi,bmiCategory,dotsScore);

@override
String toString() {
  return 'DashboardProfileDto(firstName: $firstName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, avatarUrl: $avatarUrl, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore)';
}


}

/// @nodoc
abstract mixin class $DashboardProfileDtoCopyWith<$Res>  {
  factory $DashboardProfileDtoCopyWith(DashboardProfileDto value, $Res Function(DashboardProfileDto) _then) = _$DashboardProfileDtoCopyWithImpl;
@useResult
$Res call({
 String firstName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, String? avatarUrl, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore
});




}
/// @nodoc
class _$DashboardProfileDtoCopyWithImpl<$Res>
    implements $DashboardProfileDtoCopyWith<$Res> {
  _$DashboardProfileDtoCopyWithImpl(this._self, this._then);

  final DashboardProfileDto _self;
  final $Res Function(DashboardProfileDto) _then;

/// Create a copy of DashboardProfileDto
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


/// Adds pattern-matching-related methods to [DashboardProfileDto].
extension DashboardProfileDtoPatterns on DashboardProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _DashboardProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardProfileDto() when $default != null:
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
case _DashboardProfileDto() when $default != null:
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
case _DashboardProfileDto():
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
case _DashboardProfileDto() when $default != null:
return $default(_that.firstName,_that.currentStreak,_that.level,_that.totalXp,_that.xpToNextLevel,_that.title,_that.avatarUrl,_that.latestBodyweight,_that.bmi,_that.bmiCategory,_that.dotsScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardProfileDto extends DashboardProfileDto {
  const _DashboardProfileDto({required this.firstName, required this.currentStreak, required this.level, required this.totalXp, required this.xpToNextLevel, required this.title, this.avatarUrl, this.latestBodyweight, this.bmi, this.bmiCategory, this.dotsScore}): super._();
  factory _DashboardProfileDto.fromJson(Map<String, dynamic> json) => _$DashboardProfileDtoFromJson(json);

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

/// Create a copy of DashboardProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardProfileDtoCopyWith<_DashboardProfileDto> get copyWith => __$DashboardProfileDtoCopyWithImpl<_DashboardProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardProfileDto&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.level, level) || other.level == level)&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.xpToNextLevel, xpToNextLevel) || other.xpToNextLevel == xpToNextLevel)&&(identical(other.title, title) || other.title == title)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.latestBodyweight, latestBodyweight) || other.latestBodyweight == latestBodyweight)&&(identical(other.bmi, bmi) || other.bmi == bmi)&&(identical(other.bmiCategory, bmiCategory) || other.bmiCategory == bmiCategory)&&(identical(other.dotsScore, dotsScore) || other.dotsScore == dotsScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,currentStreak,level,totalXp,xpToNextLevel,title,avatarUrl,latestBodyweight,bmi,bmiCategory,dotsScore);

@override
String toString() {
  return 'DashboardProfileDto(firstName: $firstName, currentStreak: $currentStreak, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, title: $title, avatarUrl: $avatarUrl, latestBodyweight: $latestBodyweight, bmi: $bmi, bmiCategory: $bmiCategory, dotsScore: $dotsScore)';
}


}

/// @nodoc
abstract mixin class _$DashboardProfileDtoCopyWith<$Res> implements $DashboardProfileDtoCopyWith<$Res> {
  factory _$DashboardProfileDtoCopyWith(_DashboardProfileDto value, $Res Function(_DashboardProfileDto) _then) = __$DashboardProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String firstName, int currentStreak, int level, int totalXp, int xpToNextLevel, String title, String? avatarUrl, double? latestBodyweight, double? bmi, String? bmiCategory, double? dotsScore
});




}
/// @nodoc
class __$DashboardProfileDtoCopyWithImpl<$Res>
    implements _$DashboardProfileDtoCopyWith<$Res> {
  __$DashboardProfileDtoCopyWithImpl(this._self, this._then);

  final _DashboardProfileDto _self;
  final $Res Function(_DashboardProfileDto) _then;

/// Create a copy of DashboardProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? currentStreak = null,Object? level = null,Object? totalXp = null,Object? xpToNextLevel = null,Object? title = null,Object? avatarUrl = freezed,Object? latestBodyweight = freezed,Object? bmi = freezed,Object? bmiCategory = freezed,Object? dotsScore = freezed,}) {
  return _then(_DashboardProfileDto(
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
mixin _$DashboardPlanDto {

 String get id; String get name; String get startDate; String get endDate; int get totalDays; int get completedDays; int get progressPercent; DashboardWeekDto? get currentWeek;
/// Create a copy of DashboardPlanDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardPlanDtoCopyWith<DashboardPlanDto> get copyWith => _$DashboardPlanDtoCopyWithImpl<DashboardPlanDto>(this as DashboardPlanDto, _$identity);

  /// Serializes this DashboardPlanDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardPlanDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.currentWeek, currentWeek) || other.currentWeek == currentWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,totalDays,completedDays,progressPercent,currentWeek);

@override
String toString() {
  return 'DashboardPlanDto(id: $id, name: $name, startDate: $startDate, endDate: $endDate, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent, currentWeek: $currentWeek)';
}


}

/// @nodoc
abstract mixin class $DashboardPlanDtoCopyWith<$Res>  {
  factory $DashboardPlanDtoCopyWith(DashboardPlanDto value, $Res Function(DashboardPlanDto) _then) = _$DashboardPlanDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String startDate, String endDate, int totalDays, int completedDays, int progressPercent, DashboardWeekDto? currentWeek
});


$DashboardWeekDtoCopyWith<$Res>? get currentWeek;

}
/// @nodoc
class _$DashboardPlanDtoCopyWithImpl<$Res>
    implements $DashboardPlanDtoCopyWith<$Res> {
  _$DashboardPlanDtoCopyWithImpl(this._self, this._then);

  final DashboardPlanDto _self;
  final $Res Function(DashboardPlanDto) _then;

/// Create a copy of DashboardPlanDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? totalDays = null,Object? completedDays = null,Object? progressPercent = null,Object? currentWeek = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,currentWeek: freezed == currentWeek ? _self.currentWeek : currentWeek // ignore: cast_nullable_to_non_nullable
as DashboardWeekDto?,
  ));
}
/// Create a copy of DashboardPlanDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardWeekDtoCopyWith<$Res>? get currentWeek {
    if (_self.currentWeek == null) {
    return null;
  }

  return $DashboardWeekDtoCopyWith<$Res>(_self.currentWeek!, (value) {
    return _then(_self.copyWith(currentWeek: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardPlanDto].
extension DashboardPlanDtoPatterns on DashboardPlanDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardPlanDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardPlanDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardPlanDto value)  $default,){
final _that = this;
switch (_that) {
case _DashboardPlanDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardPlanDto value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardPlanDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String startDate,  String endDate,  int totalDays,  int completedDays,  int progressPercent,  DashboardWeekDto? currentWeek)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardPlanDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String startDate,  String endDate,  int totalDays,  int completedDays,  int progressPercent,  DashboardWeekDto? currentWeek)  $default,) {final _that = this;
switch (_that) {
case _DashboardPlanDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String startDate,  String endDate,  int totalDays,  int completedDays,  int progressPercent,  DashboardWeekDto? currentWeek)?  $default,) {final _that = this;
switch (_that) {
case _DashboardPlanDto() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.totalDays,_that.completedDays,_that.progressPercent,_that.currentWeek);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardPlanDto extends DashboardPlanDto {
  const _DashboardPlanDto({required this.id, required this.name, required this.startDate, required this.endDate, required this.totalDays, required this.completedDays, required this.progressPercent, this.currentWeek}): super._();
  factory _DashboardPlanDto.fromJson(Map<String, dynamic> json) => _$DashboardPlanDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String startDate;
@override final  String endDate;
@override final  int totalDays;
@override final  int completedDays;
@override final  int progressPercent;
@override final  DashboardWeekDto? currentWeek;

/// Create a copy of DashboardPlanDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardPlanDtoCopyWith<_DashboardPlanDto> get copyWith => __$DashboardPlanDtoCopyWithImpl<_DashboardPlanDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardPlanDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardPlanDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.currentWeek, currentWeek) || other.currentWeek == currentWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,totalDays,completedDays,progressPercent,currentWeek);

@override
String toString() {
  return 'DashboardPlanDto(id: $id, name: $name, startDate: $startDate, endDate: $endDate, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent, currentWeek: $currentWeek)';
}


}

/// @nodoc
abstract mixin class _$DashboardPlanDtoCopyWith<$Res> implements $DashboardPlanDtoCopyWith<$Res> {
  factory _$DashboardPlanDtoCopyWith(_DashboardPlanDto value, $Res Function(_DashboardPlanDto) _then) = __$DashboardPlanDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String startDate, String endDate, int totalDays, int completedDays, int progressPercent, DashboardWeekDto? currentWeek
});


@override $DashboardWeekDtoCopyWith<$Res>? get currentWeek;

}
/// @nodoc
class __$DashboardPlanDtoCopyWithImpl<$Res>
    implements _$DashboardPlanDtoCopyWith<$Res> {
  __$DashboardPlanDtoCopyWithImpl(this._self, this._then);

  final _DashboardPlanDto _self;
  final $Res Function(_DashboardPlanDto) _then;

/// Create a copy of DashboardPlanDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? totalDays = null,Object? completedDays = null,Object? progressPercent = null,Object? currentWeek = freezed,}) {
  return _then(_DashboardPlanDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,currentWeek: freezed == currentWeek ? _self.currentWeek : currentWeek // ignore: cast_nullable_to_non_nullable
as DashboardWeekDto?,
  ));
}

/// Create a copy of DashboardPlanDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardWeekDtoCopyWith<$Res>? get currentWeek {
    if (_self.currentWeek == null) {
    return null;
  }

  return $DashboardWeekDtoCopyWith<$Res>(_self.currentWeek!, (value) {
    return _then(_self.copyWith(currentWeek: value));
  });
}
}


/// @nodoc
mixin _$DashboardWeekDto {

 String get id; String get name; int get totalDays; int get completedDays; int get progressPercent;
/// Create a copy of DashboardWeekDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardWeekDtoCopyWith<DashboardWeekDto> get copyWith => _$DashboardWeekDtoCopyWithImpl<DashboardWeekDto>(this as DashboardWeekDto, _$identity);

  /// Serializes this DashboardWeekDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardWeekDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,totalDays,completedDays,progressPercent);

@override
String toString() {
  return 'DashboardWeekDto(id: $id, name: $name, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent)';
}


}

/// @nodoc
abstract mixin class $DashboardWeekDtoCopyWith<$Res>  {
  factory $DashboardWeekDtoCopyWith(DashboardWeekDto value, $Res Function(DashboardWeekDto) _then) = _$DashboardWeekDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, int totalDays, int completedDays, int progressPercent
});




}
/// @nodoc
class _$DashboardWeekDtoCopyWithImpl<$Res>
    implements $DashboardWeekDtoCopyWith<$Res> {
  _$DashboardWeekDtoCopyWithImpl(this._self, this._then);

  final DashboardWeekDto _self;
  final $Res Function(DashboardWeekDto) _then;

/// Create a copy of DashboardWeekDto
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


/// Adds pattern-matching-related methods to [DashboardWeekDto].
extension DashboardWeekDtoPatterns on DashboardWeekDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardWeekDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardWeekDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardWeekDto value)  $default,){
final _that = this;
switch (_that) {
case _DashboardWeekDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardWeekDto value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardWeekDto() when $default != null:
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
case _DashboardWeekDto() when $default != null:
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
case _DashboardWeekDto():
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
case _DashboardWeekDto() when $default != null:
return $default(_that.id,_that.name,_that.totalDays,_that.completedDays,_that.progressPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardWeekDto extends DashboardWeekDto {
  const _DashboardWeekDto({required this.id, required this.name, required this.totalDays, required this.completedDays, required this.progressPercent}): super._();
  factory _DashboardWeekDto.fromJson(Map<String, dynamic> json) => _$DashboardWeekDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  int totalDays;
@override final  int completedDays;
@override final  int progressPercent;

/// Create a copy of DashboardWeekDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardWeekDtoCopyWith<_DashboardWeekDto> get copyWith => __$DashboardWeekDtoCopyWithImpl<_DashboardWeekDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardWeekDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardWeekDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,totalDays,completedDays,progressPercent);

@override
String toString() {
  return 'DashboardWeekDto(id: $id, name: $name, totalDays: $totalDays, completedDays: $completedDays, progressPercent: $progressPercent)';
}


}

/// @nodoc
abstract mixin class _$DashboardWeekDtoCopyWith<$Res> implements $DashboardWeekDtoCopyWith<$Res> {
  factory _$DashboardWeekDtoCopyWith(_DashboardWeekDto value, $Res Function(_DashboardWeekDto) _then) = __$DashboardWeekDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int totalDays, int completedDays, int progressPercent
});




}
/// @nodoc
class __$DashboardWeekDtoCopyWithImpl<$Res>
    implements _$DashboardWeekDtoCopyWith<$Res> {
  __$DashboardWeekDtoCopyWithImpl(this._self, this._then);

  final _DashboardWeekDto _self;
  final $Res Function(_DashboardWeekDto) _then;

/// Create a copy of DashboardWeekDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? totalDays = null,Object? completedDays = null,Object? progressPercent = null,}) {
  return _then(_DashboardWeekDto(
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
mixin _$TodayWorkoutDto {

 String get id; String get weeklyWorkoutId; String get dayOfWeek; String get date; String get status; bool get isCompleted; int get totalExercises; int get completedExercises; int get totalSets; int get completedSets; double get plannedVolume; String get route; List<String> get muscleGroups;
/// Create a copy of TodayWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayWorkoutDtoCopyWith<TodayWorkoutDto> get copyWith => _$TodayWorkoutDtoCopyWithImpl<TodayWorkoutDto>(this as TodayWorkoutDto, _$identity);

  /// Serializes this TodayWorkoutDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayWorkoutDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.plannedVolume, plannedVolume) || other.plannedVolume == plannedVolume)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other.muscleGroups, muscleGroups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weeklyWorkoutId,dayOfWeek,date,status,isCompleted,totalExercises,completedExercises,totalSets,completedSets,plannedVolume,route,const DeepCollectionEquality().hash(muscleGroups));

@override
String toString() {
  return 'TodayWorkoutDto(id: $id, weeklyWorkoutId: $weeklyWorkoutId, dayOfWeek: $dayOfWeek, date: $date, status: $status, isCompleted: $isCompleted, totalExercises: $totalExercises, completedExercises: $completedExercises, totalSets: $totalSets, completedSets: $completedSets, plannedVolume: $plannedVolume, route: $route, muscleGroups: $muscleGroups)';
}


}

/// @nodoc
abstract mixin class $TodayWorkoutDtoCopyWith<$Res>  {
  factory $TodayWorkoutDtoCopyWith(TodayWorkoutDto value, $Res Function(TodayWorkoutDto) _then) = _$TodayWorkoutDtoCopyWithImpl;
@useResult
$Res call({
 String id, String weeklyWorkoutId, String dayOfWeek, String date, String status, bool isCompleted, int totalExercises, int completedExercises, int totalSets, int completedSets, double plannedVolume, String route, List<String> muscleGroups
});




}
/// @nodoc
class _$TodayWorkoutDtoCopyWithImpl<$Res>
    implements $TodayWorkoutDtoCopyWith<$Res> {
  _$TodayWorkoutDtoCopyWithImpl(this._self, this._then);

  final TodayWorkoutDto _self;
  final $Res Function(TodayWorkoutDto) _then;

/// Create a copy of TodayWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weeklyWorkoutId = null,Object? dayOfWeek = null,Object? date = null,Object? status = null,Object? isCompleted = null,Object? totalExercises = null,Object? completedExercises = null,Object? totalSets = null,Object? completedSets = null,Object? plannedVolume = null,Object? route = null,Object? muscleGroups = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weeklyWorkoutId: null == weeklyWorkoutId ? _self.weeklyWorkoutId : weeklyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [TodayWorkoutDto].
extension TodayWorkoutDtoPatterns on TodayWorkoutDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayWorkoutDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayWorkoutDto value)  $default,){
final _that = this;
switch (_that) {
case _TodayWorkoutDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayWorkoutDto value)?  $default,){
final _that = this;
switch (_that) {
case _TodayWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String weeklyWorkoutId,  String dayOfWeek,  String date,  String status,  bool isCompleted,  int totalExercises,  int completedExercises,  int totalSets,  int completedSets,  double plannedVolume,  String route,  List<String> muscleGroups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String weeklyWorkoutId,  String dayOfWeek,  String date,  String status,  bool isCompleted,  int totalExercises,  int completedExercises,  int totalSets,  int completedSets,  double plannedVolume,  String route,  List<String> muscleGroups)  $default,) {final _that = this;
switch (_that) {
case _TodayWorkoutDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String weeklyWorkoutId,  String dayOfWeek,  String date,  String status,  bool isCompleted,  int totalExercises,  int completedExercises,  int totalSets,  int completedSets,  double plannedVolume,  String route,  List<String> muscleGroups)?  $default,) {final _that = this;
switch (_that) {
case _TodayWorkoutDto() when $default != null:
return $default(_that.id,_that.weeklyWorkoutId,_that.dayOfWeek,_that.date,_that.status,_that.isCompleted,_that.totalExercises,_that.completedExercises,_that.totalSets,_that.completedSets,_that.plannedVolume,_that.route,_that.muscleGroups);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodayWorkoutDto extends TodayWorkoutDto {
  const _TodayWorkoutDto({required this.id, required this.weeklyWorkoutId, required this.dayOfWeek, required this.date, required this.status, required this.isCompleted, required this.totalExercises, required this.completedExercises, required this.totalSets, required this.completedSets, required this.plannedVolume, required this.route, final  List<String> muscleGroups = const <String>[]}): _muscleGroups = muscleGroups,super._();
  factory _TodayWorkoutDto.fromJson(Map<String, dynamic> json) => _$TodayWorkoutDtoFromJson(json);

@override final  String id;
@override final  String weeklyWorkoutId;
@override final  String dayOfWeek;
@override final  String date;
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


/// Create a copy of TodayWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayWorkoutDtoCopyWith<_TodayWorkoutDto> get copyWith => __$TodayWorkoutDtoCopyWithImpl<_TodayWorkoutDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodayWorkoutDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayWorkoutDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.plannedVolume, plannedVolume) || other.plannedVolume == plannedVolume)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other._muscleGroups, _muscleGroups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weeklyWorkoutId,dayOfWeek,date,status,isCompleted,totalExercises,completedExercises,totalSets,completedSets,plannedVolume,route,const DeepCollectionEquality().hash(_muscleGroups));

@override
String toString() {
  return 'TodayWorkoutDto(id: $id, weeklyWorkoutId: $weeklyWorkoutId, dayOfWeek: $dayOfWeek, date: $date, status: $status, isCompleted: $isCompleted, totalExercises: $totalExercises, completedExercises: $completedExercises, totalSets: $totalSets, completedSets: $completedSets, plannedVolume: $plannedVolume, route: $route, muscleGroups: $muscleGroups)';
}


}

/// @nodoc
abstract mixin class _$TodayWorkoutDtoCopyWith<$Res> implements $TodayWorkoutDtoCopyWith<$Res> {
  factory _$TodayWorkoutDtoCopyWith(_TodayWorkoutDto value, $Res Function(_TodayWorkoutDto) _then) = __$TodayWorkoutDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String weeklyWorkoutId, String dayOfWeek, String date, String status, bool isCompleted, int totalExercises, int completedExercises, int totalSets, int completedSets, double plannedVolume, String route, List<String> muscleGroups
});




}
/// @nodoc
class __$TodayWorkoutDtoCopyWithImpl<$Res>
    implements _$TodayWorkoutDtoCopyWith<$Res> {
  __$TodayWorkoutDtoCopyWithImpl(this._self, this._then);

  final _TodayWorkoutDto _self;
  final $Res Function(_TodayWorkoutDto) _then;

/// Create a copy of TodayWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weeklyWorkoutId = null,Object? dayOfWeek = null,Object? date = null,Object? status = null,Object? isCompleted = null,Object? totalExercises = null,Object? completedExercises = null,Object? totalSets = null,Object? completedSets = null,Object? plannedVolume = null,Object? route = null,Object? muscleGroups = null,}) {
  return _then(_TodayWorkoutDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weeklyWorkoutId: null == weeklyWorkoutId ? _self.weeklyWorkoutId : weeklyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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
mixin _$NutritionTodayDto {

 int get loggedCalories; double get loggedProteinG; double get loggedCarbsG; double get loggedFatG; int? get calorieTarget; double? get proteinTargetG; double? get carbsTargetG; double? get fatTargetG; int? get remainingCalories; double? get remainingProteinG; double? get remainingCarbsG; double? get remainingFatG; List<String> get missingProfileFields;
/// Create a copy of NutritionTodayDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionTodayDtoCopyWith<NutritionTodayDto> get copyWith => _$NutritionTodayDtoCopyWithImpl<NutritionTodayDto>(this as NutritionTodayDto, _$identity);

  /// Serializes this NutritionTodayDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionTodayDto&&(identical(other.loggedCalories, loggedCalories) || other.loggedCalories == loggedCalories)&&(identical(other.loggedProteinG, loggedProteinG) || other.loggedProteinG == loggedProteinG)&&(identical(other.loggedCarbsG, loggedCarbsG) || other.loggedCarbsG == loggedCarbsG)&&(identical(other.loggedFatG, loggedFatG) || other.loggedFatG == loggedFatG)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinTargetG, proteinTargetG) || other.proteinTargetG == proteinTargetG)&&(identical(other.carbsTargetG, carbsTargetG) || other.carbsTargetG == carbsTargetG)&&(identical(other.fatTargetG, fatTargetG) || other.fatTargetG == fatTargetG)&&(identical(other.remainingCalories, remainingCalories) || other.remainingCalories == remainingCalories)&&(identical(other.remainingProteinG, remainingProteinG) || other.remainingProteinG == remainingProteinG)&&(identical(other.remainingCarbsG, remainingCarbsG) || other.remainingCarbsG == remainingCarbsG)&&(identical(other.remainingFatG, remainingFatG) || other.remainingFatG == remainingFatG)&&const DeepCollectionEquality().equals(other.missingProfileFields, missingProfileFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loggedCalories,loggedProteinG,loggedCarbsG,loggedFatG,calorieTarget,proteinTargetG,carbsTargetG,fatTargetG,remainingCalories,remainingProteinG,remainingCarbsG,remainingFatG,const DeepCollectionEquality().hash(missingProfileFields));

@override
String toString() {
  return 'NutritionTodayDto(loggedCalories: $loggedCalories, loggedProteinG: $loggedProteinG, loggedCarbsG: $loggedCarbsG, loggedFatG: $loggedFatG, calorieTarget: $calorieTarget, proteinTargetG: $proteinTargetG, carbsTargetG: $carbsTargetG, fatTargetG: $fatTargetG, remainingCalories: $remainingCalories, remainingProteinG: $remainingProteinG, remainingCarbsG: $remainingCarbsG, remainingFatG: $remainingFatG, missingProfileFields: $missingProfileFields)';
}


}

/// @nodoc
abstract mixin class $NutritionTodayDtoCopyWith<$Res>  {
  factory $NutritionTodayDtoCopyWith(NutritionTodayDto value, $Res Function(NutritionTodayDto) _then) = _$NutritionTodayDtoCopyWithImpl;
@useResult
$Res call({
 int loggedCalories, double loggedProteinG, double loggedCarbsG, double loggedFatG, int? calorieTarget, double? proteinTargetG, double? carbsTargetG, double? fatTargetG, int? remainingCalories, double? remainingProteinG, double? remainingCarbsG, double? remainingFatG, List<String> missingProfileFields
});




}
/// @nodoc
class _$NutritionTodayDtoCopyWithImpl<$Res>
    implements $NutritionTodayDtoCopyWith<$Res> {
  _$NutritionTodayDtoCopyWithImpl(this._self, this._then);

  final NutritionTodayDto _self;
  final $Res Function(NutritionTodayDto) _then;

/// Create a copy of NutritionTodayDto
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


/// Adds pattern-matching-related methods to [NutritionTodayDto].
extension NutritionTodayDtoPatterns on NutritionTodayDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionTodayDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionTodayDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionTodayDto value)  $default,){
final _that = this;
switch (_that) {
case _NutritionTodayDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionTodayDto value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionTodayDto() when $default != null:
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
case _NutritionTodayDto() when $default != null:
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
case _NutritionTodayDto():
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
case _NutritionTodayDto() when $default != null:
return $default(_that.loggedCalories,_that.loggedProteinG,_that.loggedCarbsG,_that.loggedFatG,_that.calorieTarget,_that.proteinTargetG,_that.carbsTargetG,_that.fatTargetG,_that.remainingCalories,_that.remainingProteinG,_that.remainingCarbsG,_that.remainingFatG,_that.missingProfileFields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionTodayDto extends NutritionTodayDto {
  const _NutritionTodayDto({required this.loggedCalories, required this.loggedProteinG, required this.loggedCarbsG, required this.loggedFatG, this.calorieTarget, this.proteinTargetG, this.carbsTargetG, this.fatTargetG, this.remainingCalories, this.remainingProteinG, this.remainingCarbsG, this.remainingFatG, final  List<String> missingProfileFields = const <String>[]}): _missingProfileFields = missingProfileFields,super._();
  factory _NutritionTodayDto.fromJson(Map<String, dynamic> json) => _$NutritionTodayDtoFromJson(json);

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


/// Create a copy of NutritionTodayDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionTodayDtoCopyWith<_NutritionTodayDto> get copyWith => __$NutritionTodayDtoCopyWithImpl<_NutritionTodayDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionTodayDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionTodayDto&&(identical(other.loggedCalories, loggedCalories) || other.loggedCalories == loggedCalories)&&(identical(other.loggedProteinG, loggedProteinG) || other.loggedProteinG == loggedProteinG)&&(identical(other.loggedCarbsG, loggedCarbsG) || other.loggedCarbsG == loggedCarbsG)&&(identical(other.loggedFatG, loggedFatG) || other.loggedFatG == loggedFatG)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinTargetG, proteinTargetG) || other.proteinTargetG == proteinTargetG)&&(identical(other.carbsTargetG, carbsTargetG) || other.carbsTargetG == carbsTargetG)&&(identical(other.fatTargetG, fatTargetG) || other.fatTargetG == fatTargetG)&&(identical(other.remainingCalories, remainingCalories) || other.remainingCalories == remainingCalories)&&(identical(other.remainingProteinG, remainingProteinG) || other.remainingProteinG == remainingProteinG)&&(identical(other.remainingCarbsG, remainingCarbsG) || other.remainingCarbsG == remainingCarbsG)&&(identical(other.remainingFatG, remainingFatG) || other.remainingFatG == remainingFatG)&&const DeepCollectionEquality().equals(other._missingProfileFields, _missingProfileFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,loggedCalories,loggedProteinG,loggedCarbsG,loggedFatG,calorieTarget,proteinTargetG,carbsTargetG,fatTargetG,remainingCalories,remainingProteinG,remainingCarbsG,remainingFatG,const DeepCollectionEquality().hash(_missingProfileFields));

@override
String toString() {
  return 'NutritionTodayDto(loggedCalories: $loggedCalories, loggedProteinG: $loggedProteinG, loggedCarbsG: $loggedCarbsG, loggedFatG: $loggedFatG, calorieTarget: $calorieTarget, proteinTargetG: $proteinTargetG, carbsTargetG: $carbsTargetG, fatTargetG: $fatTargetG, remainingCalories: $remainingCalories, remainingProteinG: $remainingProteinG, remainingCarbsG: $remainingCarbsG, remainingFatG: $remainingFatG, missingProfileFields: $missingProfileFields)';
}


}

/// @nodoc
abstract mixin class _$NutritionTodayDtoCopyWith<$Res> implements $NutritionTodayDtoCopyWith<$Res> {
  factory _$NutritionTodayDtoCopyWith(_NutritionTodayDto value, $Res Function(_NutritionTodayDto) _then) = __$NutritionTodayDtoCopyWithImpl;
@override @useResult
$Res call({
 int loggedCalories, double loggedProteinG, double loggedCarbsG, double loggedFatG, int? calorieTarget, double? proteinTargetG, double? carbsTargetG, double? fatTargetG, int? remainingCalories, double? remainingProteinG, double? remainingCarbsG, double? remainingFatG, List<String> missingProfileFields
});




}
/// @nodoc
class __$NutritionTodayDtoCopyWithImpl<$Res>
    implements _$NutritionTodayDtoCopyWith<$Res> {
  __$NutritionTodayDtoCopyWithImpl(this._self, this._then);

  final _NutritionTodayDto _self;
  final $Res Function(_NutritionTodayDto) _then;

/// Create a copy of NutritionTodayDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loggedCalories = null,Object? loggedProteinG = null,Object? loggedCarbsG = null,Object? loggedFatG = null,Object? calorieTarget = freezed,Object? proteinTargetG = freezed,Object? carbsTargetG = freezed,Object? fatTargetG = freezed,Object? remainingCalories = freezed,Object? remainingProteinG = freezed,Object? remainingCarbsG = freezed,Object? remainingFatG = freezed,Object? missingProfileFields = null,}) {
  return _then(_NutritionTodayDto(
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
mixin _$NextActionDto {

 String get type; String get label; String get description; String get route; int get priority;
/// Create a copy of NextActionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextActionDtoCopyWith<NextActionDto> get copyWith => _$NextActionDtoCopyWithImpl<NextActionDto>(this as NextActionDto, _$identity);

  /// Serializes this NextActionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextActionDto&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.route, route) || other.route == route)&&(identical(other.priority, priority) || other.priority == priority));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,description,route,priority);

@override
String toString() {
  return 'NextActionDto(type: $type, label: $label, description: $description, route: $route, priority: $priority)';
}


}

/// @nodoc
abstract mixin class $NextActionDtoCopyWith<$Res>  {
  factory $NextActionDtoCopyWith(NextActionDto value, $Res Function(NextActionDto) _then) = _$NextActionDtoCopyWithImpl;
@useResult
$Res call({
 String type, String label, String description, String route, int priority
});




}
/// @nodoc
class _$NextActionDtoCopyWithImpl<$Res>
    implements $NextActionDtoCopyWith<$Res> {
  _$NextActionDtoCopyWithImpl(this._self, this._then);

  final NextActionDto _self;
  final $Res Function(NextActionDto) _then;

/// Create a copy of NextActionDto
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


/// Adds pattern-matching-related methods to [NextActionDto].
extension NextActionDtoPatterns on NextActionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextActionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextActionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextActionDto value)  $default,){
final _that = this;
switch (_that) {
case _NextActionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextActionDto value)?  $default,){
final _that = this;
switch (_that) {
case _NextActionDto() when $default != null:
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
case _NextActionDto() when $default != null:
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
case _NextActionDto():
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
case _NextActionDto() when $default != null:
return $default(_that.type,_that.label,_that.description,_that.route,_that.priority);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NextActionDto extends NextActionDto {
  const _NextActionDto({required this.type, required this.label, required this.description, required this.route, required this.priority}): super._();
  factory _NextActionDto.fromJson(Map<String, dynamic> json) => _$NextActionDtoFromJson(json);

@override final  String type;
@override final  String label;
@override final  String description;
@override final  String route;
@override final  int priority;

/// Create a copy of NextActionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextActionDtoCopyWith<_NextActionDto> get copyWith => __$NextActionDtoCopyWithImpl<_NextActionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NextActionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextActionDto&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.route, route) || other.route == route)&&(identical(other.priority, priority) || other.priority == priority));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,description,route,priority);

@override
String toString() {
  return 'NextActionDto(type: $type, label: $label, description: $description, route: $route, priority: $priority)';
}


}

/// @nodoc
abstract mixin class _$NextActionDtoCopyWith<$Res> implements $NextActionDtoCopyWith<$Res> {
  factory _$NextActionDtoCopyWith(_NextActionDto value, $Res Function(_NextActionDto) _then) = __$NextActionDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, String label, String description, String route, int priority
});




}
/// @nodoc
class __$NextActionDtoCopyWithImpl<$Res>
    implements _$NextActionDtoCopyWith<$Res> {
  __$NextActionDtoCopyWithImpl(this._self, this._then);

  final _NextActionDto _self;
  final $Res Function(_NextActionDto) _then;

/// Create a copy of NextActionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? label = null,Object? description = null,Object? route = null,Object? priority = null,}) {
  return _then(_NextActionDto(
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
mixin _$ProInsightsDto {

 bool get isUnlocked; String? get ctaLabel; String? get ctaRoute; List<ProInsightItemDto> get items;
/// Create a copy of ProInsightsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProInsightsDtoCopyWith<ProInsightsDto> get copyWith => _$ProInsightsDtoCopyWithImpl<ProInsightsDto>(this as ProInsightsDto, _$identity);

  /// Serializes this ProInsightsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProInsightsDto&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.ctaLabel, ctaLabel) || other.ctaLabel == ctaLabel)&&(identical(other.ctaRoute, ctaRoute) || other.ctaRoute == ctaRoute)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isUnlocked,ctaLabel,ctaRoute,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ProInsightsDto(isUnlocked: $isUnlocked, ctaLabel: $ctaLabel, ctaRoute: $ctaRoute, items: $items)';
}


}

/// @nodoc
abstract mixin class $ProInsightsDtoCopyWith<$Res>  {
  factory $ProInsightsDtoCopyWith(ProInsightsDto value, $Res Function(ProInsightsDto) _then) = _$ProInsightsDtoCopyWithImpl;
@useResult
$Res call({
 bool isUnlocked, String? ctaLabel, String? ctaRoute, List<ProInsightItemDto> items
});




}
/// @nodoc
class _$ProInsightsDtoCopyWithImpl<$Res>
    implements $ProInsightsDtoCopyWith<$Res> {
  _$ProInsightsDtoCopyWithImpl(this._self, this._then);

  final ProInsightsDto _self;
  final $Res Function(ProInsightsDto) _then;

/// Create a copy of ProInsightsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isUnlocked = null,Object? ctaLabel = freezed,Object? ctaRoute = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,ctaLabel: freezed == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String?,ctaRoute: freezed == ctaRoute ? _self.ctaRoute : ctaRoute // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProInsightItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProInsightsDto].
extension ProInsightsDtoPatterns on ProInsightsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProInsightsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProInsightsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProInsightsDto value)  $default,){
final _that = this;
switch (_that) {
case _ProInsightsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProInsightsDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProInsightsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isUnlocked,  String? ctaLabel,  String? ctaRoute,  List<ProInsightItemDto> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProInsightsDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isUnlocked,  String? ctaLabel,  String? ctaRoute,  List<ProInsightItemDto> items)  $default,) {final _that = this;
switch (_that) {
case _ProInsightsDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isUnlocked,  String? ctaLabel,  String? ctaRoute,  List<ProInsightItemDto> items)?  $default,) {final _that = this;
switch (_that) {
case _ProInsightsDto() when $default != null:
return $default(_that.isUnlocked,_that.ctaLabel,_that.ctaRoute,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProInsightsDto extends ProInsightsDto {
  const _ProInsightsDto({required this.isUnlocked, this.ctaLabel, this.ctaRoute, final  List<ProInsightItemDto> items = const <ProInsightItemDto>[]}): _items = items,super._();
  factory _ProInsightsDto.fromJson(Map<String, dynamic> json) => _$ProInsightsDtoFromJson(json);

@override final  bool isUnlocked;
@override final  String? ctaLabel;
@override final  String? ctaRoute;
 final  List<ProInsightItemDto> _items;
@override@JsonKey() List<ProInsightItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ProInsightsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProInsightsDtoCopyWith<_ProInsightsDto> get copyWith => __$ProInsightsDtoCopyWithImpl<_ProInsightsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProInsightsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProInsightsDto&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.ctaLabel, ctaLabel) || other.ctaLabel == ctaLabel)&&(identical(other.ctaRoute, ctaRoute) || other.ctaRoute == ctaRoute)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isUnlocked,ctaLabel,ctaRoute,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ProInsightsDto(isUnlocked: $isUnlocked, ctaLabel: $ctaLabel, ctaRoute: $ctaRoute, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ProInsightsDtoCopyWith<$Res> implements $ProInsightsDtoCopyWith<$Res> {
  factory _$ProInsightsDtoCopyWith(_ProInsightsDto value, $Res Function(_ProInsightsDto) _then) = __$ProInsightsDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isUnlocked, String? ctaLabel, String? ctaRoute, List<ProInsightItemDto> items
});




}
/// @nodoc
class __$ProInsightsDtoCopyWithImpl<$Res>
    implements _$ProInsightsDtoCopyWith<$Res> {
  __$ProInsightsDtoCopyWithImpl(this._self, this._then);

  final _ProInsightsDto _self;
  final $Res Function(_ProInsightsDto) _then;

/// Create a copy of ProInsightsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isUnlocked = null,Object? ctaLabel = freezed,Object? ctaRoute = freezed,Object? items = null,}) {
  return _then(_ProInsightsDto(
isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,ctaLabel: freezed == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String?,ctaRoute: freezed == ctaRoute ? _self.ctaRoute : ctaRoute // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProInsightItemDto>,
  ));
}


}


/// @nodoc
mixin _$ProInsightItemDto {

 String get type; String get severity; String get title; String get message;
/// Create a copy of ProInsightItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProInsightItemDtoCopyWith<ProInsightItemDto> get copyWith => _$ProInsightItemDtoCopyWithImpl<ProInsightItemDto>(this as ProInsightItemDto, _$identity);

  /// Serializes this ProInsightItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProInsightItemDto&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message);

@override
String toString() {
  return 'ProInsightItemDto(type: $type, severity: $severity, title: $title, message: $message)';
}


}

/// @nodoc
abstract mixin class $ProInsightItemDtoCopyWith<$Res>  {
  factory $ProInsightItemDtoCopyWith(ProInsightItemDto value, $Res Function(ProInsightItemDto) _then) = _$ProInsightItemDtoCopyWithImpl;
@useResult
$Res call({
 String type, String severity, String title, String message
});




}
/// @nodoc
class _$ProInsightItemDtoCopyWithImpl<$Res>
    implements $ProInsightItemDtoCopyWith<$Res> {
  _$ProInsightItemDtoCopyWithImpl(this._self, this._then);

  final ProInsightItemDto _self;
  final $Res Function(ProInsightItemDto) _then;

/// Create a copy of ProInsightItemDto
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


/// Adds pattern-matching-related methods to [ProInsightItemDto].
extension ProInsightItemDtoPatterns on ProInsightItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProInsightItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProInsightItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProInsightItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ProInsightItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProInsightItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProInsightItemDto() when $default != null:
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
case _ProInsightItemDto() when $default != null:
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
case _ProInsightItemDto():
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
case _ProInsightItemDto() when $default != null:
return $default(_that.type,_that.severity,_that.title,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProInsightItemDto extends ProInsightItemDto {
  const _ProInsightItemDto({required this.type, required this.severity, required this.title, required this.message}): super._();
  factory _ProInsightItemDto.fromJson(Map<String, dynamic> json) => _$ProInsightItemDtoFromJson(json);

@override final  String type;
@override final  String severity;
@override final  String title;
@override final  String message;

/// Create a copy of ProInsightItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProInsightItemDtoCopyWith<_ProInsightItemDto> get copyWith => __$ProInsightItemDtoCopyWithImpl<_ProInsightItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProInsightItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProInsightItemDto&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message);

@override
String toString() {
  return 'ProInsightItemDto(type: $type, severity: $severity, title: $title, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProInsightItemDtoCopyWith<$Res> implements $ProInsightItemDtoCopyWith<$Res> {
  factory _$ProInsightItemDtoCopyWith(_ProInsightItemDto value, $Res Function(_ProInsightItemDto) _then) = __$ProInsightItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, String severity, String title, String message
});




}
/// @nodoc
class __$ProInsightItemDtoCopyWithImpl<$Res>
    implements _$ProInsightItemDtoCopyWith<$Res> {
  __$ProInsightItemDtoCopyWithImpl(this._self, this._then);

  final _ProInsightItemDto _self;
  final $Res Function(_ProInsightItemDto) _then;

/// Create a copy of ProInsightItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? severity = null,Object? title = null,Object? message = null,}) {
  return _then(_ProInsightItemDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
