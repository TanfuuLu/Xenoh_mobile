// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_workout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyWorkout {

 String get id; DateTime get date; String get dayOfWeek; bool get isCompleted; String get weeklyWorkoutId; int get totalExercises; int get completedExercises; bool get hasWarning; String get status;
/// Create a copy of DailyWorkout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyWorkoutCopyWith<DailyWorkout> get copyWith => _$DailyWorkoutCopyWithImpl<DailyWorkout>(this as DailyWorkout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyWorkout&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.hasWarning, hasWarning) || other.hasWarning == hasWarning)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,dayOfWeek,isCompleted,weeklyWorkoutId,totalExercises,completedExercises,hasWarning,status);

@override
String toString() {
  return 'DailyWorkout(id: $id, date: $date, dayOfWeek: $dayOfWeek, isCompleted: $isCompleted, weeklyWorkoutId: $weeklyWorkoutId, totalExercises: $totalExercises, completedExercises: $completedExercises, hasWarning: $hasWarning, status: $status)';
}


}

/// @nodoc
abstract mixin class $DailyWorkoutCopyWith<$Res>  {
  factory $DailyWorkoutCopyWith(DailyWorkout value, $Res Function(DailyWorkout) _then) = _$DailyWorkoutCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String dayOfWeek, bool isCompleted, String weeklyWorkoutId, int totalExercises, int completedExercises, bool hasWarning, String status
});




}
/// @nodoc
class _$DailyWorkoutCopyWithImpl<$Res>
    implements $DailyWorkoutCopyWith<$Res> {
  _$DailyWorkoutCopyWithImpl(this._self, this._then);

  final DailyWorkout _self;
  final $Res Function(DailyWorkout) _then;

/// Create a copy of DailyWorkout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? dayOfWeek = null,Object? isCompleted = null,Object? weeklyWorkoutId = null,Object? totalExercises = null,Object? completedExercises = null,Object? hasWarning = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,weeklyWorkoutId: null == weeklyWorkoutId ? _self.weeklyWorkoutId : weeklyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,totalExercises: null == totalExercises ? _self.totalExercises : totalExercises // ignore: cast_nullable_to_non_nullable
as int,completedExercises: null == completedExercises ? _self.completedExercises : completedExercises // ignore: cast_nullable_to_non_nullable
as int,hasWarning: null == hasWarning ? _self.hasWarning : hasWarning // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyWorkout].
extension DailyWorkoutPatterns on DailyWorkout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyWorkout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyWorkout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyWorkout value)  $default,){
final _that = this;
switch (_that) {
case _DailyWorkout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyWorkout value)?  $default,){
final _that = this;
switch (_that) {
case _DailyWorkout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  String dayOfWeek,  bool isCompleted,  String weeklyWorkoutId,  int totalExercises,  int completedExercises,  bool hasWarning,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyWorkout() when $default != null:
return $default(_that.id,_that.date,_that.dayOfWeek,_that.isCompleted,_that.weeklyWorkoutId,_that.totalExercises,_that.completedExercises,_that.hasWarning,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  String dayOfWeek,  bool isCompleted,  String weeklyWorkoutId,  int totalExercises,  int completedExercises,  bool hasWarning,  String status)  $default,) {final _that = this;
switch (_that) {
case _DailyWorkout():
return $default(_that.id,_that.date,_that.dayOfWeek,_that.isCompleted,_that.weeklyWorkoutId,_that.totalExercises,_that.completedExercises,_that.hasWarning,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  String dayOfWeek,  bool isCompleted,  String weeklyWorkoutId,  int totalExercises,  int completedExercises,  bool hasWarning,  String status)?  $default,) {final _that = this;
switch (_that) {
case _DailyWorkout() when $default != null:
return $default(_that.id,_that.date,_that.dayOfWeek,_that.isCompleted,_that.weeklyWorkoutId,_that.totalExercises,_that.completedExercises,_that.hasWarning,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _DailyWorkout extends DailyWorkout {
  const _DailyWorkout({required this.id, required this.date, required this.dayOfWeek, required this.isCompleted, required this.weeklyWorkoutId, required this.totalExercises, required this.completedExercises, required this.hasWarning, required this.status}): super._();
  

@override final  String id;
@override final  DateTime date;
@override final  String dayOfWeek;
@override final  bool isCompleted;
@override final  String weeklyWorkoutId;
@override final  int totalExercises;
@override final  int completedExercises;
@override final  bool hasWarning;
@override final  String status;

/// Create a copy of DailyWorkout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyWorkoutCopyWith<_DailyWorkout> get copyWith => __$DailyWorkoutCopyWithImpl<_DailyWorkout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyWorkout&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.hasWarning, hasWarning) || other.hasWarning == hasWarning)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,dayOfWeek,isCompleted,weeklyWorkoutId,totalExercises,completedExercises,hasWarning,status);

@override
String toString() {
  return 'DailyWorkout(id: $id, date: $date, dayOfWeek: $dayOfWeek, isCompleted: $isCompleted, weeklyWorkoutId: $weeklyWorkoutId, totalExercises: $totalExercises, completedExercises: $completedExercises, hasWarning: $hasWarning, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DailyWorkoutCopyWith<$Res> implements $DailyWorkoutCopyWith<$Res> {
  factory _$DailyWorkoutCopyWith(_DailyWorkout value, $Res Function(_DailyWorkout) _then) = __$DailyWorkoutCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String dayOfWeek, bool isCompleted, String weeklyWorkoutId, int totalExercises, int completedExercises, bool hasWarning, String status
});




}
/// @nodoc
class __$DailyWorkoutCopyWithImpl<$Res>
    implements _$DailyWorkoutCopyWith<$Res> {
  __$DailyWorkoutCopyWithImpl(this._self, this._then);

  final _DailyWorkout _self;
  final $Res Function(_DailyWorkout) _then;

/// Create a copy of DailyWorkout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? dayOfWeek = null,Object? isCompleted = null,Object? weeklyWorkoutId = null,Object? totalExercises = null,Object? completedExercises = null,Object? hasWarning = null,Object? status = null,}) {
  return _then(_DailyWorkout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,weeklyWorkoutId: null == weeklyWorkoutId ? _self.weeklyWorkoutId : weeklyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,totalExercises: null == totalExercises ? _self.totalExercises : totalExercises // ignore: cast_nullable_to_non_nullable
as int,completedExercises: null == completedExercises ? _self.completedExercises : completedExercises // ignore: cast_nullable_to_non_nullable
as int,hasWarning: null == hasWarning ? _self.hasWarning : hasWarning // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
