// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_workout_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyWorkoutDto {

 String get id; int get weekNumber; String get name; String get startDate; String get endDate; String get planId; int get totalDays; int get completedDays; bool get hasWarning; bool get isCompleted;
/// Create a copy of WeeklyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyWorkoutDtoCopyWith<WeeklyWorkoutDto> get copyWith => _$WeeklyWorkoutDtoCopyWithImpl<WeeklyWorkoutDto>(this as WeeklyWorkoutDto, _$identity);

  /// Serializes this WeeklyWorkoutDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyWorkoutDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.hasWarning, hasWarning) || other.hasWarning == hasWarning)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekNumber,name,startDate,endDate,planId,totalDays,completedDays,hasWarning,isCompleted);

@override
String toString() {
  return 'WeeklyWorkoutDto(id: $id, weekNumber: $weekNumber, name: $name, startDate: $startDate, endDate: $endDate, planId: $planId, totalDays: $totalDays, completedDays: $completedDays, hasWarning: $hasWarning, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $WeeklyWorkoutDtoCopyWith<$Res>  {
  factory $WeeklyWorkoutDtoCopyWith(WeeklyWorkoutDto value, $Res Function(WeeklyWorkoutDto) _then) = _$WeeklyWorkoutDtoCopyWithImpl;
@useResult
$Res call({
 String id, int weekNumber, String name, String startDate, String endDate, String planId, int totalDays, int completedDays, bool hasWarning, bool isCompleted
});




}
/// @nodoc
class _$WeeklyWorkoutDtoCopyWithImpl<$Res>
    implements $WeeklyWorkoutDtoCopyWith<$Res> {
  _$WeeklyWorkoutDtoCopyWithImpl(this._self, this._then);

  final WeeklyWorkoutDto _self;
  final $Res Function(WeeklyWorkoutDto) _then;

/// Create a copy of WeeklyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weekNumber = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? planId = null,Object? totalDays = null,Object? completedDays = null,Object? hasWarning = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,hasWarning: null == hasWarning ? _self.hasWarning : hasWarning // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyWorkoutDto].
extension WeeklyWorkoutDtoPatterns on WeeklyWorkoutDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyWorkoutDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyWorkoutDto value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyWorkoutDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyWorkoutDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int weekNumber,  String name,  String startDate,  String endDate,  String planId,  int totalDays,  int completedDays,  bool hasWarning,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyWorkoutDto() when $default != null:
return $default(_that.id,_that.weekNumber,_that.name,_that.startDate,_that.endDate,_that.planId,_that.totalDays,_that.completedDays,_that.hasWarning,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int weekNumber,  String name,  String startDate,  String endDate,  String planId,  int totalDays,  int completedDays,  bool hasWarning,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _WeeklyWorkoutDto():
return $default(_that.id,_that.weekNumber,_that.name,_that.startDate,_that.endDate,_that.planId,_that.totalDays,_that.completedDays,_that.hasWarning,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int weekNumber,  String name,  String startDate,  String endDate,  String planId,  int totalDays,  int completedDays,  bool hasWarning,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyWorkoutDto() when $default != null:
return $default(_that.id,_that.weekNumber,_that.name,_that.startDate,_that.endDate,_that.planId,_that.totalDays,_that.completedDays,_that.hasWarning,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyWorkoutDto extends WeeklyWorkoutDto {
  const _WeeklyWorkoutDto({required this.id, required this.weekNumber, required this.name, required this.startDate, required this.endDate, required this.planId, required this.totalDays, required this.completedDays, required this.hasWarning, required this.isCompleted}): super._();
  factory _WeeklyWorkoutDto.fromJson(Map<String, dynamic> json) => _$WeeklyWorkoutDtoFromJson(json);

@override final  String id;
@override final  int weekNumber;
@override final  String name;
@override final  String startDate;
@override final  String endDate;
@override final  String planId;
@override final  int totalDays;
@override final  int completedDays;
@override final  bool hasWarning;
@override final  bool isCompleted;

/// Create a copy of WeeklyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyWorkoutDtoCopyWith<_WeeklyWorkoutDto> get copyWith => __$WeeklyWorkoutDtoCopyWithImpl<_WeeklyWorkoutDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyWorkoutDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyWorkoutDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.hasWarning, hasWarning) || other.hasWarning == hasWarning)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekNumber,name,startDate,endDate,planId,totalDays,completedDays,hasWarning,isCompleted);

@override
String toString() {
  return 'WeeklyWorkoutDto(id: $id, weekNumber: $weekNumber, name: $name, startDate: $startDate, endDate: $endDate, planId: $planId, totalDays: $totalDays, completedDays: $completedDays, hasWarning: $hasWarning, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$WeeklyWorkoutDtoCopyWith<$Res> implements $WeeklyWorkoutDtoCopyWith<$Res> {
  factory _$WeeklyWorkoutDtoCopyWith(_WeeklyWorkoutDto value, $Res Function(_WeeklyWorkoutDto) _then) = __$WeeklyWorkoutDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int weekNumber, String name, String startDate, String endDate, String planId, int totalDays, int completedDays, bool hasWarning, bool isCompleted
});




}
/// @nodoc
class __$WeeklyWorkoutDtoCopyWithImpl<$Res>
    implements _$WeeklyWorkoutDtoCopyWith<$Res> {
  __$WeeklyWorkoutDtoCopyWithImpl(this._self, this._then);

  final _WeeklyWorkoutDto _self;
  final $Res Function(_WeeklyWorkoutDto) _then;

/// Create a copy of WeeklyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weekNumber = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? planId = null,Object? totalDays = null,Object? completedDays = null,Object? hasWarning = null,Object? isCompleted = null,}) {
  return _then(_WeeklyWorkoutDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,hasWarning: null == hasWarning ? _self.hasWarning : hasWarning // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
