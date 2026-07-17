// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoodLogItem {

 String get id; String get foodItemId; String get nameVi; String get nameEn; double get grams; int get computedCalories; double get computedProteinG; double get computedCarbsG; double get computedFatG; String? get servingLabelVi; String? get servingLabelEn; double? get servingCount;
/// Create a copy of FoodLogItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodLogItemCopyWith<FoodLogItem> get copyWith => _$FoodLogItemCopyWithImpl<FoodLogItem>(this as FoodLogItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodLogItem&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.computedCalories, computedCalories) || other.computedCalories == computedCalories)&&(identical(other.computedProteinG, computedProteinG) || other.computedProteinG == computedProteinG)&&(identical(other.computedCarbsG, computedCarbsG) || other.computedCarbsG == computedCarbsG)&&(identical(other.computedFatG, computedFatG) || other.computedFatG == computedFatG)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,grams,computedCalories,computedProteinG,computedCarbsG,computedFatG,servingLabelVi,servingLabelEn,servingCount);

@override
String toString() {
  return 'FoodLogItem(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, grams: $grams, computedCalories: $computedCalories, computedProteinG: $computedProteinG, computedCarbsG: $computedCarbsG, computedFatG: $computedFatG, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount)';
}


}

/// @nodoc
abstract mixin class $FoodLogItemCopyWith<$Res>  {
  factory $FoodLogItemCopyWith(FoodLogItem value, $Res Function(FoodLogItem) _then) = _$FoodLogItemCopyWithImpl;
@useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, double grams, int computedCalories, double computedProteinG, double computedCarbsG, double computedFatG, String? servingLabelVi, String? servingLabelEn, double? servingCount
});




}
/// @nodoc
class _$FoodLogItemCopyWithImpl<$Res>
    implements $FoodLogItemCopyWith<$Res> {
  _$FoodLogItemCopyWithImpl(this._self, this._then);

  final FoodLogItem _self;
  final $Res Function(FoodLogItem) _then;

/// Create a copy of FoodLogItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? foodItemId = null,Object? nameVi = null,Object? nameEn = null,Object? grams = null,Object? computedCalories = null,Object? computedProteinG = null,Object? computedCarbsG = null,Object? computedFatG = null,Object? servingLabelVi = freezed,Object? servingLabelEn = freezed,Object? servingCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,foodItemId: null == foodItemId ? _self.foodItemId : foodItemId // ignore: cast_nullable_to_non_nullable
as String,nameVi: null == nameVi ? _self.nameVi : nameVi // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,computedCalories: null == computedCalories ? _self.computedCalories : computedCalories // ignore: cast_nullable_to_non_nullable
as int,computedProteinG: null == computedProteinG ? _self.computedProteinG : computedProteinG // ignore: cast_nullable_to_non_nullable
as double,computedCarbsG: null == computedCarbsG ? _self.computedCarbsG : computedCarbsG // ignore: cast_nullable_to_non_nullable
as double,computedFatG: null == computedFatG ? _self.computedFatG : computedFatG // ignore: cast_nullable_to_non_nullable
as double,servingLabelVi: freezed == servingLabelVi ? _self.servingLabelVi : servingLabelVi // ignore: cast_nullable_to_non_nullable
as String?,servingLabelEn: freezed == servingLabelEn ? _self.servingLabelEn : servingLabelEn // ignore: cast_nullable_to_non_nullable
as String?,servingCount: freezed == servingCount ? _self.servingCount : servingCount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodLogItem].
extension FoodLogItemPatterns on FoodLogItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodLogItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodLogItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodLogItem value)  $default,){
final _that = this;
switch (_that) {
case _FoodLogItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodLogItem value)?  $default,){
final _that = this;
switch (_that) {
case _FoodLogItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String foodItemId,  String nameVi,  String nameEn,  double grams,  int computedCalories,  double computedProteinG,  double computedCarbsG,  double computedFatG,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodLogItem() when $default != null:
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.grams,_that.computedCalories,_that.computedProteinG,_that.computedCarbsG,_that.computedFatG,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String foodItemId,  String nameVi,  String nameEn,  double grams,  int computedCalories,  double computedProteinG,  double computedCarbsG,  double computedFatG,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount)  $default,) {final _that = this;
switch (_that) {
case _FoodLogItem():
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.grams,_that.computedCalories,_that.computedProteinG,_that.computedCarbsG,_that.computedFatG,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String foodItemId,  String nameVi,  String nameEn,  double grams,  int computedCalories,  double computedProteinG,  double computedCarbsG,  double computedFatG,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount)?  $default,) {final _that = this;
switch (_that) {
case _FoodLogItem() when $default != null:
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.grams,_that.computedCalories,_that.computedProteinG,_that.computedCarbsG,_that.computedFatG,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount);case _:
  return null;

}
}

}

/// @nodoc


class _FoodLogItem extends FoodLogItem {
  const _FoodLogItem({required this.id, required this.foodItemId, required this.nameVi, required this.nameEn, required this.grams, required this.computedCalories, required this.computedProteinG, required this.computedCarbsG, required this.computedFatG, this.servingLabelVi, this.servingLabelEn, this.servingCount}): super._();
  

@override final  String id;
@override final  String foodItemId;
@override final  String nameVi;
@override final  String nameEn;
@override final  double grams;
@override final  int computedCalories;
@override final  double computedProteinG;
@override final  double computedCarbsG;
@override final  double computedFatG;
@override final  String? servingLabelVi;
@override final  String? servingLabelEn;
@override final  double? servingCount;

/// Create a copy of FoodLogItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodLogItemCopyWith<_FoodLogItem> get copyWith => __$FoodLogItemCopyWithImpl<_FoodLogItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodLogItem&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.computedCalories, computedCalories) || other.computedCalories == computedCalories)&&(identical(other.computedProteinG, computedProteinG) || other.computedProteinG == computedProteinG)&&(identical(other.computedCarbsG, computedCarbsG) || other.computedCarbsG == computedCarbsG)&&(identical(other.computedFatG, computedFatG) || other.computedFatG == computedFatG)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,grams,computedCalories,computedProteinG,computedCarbsG,computedFatG,servingLabelVi,servingLabelEn,servingCount);

@override
String toString() {
  return 'FoodLogItem(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, grams: $grams, computedCalories: $computedCalories, computedProteinG: $computedProteinG, computedCarbsG: $computedCarbsG, computedFatG: $computedFatG, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount)';
}


}

/// @nodoc
abstract mixin class _$FoodLogItemCopyWith<$Res> implements $FoodLogItemCopyWith<$Res> {
  factory _$FoodLogItemCopyWith(_FoodLogItem value, $Res Function(_FoodLogItem) _then) = __$FoodLogItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, double grams, int computedCalories, double computedProteinG, double computedCarbsG, double computedFatG, String? servingLabelVi, String? servingLabelEn, double? servingCount
});




}
/// @nodoc
class __$FoodLogItemCopyWithImpl<$Res>
    implements _$FoodLogItemCopyWith<$Res> {
  __$FoodLogItemCopyWithImpl(this._self, this._then);

  final _FoodLogItem _self;
  final $Res Function(_FoodLogItem) _then;

/// Create a copy of FoodLogItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? foodItemId = null,Object? nameVi = null,Object? nameEn = null,Object? grams = null,Object? computedCalories = null,Object? computedProteinG = null,Object? computedCarbsG = null,Object? computedFatG = null,Object? servingLabelVi = freezed,Object? servingLabelEn = freezed,Object? servingCount = freezed,}) {
  return _then(_FoodLogItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,foodItemId: null == foodItemId ? _self.foodItemId : foodItemId // ignore: cast_nullable_to_non_nullable
as String,nameVi: null == nameVi ? _self.nameVi : nameVi // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,computedCalories: null == computedCalories ? _self.computedCalories : computedCalories // ignore: cast_nullable_to_non_nullable
as int,computedProteinG: null == computedProteinG ? _self.computedProteinG : computedProteinG // ignore: cast_nullable_to_non_nullable
as double,computedCarbsG: null == computedCarbsG ? _self.computedCarbsG : computedCarbsG // ignore: cast_nullable_to_non_nullable
as double,computedFatG: null == computedFatG ? _self.computedFatG : computedFatG // ignore: cast_nullable_to_non_nullable
as double,servingLabelVi: freezed == servingLabelVi ? _self.servingLabelVi : servingLabelVi // ignore: cast_nullable_to_non_nullable
as String?,servingLabelEn: freezed == servingLabelEn ? _self.servingLabelEn : servingLabelEn // ignore: cast_nullable_to_non_nullable
as String?,servingCount: freezed == servingCount ? _self.servingCount : servingCount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$FoodLogTotals {

 int get totalCalories; double get totalProteinG; double get totalCarbsG; double get totalFatG;
/// Create a copy of FoodLogTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodLogTotalsCopyWith<FoodLogTotals> get copyWith => _$FoodLogTotalsCopyWithImpl<FoodLogTotals>(this as FoodLogTotals, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodLogTotals&&(identical(other.totalCalories, totalCalories) || other.totalCalories == totalCalories)&&(identical(other.totalProteinG, totalProteinG) || other.totalProteinG == totalProteinG)&&(identical(other.totalCarbsG, totalCarbsG) || other.totalCarbsG == totalCarbsG)&&(identical(other.totalFatG, totalFatG) || other.totalFatG == totalFatG));
}


@override
int get hashCode => Object.hash(runtimeType,totalCalories,totalProteinG,totalCarbsG,totalFatG);

@override
String toString() {
  return 'FoodLogTotals(totalCalories: $totalCalories, totalProteinG: $totalProteinG, totalCarbsG: $totalCarbsG, totalFatG: $totalFatG)';
}


}

/// @nodoc
abstract mixin class $FoodLogTotalsCopyWith<$Res>  {
  factory $FoodLogTotalsCopyWith(FoodLogTotals value, $Res Function(FoodLogTotals) _then) = _$FoodLogTotalsCopyWithImpl;
@useResult
$Res call({
 int totalCalories, double totalProteinG, double totalCarbsG, double totalFatG
});




}
/// @nodoc
class _$FoodLogTotalsCopyWithImpl<$Res>
    implements $FoodLogTotalsCopyWith<$Res> {
  _$FoodLogTotalsCopyWithImpl(this._self, this._then);

  final FoodLogTotals _self;
  final $Res Function(FoodLogTotals) _then;

/// Create a copy of FoodLogTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCalories = null,Object? totalProteinG = null,Object? totalCarbsG = null,Object? totalFatG = null,}) {
  return _then(_self.copyWith(
totalCalories: null == totalCalories ? _self.totalCalories : totalCalories // ignore: cast_nullable_to_non_nullable
as int,totalProteinG: null == totalProteinG ? _self.totalProteinG : totalProteinG // ignore: cast_nullable_to_non_nullable
as double,totalCarbsG: null == totalCarbsG ? _self.totalCarbsG : totalCarbsG // ignore: cast_nullable_to_non_nullable
as double,totalFatG: null == totalFatG ? _self.totalFatG : totalFatG // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodLogTotals].
extension FoodLogTotalsPatterns on FoodLogTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodLogTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodLogTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodLogTotals value)  $default,){
final _that = this;
switch (_that) {
case _FoodLogTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodLogTotals value)?  $default,){
final _that = this;
switch (_that) {
case _FoodLogTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCalories,  double totalProteinG,  double totalCarbsG,  double totalFatG)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodLogTotals() when $default != null:
return $default(_that.totalCalories,_that.totalProteinG,_that.totalCarbsG,_that.totalFatG);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCalories,  double totalProteinG,  double totalCarbsG,  double totalFatG)  $default,) {final _that = this;
switch (_that) {
case _FoodLogTotals():
return $default(_that.totalCalories,_that.totalProteinG,_that.totalCarbsG,_that.totalFatG);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCalories,  double totalProteinG,  double totalCarbsG,  double totalFatG)?  $default,) {final _that = this;
switch (_that) {
case _FoodLogTotals() when $default != null:
return $default(_that.totalCalories,_that.totalProteinG,_that.totalCarbsG,_that.totalFatG);case _:
  return null;

}
}

}

/// @nodoc


class _FoodLogTotals implements FoodLogTotals {
  const _FoodLogTotals({required this.totalCalories, required this.totalProteinG, required this.totalCarbsG, required this.totalFatG});
  

@override final  int totalCalories;
@override final  double totalProteinG;
@override final  double totalCarbsG;
@override final  double totalFatG;

/// Create a copy of FoodLogTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodLogTotalsCopyWith<_FoodLogTotals> get copyWith => __$FoodLogTotalsCopyWithImpl<_FoodLogTotals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodLogTotals&&(identical(other.totalCalories, totalCalories) || other.totalCalories == totalCalories)&&(identical(other.totalProteinG, totalProteinG) || other.totalProteinG == totalProteinG)&&(identical(other.totalCarbsG, totalCarbsG) || other.totalCarbsG == totalCarbsG)&&(identical(other.totalFatG, totalFatG) || other.totalFatG == totalFatG));
}


@override
int get hashCode => Object.hash(runtimeType,totalCalories,totalProteinG,totalCarbsG,totalFatG);

@override
String toString() {
  return 'FoodLogTotals(totalCalories: $totalCalories, totalProteinG: $totalProteinG, totalCarbsG: $totalCarbsG, totalFatG: $totalFatG)';
}


}

/// @nodoc
abstract mixin class _$FoodLogTotalsCopyWith<$Res> implements $FoodLogTotalsCopyWith<$Res> {
  factory _$FoodLogTotalsCopyWith(_FoodLogTotals value, $Res Function(_FoodLogTotals) _then) = __$FoodLogTotalsCopyWithImpl;
@override @useResult
$Res call({
 int totalCalories, double totalProteinG, double totalCarbsG, double totalFatG
});




}
/// @nodoc
class __$FoodLogTotalsCopyWithImpl<$Res>
    implements _$FoodLogTotalsCopyWith<$Res> {
  __$FoodLogTotalsCopyWithImpl(this._self, this._then);

  final _FoodLogTotals _self;
  final $Res Function(_FoodLogTotals) _then;

/// Create a copy of FoodLogTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCalories = null,Object? totalProteinG = null,Object? totalCarbsG = null,Object? totalFatG = null,}) {
  return _then(_FoodLogTotals(
totalCalories: null == totalCalories ? _self.totalCalories : totalCalories // ignore: cast_nullable_to_non_nullable
as int,totalProteinG: null == totalProteinG ? _self.totalProteinG : totalProteinG // ignore: cast_nullable_to_non_nullable
as double,totalCarbsG: null == totalCarbsG ? _self.totalCarbsG : totalCarbsG // ignore: cast_nullable_to_non_nullable
as double,totalFatG: null == totalFatG ? _self.totalFatG : totalFatG // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$FoodLogsForDate {

 DateTime get date; FoodLogTotals get totals; List<FoodLogItem> get items;
/// Create a copy of FoodLogsForDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodLogsForDateCopyWith<FoodLogsForDate> get copyWith => _$FoodLogsForDateCopyWithImpl<FoodLogsForDate>(this as FoodLogsForDate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodLogsForDate&&(identical(other.date, date) || other.date == date)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,date,totals,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'FoodLogsForDate(date: $date, totals: $totals, items: $items)';
}


}

/// @nodoc
abstract mixin class $FoodLogsForDateCopyWith<$Res>  {
  factory $FoodLogsForDateCopyWith(FoodLogsForDate value, $Res Function(FoodLogsForDate) _then) = _$FoodLogsForDateCopyWithImpl;
@useResult
$Res call({
 DateTime date, FoodLogTotals totals, List<FoodLogItem> items
});


$FoodLogTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$FoodLogsForDateCopyWithImpl<$Res>
    implements $FoodLogsForDateCopyWith<$Res> {
  _$FoodLogsForDateCopyWithImpl(this._self, this._then);

  final FoodLogsForDate _self;
  final $Res Function(FoodLogsForDate) _then;

/// Create a copy of FoodLogsForDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? totals = null,Object? items = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FoodLogTotals,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FoodLogItem>,
  ));
}
/// Create a copy of FoodLogsForDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FoodLogTotalsCopyWith<$Res> get totals {
  
  return $FoodLogTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [FoodLogsForDate].
extension FoodLogsForDatePatterns on FoodLogsForDate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodLogsForDate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodLogsForDate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodLogsForDate value)  $default,){
final _that = this;
switch (_that) {
case _FoodLogsForDate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodLogsForDate value)?  $default,){
final _that = this;
switch (_that) {
case _FoodLogsForDate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  FoodLogTotals totals,  List<FoodLogItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodLogsForDate() when $default != null:
return $default(_that.date,_that.totals,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  FoodLogTotals totals,  List<FoodLogItem> items)  $default,) {final _that = this;
switch (_that) {
case _FoodLogsForDate():
return $default(_that.date,_that.totals,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  FoodLogTotals totals,  List<FoodLogItem> items)?  $default,) {final _that = this;
switch (_that) {
case _FoodLogsForDate() when $default != null:
return $default(_that.date,_that.totals,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _FoodLogsForDate implements FoodLogsForDate {
  const _FoodLogsForDate({required this.date, required this.totals, final  List<FoodLogItem> items = const <FoodLogItem>[]}): _items = items;
  

@override final  DateTime date;
@override final  FoodLogTotals totals;
 final  List<FoodLogItem> _items;
@override@JsonKey() List<FoodLogItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of FoodLogsForDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodLogsForDateCopyWith<_FoodLogsForDate> get copyWith => __$FoodLogsForDateCopyWithImpl<_FoodLogsForDate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodLogsForDate&&(identical(other.date, date) || other.date == date)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,date,totals,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'FoodLogsForDate(date: $date, totals: $totals, items: $items)';
}


}

/// @nodoc
abstract mixin class _$FoodLogsForDateCopyWith<$Res> implements $FoodLogsForDateCopyWith<$Res> {
  factory _$FoodLogsForDateCopyWith(_FoodLogsForDate value, $Res Function(_FoodLogsForDate) _then) = __$FoodLogsForDateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, FoodLogTotals totals, List<FoodLogItem> items
});


@override $FoodLogTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$FoodLogsForDateCopyWithImpl<$Res>
    implements _$FoodLogsForDateCopyWith<$Res> {
  __$FoodLogsForDateCopyWithImpl(this._self, this._then);

  final _FoodLogsForDate _self;
  final $Res Function(_FoodLogsForDate) _then;

/// Create a copy of FoodLogsForDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? totals = null,Object? items = null,}) {
  return _then(_FoodLogsForDate(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FoodLogTotals,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<FoodLogItem>,
  ));
}

/// Create a copy of FoodLogsForDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FoodLogTotalsCopyWith<$Res> get totals {
  
  return $FoodLogTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}

// dart format on
