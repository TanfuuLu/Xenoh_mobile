// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NutritionSummaryDto {

 NutritionProfileDto get profile; NutritionCalculationDto get calculation; bool get canUseAdvancedAnalysis; NutritionDailyLogDto? get todayLog;
/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionSummaryDtoCopyWith<NutritionSummaryDto> get copyWith => _$NutritionSummaryDtoCopyWithImpl<NutritionSummaryDto>(this as NutritionSummaryDto, _$identity);

  /// Serializes this NutritionSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionSummaryDto&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.calculation, calculation) || other.calculation == calculation)&&(identical(other.canUseAdvancedAnalysis, canUseAdvancedAnalysis) || other.canUseAdvancedAnalysis == canUseAdvancedAnalysis)&&(identical(other.todayLog, todayLog) || other.todayLog == todayLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profile,calculation,canUseAdvancedAnalysis,todayLog);

@override
String toString() {
  return 'NutritionSummaryDto(profile: $profile, calculation: $calculation, canUseAdvancedAnalysis: $canUseAdvancedAnalysis, todayLog: $todayLog)';
}


}

/// @nodoc
abstract mixin class $NutritionSummaryDtoCopyWith<$Res>  {
  factory $NutritionSummaryDtoCopyWith(NutritionSummaryDto value, $Res Function(NutritionSummaryDto) _then) = _$NutritionSummaryDtoCopyWithImpl;
@useResult
$Res call({
 NutritionProfileDto profile, NutritionCalculationDto calculation, bool canUseAdvancedAnalysis, NutritionDailyLogDto? todayLog
});


$NutritionProfileDtoCopyWith<$Res> get profile;$NutritionCalculationDtoCopyWith<$Res> get calculation;$NutritionDailyLogDtoCopyWith<$Res>? get todayLog;

}
/// @nodoc
class _$NutritionSummaryDtoCopyWithImpl<$Res>
    implements $NutritionSummaryDtoCopyWith<$Res> {
  _$NutritionSummaryDtoCopyWithImpl(this._self, this._then);

  final NutritionSummaryDto _self;
  final $Res Function(NutritionSummaryDto) _then;

/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? calculation = null,Object? canUseAdvancedAnalysis = null,Object? todayLog = freezed,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as NutritionProfileDto,calculation: null == calculation ? _self.calculation : calculation // ignore: cast_nullable_to_non_nullable
as NutritionCalculationDto,canUseAdvancedAnalysis: null == canUseAdvancedAnalysis ? _self.canUseAdvancedAnalysis : canUseAdvancedAnalysis // ignore: cast_nullable_to_non_nullable
as bool,todayLog: freezed == todayLog ? _self.todayLog : todayLog // ignore: cast_nullable_to_non_nullable
as NutritionDailyLogDto?,
  ));
}
/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionProfileDtoCopyWith<$Res> get profile {
  
  return $NutritionProfileDtoCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionCalculationDtoCopyWith<$Res> get calculation {
  
  return $NutritionCalculationDtoCopyWith<$Res>(_self.calculation, (value) {
    return _then(_self.copyWith(calculation: value));
  });
}/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionDailyLogDtoCopyWith<$Res>? get todayLog {
    if (_self.todayLog == null) {
    return null;
  }

  return $NutritionDailyLogDtoCopyWith<$Res>(_self.todayLog!, (value) {
    return _then(_self.copyWith(todayLog: value));
  });
}
}


/// Adds pattern-matching-related methods to [NutritionSummaryDto].
extension NutritionSummaryDtoPatterns on NutritionSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _NutritionSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NutritionProfileDto profile,  NutritionCalculationDto calculation,  bool canUseAdvancedAnalysis,  NutritionDailyLogDto? todayLog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionSummaryDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NutritionProfileDto profile,  NutritionCalculationDto calculation,  bool canUseAdvancedAnalysis,  NutritionDailyLogDto? todayLog)  $default,) {final _that = this;
switch (_that) {
case _NutritionSummaryDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NutritionProfileDto profile,  NutritionCalculationDto calculation,  bool canUseAdvancedAnalysis,  NutritionDailyLogDto? todayLog)?  $default,) {final _that = this;
switch (_that) {
case _NutritionSummaryDto() when $default != null:
return $default(_that.profile,_that.calculation,_that.canUseAdvancedAnalysis,_that.todayLog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionSummaryDto extends NutritionSummaryDto {
  const _NutritionSummaryDto({required this.profile, required this.calculation, required this.canUseAdvancedAnalysis, this.todayLog}): super._();
  factory _NutritionSummaryDto.fromJson(Map<String, dynamic> json) => _$NutritionSummaryDtoFromJson(json);

@override final  NutritionProfileDto profile;
@override final  NutritionCalculationDto calculation;
@override final  bool canUseAdvancedAnalysis;
@override final  NutritionDailyLogDto? todayLog;

/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionSummaryDtoCopyWith<_NutritionSummaryDto> get copyWith => __$NutritionSummaryDtoCopyWithImpl<_NutritionSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionSummaryDto&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.calculation, calculation) || other.calculation == calculation)&&(identical(other.canUseAdvancedAnalysis, canUseAdvancedAnalysis) || other.canUseAdvancedAnalysis == canUseAdvancedAnalysis)&&(identical(other.todayLog, todayLog) || other.todayLog == todayLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profile,calculation,canUseAdvancedAnalysis,todayLog);

@override
String toString() {
  return 'NutritionSummaryDto(profile: $profile, calculation: $calculation, canUseAdvancedAnalysis: $canUseAdvancedAnalysis, todayLog: $todayLog)';
}


}

/// @nodoc
abstract mixin class _$NutritionSummaryDtoCopyWith<$Res> implements $NutritionSummaryDtoCopyWith<$Res> {
  factory _$NutritionSummaryDtoCopyWith(_NutritionSummaryDto value, $Res Function(_NutritionSummaryDto) _then) = __$NutritionSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 NutritionProfileDto profile, NutritionCalculationDto calculation, bool canUseAdvancedAnalysis, NutritionDailyLogDto? todayLog
});


@override $NutritionProfileDtoCopyWith<$Res> get profile;@override $NutritionCalculationDtoCopyWith<$Res> get calculation;@override $NutritionDailyLogDtoCopyWith<$Res>? get todayLog;

}
/// @nodoc
class __$NutritionSummaryDtoCopyWithImpl<$Res>
    implements _$NutritionSummaryDtoCopyWith<$Res> {
  __$NutritionSummaryDtoCopyWithImpl(this._self, this._then);

  final _NutritionSummaryDto _self;
  final $Res Function(_NutritionSummaryDto) _then;

/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? calculation = null,Object? canUseAdvancedAnalysis = null,Object? todayLog = freezed,}) {
  return _then(_NutritionSummaryDto(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as NutritionProfileDto,calculation: null == calculation ? _self.calculation : calculation // ignore: cast_nullable_to_non_nullable
as NutritionCalculationDto,canUseAdvancedAnalysis: null == canUseAdvancedAnalysis ? _self.canUseAdvancedAnalysis : canUseAdvancedAnalysis // ignore: cast_nullable_to_non_nullable
as bool,todayLog: freezed == todayLog ? _self.todayLog : todayLog // ignore: cast_nullable_to_non_nullable
as NutritionDailyLogDto?,
  ));
}

/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionProfileDtoCopyWith<$Res> get profile {
  
  return $NutritionProfileDtoCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionCalculationDtoCopyWith<$Res> get calculation {
  
  return $NutritionCalculationDtoCopyWith<$Res>(_self.calculation, (value) {
    return _then(_self.copyWith(calculation: value));
  });
}/// Create a copy of NutritionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NutritionDailyLogDtoCopyWith<$Res>? get todayLog {
    if (_self.todayLog == null) {
    return null;
  }

  return $NutritionDailyLogDtoCopyWith<$Res>(_self.todayLog!, (value) {
    return _then(_self.copyWith(todayLog: value));
  });
}
}


/// @nodoc
mixin _$NutritionProfileDto {

 String get activityLevel; String get goal; double? get targetWeightKg; int? get customCalorieTarget; double? get proteinPerKg; double? get fatPerKg;
/// Create a copy of NutritionProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionProfileDtoCopyWith<NutritionProfileDto> get copyWith => _$NutritionProfileDtoCopyWithImpl<NutritionProfileDto>(this as NutritionProfileDto, _$identity);

  /// Serializes this NutritionProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionProfileDto&&(identical(other.activityLevel, activityLevel) || other.activityLevel == activityLevel)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.targetWeightKg, targetWeightKg) || other.targetWeightKg == targetWeightKg)&&(identical(other.customCalorieTarget, customCalorieTarget) || other.customCalorieTarget == customCalorieTarget)&&(identical(other.proteinPerKg, proteinPerKg) || other.proteinPerKg == proteinPerKg)&&(identical(other.fatPerKg, fatPerKg) || other.fatPerKg == fatPerKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityLevel,goal,targetWeightKg,customCalorieTarget,proteinPerKg,fatPerKg);

@override
String toString() {
  return 'NutritionProfileDto(activityLevel: $activityLevel, goal: $goal, targetWeightKg: $targetWeightKg, customCalorieTarget: $customCalorieTarget, proteinPerKg: $proteinPerKg, fatPerKg: $fatPerKg)';
}


}

/// @nodoc
abstract mixin class $NutritionProfileDtoCopyWith<$Res>  {
  factory $NutritionProfileDtoCopyWith(NutritionProfileDto value, $Res Function(NutritionProfileDto) _then) = _$NutritionProfileDtoCopyWithImpl;
@useResult
$Res call({
 String activityLevel, String goal, double? targetWeightKg, int? customCalorieTarget, double? proteinPerKg, double? fatPerKg
});




}
/// @nodoc
class _$NutritionProfileDtoCopyWithImpl<$Res>
    implements $NutritionProfileDtoCopyWith<$Res> {
  _$NutritionProfileDtoCopyWithImpl(this._self, this._then);

  final NutritionProfileDto _self;
  final $Res Function(NutritionProfileDto) _then;

/// Create a copy of NutritionProfileDto
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


/// Adds pattern-matching-related methods to [NutritionProfileDto].
extension NutritionProfileDtoPatterns on NutritionProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _NutritionProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionProfileDto() when $default != null:
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
case _NutritionProfileDto() when $default != null:
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
case _NutritionProfileDto():
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
case _NutritionProfileDto() when $default != null:
return $default(_that.activityLevel,_that.goal,_that.targetWeightKg,_that.customCalorieTarget,_that.proteinPerKg,_that.fatPerKg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionProfileDto extends NutritionProfileDto {
  const _NutritionProfileDto({required this.activityLevel, required this.goal, this.targetWeightKg, this.customCalorieTarget, this.proteinPerKg, this.fatPerKg}): super._();
  factory _NutritionProfileDto.fromJson(Map<String, dynamic> json) => _$NutritionProfileDtoFromJson(json);

@override final  String activityLevel;
@override final  String goal;
@override final  double? targetWeightKg;
@override final  int? customCalorieTarget;
@override final  double? proteinPerKg;
@override final  double? fatPerKg;

/// Create a copy of NutritionProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionProfileDtoCopyWith<_NutritionProfileDto> get copyWith => __$NutritionProfileDtoCopyWithImpl<_NutritionProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionProfileDto&&(identical(other.activityLevel, activityLevel) || other.activityLevel == activityLevel)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.targetWeightKg, targetWeightKg) || other.targetWeightKg == targetWeightKg)&&(identical(other.customCalorieTarget, customCalorieTarget) || other.customCalorieTarget == customCalorieTarget)&&(identical(other.proteinPerKg, proteinPerKg) || other.proteinPerKg == proteinPerKg)&&(identical(other.fatPerKg, fatPerKg) || other.fatPerKg == fatPerKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activityLevel,goal,targetWeightKg,customCalorieTarget,proteinPerKg,fatPerKg);

@override
String toString() {
  return 'NutritionProfileDto(activityLevel: $activityLevel, goal: $goal, targetWeightKg: $targetWeightKg, customCalorieTarget: $customCalorieTarget, proteinPerKg: $proteinPerKg, fatPerKg: $fatPerKg)';
}


}

/// @nodoc
abstract mixin class _$NutritionProfileDtoCopyWith<$Res> implements $NutritionProfileDtoCopyWith<$Res> {
  factory _$NutritionProfileDtoCopyWith(_NutritionProfileDto value, $Res Function(_NutritionProfileDto) _then) = __$NutritionProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String activityLevel, String goal, double? targetWeightKg, int? customCalorieTarget, double? proteinPerKg, double? fatPerKg
});




}
/// @nodoc
class __$NutritionProfileDtoCopyWithImpl<$Res>
    implements _$NutritionProfileDtoCopyWith<$Res> {
  __$NutritionProfileDtoCopyWithImpl(this._self, this._then);

  final _NutritionProfileDto _self;
  final $Res Function(_NutritionProfileDto) _then;

/// Create a copy of NutritionProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityLevel = null,Object? goal = null,Object? targetWeightKg = freezed,Object? customCalorieTarget = freezed,Object? proteinPerKg = freezed,Object? fatPerKg = freezed,}) {
  return _then(_NutritionProfileDto(
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
mixin _$NutritionCalculationDto {

 List<String> get missingFields; double? get bodyweightKg; int? get age; int? get bmr; int? get tdee; int? get recommendedCalories; int? get calorieTarget; double? get proteinG; double? get carbsG; double? get fatG;
/// Create a copy of NutritionCalculationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionCalculationDtoCopyWith<NutritionCalculationDto> get copyWith => _$NutritionCalculationDtoCopyWithImpl<NutritionCalculationDto>(this as NutritionCalculationDto, _$identity);

  /// Serializes this NutritionCalculationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionCalculationDto&&const DeepCollectionEquality().equals(other.missingFields, missingFields)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg)&&(identical(other.age, age) || other.age == age)&&(identical(other.bmr, bmr) || other.bmr == bmr)&&(identical(other.tdee, tdee) || other.tdee == tdee)&&(identical(other.recommendedCalories, recommendedCalories) || other.recommendedCalories == recommendedCalories)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(missingFields),bodyweightKg,age,bmr,tdee,recommendedCalories,calorieTarget,proteinG,carbsG,fatG);

@override
String toString() {
  return 'NutritionCalculationDto(missingFields: $missingFields, bodyweightKg: $bodyweightKg, age: $age, bmr: $bmr, tdee: $tdee, recommendedCalories: $recommendedCalories, calorieTarget: $calorieTarget, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class $NutritionCalculationDtoCopyWith<$Res>  {
  factory $NutritionCalculationDtoCopyWith(NutritionCalculationDto value, $Res Function(NutritionCalculationDto) _then) = _$NutritionCalculationDtoCopyWithImpl;
@useResult
$Res call({
 List<String> missingFields, double? bodyweightKg, int? age, int? bmr, int? tdee, int? recommendedCalories, int? calorieTarget, double? proteinG, double? carbsG, double? fatG
});




}
/// @nodoc
class _$NutritionCalculationDtoCopyWithImpl<$Res>
    implements $NutritionCalculationDtoCopyWith<$Res> {
  _$NutritionCalculationDtoCopyWithImpl(this._self, this._then);

  final NutritionCalculationDto _self;
  final $Res Function(NutritionCalculationDto) _then;

/// Create a copy of NutritionCalculationDto
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


/// Adds pattern-matching-related methods to [NutritionCalculationDto].
extension NutritionCalculationDtoPatterns on NutritionCalculationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionCalculationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionCalculationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionCalculationDto value)  $default,){
final _that = this;
switch (_that) {
case _NutritionCalculationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionCalculationDto value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionCalculationDto() when $default != null:
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
case _NutritionCalculationDto() when $default != null:
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
case _NutritionCalculationDto():
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
case _NutritionCalculationDto() when $default != null:
return $default(_that.missingFields,_that.bodyweightKg,_that.age,_that.bmr,_that.tdee,_that.recommendedCalories,_that.calorieTarget,_that.proteinG,_that.carbsG,_that.fatG);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionCalculationDto extends NutritionCalculationDto {
  const _NutritionCalculationDto({final  List<String> missingFields = const <String>[], this.bodyweightKg, this.age, this.bmr, this.tdee, this.recommendedCalories, this.calorieTarget, this.proteinG, this.carbsG, this.fatG}): _missingFields = missingFields,super._();
  factory _NutritionCalculationDto.fromJson(Map<String, dynamic> json) => _$NutritionCalculationDtoFromJson(json);

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

/// Create a copy of NutritionCalculationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionCalculationDtoCopyWith<_NutritionCalculationDto> get copyWith => __$NutritionCalculationDtoCopyWithImpl<_NutritionCalculationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionCalculationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionCalculationDto&&const DeepCollectionEquality().equals(other._missingFields, _missingFields)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg)&&(identical(other.age, age) || other.age == age)&&(identical(other.bmr, bmr) || other.bmr == bmr)&&(identical(other.tdee, tdee) || other.tdee == tdee)&&(identical(other.recommendedCalories, recommendedCalories) || other.recommendedCalories == recommendedCalories)&&(identical(other.calorieTarget, calorieTarget) || other.calorieTarget == calorieTarget)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_missingFields),bodyweightKg,age,bmr,tdee,recommendedCalories,calorieTarget,proteinG,carbsG,fatG);

@override
String toString() {
  return 'NutritionCalculationDto(missingFields: $missingFields, bodyweightKg: $bodyweightKg, age: $age, bmr: $bmr, tdee: $tdee, recommendedCalories: $recommendedCalories, calorieTarget: $calorieTarget, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class _$NutritionCalculationDtoCopyWith<$Res> implements $NutritionCalculationDtoCopyWith<$Res> {
  factory _$NutritionCalculationDtoCopyWith(_NutritionCalculationDto value, $Res Function(_NutritionCalculationDto) _then) = __$NutritionCalculationDtoCopyWithImpl;
@override @useResult
$Res call({
 List<String> missingFields, double? bodyweightKg, int? age, int? bmr, int? tdee, int? recommendedCalories, int? calorieTarget, double? proteinG, double? carbsG, double? fatG
});




}
/// @nodoc
class __$NutritionCalculationDtoCopyWithImpl<$Res>
    implements _$NutritionCalculationDtoCopyWith<$Res> {
  __$NutritionCalculationDtoCopyWithImpl(this._self, this._then);

  final _NutritionCalculationDto _self;
  final $Res Function(_NutritionCalculationDto) _then;

/// Create a copy of NutritionCalculationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? missingFields = null,Object? bodyweightKg = freezed,Object? age = freezed,Object? bmr = freezed,Object? tdee = freezed,Object? recommendedCalories = freezed,Object? calorieTarget = freezed,Object? proteinG = freezed,Object? carbsG = freezed,Object? fatG = freezed,}) {
  return _then(_NutritionCalculationDto(
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
mixin _$NutritionDailyLogDto {

 String get date; int get calories; double get proteinG; double get carbsG; double get fatG; String? get notes;
/// Create a copy of NutritionDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionDailyLogDtoCopyWith<NutritionDailyLogDto> get copyWith => _$NutritionDailyLogDtoCopyWithImpl<NutritionDailyLogDto>(this as NutritionDailyLogDto, _$identity);

  /// Serializes this NutritionDailyLogDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionDailyLogDto&&(identical(other.date, date) || other.date == date)&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,calories,proteinG,carbsG,fatG,notes);

@override
String toString() {
  return 'NutritionDailyLogDto(date: $date, calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $NutritionDailyLogDtoCopyWith<$Res>  {
  factory $NutritionDailyLogDtoCopyWith(NutritionDailyLogDto value, $Res Function(NutritionDailyLogDto) _then) = _$NutritionDailyLogDtoCopyWithImpl;
@useResult
$Res call({
 String date, int calories, double proteinG, double carbsG, double fatG, String? notes
});




}
/// @nodoc
class _$NutritionDailyLogDtoCopyWithImpl<$Res>
    implements $NutritionDailyLogDtoCopyWith<$Res> {
  _$NutritionDailyLogDtoCopyWithImpl(this._self, this._then);

  final NutritionDailyLogDto _self;
  final $Res Function(NutritionDailyLogDto) _then;

/// Create a copy of NutritionDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? calories = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionDailyLogDto].
extension NutritionDailyLogDtoPatterns on NutritionDailyLogDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionDailyLogDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionDailyLogDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionDailyLogDto value)  $default,){
final _that = this;
switch (_that) {
case _NutritionDailyLogDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionDailyLogDto value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionDailyLogDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int calories,  double proteinG,  double carbsG,  double fatG,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionDailyLogDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int calories,  double proteinG,  double carbsG,  double fatG,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _NutritionDailyLogDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int calories,  double proteinG,  double carbsG,  double fatG,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _NutritionDailyLogDto() when $default != null:
return $default(_that.date,_that.calories,_that.proteinG,_that.carbsG,_that.fatG,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionDailyLogDto extends NutritionDailyLogDto {
  const _NutritionDailyLogDto({required this.date, required this.calories, required this.proteinG, required this.carbsG, required this.fatG, this.notes}): super._();
  factory _NutritionDailyLogDto.fromJson(Map<String, dynamic> json) => _$NutritionDailyLogDtoFromJson(json);

@override final  String date;
@override final  int calories;
@override final  double proteinG;
@override final  double carbsG;
@override final  double fatG;
@override final  String? notes;

/// Create a copy of NutritionDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionDailyLogDtoCopyWith<_NutritionDailyLogDto> get copyWith => __$NutritionDailyLogDtoCopyWithImpl<_NutritionDailyLogDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionDailyLogDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionDailyLogDto&&(identical(other.date, date) || other.date == date)&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,calories,proteinG,carbsG,fatG,notes);

@override
String toString() {
  return 'NutritionDailyLogDto(date: $date, calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$NutritionDailyLogDtoCopyWith<$Res> implements $NutritionDailyLogDtoCopyWith<$Res> {
  factory _$NutritionDailyLogDtoCopyWith(_NutritionDailyLogDto value, $Res Function(_NutritionDailyLogDto) _then) = __$NutritionDailyLogDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, int calories, double proteinG, double carbsG, double fatG, String? notes
});




}
/// @nodoc
class __$NutritionDailyLogDtoCopyWithImpl<$Res>
    implements _$NutritionDailyLogDtoCopyWith<$Res> {
  __$NutritionDailyLogDtoCopyWithImpl(this._self, this._then);

  final _NutritionDailyLogDto _self;
  final $Res Function(_NutritionDailyLogDto) _then;

/// Create a copy of NutritionDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? calories = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? notes = freezed,}) {
  return _then(_NutritionDailyLogDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
