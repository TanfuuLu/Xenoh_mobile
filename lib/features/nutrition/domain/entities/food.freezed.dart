// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoodItem {

 String get id; String get nameVi; String get nameEn; double get caloriesPer100g; double get proteinPer100g; double get carbsPer100g; double get fatPer100g; List<FoodServing> get servings;
/// Create a copy of FoodItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodItemCopyWith<FoodItem> get copyWith => _$FoodItemCopyWithImpl<FoodItem>(this as FoodItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodItem&&(identical(other.id, id) || other.id == id)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.caloriesPer100g, caloriesPer100g) || other.caloriesPer100g == caloriesPer100g)&&(identical(other.proteinPer100g, proteinPer100g) || other.proteinPer100g == proteinPer100g)&&(identical(other.carbsPer100g, carbsPer100g) || other.carbsPer100g == carbsPer100g)&&(identical(other.fatPer100g, fatPer100g) || other.fatPer100g == fatPer100g)&&const DeepCollectionEquality().equals(other.servings, servings));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameVi,nameEn,caloriesPer100g,proteinPer100g,carbsPer100g,fatPer100g,const DeepCollectionEquality().hash(servings));

@override
String toString() {
  return 'FoodItem(id: $id, nameVi: $nameVi, nameEn: $nameEn, caloriesPer100g: $caloriesPer100g, proteinPer100g: $proteinPer100g, carbsPer100g: $carbsPer100g, fatPer100g: $fatPer100g, servings: $servings)';
}


}

/// @nodoc
abstract mixin class $FoodItemCopyWith<$Res>  {
  factory $FoodItemCopyWith(FoodItem value, $Res Function(FoodItem) _then) = _$FoodItemCopyWithImpl;
@useResult
$Res call({
 String id, String nameVi, String nameEn, double caloriesPer100g, double proteinPer100g, double carbsPer100g, double fatPer100g, List<FoodServing> servings
});




}
/// @nodoc
class _$FoodItemCopyWithImpl<$Res>
    implements $FoodItemCopyWith<$Res> {
  _$FoodItemCopyWithImpl(this._self, this._then);

  final FoodItem _self;
  final $Res Function(FoodItem) _then;

/// Create a copy of FoodItem
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
as List<FoodServing>,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodItem].
extension FoodItemPatterns on FoodItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodItem value)  $default,){
final _that = this;
switch (_that) {
case _FoodItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodItem value)?  $default,){
final _that = this;
switch (_that) {
case _FoodItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nameVi,  String nameEn,  double caloriesPer100g,  double proteinPer100g,  double carbsPer100g,  double fatPer100g,  List<FoodServing> servings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nameVi,  String nameEn,  double caloriesPer100g,  double proteinPer100g,  double carbsPer100g,  double fatPer100g,  List<FoodServing> servings)  $default,) {final _that = this;
switch (_that) {
case _FoodItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nameVi,  String nameEn,  double caloriesPer100g,  double proteinPer100g,  double carbsPer100g,  double fatPer100g,  List<FoodServing> servings)?  $default,) {final _that = this;
switch (_that) {
case _FoodItem() when $default != null:
return $default(_that.id,_that.nameVi,_that.nameEn,_that.caloriesPer100g,_that.proteinPer100g,_that.carbsPer100g,_that.fatPer100g,_that.servings);case _:
  return null;

}
}

}

/// @nodoc


class _FoodItem extends FoodItem {
  const _FoodItem({required this.id, required this.nameVi, required this.nameEn, required this.caloriesPer100g, required this.proteinPer100g, required this.carbsPer100g, required this.fatPer100g, final  List<FoodServing> servings = const <FoodServing>[]}): _servings = servings,super._();
  

@override final  String id;
@override final  String nameVi;
@override final  String nameEn;
@override final  double caloriesPer100g;
@override final  double proteinPer100g;
@override final  double carbsPer100g;
@override final  double fatPer100g;
 final  List<FoodServing> _servings;
@override@JsonKey() List<FoodServing> get servings {
  if (_servings is EqualUnmodifiableListView) return _servings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servings);
}


/// Create a copy of FoodItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodItemCopyWith<_FoodItem> get copyWith => __$FoodItemCopyWithImpl<_FoodItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodItem&&(identical(other.id, id) || other.id == id)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.caloriesPer100g, caloriesPer100g) || other.caloriesPer100g == caloriesPer100g)&&(identical(other.proteinPer100g, proteinPer100g) || other.proteinPer100g == proteinPer100g)&&(identical(other.carbsPer100g, carbsPer100g) || other.carbsPer100g == carbsPer100g)&&(identical(other.fatPer100g, fatPer100g) || other.fatPer100g == fatPer100g)&&const DeepCollectionEquality().equals(other._servings, _servings));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameVi,nameEn,caloriesPer100g,proteinPer100g,carbsPer100g,fatPer100g,const DeepCollectionEquality().hash(_servings));

@override
String toString() {
  return 'FoodItem(id: $id, nameVi: $nameVi, nameEn: $nameEn, caloriesPer100g: $caloriesPer100g, proteinPer100g: $proteinPer100g, carbsPer100g: $carbsPer100g, fatPer100g: $fatPer100g, servings: $servings)';
}


}

/// @nodoc
abstract mixin class _$FoodItemCopyWith<$Res> implements $FoodItemCopyWith<$Res> {
  factory _$FoodItemCopyWith(_FoodItem value, $Res Function(_FoodItem) _then) = __$FoodItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String nameVi, String nameEn, double caloriesPer100g, double proteinPer100g, double carbsPer100g, double fatPer100g, List<FoodServing> servings
});




}
/// @nodoc
class __$FoodItemCopyWithImpl<$Res>
    implements _$FoodItemCopyWith<$Res> {
  __$FoodItemCopyWithImpl(this._self, this._then);

  final _FoodItem _self;
  final $Res Function(_FoodItem) _then;

/// Create a copy of FoodItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameVi = null,Object? nameEn = null,Object? caloriesPer100g = null,Object? proteinPer100g = null,Object? carbsPer100g = null,Object? fatPer100g = null,Object? servings = null,}) {
  return _then(_FoodItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameVi: null == nameVi ? _self.nameVi : nameVi // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,caloriesPer100g: null == caloriesPer100g ? _self.caloriesPer100g : caloriesPer100g // ignore: cast_nullable_to_non_nullable
as double,proteinPer100g: null == proteinPer100g ? _self.proteinPer100g : proteinPer100g // ignore: cast_nullable_to_non_nullable
as double,carbsPer100g: null == carbsPer100g ? _self.carbsPer100g : carbsPer100g // ignore: cast_nullable_to_non_nullable
as double,fatPer100g: null == fatPer100g ? _self.fatPer100g : fatPer100g // ignore: cast_nullable_to_non_nullable
as double,servings: null == servings ? _self._servings : servings // ignore: cast_nullable_to_non_nullable
as List<FoodServing>,
  ));
}


}

/// @nodoc
mixin _$FoodServing {

 String get id; String get labelVi; double get grams; String? get labelEn;
/// Create a copy of FoodServing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodServingCopyWith<FoodServing> get copyWith => _$FoodServingCopyWithImpl<FoodServing>(this as FoodServing, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodServing&&(identical(other.id, id) || other.id == id)&&(identical(other.labelVi, labelVi) || other.labelVi == labelVi)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn));
}


@override
int get hashCode => Object.hash(runtimeType,id,labelVi,grams,labelEn);

@override
String toString() {
  return 'FoodServing(id: $id, labelVi: $labelVi, grams: $grams, labelEn: $labelEn)';
}


}

/// @nodoc
abstract mixin class $FoodServingCopyWith<$Res>  {
  factory $FoodServingCopyWith(FoodServing value, $Res Function(FoodServing) _then) = _$FoodServingCopyWithImpl;
@useResult
$Res call({
 String id, String labelVi, double grams, String? labelEn
});




}
/// @nodoc
class _$FoodServingCopyWithImpl<$Res>
    implements $FoodServingCopyWith<$Res> {
  _$FoodServingCopyWithImpl(this._self, this._then);

  final FoodServing _self;
  final $Res Function(FoodServing) _then;

/// Create a copy of FoodServing
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


/// Adds pattern-matching-related methods to [FoodServing].
extension FoodServingPatterns on FoodServing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodServing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodServing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodServing value)  $default,){
final _that = this;
switch (_that) {
case _FoodServing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodServing value)?  $default,){
final _that = this;
switch (_that) {
case _FoodServing() when $default != null:
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
case _FoodServing() when $default != null:
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
case _FoodServing():
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
case _FoodServing() when $default != null:
return $default(_that.id,_that.labelVi,_that.grams,_that.labelEn);case _:
  return null;

}
}

}

/// @nodoc


class _FoodServing extends FoodServing {
  const _FoodServing({required this.id, required this.labelVi, required this.grams, this.labelEn}): super._();
  

@override final  String id;
@override final  String labelVi;
@override final  double grams;
@override final  String? labelEn;

/// Create a copy of FoodServing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodServingCopyWith<_FoodServing> get copyWith => __$FoodServingCopyWithImpl<_FoodServing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodServing&&(identical(other.id, id) || other.id == id)&&(identical(other.labelVi, labelVi) || other.labelVi == labelVi)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn));
}


@override
int get hashCode => Object.hash(runtimeType,id,labelVi,grams,labelEn);

@override
String toString() {
  return 'FoodServing(id: $id, labelVi: $labelVi, grams: $grams, labelEn: $labelEn)';
}


}

/// @nodoc
abstract mixin class _$FoodServingCopyWith<$Res> implements $FoodServingCopyWith<$Res> {
  factory _$FoodServingCopyWith(_FoodServing value, $Res Function(_FoodServing) _then) = __$FoodServingCopyWithImpl;
@override @useResult
$Res call({
 String id, String labelVi, double grams, String? labelEn
});




}
/// @nodoc
class __$FoodServingCopyWithImpl<$Res>
    implements _$FoodServingCopyWith<$Res> {
  __$FoodServingCopyWithImpl(this._self, this._then);

  final _FoodServing _self;
  final $Res Function(_FoodServing) _then;

/// Create a copy of FoodServing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? labelVi = null,Object? grams = null,Object? labelEn = freezed,}) {
  return _then(_FoodServing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,labelVi: null == labelVi ? _self.labelVi : labelVi // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,labelEn: freezed == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
