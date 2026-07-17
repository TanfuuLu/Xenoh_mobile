// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bodyweight_log_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BodyweightLogDto {

 String get id; double get weight; String get date;
/// Create a copy of BodyweightLogDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyweightLogDtoCopyWith<BodyweightLogDto> get copyWith => _$BodyweightLogDtoCopyWithImpl<BodyweightLogDto>(this as BodyweightLogDto, _$identity);

  /// Serializes this BodyweightLogDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyweightLogDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weight,date);

@override
String toString() {
  return 'BodyweightLogDto(id: $id, weight: $weight, date: $date)';
}


}

/// @nodoc
abstract mixin class $BodyweightLogDtoCopyWith<$Res>  {
  factory $BodyweightLogDtoCopyWith(BodyweightLogDto value, $Res Function(BodyweightLogDto) _then) = _$BodyweightLogDtoCopyWithImpl;
@useResult
$Res call({
 String id, double weight, String date
});




}
/// @nodoc
class _$BodyweightLogDtoCopyWithImpl<$Res>
    implements $BodyweightLogDtoCopyWith<$Res> {
  _$BodyweightLogDtoCopyWithImpl(this._self, this._then);

  final BodyweightLogDto _self;
  final $Res Function(BodyweightLogDto) _then;

/// Create a copy of BodyweightLogDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weight = null,Object? date = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyweightLogDto].
extension BodyweightLogDtoPatterns on BodyweightLogDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyweightLogDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyweightLogDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyweightLogDto value)  $default,){
final _that = this;
switch (_that) {
case _BodyweightLogDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyweightLogDto value)?  $default,){
final _that = this;
switch (_that) {
case _BodyweightLogDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double weight,  String date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyweightLogDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double weight,  String date)  $default,) {final _that = this;
switch (_that) {
case _BodyweightLogDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double weight,  String date)?  $default,) {final _that = this;
switch (_that) {
case _BodyweightLogDto() when $default != null:
return $default(_that.id,_that.weight,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BodyweightLogDto extends BodyweightLogDto {
  const _BodyweightLogDto({required this.id, required this.weight, required this.date}): super._();
  factory _BodyweightLogDto.fromJson(Map<String, dynamic> json) => _$BodyweightLogDtoFromJson(json);

@override final  String id;
@override final  double weight;
@override final  String date;

/// Create a copy of BodyweightLogDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyweightLogDtoCopyWith<_BodyweightLogDto> get copyWith => __$BodyweightLogDtoCopyWithImpl<_BodyweightLogDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BodyweightLogDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyweightLogDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weight,date);

@override
String toString() {
  return 'BodyweightLogDto(id: $id, weight: $weight, date: $date)';
}


}

/// @nodoc
abstract mixin class _$BodyweightLogDtoCopyWith<$Res> implements $BodyweightLogDtoCopyWith<$Res> {
  factory _$BodyweightLogDtoCopyWith(_BodyweightLogDto value, $Res Function(_BodyweightLogDto) _then) = __$BodyweightLogDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, double weight, String date
});




}
/// @nodoc
class __$BodyweightLogDtoCopyWithImpl<$Res>
    implements _$BodyweightLogDtoCopyWith<$Res> {
  __$BodyweightLogDtoCopyWithImpl(this._self, this._then);

  final _BodyweightLogDto _self;
  final $Res Function(_BodyweightLogDto) _then;

/// Create a copy of BodyweightLogDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weight = null,Object? date = null,}) {
  return _then(_BodyweightLogDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
