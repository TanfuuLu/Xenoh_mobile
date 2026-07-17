// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NutritionSummary {

 NutritionProfile get profile; NutritionCalculation get calculation; bool get canUseAdvancedAnalysis; NutritionDailyLog? get todayLog;
/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionSummaryCopyWith<NutritionSummary> get copyWith => _$NutritionSummaryCopyWithImpl<NutritionSummary>(this as NutritionSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionSummary&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.calculation, calculation) || other.calculation == calculation)&&(identical(other.canUseAdvancedAnalysis, canUseAdvancedAnalysis) || other.canUseAdvancedAnalysis == canUseAdvancedAnalysis)&&(identical(other.todayLog, todayLog) || other.todayLog == todayLog));
}


@override
int get hashCode => Object.hash(runtimeType,profile,calculation,canUseAdvancedAnalysis,todayLog);

@override
String toString() {
  return 'NutritionSummary(profile: $profile, calculation: $calculation, canUseAdvancedAnalysis: $canUseAdvancedAnalysis, todayLog: $todayLog)';
}


}

/// @nodoc
abstract mixin class $NutritionSummaryCopyWith<$Res>  {
  factory $NutritionSummaryCopyWith(NutritionSummary value, $Res Function(NutritionSummary) _then) = _$NutritionSummaryCopyWithImpl;
@useResult
$Res call({
 NutritionProfile profile, NutritionCalculation calculation, bool canUseAdvancedAnalysis, NutritionDailyLog? todayLog
});


$NutritionProfileCopyWith<$Res> get profile;$NutritionCalculationCopyWith<$Res> get calculation;$NutritionDailyLogCopyWith<$Res>? get todayLog;

}
/// @nodoc
class _$NutritionSummaryCopyWithImpl<$Res>
    implements $NutritionSummaryCopyWith<$Res> {
  _$NutritionSummaryCopyWithImpl(this._self, this._then);

  final NutritionSummary _self;
  final $Res Function(NutritionSummary) _then;

/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? calculation = null,Object? canUseAdvancedAnalysis = null,Object? todayLog = freezed,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as NutritionProfile,calculation: null == calculation ? _self.calculation : calculation // ignore: cast_nullable_to_non_nullable
as NutritionCalculation,canUseAdvancedAnalysis: null == canUseAdvancedAnalysis ? _self.canUseAdvancedAnalysis : canUseAdvancedAnalysis // ignore: cast_nullable_to_non_nullable
as bool,todayLog: freezed == todayLog ? _self.todayLog : todayLog // ignore: cast_nullable_to_non_nullable
as NutritionDailyLog?,
  ));
}
/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionProfileCopyWith<$Res> get profile {
  
  return $NutritionProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionCalculationCopyWith<$Res> get calculation {
  
  return $NutritionCalculationCopyWith<$Res>(_self.calculation, (value) {
    return _then(_self.copyWith(calculation: value));
  });
}/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionDailyLogCopyWith<$Res>? get todayLog {
    if (_self.todayLog == null) {
    return null;
  }

  return $NutritionDailyLogCopyWith<$Res>(_self.todayLog!, (value) {
    return _then(_self.copyWith(todayLog: value));
  });
}
}


/// Adds pattern-matching-related methods to [NutritionSummary].
extension NutritionSummaryPatterns on NutritionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionSummary value)  $default,){
final _that = this;
switch (_that) {
case _NutritionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NutritionProfile profile,  NutritionCalculation calculation,  bool canUseAdvancedAnalysis,  NutritionDailyLog? todayLog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionSummary() when $default != null:
return $default(_that.profile,_that.calculation,_that.canUseAdvancedAnalysis,_that.todayLog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NutritionProfile profile,  NutritionCalculation calculation,  bool canUseAdvancedAnalysis,  NutritionDailyLog? todayLog)  $default,) {final _that = this;
switch (_that) {
case _NutritionSummary():
return $default(_that.profile,_that.calculation,_that.canUseAdvancedAnalysis,_that.todayLog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NutritionProfile profile,  NutritionCalculation calculation,  bool canUseAdvancedAnalysis,  NutritionDailyLog? todayLog)?  $default,) {final _that = this;
switch (_that) {
case _NutritionSummary() when $default != null:
return $default(_that.profile,_that.calculation,_that.canUseAdvancedAnalysis,_that.todayLog);case _:
  return null;

}
}

}

/// @nodoc


class _NutritionSummary extends NutritionSummary {
  const _NutritionSummary({required this.profile, required this.calculation, required this.canUseAdvancedAnalysis, this.todayLog}): super._();
  

@override final  NutritionProfile profile;
@override final  NutritionCalculation calculation;
@override final  bool canUseAdvancedAnalysis;
@override final  NutritionDailyLog? todayLog;

/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionSummaryCopyWith<_NutritionSummary> get copyWith => __$NutritionSummaryCopyWithImpl<_NutritionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionSummary&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.calculation, calculation) || other.calculation == calculation)&&(identical(other.canUseAdvancedAnalysis, canUseAdvancedAnalysis) || other.canUseAdvancedAnalysis == canUseAdvancedAnalysis)&&(identical(other.todayLog, todayLog) || other.todayLog == todayLog));
}


@override
int get hashCode => Object.hash(runtimeType,profile,calculation,canUseAdvancedAnalysis,todayLog);

@override
String toString() {
  return 'NutritionSummary(profile: $profile, calculation: $calculation, canUseAdvancedAnalysis: $canUseAdvancedAnalysis, todayLog: $todayLog)';
}


}

/// @nodoc
abstract mixin class _$NutritionSummaryCopyWith<$Res> implements $NutritionSummaryCopyWith<$Res> {
  factory _$NutritionSummaryCopyWith(_NutritionSummary value, $Res Function(_NutritionSummary) _then) = __$NutritionSummaryCopyWithImpl;
@override @useResult
$Res call({
 NutritionProfile profile, NutritionCalculation calculation, bool canUseAdvancedAnalysis, NutritionDailyLog? todayLog
});


@override $NutritionProfileCopyWith<$Res> get profile;@override $NutritionCalculationCopyWith<$Res> get calculation;@override $NutritionDailyLogCopyWith<$Res>? get todayLog;

}
/// @nodoc
class __$NutritionSummaryCopyWithImpl<$Res>
    implements _$NutritionSummaryCopyWith<$Res> {
  __$NutritionSummaryCopyWithImpl(this._self, this._then);

  final _NutritionSummary _self;
  final $Res Function(_NutritionSummary) _then;

/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? calculation = null,Object? canUseAdvancedAnalysis = null,Object? todayLog = freezed,}) {
  return _then(_NutritionSummary(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as NutritionProfile,calculation: null == calculation ? _self.calculation : calculation // ignore: cast_nullable_to_non_nullable
as NutritionCalculation,canUseAdvancedAnalysis: null == canUseAdvancedAnalysis ? _self.canUseAdvancedAnalysis : canUseAdvancedAnalysis // ignore: cast_nullable_to_non_nullable
as bool,todayLog: freezed == todayLog ? _self.todayLog : todayLog // ignore: cast_nullable_to_non_nullable
as NutritionDailyLog?,
  ));
}

/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionProfileCopyWith<$Res> get profile {
  
  return $NutritionProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionCalculationCopyWith<$Res> get calculation {
  
  return $NutritionCalculationCopyWith<$Res>(_self.calculation, (value) {
    return _then(_self.copyWith(calculation: value));
  });
}/// Create a copy of NutritionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionDailyLogCopyWith<$Res>? get todayLog {
    if (_self.todayLog == null) {
    return null;
  }

  return $NutritionDailyLogCopyWith<$Res>(_self.todayLog!, (value) {
    return _then(_self.copyWith(todayLog: value));
  });
}
}

/// @nodoc
mixin _$NutritionProfile {

 String get activityLevel; String get goal; double? get targetWeightKg; int? get customCalorieTarget; double? get proteinPerKg; double? get fatPerKg;
/// Create a copy of NutritionProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionProfileCopyWith<NutritionProfile> get copyWith => _$NutritionProfileCopyWithImpl<NutritionProfile>(this as NutritionProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionProfile&&(identical(other.activityLevel, activityLevel) || other.activityLevel == activityLevel)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.targetWeightKg, targetWeightKg) || other.targetWeightKg == targetWeightKg)&&(identical(other.customCalorieTarget, customCalorieTarget) || other.customCalorieTarget == customCalorieTarget)&&(identical(other.proteinPerKg, proteinPerKg) || other.proteinPerKg == proteinPerKg)&&(identical(other.fatPerKg, fatPerKg) || other.fatPerKg == fatPerKg));
}


@override
int get hashCode => Object.hash(runtimeType,activityLevel,goal,targetWeightKg,customCalorieTarget,proteinPerKg,fatPerKg);

@override
String toString() {
  return 'NutritionProfile(activityLevel: $activityLevel, goal: $goal, targetWeightKg: $targetWeightKg, customCalorieTarget: $customCalorieTarget, proteinPerKg: $proteinPerKg, fatPerKg: $fatPerKg)';
}


}

/// @nodoc
abstract mixin class $NutritionProfileCopyWith<$Res>  {
  factory $NutritionProfileCopyWith(NutritionProfile value, $Res Function(NutritionProfile) _then) = _$NutritionProfileCopyWithImpl;
@useResult
$Res call({
 String activityLevel, String goal, double? targetWeightKg, int? customCalorieTarget, double? proteinPerKg, double? fatPerKg
});




}
/// @nodoc
class _$NutritionProfileCopyWithImpl<$Res>
    implements $NutritionProfileCopyWith<$Res> {
  _$NutritionProfileCopyWithImpl(this._self, this._then);

  final NutritionProfile _self;
  final $Res Function(NutritionProfile) _then;

/// Create a copy of NutritionProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityLevel = null,Object? goal = null,Object? targetWeightKg = freezed,Object? customCalorieTarget = freezed,Object? proteinPerKg = freezed,Object? fatPerKg = freezed,}) {
  return _then(_self.copyWith(
activityLevel: null == activityLevel ? _self.activityLevel : activityLevel // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,targetWeightKg: freezed == targetWeightKg ? _self.targetWeightKg : targetWeightKg // ignore: cast_nullable_to_non_nullable
as double?,customCalorieTarget: freezed == customCalorieTarget ? _self.customCalorieTarget : customCalorieTarget // ignore: cast_nullable_to_non_nullable
as int?,proteinPerKg: freezed == proteinPerKg ? _self.proteinPerKg : proteinPerKg // ignore: cast_nullable_to_non_nullable
as double?,fatPerKg: freezed == fatPerKg ? _self.fatPerKg : fatPerKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionProfile].
extension NutritionProfilePatterns on NutritionProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionProfile value)  $default,){
final _that = this;
switch (_that) {
case _NutritionProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionProfile value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String activityLevel,  String goal,  double? targetWeightKg,  int? customCalorieTarget,  double? proteinPerKg,  double? fatPerKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionProfile() when $default != null:
return $default(_that.activityLevel,_that.goal,_that.targetWeightKg,_that.customCalorieTarget,_that.proteinPerKg,_that.fatPerKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String activityLevel,  String goal,  double? targetWeightKg,  int? customCalorieTarget,  double? proteinPerKg,  double? fatPerKg)  $default,) {final _that = this;
switch (_that) {
case _NutritionProfile():
return $default(_that.activityLevel,_that.goal,_that.targetWeightKg,_that.customCalorieTarget,_that.proteinPerKg,_that.fatPerKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String activityLevel,  String goal,  double? targetWeightKg,  int? customCalorieTarget,  double? proteinPerKg,  double? fatPerKg)?  $default,) {final _that = this;
switch (_that) {
case _NutritionProfile() when $default != null:
return $default(_that.activityLevel,_that.goal,_that.targetWeightKg,_that.customCalorieTarget,_that.proteinPerKg,_that.fatPerKg);case _:
  return null;

}
}

}

/// @nodoc


class _NutritionProfile implements NutritionProfile {
  const _NutritionProfile({required this.activityLevel, required this.goal, this.targetWeightKg, this.customCalorieTarget, this.proteinPerKg, this.fatPerKg});
  

@override final  String activityLevel;
@override final  String goal;
@override final  double? targetWeightKg;
@override final  int? customCalorieTarget;
@override final  double? proteinPerKg;
@override final  double? fatPerKg;

/// Create a copy of NutritionProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionProfileCopyWith<_NutritionProfile> get copyWith => __$NutritionProfileCopyWithImpl<_NutritionProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionProfile&&(identical(other.activityLevel, activityLevel) || other.activityLevel == activityLevel)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.targetWeightKg, targetWeightKg) || other.targetWeightKg == targetWeightKg)&&(identical(other.customCalorieTarget, customCalorieTarget) || other.customCalorieTarget == customCalorieTarget)&&(identical(other.proteinPerKg, proteinPerKg) || other.proteinPerKg == proteinPerKg)&&(identical(other.fatPerKg, fatPerKg) || other.fatPerKg == fatPerKg));
}


@override
int get hashCode => Object.hash(runtimeType,activityLevel,goal,targetWeightKg,customCalorieTarget,proteinPerKg,fatPerKg);

@override
String toString() {
  return 'NutritionProfile(activityLevel: $activityLevel, goal: $goal, targetWeightKg: $targetWeightKg, customCalorieTarget: $customCalorieTarget, proteinPerKg: $proteinPerKg, fatPerKg: $fatPerKg)';
}


}

/// @nodoc
abstract mixin class _$NutritionProfileCopyWith<$Res> implements $NutritionProfileCopyWith<$Res> {
  factory _$NutritionProfileCopyWith(_NutritionProfile value, $Res Function(_NutritionProfile) _then) = __$NutritionProfileCopyWithImpl;
@override @useResult
$Res call({
 String activityLevel, String goal, double? targetWeightKg, int? customCalorieTarget, double? proteinPerKg, double? fatPerKg
});




}
/// @nodoc
class __$NutritionProfileCopyWithImpl<$Res>
    implements _$NutritionProfileCopyWith<$Res> {
  __$NutritionProfileCopyWithImpl(this._self, this._then);

  final _NutritionProfile _self;
  final $Res Function(_NutritionProfile) _then;

/// Create a copy of NutritionProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityLevel = null,Object? goal = null,Object? targetWeightKg = freezed,Object? customCalorieTarget = freezed,Object? proteinPerKg = freezed,Object? fatPerKg = freezed,}) {
  return _then(_NutritionProfile(
activityLevel: null == activityLevel ? _self.activityLevel : activityLevel // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,targetWeightKg: freezed == targetWeightKg ? _self.targetWeightKg : targetWeightKg // ignore: cast_nullable_to_non_nullable
as double?,customCalorieTarget: freezed == customCalorieTarget ? _self.customCalorieTarget : customCalorieTarget // ignore: cast_nullable_to_non_nullable
as int?,proteinPerKg: freezed == proteinPerKg ? _self.proteinPerKg : proteinPerKg // ignore: cast_nullable_to_non_nullable
as double?,fatPerKg: freezed == fatPerKg ? _self.fatPerKg : fatPerKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$NutritionCalculation {

 List<String> get missingFields; double? get bodyweightKg; int? get age; int? get bmr; int? get tdee; int? get recommendedCalories; int? get calorieTarget; double? get proteinG; double? get carbsG; double? get fatG;
/// Create a copy of NutritionCalculation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionCalculationCopyWith<NutritionCalculation> get copyWith => _$NutritionCalculationCopyWithImpl<NutritionCalculation>(this as NutritionCalculation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionCalculation&&const DeepCollectionEquality().equals(other.missingFields, missingFields)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg)&&(identical(other.age, age) || other.age == age)&&(identical(other.bmr, bmr) || other.bmr == bmr)&&(identical(other.tdee, tdee) || other.tdee == tdee)&&(identical(other.recommendedCalories, recommendedCalories) || other.recommendedCalories == recommendedCalories)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(missingFields),bodyweightKg,age,bmr,tdee,recommendedCalories,calorieTarget,proteinG,carbsG,fatG);

@override
String toString() {
  return 'NutritionCalculation(missingFields: $missingFields, bodyweightKg: $bodyweightKg, age: $age, bmr: $bmr, tdee: $tdee, recommendedCalories: $recommendedCalories, calorieTarget: $calorieTarget, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class $NutritionCalculationCopyWith<$Res>  {
  factory $NutritionCalculationCopyWith(NutritionCalculation value, $Res Function(NutritionCalculation) _then) = _$NutritionCalculationCopyWithImpl;
@useResult
$Res call({
 List<String> missingFields, double? bodyweightKg, int? age, int? bmr, int? tdee, int? recommendedCalories, int? calorieTarget, double? proteinG, double? carbsG, double? fatG
});




}
/// @nodoc
class _$NutritionCalculationCopyWithImpl<$Res>
    implements $NutritionCalculationCopyWith<$Res> {
  _$NutritionCalculationCopyWithImpl(this._self, this._then);

  final NutritionCalculation _self;
  final $Res Function(NutritionCalculation) _then;

/// Create a copy of NutritionCalculation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? missingFields = null,Object? bodyweightKg = freezed,Object? age = freezed,Object? bmr = freezed,Object? tdee = freezed,Object? recommendedCalories = freezed,Object? calorieTarget = freezed,Object? proteinG = freezed,Object? carbsG = freezed,Object? fatG = freezed,}) {
  return _then(_self.copyWith(
missingFields: null == missingFields ? _self.missingFields : missingFields // ignore: cast_nullable_to_non_nullable
as List<String>,bodyweightKg: freezed == bodyweightKg ? _self.bodyweightKg : bodyweightKg // ignore: cast_nullable_to_non_nullable
as double?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,bmr: freezed == bmr ? _self.bmr : bmr // ignore: cast_nullable_to_non_nullable
as int?,tdee: freezed == tdee ? _self.tdee : tdee // ignore: cast_nullable_to_non_nullable
as int?,recommendedCalories: freezed == recommendedCalories ? _self.recommendedCalories : recommendedCalories // ignore: cast_nullable_to_non_nullable
as int?,calorieTarget: freezed == calorieTarget ? _self.calorieTarget : calorieTarget // ignore: cast_nullable_to_non_nullable
as int?,proteinG: freezed == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double?,carbsG: freezed == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double?,fatG: freezed == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionCalculation].
extension NutritionCalculationPatterns on NutritionCalculation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionCalculation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionCalculation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionCalculation value)  $default,){
final _that = this;
switch (_that) {
case _NutritionCalculation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionCalculation value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionCalculation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> missingFields,  double? bodyweightKg,  int? age,  int? bmr,  int? tdee,  int? recommendedCalories,  int? calorieTarget,  double? proteinG,  double? carbsG,  double? fatG)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionCalculation() when $default != null:
return $default(_that.missingFields,_that.bodyweightKg,_that.age,_that.bmr,_that.tdee,_that.recommendedCalories,_that.calorieTarget,_that.proteinG,_that.carbsG,_that.fatG);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> missingFields,  double? bodyweightKg,  int? age,  int? bmr,  int? tdee,  int? recommendedCalories,  int? calorieTarget,  double? proteinG,  double? carbsG,  double? fatG)  $default,) {final _that = this;
switch (_that) {
case _NutritionCalculation():
return $default(_that.missingFields,_that.bodyweightKg,_that.age,_that.bmr,_that.tdee,_that.recommendedCalories,_that.calorieTarget,_that.proteinG,_that.carbsG,_that.fatG);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> missingFields,  double? bodyweightKg,  int? age,  int? bmr,  int? tdee,  int? recommendedCalories,  int? calorieTarget,  double? proteinG,  double? carbsG,  double? fatG)?  $default,) {final _that = this;
switch (_that) {
case _NutritionCalculation() when $default != null:
return $default(_that.missingFields,_that.bodyweightKg,_that.age,_that.bmr,_that.tdee,_that.recommendedCalories,_that.calorieTarget,_that.proteinG,_that.carbsG,_that.fatG);case _:
  return null;

}
}

}

/// @nodoc


class _NutritionCalculation implements NutritionCalculation {
  const _NutritionCalculation({final  List<String> missingFields = const <String>[], this.bodyweightKg, this.age, this.bmr, this.tdee, this.recommendedCalories, this.calorieTarget, this.proteinG, this.carbsG, this.fatG}): _missingFields = missingFields;
  

 final  List<String> _missingFields;
@override@JsonKey() List<String> get missingFields {
  if (_missingFields is EqualUnmodifiableListView) return _missingFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missingFields);
}

@override final  double? bodyweightKg;
@override final  int? age;
@override final  int? bmr;
@override final  int? tdee;
@override final  int? recommendedCalories;
@override final  int? calorieTarget;
@override final  double? proteinG;
@override final  double? carbsG;
@override final  double? fatG;

/// Create a copy of NutritionCalculation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionCalculationCopyWith<_NutritionCalculation> get copyWith => __$NutritionCalculationCopyWithImpl<_NutritionCalculation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionCalculation&&const DeepCollectionEquality().equals(other._missingFields, _missingFields)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg)&&(identical(other.age, age) || other.age == age)&&(identical(other.bmr, bmr) || other.bmr == bmr)&&(identical(other.tdee, tdee) || other.tdee == tdee)&&(identical(other.recommendedCalories, recommendedCalories) || other.recommendedCalories == recommendedCalories)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_missingFields),bodyweightKg,age,bmr,tdee,recommendedCalories,calorieTarget,proteinG,carbsG,fatG);

@override
String toString() {
  return 'NutritionCalculation(missingFields: $missingFields, bodyweightKg: $bodyweightKg, age: $age, bmr: $bmr, tdee: $tdee, recommendedCalories: $recommendedCalories, calorieTarget: $calorieTarget, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class _$NutritionCalculationCopyWith<$Res> implements $NutritionCalculationCopyWith<$Res> {
  factory _$NutritionCalculationCopyWith(_NutritionCalculation value, $Res Function(_NutritionCalculation) _then) = __$NutritionCalculationCopyWithImpl;
@override @useResult
$Res call({
 List<String> missingFields, double? bodyweightKg, int? age, int? bmr, int? tdee, int? recommendedCalories, int? calorieTarget, double? proteinG, double? carbsG, double? fatG
});




}
/// @nodoc
class __$NutritionCalculationCopyWithImpl<$Res>
    implements _$NutritionCalculationCopyWith<$Res> {
  __$NutritionCalculationCopyWithImpl(this._self, this._then);

  final _NutritionCalculation _self;
  final $Res Function(_NutritionCalculation) _then;

/// Create a copy of NutritionCalculation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? missingFields = null,Object? bodyweightKg = freezed,Object? age = freezed,Object? bmr = freezed,Object? tdee = freezed,Object? recommendedCalories = freezed,Object? calorieTarget = freezed,Object? proteinG = freezed,Object? carbsG = freezed,Object? fatG = freezed,}) {
  return _then(_NutritionCalculation(
missingFields: null == missingFields ? _self._missingFields : missingFields // ignore: cast_nullable_to_non_nullable
as List<String>,bodyweightKg: freezed == bodyweightKg ? _self.bodyweightKg : bodyweightKg // ignore: cast_nullable_to_non_nullable
as double?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,bmr: freezed == bmr ? _self.bmr : bmr // ignore: cast_nullable_to_non_nullable
as int?,tdee: freezed == tdee ? _self.tdee : tdee // ignore: cast_nullable_to_non_nullable
as int?,recommendedCalories: freezed == recommendedCalories ? _self.recommendedCalories : recommendedCalories // ignore: cast_nullable_to_non_nullable
as int?,calorieTarget: freezed == calorieTarget ? _self.calorieTarget : calorieTarget // ignore: cast_nullable_to_non_nullable
as int?,proteinG: freezed == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double?,carbsG: freezed == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double?,fatG: freezed == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$NutritionDailyLog {

 DateTime get date; int get calories; double get proteinG; double get carbsG; double get fatG; String? get notes;
/// Create a copy of NutritionDailyLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionDailyLogCopyWith<NutritionDailyLog> get copyWith => _$NutritionDailyLogCopyWithImpl<NutritionDailyLog>(this as NutritionDailyLog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionDailyLog&&(identical(other.date, date) || other.date == date)&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,date,calories,proteinG,carbsG,fatG,notes);

@override
String toString() {
  return 'NutritionDailyLog(date: $date, calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $NutritionDailyLogCopyWith<$Res>  {
  factory $NutritionDailyLogCopyWith(NutritionDailyLog value, $Res Function(NutritionDailyLog) _then) = _$NutritionDailyLogCopyWithImpl;
@useResult
$Res call({
 DateTime date, int calories, double proteinG, double carbsG, double fatG, String? notes
});




}
/// @nodoc
class _$NutritionDailyLogCopyWithImpl<$Res>
    implements $NutritionDailyLogCopyWith<$Res> {
  _$NutritionDailyLogCopyWithImpl(this._self, this._then);

  final NutritionDailyLog _self;
  final $Res Function(NutritionDailyLog) _then;

/// Create a copy of NutritionDailyLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? calories = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionDailyLog].
extension NutritionDailyLogPatterns on NutritionDailyLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionDailyLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionDailyLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionDailyLog value)  $default,){
final _that = this;
switch (_that) {
case _NutritionDailyLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionDailyLog value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionDailyLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int calories,  double proteinG,  double carbsG,  double fatG,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionDailyLog() when $default != null:
return $default(_that.date,_that.calories,_that.proteinG,_that.carbsG,_that.fatG,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int calories,  double proteinG,  double carbsG,  double fatG,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _NutritionDailyLog():
return $default(_that.date,_that.calories,_that.proteinG,_that.carbsG,_that.fatG,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int calories,  double proteinG,  double carbsG,  double fatG,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _NutritionDailyLog() when $default != null:
return $default(_that.date,_that.calories,_that.proteinG,_that.carbsG,_that.fatG,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _NutritionDailyLog implements NutritionDailyLog {
  const _NutritionDailyLog({required this.date, required this.calories, required this.proteinG, required this.carbsG, required this.fatG, this.notes});
  

@override final  DateTime date;
@override final  int calories;
@override final  double proteinG;
@override final  double carbsG;
@override final  double fatG;
@override final  String? notes;

/// Create a copy of NutritionDailyLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionDailyLogCopyWith<_NutritionDailyLog> get copyWith => __$NutritionDailyLogCopyWithImpl<_NutritionDailyLog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionDailyLog&&(identical(other.date, date) || other.date == date)&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,date,calories,proteinG,carbsG,fatG,notes);

@override
String toString() {
  return 'NutritionDailyLog(date: $date, calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$NutritionDailyLogCopyWith<$Res> implements $NutritionDailyLogCopyWith<$Res> {
  factory _$NutritionDailyLogCopyWith(_NutritionDailyLog value, $Res Function(_NutritionDailyLog) _then) = __$NutritionDailyLogCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int calories, double proteinG, double carbsG, double fatG, String? notes
});




}
/// @nodoc
class __$NutritionDailyLogCopyWithImpl<$Res>
    implements _$NutritionDailyLogCopyWith<$Res> {
  __$NutritionDailyLogCopyWithImpl(this._self, this._then);

  final _NutritionDailyLog _self;
  final $Res Function(_NutritionDailyLog) _then;

/// Create a copy of NutritionDailyLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? calories = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? notes = freezed,}) {
  return _then(_NutritionDailyLog(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
