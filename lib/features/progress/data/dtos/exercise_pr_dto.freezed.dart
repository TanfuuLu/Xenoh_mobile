// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_pr_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExercisePrDto {

 String get exerciseTemplateId; String get exerciseName; double get currentWeight; int get reps; DateTime get achievedAt;
/// Create a copy of ExercisePrDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExercisePrDtoCopyWith<ExercisePrDto> get copyWith => _$ExercisePrDtoCopyWithImpl<ExercisePrDto>(this as ExercisePrDto, _$identity);

  /// Serializes this ExercisePrDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExercisePrDto&&(identical(other.exerciseTemplateId, exerciseTemplateId) || other.exerciseTemplateId == exerciseTemplateId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.currentWeight, currentWeight) || other.currentWeight == currentWeight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseTemplateId,exerciseName,currentWeight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePrDto(exerciseTemplateId: $exerciseTemplateId, exerciseName: $exerciseName, currentWeight: $currentWeight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class $ExercisePrDtoCopyWith<$Res>  {
  factory $ExercisePrDtoCopyWith(ExercisePrDto value, $Res Function(ExercisePrDto) _then) = _$ExercisePrDtoCopyWithImpl;
@useResult
$Res call({
 String exerciseTemplateId, String exerciseName, double currentWeight, int reps, DateTime achievedAt
});




}
/// @nodoc
class _$ExercisePrDtoCopyWithImpl<$Res>
    implements $ExercisePrDtoCopyWith<$Res> {
  _$ExercisePrDtoCopyWithImpl(this._self, this._then);

  final ExercisePrDto _self;
  final $Res Function(ExercisePrDto) _then;

/// Create a copy of ExercisePrDto
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


/// Adds pattern-matching-related methods to [ExercisePrDto].
extension ExercisePrDtoPatterns on ExercisePrDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExercisePrDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExercisePrDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExercisePrDto value)  $default,){
final _that = this;
switch (_that) {
case _ExercisePrDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExercisePrDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExercisePrDto() when $default != null:
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
case _ExercisePrDto() when $default != null:
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
case _ExercisePrDto():
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
case _ExercisePrDto() when $default != null:
return $default(_that.exerciseTemplateId,_that.exerciseName,_that.currentWeight,_that.reps,_that.achievedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExercisePrDto extends ExercisePrDto {
  const _ExercisePrDto({required this.exerciseTemplateId, required this.exerciseName, required this.currentWeight, required this.reps, required this.achievedAt}): super._();
  factory _ExercisePrDto.fromJson(Map<String, dynamic> json) => _$ExercisePrDtoFromJson(json);

@override final  String exerciseTemplateId;
@override final  String exerciseName;
@override final  double currentWeight;
@override final  int reps;
@override final  DateTime achievedAt;

/// Create a copy of ExercisePrDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExercisePrDtoCopyWith<_ExercisePrDto> get copyWith => __$ExercisePrDtoCopyWithImpl<_ExercisePrDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExercisePrDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExercisePrDto&&(identical(other.exerciseTemplateId, exerciseTemplateId) || other.exerciseTemplateId == exerciseTemplateId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.currentWeight, currentWeight) || other.currentWeight == currentWeight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseTemplateId,exerciseName,currentWeight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePrDto(exerciseTemplateId: $exerciseTemplateId, exerciseName: $exerciseName, currentWeight: $currentWeight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class _$ExercisePrDtoCopyWith<$Res> implements $ExercisePrDtoCopyWith<$Res> {
  factory _$ExercisePrDtoCopyWith(_ExercisePrDto value, $Res Function(_ExercisePrDto) _then) = __$ExercisePrDtoCopyWithImpl;
@override @useResult
$Res call({
 String exerciseTemplateId, String exerciseName, double currentWeight, int reps, DateTime achievedAt
});




}
/// @nodoc
class __$ExercisePrDtoCopyWithImpl<$Res>
    implements _$ExercisePrDtoCopyWith<$Res> {
  __$ExercisePrDtoCopyWithImpl(this._self, this._then);

  final _ExercisePrDto _self;
  final $Res Function(_ExercisePrDto) _then;

/// Create a copy of ExercisePrDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseTemplateId = null,Object? exerciseName = null,Object? currentWeight = null,Object? reps = null,Object? achievedAt = null,}) {
  return _then(_ExercisePrDto(
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
mixin _$ExercisePrPointDto {

 double get weight; int get reps; DateTime get achievedAt;
/// Create a copy of ExercisePrPointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExercisePrPointDtoCopyWith<ExercisePrPointDto> get copyWith => _$ExercisePrPointDtoCopyWithImpl<ExercisePrPointDto>(this as ExercisePrPointDto, _$identity);

  /// Serializes this ExercisePrPointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExercisePrPointDto&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePrPointDto(weight: $weight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class $ExercisePrPointDtoCopyWith<$Res>  {
  factory $ExercisePrPointDtoCopyWith(ExercisePrPointDto value, $Res Function(ExercisePrPointDto) _then) = _$ExercisePrPointDtoCopyWithImpl;
@useResult
$Res call({
 double weight, int reps, DateTime achievedAt
});




}
/// @nodoc
class _$ExercisePrPointDtoCopyWithImpl<$Res>
    implements $ExercisePrPointDtoCopyWith<$Res> {
  _$ExercisePrPointDtoCopyWithImpl(this._self, this._then);

  final ExercisePrPointDto _self;
  final $Res Function(ExercisePrPointDto) _then;

/// Create a copy of ExercisePrPointDto
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


/// Adds pattern-matching-related methods to [ExercisePrPointDto].
extension ExercisePrPointDtoPatterns on ExercisePrPointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExercisePrPointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExercisePrPointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExercisePrPointDto value)  $default,){
final _that = this;
switch (_that) {
case _ExercisePrPointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExercisePrPointDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExercisePrPointDto() when $default != null:
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
case _ExercisePrPointDto() when $default != null:
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
case _ExercisePrPointDto():
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
case _ExercisePrPointDto() when $default != null:
return $default(_that.weight,_that.reps,_that.achievedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExercisePrPointDto extends ExercisePrPointDto {
  const _ExercisePrPointDto({required this.weight, required this.reps, required this.achievedAt}): super._();
  factory _ExercisePrPointDto.fromJson(Map<String, dynamic> json) => _$ExercisePrPointDtoFromJson(json);

@override final  double weight;
@override final  int reps;
@override final  DateTime achievedAt;

/// Create a copy of ExercisePrPointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExercisePrPointDtoCopyWith<_ExercisePrPointDto> get copyWith => __$ExercisePrPointDtoCopyWithImpl<_ExercisePrPointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExercisePrPointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExercisePrPointDto&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weight,reps,achievedAt);

@override
String toString() {
  return 'ExercisePrPointDto(weight: $weight, reps: $reps, achievedAt: $achievedAt)';
}


}

/// @nodoc
abstract mixin class _$ExercisePrPointDtoCopyWith<$Res> implements $ExercisePrPointDtoCopyWith<$Res> {
  factory _$ExercisePrPointDtoCopyWith(_ExercisePrPointDto value, $Res Function(_ExercisePrPointDto) _then) = __$ExercisePrPointDtoCopyWithImpl;
@override @useResult
$Res call({
 double weight, int reps, DateTime achievedAt
});




}
/// @nodoc
class __$ExercisePrPointDtoCopyWithImpl<$Res>
    implements _$ExercisePrPointDtoCopyWith<$Res> {
  __$ExercisePrPointDtoCopyWithImpl(this._self, this._then);

  final _ExercisePrPointDto _self;
  final $Res Function(_ExercisePrPointDto) _then;

/// Create a copy of ExercisePrPointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weight = null,Object? reps = null,Object? achievedAt = null,}) {
  return _then(_ExercisePrPointDto(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
