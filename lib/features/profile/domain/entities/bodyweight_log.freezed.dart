// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bodyweight_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyweightLog {

 String get id; double get weight; DateTime get date;
/// Create a copy of BodyweightLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyweightLogCopyWith<BodyweightLog> get copyWith => _$BodyweightLogCopyWithImpl<BodyweightLog>(this as BodyweightLog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyweightLog&&(identical(other.id, id) || other.id == id)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,id,weight,date);

@override
String toString() {
  return 'BodyweightLog(id: $id, weight: $weight, date: $date)';
}


}

/// @nodoc
abstract mixin class $BodyweightLogCopyWith<$Res>  {
  factory $BodyweightLogCopyWith(BodyweightLog value, $Res Function(BodyweightLog) _then) = _$BodyweightLogCopyWithImpl;
@useResult
$Res call({
 String id, double weight, DateTime date
});




}
/// @nodoc
class _$BodyweightLogCopyWithImpl<$Res>
    implements $BodyweightLogCopyWith<$Res> {
  _$BodyweightLogCopyWithImpl(this._self, this._then);

  final BodyweightLog _self;
  final $Res Function(BodyweightLog) _then;

/// Create a copy of BodyweightLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weight = null,Object? date = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyweightLog].
extension BodyweightLogPatterns on BodyweightLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyweightLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyweightLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyweightLog value)  $default,){
final _that = this;
switch (_that) {
case _BodyweightLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyweightLog value)?  $default,){
final _that = this;
switch (_that) {
case _BodyweightLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double weight,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyweightLog() when $default != null:
return $default(_that.id,_that.weight,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double weight,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _BodyweightLog():
return $default(_that.id,_that.weight,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double weight,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _BodyweightLog() when $default != null:
return $default(_that.id,_that.weight,_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _BodyweightLog implements BodyweightLog {
  const _BodyweightLog({required this.id, required this.weight, required this.date});
  

@override final  String id;
@override final  double weight;
@override final  DateTime date;

/// Create a copy of BodyweightLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyweightLogCopyWith<_BodyweightLog> get copyWith => __$BodyweightLogCopyWithImpl<_BodyweightLog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyweightLog&&(identical(other.id, id) || other.id == id)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,id,weight,date);

@override
String toString() {
  return 'BodyweightLog(id: $id, weight: $weight, date: $date)';
}


}

/// @nodoc
abstract mixin class _$BodyweightLogCopyWith<$Res> implements $BodyweightLogCopyWith<$Res> {
  factory _$BodyweightLogCopyWith(_BodyweightLog value, $Res Function(_BodyweightLog) _then) = __$BodyweightLogCopyWithImpl;
@override @useResult
$Res call({
 String id, double weight, DateTime date
});




}
/// @nodoc
class __$BodyweightLogCopyWithImpl<$Res>
    implements _$BodyweightLogCopyWith<$Res> {
  __$BodyweightLogCopyWithImpl(this._self, this._then);

  final _BodyweightLog _self;
  final $Res Function(_BodyweightLog) _then;

/// Create a copy of BodyweightLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weight = null,Object? date = null,}) {
  return _then(_BodyweightLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
