// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_pr.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExercisePr {

 String get exerciseTemplateId; String get exerciseName; double get currentWeight; int get reps; DateTime get achievedAt;
/// Create a copy of ExercisePr
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExercisePrCopyWith<ExercisePr> get copyWith => _$ExercisePrCopyWithImpl<ExercisePr>(this as ExercisePr, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExercisePr&&(identical(other.exerciseTemplateId, exerciseTemplateId) || other.exerciseTemplateId == exerciseTemplateId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.currentWeight, currentWeight) || other.currentWeight == currentWeight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseTemplateId,exerciseName,currentWeight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePr(exerciseTemplateId: $exerciseTemplateId, exerciseName: $exerciseName, currentWeight: $currentWeight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class $ExercisePrCopyWith<$Res>  {
  factory $ExercisePrCopyWith(ExercisePr value, $Res Function(ExercisePr) _then) = _$ExercisePrCopyWithImpl;
@useResult
$Res call({
 String exerciseTemplateId, String exerciseName, double currentWeight, int reps, DateTime achievedAt
});




}
/// @nodoc
class _$ExercisePrCopyWithImpl<$Res>
    implements $ExercisePrCopyWith<$Res> {
  _$ExercisePrCopyWithImpl(this._self, this._then);

  final ExercisePr _self;
  final $Res Function(ExercisePr) _then;

/// Create a copy of ExercisePr
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseTemplateId = null,Object? exerciseName = null,Object? currentWeight = null,Object? reps = null,Object? achievedAt = null,}) {
  return _then(_self.copyWith(
exerciseTemplateId: null == exerciseTemplateId ? _self.exerciseTemplateId : exerciseTemplateId // ignore: cast_nullable_to_non_nullable
as String,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,currentWeight: null == currentWeight ? _self.currentWeight : currentWeight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ExercisePr].
extension ExercisePrPatterns on ExercisePr {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExercisePr value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExercisePr() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExercisePr value)  $default,){
final _that = this;
switch (_that) {
case _ExercisePr():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExercisePr value)?  $default,){
final _that = this;
switch (_that) {
case _ExercisePr() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseTemplateId,  String exerciseName,  double currentWeight,  int reps,  DateTime achievedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExercisePr() when $default != null:
return $default(_that.exerciseTemplateId,_that.exerciseName,_that.currentWeight,_that.reps,_that.achievedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseTemplateId,  String exerciseName,  double currentWeight,  int reps,  DateTime achievedAt)  $default,) {final _that = this;
switch (_that) {
case _ExercisePr():
return $default(_that.exerciseTemplateId,_that.exerciseName,_that.currentWeight,_that.reps,_that.achievedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseTemplateId,  String exerciseName,  double currentWeight,  int reps,  DateTime achievedAt)?  $default,) {final _that = this;
switch (_that) {
case _ExercisePr() when $default != null:
return $default(_that.exerciseTemplateId,_that.exerciseName,_that.currentWeight,_that.reps,_that.achievedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ExercisePr implements ExercisePr {
  const _ExercisePr({required this.exerciseTemplateId, required this.exerciseName, required this.currentWeight, required this.reps, required this.achievedAt});
  

@override final  String exerciseTemplateId;
@override final  String exerciseName;
@override final  double currentWeight;
@override final  int reps;
@override final  DateTime achievedAt;

/// Create a copy of ExercisePr
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExercisePrCopyWith<_ExercisePr> get copyWith => __$ExercisePrCopyWithImpl<_ExercisePr>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExercisePr&&(identical(other.exerciseTemplateId, exerciseTemplateId) || other.exerciseTemplateId == exerciseTemplateId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.currentWeight, currentWeight) || other.currentWeight == currentWeight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseTemplateId,exerciseName,currentWeight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePr(exerciseTemplateId: $exerciseTemplateId, exerciseName: $exerciseName, currentWeight: $currentWeight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class _$ExercisePrCopyWith<$Res> implements $ExercisePrCopyWith<$Res> {
  factory _$ExercisePrCopyWith(_ExercisePr value, $Res Function(_ExercisePr) _then) = __$ExercisePrCopyWithImpl;
@override @useResult
$Res call({
 String exerciseTemplateId, String exerciseName, double currentWeight, int reps, DateTime achievedAt
});




}
/// @nodoc
class __$ExercisePrCopyWithImpl<$Res>
    implements _$ExercisePrCopyWith<$Res> {
  __$ExercisePrCopyWithImpl(this._self, this._then);

  final _ExercisePr _self;
  final $Res Function(_ExercisePr) _then;

/// Create a copy of ExercisePr
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseTemplateId = null,Object? exerciseName = null,Object? currentWeight = null,Object? reps = null,Object? achievedAt = null,}) {
  return _then(_ExercisePr(
exerciseTemplateId: null == exerciseTemplateId ? _self.exerciseTemplateId : exerciseTemplateId // ignore: cast_nullable_to_non_nullable
as String,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,currentWeight: null == currentWeight ? _self.currentWeight : currentWeight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$ExercisePrPoint {

 double get weight; int get reps; DateTime get achievedAt;
/// Create a copy of ExercisePrPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExercisePrPointCopyWith<ExercisePrPoint> get copyWith => _$ExercisePrPointCopyWithImpl<ExercisePrPoint>(this as ExercisePrPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExercisePrPoint&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}


@override
int get hashCode => Object.hash(runtimeType,weight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePrPoint(weight: $weight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class $ExercisePrPointCopyWith<$Res>  {
  factory $ExercisePrPointCopyWith(ExercisePrPoint value, $Res Function(ExercisePrPoint) _then) = _$ExercisePrPointCopyWithImpl;
@useResult
$Res call({
 double weight, int reps, DateTime achievedAt
});




}
/// @nodoc
class _$ExercisePrPointCopyWithImpl<$Res>
    implements $ExercisePrPointCopyWith<$Res> {
  _$ExercisePrPointCopyWithImpl(this._self, this._then);

  final ExercisePrPoint _self;
  final $Res Function(ExercisePrPoint) _then;

/// Create a copy of ExercisePrPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weight = null,Object? reps = null,Object? achievedAt = null,}) {
  return _then(_self.copyWith(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ExercisePrPoint].
extension ExercisePrPointPatterns on ExercisePrPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExercisePrPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExercisePrPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExercisePrPoint value)  $default,){
final _that = this;
switch (_that) {
case _ExercisePrPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExercisePrPoint value)?  $default,){
final _that = this;
switch (_that) {
case _ExercisePrPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double weight,  int reps,  DateTime achievedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExercisePrPoint() when $default != null:
return $default(_that.weight,_that.reps,_that.achievedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double weight,  int reps,  DateTime achievedAt)  $default,) {final _that = this;
switch (_that) {
case _ExercisePrPoint():
return $default(_that.weight,_that.reps,_that.achievedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double weight,  int reps,  DateTime achievedAt)?  $default,) {final _that = this;
switch (_that) {
case _ExercisePrPoint() when $default != null:
return $default(_that.weight,_that.reps,_that.achievedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ExercisePrPoint implements ExercisePrPoint {
  const _ExercisePrPoint({required this.weight, required this.reps, required this.achievedAt});
  

@override final  double weight;
@override final  int reps;
@override final  DateTime achievedAt;

/// Create a copy of ExercisePrPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExercisePrPointCopyWith<_ExercisePrPoint> get copyWith => __$ExercisePrPointCopyWithImpl<_ExercisePrPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExercisePrPoint&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}


@override
int get hashCode => Object.hash(runtimeType,weight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePrPoint(weight: $weight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class _$ExercisePrPointCopyWith<$Res> implements $ExercisePrPointCopyWith<$Res> {
  factory _$ExercisePrPointCopyWith(_ExercisePrPoint value, $Res Function(_ExercisePrPoint) _then) = __$ExercisePrPointCopyWithImpl;
@override @useResult
$Res call({
 double weight, int reps, DateTime achievedAt
});




}
/// @nodoc
class __$ExercisePrPointCopyWithImpl<$Res>
    implements _$ExercisePrPointCopyWith<$Res> {
  __$ExercisePrPointCopyWithImpl(this._self, this._then);

  final _ExercisePrPoint _self;
  final $Res Function(_ExercisePrPoint) _then;

/// Create a copy of ExercisePrPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weight = null,Object? reps = null,Object? achievedAt = null,}) {
  return _then(_ExercisePrPoint(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
