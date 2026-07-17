// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_workout_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CopyDailyWorkoutDto {

 String get targetDailyWorkoutId; int get exercisesCopied;
/// Create a copy of CopyDailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CopyDailyWorkoutDtoCopyWith<CopyDailyWorkoutDto> get copyWith => _$CopyDailyWorkoutDtoCopyWithImpl<CopyDailyWorkoutDto>(this as CopyDailyWorkoutDto, _$identity);

  /// Serializes this CopyDailyWorkoutDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CopyDailyWorkoutDto&&(identical(other.targetDailyWorkoutId, targetDailyWorkoutId) || other.targetDailyWorkoutId == targetDailyWorkoutId)&&(identical(other.exercisesCopied, exercisesCopied) || other.exercisesCopied == exercisesCopied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetDailyWorkoutId,exercisesCopied);

@override
String toString() {
  return 'CopyDailyWorkoutDto(targetDailyWorkoutId: $targetDailyWorkoutId, exercisesCopied: $exercisesCopied)';
}


}

/// @nodoc
abstract mixin class $CopyDailyWorkoutDtoCopyWith<$Res>  {
  factory $CopyDailyWorkoutDtoCopyWith(CopyDailyWorkoutDto value, $Res Function(CopyDailyWorkoutDto) _then) = _$CopyDailyWorkoutDtoCopyWithImpl;
@useResult
$Res call({
 String targetDailyWorkoutId, int exercisesCopied
});




}
/// @nodoc
class _$CopyDailyWorkoutDtoCopyWithImpl<$Res>
    implements $CopyDailyWorkoutDtoCopyWith<$Res> {
  _$CopyDailyWorkoutDtoCopyWithImpl(this._self, this._then);

  final CopyDailyWorkoutDto _self;
  final $Res Function(CopyDailyWorkoutDto) _then;

/// Create a copy of CopyDailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetDailyWorkoutId = null,Object? exercisesCopied = null,}) {
  return _then(_self.copyWith(
targetDailyWorkoutId: null == targetDailyWorkoutId ? _self.targetDailyWorkoutId : targetDailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,exercisesCopied: null == exercisesCopied ? _self.exercisesCopied : exercisesCopied // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CopyDailyWorkoutDto].
extension CopyDailyWorkoutDtoPatterns on CopyDailyWorkoutDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CopyDailyWorkoutDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CopyDailyWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CopyDailyWorkoutDto value)  $default,){
final _that = this;
switch (_that) {
case _CopyDailyWorkoutDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CopyDailyWorkoutDto value)?  $default,){
final _that = this;
switch (_that) {
case _CopyDailyWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String targetDailyWorkoutId,  int exercisesCopied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CopyDailyWorkoutDto() when $default != null:
return $default(_that.targetDailyWorkoutId,_that.exercisesCopied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String targetDailyWorkoutId,  int exercisesCopied)  $default,) {final _that = this;
switch (_that) {
case _CopyDailyWorkoutDto():
return $default(_that.targetDailyWorkoutId,_that.exercisesCopied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String targetDailyWorkoutId,  int exercisesCopied)?  $default,) {final _that = this;
switch (_that) {
case _CopyDailyWorkoutDto() when $default != null:
return $default(_that.targetDailyWorkoutId,_that.exercisesCopied);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CopyDailyWorkoutDto implements CopyDailyWorkoutDto {
  const _CopyDailyWorkoutDto({required this.targetDailyWorkoutId, required this.exercisesCopied});
  factory _CopyDailyWorkoutDto.fromJson(Map<String, dynamic> json) => _$CopyDailyWorkoutDtoFromJson(json);

@override final  String targetDailyWorkoutId;
@override final  int exercisesCopied;

/// Create a copy of CopyDailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CopyDailyWorkoutDtoCopyWith<_CopyDailyWorkoutDto> get copyWith => __$CopyDailyWorkoutDtoCopyWithImpl<_CopyDailyWorkoutDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CopyDailyWorkoutDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CopyDailyWorkoutDto&&(identical(other.targetDailyWorkoutId, targetDailyWorkoutId) || other.targetDailyWorkoutId == targetDailyWorkoutId)&&(identical(other.exercisesCopied, exercisesCopied) || other.exercisesCopied == exercisesCopied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetDailyWorkoutId,exercisesCopied);

@override
String toString() {
  return 'CopyDailyWorkoutDto(targetDailyWorkoutId: $targetDailyWorkoutId, exercisesCopied: $exercisesCopied)';
}


}

/// @nodoc
abstract mixin class _$CopyDailyWorkoutDtoCopyWith<$Res> implements $CopyDailyWorkoutDtoCopyWith<$Res> {
  factory _$CopyDailyWorkoutDtoCopyWith(_CopyDailyWorkoutDto value, $Res Function(_CopyDailyWorkoutDto) _then) = __$CopyDailyWorkoutDtoCopyWithImpl;
@override @useResult
$Res call({
 String targetDailyWorkoutId, int exercisesCopied
});




}
/// @nodoc
class __$CopyDailyWorkoutDtoCopyWithImpl<$Res>
    implements _$CopyDailyWorkoutDtoCopyWith<$Res> {
  __$CopyDailyWorkoutDtoCopyWithImpl(this._self, this._then);

  final _CopyDailyWorkoutDto _self;
  final $Res Function(_CopyDailyWorkoutDto) _then;

/// Create a copy of CopyDailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetDailyWorkoutId = null,Object? exercisesCopied = null,}) {
  return _then(_CopyDailyWorkoutDto(
targetDailyWorkoutId: null == targetDailyWorkoutId ? _self.targetDailyWorkoutId : targetDailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,exercisesCopied: null == exercisesCopied ? _self.exercisesCopied : exercisesCopied // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DailyWorkoutDto {

 String get id; String get date; String get dayOfWeek; bool get isCompleted; String get weeklyWorkoutId; int get totalExercises; int get completedExercises; bool get hasWarning; String get status;
/// Create a copy of DailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyWorkoutDtoCopyWith<DailyWorkoutDto> get copyWith => _$DailyWorkoutDtoCopyWithImpl<DailyWorkoutDto>(this as DailyWorkoutDto, _$identity);

  /// Serializes this DailyWorkoutDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyWorkoutDto&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.hasWarning, hasWarning) || other.hasWarning == hasWarning)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,dayOfWeek,isCompleted,weeklyWorkoutId,totalExercises,completedExercises,hasWarning,status);

@override
String toString() {
  return 'DailyWorkoutDto(id: $id, date: $date, dayOfWeek: $dayOfWeek, isCompleted: $isCompleted, weeklyWorkoutId: $weeklyWorkoutId, totalExercises: $totalExercises, completedExercises: $completedExercises, hasWarning: $hasWarning, status: $status)';
}


}

/// @nodoc
abstract mixin class $DailyWorkoutDtoCopyWith<$Res>  {
  factory $DailyWorkoutDtoCopyWith(DailyWorkoutDto value, $Res Function(DailyWorkoutDto) _then) = _$DailyWorkoutDtoCopyWithImpl;
@useResult
$Res call({
 String id, String date, String dayOfWeek, bool isCompleted, String weeklyWorkoutId, int totalExercises, int completedExercises, bool hasWarning, String status
});




}
/// @nodoc
class _$DailyWorkoutDtoCopyWithImpl<$Res>
    implements $DailyWorkoutDtoCopyWith<$Res> {
  _$DailyWorkoutDtoCopyWithImpl(this._self, this._then);

  final DailyWorkoutDto _self;
  final $Res Function(DailyWorkoutDto) _then;

/// Create a copy of DailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? dayOfWeek = null,Object? isCompleted = null,Object? weeklyWorkoutId = null,Object? totalExercises = null,Object? completedExercises = null,Object? hasWarning = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [DailyWorkoutDto].
extension DailyWorkoutDtoPatterns on DailyWorkoutDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyWorkoutDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyWorkoutDto value)  $default,){
final _that = this;
switch (_that) {
case _DailyWorkoutDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyWorkoutDto value)?  $default,){
final _that = this;
switch (_that) {
case _DailyWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String date,  String dayOfWeek,  bool isCompleted,  String weeklyWorkoutId,  int totalExercises,  int completedExercises,  bool hasWarning,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyWorkoutDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String date,  String dayOfWeek,  bool isCompleted,  String weeklyWorkoutId,  int totalExercises,  int completedExercises,  bool hasWarning,  String status)  $default,) {final _that = this;
switch (_that) {
case _DailyWorkoutDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String date,  String dayOfWeek,  bool isCompleted,  String weeklyWorkoutId,  int totalExercises,  int completedExercises,  bool hasWarning,  String status)?  $default,) {final _that = this;
switch (_that) {
case _DailyWorkoutDto() when $default != null:
return $default(_that.id,_that.date,_that.dayOfWeek,_that.isCompleted,_that.weeklyWorkoutId,_that.totalExercises,_that.completedExercises,_that.hasWarning,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyWorkoutDto extends DailyWorkoutDto {
  const _DailyWorkoutDto({required this.id, required this.date, required this.dayOfWeek, required this.isCompleted, required this.weeklyWorkoutId, required this.totalExercises, required this.completedExercises, required this.hasWarning, required this.status}): super._();
  factory _DailyWorkoutDto.fromJson(Map<String, dynamic> json) => _$DailyWorkoutDtoFromJson(json);

@override final  String id;
@override final  String date;
@override final  String dayOfWeek;
@override final  bool isCompleted;
@override final  String weeklyWorkoutId;
@override final  int totalExercises;
@override final  int completedExercises;
@override final  bool hasWarning;
@override final  String status;

/// Create a copy of DailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyWorkoutDtoCopyWith<_DailyWorkoutDto> get copyWith => __$DailyWorkoutDtoCopyWithImpl<_DailyWorkoutDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyWorkoutDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyWorkoutDto&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.weeklyWorkoutId, weeklyWorkoutId) || other.weeklyWorkoutId == weeklyWorkoutId)&&(identical(other.totalExercises, totalExercises) || other.totalExercises == totalExercises)&&(identical(other.completedExercises, completedExercises) || other.completedExercises == completedExercises)&&(identical(other.hasWarning, hasWarning) || other.hasWarning == hasWarning)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,dayOfWeek,isCompleted,weeklyWorkoutId,totalExercises,completedExercises,hasWarning,status);

@override
String toString() {
  return 'DailyWorkoutDto(id: $id, date: $date, dayOfWeek: $dayOfWeek, isCompleted: $isCompleted, weeklyWorkoutId: $weeklyWorkoutId, totalExercises: $totalExercises, completedExercises: $completedExercises, hasWarning: $hasWarning, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DailyWorkoutDtoCopyWith<$Res> implements $DailyWorkoutDtoCopyWith<$Res> {
  factory _$DailyWorkoutDtoCopyWith(_DailyWorkoutDto value, $Res Function(_DailyWorkoutDto) _then) = __$DailyWorkoutDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String date, String dayOfWeek, bool isCompleted, String weeklyWorkoutId, int totalExercises, int completedExercises, bool hasWarning, String status
});




}
/// @nodoc
class __$DailyWorkoutDtoCopyWithImpl<$Res>
    implements _$DailyWorkoutDtoCopyWith<$Res> {
  __$DailyWorkoutDtoCopyWithImpl(this._self, this._then);

  final _DailyWorkoutDto _self;
  final $Res Function(_DailyWorkoutDto) _then;

/// Create a copy of DailyWorkoutDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? dayOfWeek = null,Object? isCompleted = null,Object? weeklyWorkoutId = null,Object? totalExercises = null,Object? completedExercises = null,Object? hasWarning = null,Object? status = null,}) {
  return _then(_DailyWorkoutDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
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
