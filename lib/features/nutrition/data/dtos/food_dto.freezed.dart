// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FoodItemDto {

 String get id; String get nameVi; String get nameEn; double get caloriesPer100g; double get proteinPer100g; double get carbsPer100g; double get fatPer100g; List<FoodServingDto> get servings;
/// Create a copy of FoodItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodItemDtoCopyWith<FoodItemDto> get copyWith => _$FoodItemDtoCopyWithImpl<FoodItemDto>(this as FoodItemDto, _$identity);

  /// Serializes this FoodItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.caloriesPer100g, caloriesPer100g) || other.caloriesPer100g == caloriesPer100g)&&(identical(other.proteinPer100g, proteinPer100g) || other.proteinPer100g == proteinPer100g)&&(identical(other.carbsPer100g, carbsPer100g) || other.carbsPer100g == carbsPer100g)&&(identical(other.fatPer100g, fatPer100g) || other.fatPer100g == fatPer100g)&&const DeepCollectionEquality().equals(other.servings, servings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameVi,nameEn,caloriesPer100g,proteinPer100g,carbsPer100g,fatPer100g,const DeepCollectionEquality().hash(servings));

@override
String toString() {
  return 'FoodItemDto(id: $id, nameVi: $nameVi, nameEn: $nameEn, caloriesPer100g: $caloriesPer100g, proteinPer100g: $proteinPer100g, carbsPer100g: $carbsPer100g, fatPer100g: $fatPer100g, servings: $servings)';
}


}

/// @nodoc
abstract mixin class $FoodItemDtoCopyWith<$Res>  {
  factory $FoodItemDtoCopyWith(FoodItemDto value, $Res Function(FoodItemDto) _then) = _$FoodItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String nameVi, String nameEn, double caloriesPer100g, double proteinPer100g, double carbsPer100g, double fatPer100g, List<FoodServingDto> servings
});




}
/// @nodoc
class _$FoodItemDtoCopyWithImpl<$Res>
    implements $FoodItemDtoCopyWith<$Res> {
  _$FoodItemDtoCopyWithImpl(this._self, this._then);

  final FoodItemDto _self;
  final $Res Function(FoodItemDto) _then;

/// Create a copy of FoodItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameVi = null,Object? nameEn = null,Object? caloriesPer100g = null,Object? proteinPer100g = null,Object? carbsPer100g = null,Object? fatPer100g = null,Object? servings = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameVi: null == nameVi ? _self.nameVi : nameVi // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,caloriesPer100g: null == caloriesPer100g ? _self.caloriesPer100g : caloriesPer100g // ignore: cast_nullable_to_non_nullable
as double,proteinPer100g: null == proteinPer100g ? _self.proteinPer100g : proteinPer100g // ignore: cast_nullable_to_non_nullable
as double,carbsPer100g: null == carbsPer100g ? _self.carbsPer100g : carbsPer100g // ignore: cast_nullable_to_non_nullable
as double,fatPer100g: null == fatPer100g ? _self.fatPer100g : fatPer100g // ignore: cast_nullable_to_non_nullable
as double,servings: null == servings ? _self.servings : servings // ignore: cast_nullable_to_non_nullable
as List<FoodServingDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodItemDto].
extension FoodItemDtoPatterns on FoodItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodItemDto value)  $default,){
final _that = this;
switch (_that) {
case _FoodItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _FoodItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nameVi,  String nameEn,  double caloriesPer100g,  double proteinPer100g,  double carbsPer100g,  double fatPer100g,  List<FoodServingDto> servings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodItemDto() when $default != null:
return $default(_that.id,_that.nameVi,_that.nameEn,_that.caloriesPer100g,_that.proteinPer100g,_that.carbsPer100g,_that.fatPer100g,_that.servings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nameVi,  String nameEn,  double caloriesPer100g,  double proteinPer100g,  double carbsPer100g,  double fatPer100g,  List<FoodServingDto> servings)  $default,) {final _that = this;
switch (_that) {
case _FoodItemDto():
return $default(_that.id,_that.nameVi,_that.nameEn,_that.caloriesPer100g,_that.proteinPer100g,_that.carbsPer100g,_that.fatPer100g,_that.servings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nameVi,  String nameEn,  double caloriesPer100g,  double proteinPer100g,  double carbsPer100g,  double fatPer100g,  List<FoodServingDto> servings)?  $default,) {final _that = this;
switch (_that) {
case _FoodItemDto() when $default != null:
return $default(_that.id,_that.nameVi,_that.nameEn,_that.caloriesPer100g,_that.proteinPer100g,_that.carbsPer100g,_that.fatPer100g,_that.servings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodItemDto extends FoodItemDto {
  const _FoodItemDto({required this.id, required this.nameVi, required this.nameEn, required this.caloriesPer100g, required this.proteinPer100g, required this.carbsPer100g, required this.fatPer100g, final  List<FoodServingDto> servings = const <FoodServingDto>[]}): _servings = servings,super._();
  factory _FoodItemDto.fromJson(Map<String, dynamic> json) => _$FoodItemDtoFromJson(json);

@override final  String id;
@override final  String nameVi;
@override final  String nameEn;
@override final  double caloriesPer100g;
@override final  double proteinPer100g;
@override final  double carbsPer100g;
@override final  double fatPer100g;
 final  List<FoodServingDto> _servings;
@override@JsonKey() List<FoodServingDto> get servings {
  if (_servings is EqualUnmodifiableListView) return _servings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servings);
}


/// Create a copy of FoodItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodItemDtoCopyWith<_FoodItemDto> get copyWith => __$FoodItemDtoCopyWithImpl<_FoodItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.caloriesPer100g, caloriesPer100g) || other.caloriesPer100g == caloriesPer100g)&&(identical(other.proteinPer100g, proteinPer100g) || other.proteinPer100g == proteinPer100g)&&(identical(other.carbsPer100g, carbsPer100g) || other.carbsPer100g == carbsPer100g)&&(identical(other.fatPer100g, fatPer100g) || other.fatPer100g == fatPer100g)&&const DeepCollectionEquality().equals(other._servings, _servings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameVi,nameEn,caloriesPer100g,proteinPer100g,carbsPer100g,fatPer100g,const DeepCollectionEquality().hash(_servings));

@override
String toString() {
  return 'FoodItemDto(id: $id, nameVi: $nameVi, nameEn: $nameEn, caloriesPer100g: $caloriesPer100g, proteinPer100g: $proteinPer100g, carbsPer100g: $carbsPer100g, fatPer100g: $fatPer100g, servings: $servings)';
}


}

/// @nodoc
abstract mixin class _$FoodItemDtoCopyWith<$Res> implements $FoodItemDtoCopyWith<$Res> {
  factory _$FoodItemDtoCopyWith(_FoodItemDto value, $Res Function(_FoodItemDto) _then) = __$FoodItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String nameVi, String nameEn, double caloriesPer100g, double proteinPer100g, double carbsPer100g, double fatPer100g, List<FoodServingDto> servings
});




}
/// @nodoc
class __$FoodItemDtoCopyWithImpl<$Res>
    implements _$FoodItemDtoCopyWith<$Res> {
  __$FoodItemDtoCopyWithImpl(this._self, this._then);

  final _FoodItemDto _self;
  final $Res Function(_FoodItemDto) _then;

/// Create a copy of FoodItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameVi = null,Object? nameEn = null,Object? caloriesPer100g = null,Object? proteinPer100g = null,Object? carbsPer100g = null,Object? fatPer100g = null,Object? servings = null,}) {
  return _then(_FoodItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameVi: null == nameVi ? _self.nameVi : nameVi // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,caloriesPer100g: null == caloriesPer100g ? _self.caloriesPer100g : caloriesPer100g // ignore: cast_nullable_to_non_nullable
as double,proteinPer100g: null == proteinPer100g ? _self.proteinPer100g : proteinPer100g // ignore: cast_nullable_to_non_nullable
as double,carbsPer100g: null == carbsPer100g ? _self.carbsPer100g : carbsPer100g // ignore: cast_nullable_to_non_nullable
as double,fatPer100g: null == fatPer100g ? _self.fatPer100g : fatPer100g // ignore: cast_nullable_to_non_nullable
as double,servings: null == servings ? _self._servings : servings // ignore: cast_nullable_to_non_nullable
as List<FoodServingDto>,
  ));
}


}


/// @nodoc
mixin _$FoodServingDto {

 String get id; String get labelVi; double get grams; String? get labelEn;
/// Create a copy of FoodServingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodServingDtoCopyWith<FoodServingDto> get copyWith => _$FoodServingDtoCopyWithImpl<FoodServingDto>(this as FoodServingDto, _$identity);

  /// Serializes this FoodServingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodServingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.labelVi, labelVi) || other.labelVi == labelVi)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,labelVi,grams,labelEn);

@override
String toString() {
  return 'FoodServingDto(id: $id, labelVi: $labelVi, grams: $grams, labelEn: $labelEn)';
}


}

/// @nodoc
abstract mixin class $FoodServingDtoCopyWith<$Res>  {
  factory $FoodServingDtoCopyWith(FoodServingDto value, $Res Function(FoodServingDto) _then) = _$FoodServingDtoCopyWithImpl;
@useResult
$Res call({
 String id, String labelVi, double grams, String? labelEn
});




}
/// @nodoc
class _$FoodServingDtoCopyWithImpl<$Res>
    implements $FoodServingDtoCopyWith<$Res> {
  _$FoodServingDtoCopyWithImpl(this._self, this._then);

  final FoodServingDto _self;
  final $Res Function(FoodServingDto) _then;

/// Create a copy of FoodServingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? labelVi = null,Object? grams = null,Object? labelEn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,labelVi: null == labelVi ? _self.labelVi : labelVi // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,labelEn: freezed == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodServingDto].
extension FoodServingDtoPatterns on FoodServingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodServingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodServingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodServingDto value)  $default,){
final _that = this;
switch (_that) {
case _FoodServingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodServingDto value)?  $default,){
final _that = this;
switch (_that) {
case _FoodServingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String labelVi,  double grams,  String? labelEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodServingDto() when $default != null:
return $default(_that.id,_that.labelVi,_that.grams,_that.labelEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String labelVi,  double grams,  String? labelEn)  $default,) {final _that = this;
switch (_that) {
case _FoodServingDto():
return $default(_that.id,_that.labelVi,_that.grams,_that.labelEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String labelVi,  double grams,  String? labelEn)?  $default,) {final _that = this;
switch (_that) {
case _FoodServingDto() when $default != null:
return $default(_that.id,_that.labelVi,_that.grams,_that.labelEn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodServingDto extends FoodServingDto {
  const _FoodServingDto({required this.id, required this.labelVi, required this.grams, this.labelEn}): super._();
  factory _FoodServingDto.fromJson(Map<String, dynamic> json) => _$FoodServingDtoFromJson(json);

@override final  String id;
@override final  String labelVi;
@override final  double grams;
@override final  String? labelEn;

/// Create a copy of FoodServingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodServingDtoCopyWith<_FoodServingDto> get copyWith => __$FoodServingDtoCopyWithImpl<_FoodServingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodServingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodServingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.labelVi, labelVi) || other.labelVi == labelVi)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,labelVi,grams,labelEn);

@override
String toString() {
  return 'FoodServingDto(id: $id, labelVi: $labelVi, grams: $grams, labelEn: $labelEn)';
}


}

/// @nodoc
abstract mixin class _$FoodServingDtoCopyWith<$Res> implements $FoodServingDtoCopyWith<$Res> {
  factory _$FoodServingDtoCopyWith(_FoodServingDto value, $Res Function(_FoodServingDto) _then) = __$FoodServingDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String labelVi, double grams, String? labelEn
});




}
/// @nodoc
class __$FoodServingDtoCopyWithImpl<$Res>
    implements _$FoodServingDtoCopyWith<$Res> {
  __$FoodServingDtoCopyWithImpl(this._self, this._then);

  final _FoodServingDto _self;
  final $Res Function(_FoodServingDto) _then;

/// Create a copy of FoodServingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? labelVi = null,Object? grams = null,Object? labelEn = freezed,}) {
  return _then(_FoodServingDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,labelVi: null == labelVi ? _self.labelVi : labelVi // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,labelEn: freezed == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
