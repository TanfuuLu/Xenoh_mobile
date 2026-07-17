// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MealPlanTotals {

 int get calories; double get proteinG; double get carbsG; double get fatG;
/// Create a copy of MealPlanTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<MealPlanTotals> get copyWith => _$MealPlanTotalsCopyWithImpl<MealPlanTotals>(this as MealPlanTotals, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanTotals&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}


@override
int get hashCode => Object.hash(runtimeType,calories,proteinG,carbsG,fatG);

@override
String toString() {
  return 'MealPlanTotals(calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class $MealPlanTotalsCopyWith<$Res>  {
  factory $MealPlanTotalsCopyWith(MealPlanTotals value, $Res Function(MealPlanTotals) _then) = _$MealPlanTotalsCopyWithImpl;
@useResult
$Res call({
 int calories, double proteinG, double carbsG, double fatG
});




}
/// @nodoc
class _$MealPlanTotalsCopyWithImpl<$Res>
    implements $MealPlanTotalsCopyWith<$Res> {
  _$MealPlanTotalsCopyWithImpl(this._self, this._then);

  final MealPlanTotals _self;
  final $Res Function(MealPlanTotals) _then;

/// Create a copy of MealPlanTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calories = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,}) {
  return _then(_self.copyWith(
calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MealPlanTotals].
extension MealPlanTotalsPatterns on MealPlanTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanTotals value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanTotals value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int calories,  double proteinG,  double carbsG,  double fatG)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealPlanTotals() when $default != null:
return $default(_that.calories,_that.proteinG,_that.carbsG,_that.fatG);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int calories,  double proteinG,  double carbsG,  double fatG)  $default,) {final _that = this;
switch (_that) {
case _MealPlanTotals():
return $default(_that.calories,_that.proteinG,_that.carbsG,_that.fatG);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int calories,  double proteinG,  double carbsG,  double fatG)?  $default,) {final _that = this;
switch (_that) {
case _MealPlanTotals() when $default != null:
return $default(_that.calories,_that.proteinG,_that.carbsG,_that.fatG);case _:
  return null;

}
}

}

/// @nodoc


class _MealPlanTotals implements MealPlanTotals {
  const _MealPlanTotals({required this.calories, required this.proteinG, required this.carbsG, required this.fatG});
  

@override final  int calories;
@override final  double proteinG;
@override final  double carbsG;
@override final  double fatG;

/// Create a copy of MealPlanTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanTotalsCopyWith<_MealPlanTotals> get copyWith => __$MealPlanTotalsCopyWithImpl<_MealPlanTotals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanTotals&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}


@override
int get hashCode => Object.hash(runtimeType,calories,proteinG,carbsG,fatG);

@override
String toString() {
  return 'MealPlanTotals(calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class _$MealPlanTotalsCopyWith<$Res> implements $MealPlanTotalsCopyWith<$Res> {
  factory _$MealPlanTotalsCopyWith(_MealPlanTotals value, $Res Function(_MealPlanTotals) _then) = __$MealPlanTotalsCopyWithImpl;
@override @useResult
$Res call({
 int calories, double proteinG, double carbsG, double fatG
});




}
/// @nodoc
class __$MealPlanTotalsCopyWithImpl<$Res>
    implements _$MealPlanTotalsCopyWith<$Res> {
  __$MealPlanTotalsCopyWithImpl(this._self, this._then);

  final _MealPlanTotals _self;
  final $Res Function(_MealPlanTotals) _then;

/// Create a copy of MealPlanTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calories = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,}) {
  return _then(_MealPlanTotals(
calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$MealPlanItem {

 String get id; String get foodItemId; String get nameVi; String get nameEn; int get sortOrder; double get grams; int get plannedCalories; double get plannedProteinG; double get plannedCarbsG; double get plannedFatG; bool get isChecked; String? get servingLabelVi; String? get servingLabelEn; double? get servingCount; DateTime? get checkedAt; String? get foodLogId;
/// Create a copy of MealPlanItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanItemCopyWith<MealPlanItem> get copyWith => _$MealPlanItemCopyWithImpl<MealPlanItem>(this as MealPlanItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanItem&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.plannedCalories, plannedCalories) || other.plannedCalories == plannedCalories)&&(identical(other.plannedProteinG, plannedProteinG) || other.plannedProteinG == plannedProteinG)&&(identical(other.plannedCarbsG, plannedCarbsG) || other.plannedCarbsG == plannedCarbsG)&&(identical(other.plannedFatG, plannedFatG) || other.plannedFatG == plannedFatG)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.foodLogId, foodLogId) || other.foodLogId == foodLogId));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,sortOrder,grams,plannedCalories,plannedProteinG,plannedCarbsG,plannedFatG,isChecked,servingLabelVi,servingLabelEn,servingCount,checkedAt,foodLogId);

@override
String toString() {
  return 'MealPlanItem(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, sortOrder: $sortOrder, grams: $grams, plannedCalories: $plannedCalories, plannedProteinG: $plannedProteinG, plannedCarbsG: $plannedCarbsG, plannedFatG: $plannedFatG, isChecked: $isChecked, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount, checkedAt: $checkedAt, foodLogId: $foodLogId)';
}


}

/// @nodoc
abstract mixin class $MealPlanItemCopyWith<$Res>  {
  factory $MealPlanItemCopyWith(MealPlanItem value, $Res Function(MealPlanItem) _then) = _$MealPlanItemCopyWithImpl;
@useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, int sortOrder, double grams, int plannedCalories, double plannedProteinG, double plannedCarbsG, double plannedFatG, bool isChecked, String? servingLabelVi, String? servingLabelEn, double? servingCount, DateTime? checkedAt, String? foodLogId
});




}
/// @nodoc
class _$MealPlanItemCopyWithImpl<$Res>
    implements $MealPlanItemCopyWith<$Res> {
  _$MealPlanItemCopyWithImpl(this._self, this._then);

  final MealPlanItem _self;
  final $Res Function(MealPlanItem) _then;

/// Create a copy of MealPlanItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? foodItemId = null,Object? nameVi = null,Object? nameEn = null,Object? sortOrder = null,Object? grams = null,Object? plannedCalories = null,Object? plannedProteinG = null,Object? plannedCarbsG = null,Object? plannedFatG = null,Object? isChecked = null,Object? servingLabelVi = freezed,Object? servingLabelEn = freezed,Object? servingCount = freezed,Object? checkedAt = freezed,Object? foodLogId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,foodItemId: null == foodItemId ? _self.foodItemId : foodItemId // ignore: cast_nullable_to_non_nullable
as String,nameVi: null == nameVi ? _self.nameVi : nameVi // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,plannedCalories: null == plannedCalories ? _self.plannedCalories : plannedCalories // ignore: cast_nullable_to_non_nullable
as int,plannedProteinG: null == plannedProteinG ? _self.plannedProteinG : plannedProteinG // ignore: cast_nullable_to_non_nullable
as double,plannedCarbsG: null == plannedCarbsG ? _self.plannedCarbsG : plannedCarbsG // ignore: cast_nullable_to_non_nullable
as double,plannedFatG: null == plannedFatG ? _self.plannedFatG : plannedFatG // ignore: cast_nullable_to_non_nullable
as double,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,servingLabelVi: freezed == servingLabelVi ? _self.servingLabelVi : servingLabelVi // ignore: cast_nullable_to_non_nullable
as String?,servingLabelEn: freezed == servingLabelEn ? _self.servingLabelEn : servingLabelEn // ignore: cast_nullable_to_non_nullable
as String?,servingCount: freezed == servingCount ? _self.servingCount : servingCount // ignore: cast_nullable_to_non_nullable
as double?,checkedAt: freezed == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,foodLogId: freezed == foodLogId ? _self.foodLogId : foodLogId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MealPlanItem].
extension MealPlanItemPatterns on MealPlanItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanItem value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanItem value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String foodItemId,  String nameVi,  String nameEn,  int sortOrder,  double grams,  int plannedCalories,  double plannedProteinG,  double plannedCarbsG,  double plannedFatG,  bool isChecked,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount,  DateTime? checkedAt,  String? foodLogId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealPlanItem() when $default != null:
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.sortOrder,_that.grams,_that.plannedCalories,_that.plannedProteinG,_that.plannedCarbsG,_that.plannedFatG,_that.isChecked,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount,_that.checkedAt,_that.foodLogId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String foodItemId,  String nameVi,  String nameEn,  int sortOrder,  double grams,  int plannedCalories,  double plannedProteinG,  double plannedCarbsG,  double plannedFatG,  bool isChecked,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount,  DateTime? checkedAt,  String? foodLogId)  $default,) {final _that = this;
switch (_that) {
case _MealPlanItem():
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.sortOrder,_that.grams,_that.plannedCalories,_that.plannedProteinG,_that.plannedCarbsG,_that.plannedFatG,_that.isChecked,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount,_that.checkedAt,_that.foodLogId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String foodItemId,  String nameVi,  String nameEn,  int sortOrder,  double grams,  int plannedCalories,  double plannedProteinG,  double plannedCarbsG,  double plannedFatG,  bool isChecked,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount,  DateTime? checkedAt,  String? foodLogId)?  $default,) {final _that = this;
switch (_that) {
case _MealPlanItem() when $default != null:
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.sortOrder,_that.grams,_that.plannedCalories,_that.plannedProteinG,_that.plannedCarbsG,_that.plannedFatG,_that.isChecked,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount,_that.checkedAt,_that.foodLogId);case _:
  return null;

}
}

}

/// @nodoc


class _MealPlanItem extends MealPlanItem {
  const _MealPlanItem({required this.id, required this.foodItemId, required this.nameVi, required this.nameEn, required this.sortOrder, required this.grams, required this.plannedCalories, required this.plannedProteinG, required this.plannedCarbsG, required this.plannedFatG, required this.isChecked, this.servingLabelVi, this.servingLabelEn, this.servingCount, this.checkedAt, this.foodLogId}): super._();
  

@override final  String id;
@override final  String foodItemId;
@override final  String nameVi;
@override final  String nameEn;
@override final  int sortOrder;
@override final  double grams;
@override final  int plannedCalories;
@override final  double plannedProteinG;
@override final  double plannedCarbsG;
@override final  double plannedFatG;
@override final  bool isChecked;
@override final  String? servingLabelVi;
@override final  String? servingLabelEn;
@override final  double? servingCount;
@override final  DateTime? checkedAt;
@override final  String? foodLogId;

/// Create a copy of MealPlanItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanItemCopyWith<_MealPlanItem> get copyWith => __$MealPlanItemCopyWithImpl<_MealPlanItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanItem&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.plannedCalories, plannedCalories) || other.plannedCalories == plannedCalories)&&(identical(other.plannedProteinG, plannedProteinG) || other.plannedProteinG == plannedProteinG)&&(identical(other.plannedCarbsG, plannedCarbsG) || other.plannedCarbsG == plannedCarbsG)&&(identical(other.plannedFatG, plannedFatG) || other.plannedFatG == plannedFatG)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.foodLogId, foodLogId) || other.foodLogId == foodLogId));
}


@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,sortOrder,grams,plannedCalories,plannedProteinG,plannedCarbsG,plannedFatG,isChecked,servingLabelVi,servingLabelEn,servingCount,checkedAt,foodLogId);

@override
String toString() {
  return 'MealPlanItem(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, sortOrder: $sortOrder, grams: $grams, plannedCalories: $plannedCalories, plannedProteinG: $plannedProteinG, plannedCarbsG: $plannedCarbsG, plannedFatG: $plannedFatG, isChecked: $isChecked, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount, checkedAt: $checkedAt, foodLogId: $foodLogId)';
}


}

/// @nodoc
abstract mixin class _$MealPlanItemCopyWith<$Res> implements $MealPlanItemCopyWith<$Res> {
  factory _$MealPlanItemCopyWith(_MealPlanItem value, $Res Function(_MealPlanItem) _then) = __$MealPlanItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, int sortOrder, double grams, int plannedCalories, double plannedProteinG, double plannedCarbsG, double plannedFatG, bool isChecked, String? servingLabelVi, String? servingLabelEn, double? servingCount, DateTime? checkedAt, String? foodLogId
});




}
/// @nodoc
class __$MealPlanItemCopyWithImpl<$Res>
    implements _$MealPlanItemCopyWith<$Res> {
  __$MealPlanItemCopyWithImpl(this._self, this._then);

  final _MealPlanItem _self;
  final $Res Function(_MealPlanItem) _then;

/// Create a copy of MealPlanItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? foodItemId = null,Object? nameVi = null,Object? nameEn = null,Object? sortOrder = null,Object? grams = null,Object? plannedCalories = null,Object? plannedProteinG = null,Object? plannedCarbsG = null,Object? plannedFatG = null,Object? isChecked = null,Object? servingLabelVi = freezed,Object? servingLabelEn = freezed,Object? servingCount = freezed,Object? checkedAt = freezed,Object? foodLogId = freezed,}) {
  return _then(_MealPlanItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,foodItemId: null == foodItemId ? _self.foodItemId : foodItemId // ignore: cast_nullable_to_non_nullable
as String,nameVi: null == nameVi ? _self.nameVi : nameVi // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,plannedCalories: null == plannedCalories ? _self.plannedCalories : plannedCalories // ignore: cast_nullable_to_non_nullable
as int,plannedProteinG: null == plannedProteinG ? _self.plannedProteinG : plannedProteinG // ignore: cast_nullable_to_non_nullable
as double,plannedCarbsG: null == plannedCarbsG ? _self.plannedCarbsG : plannedCarbsG // ignore: cast_nullable_to_non_nullable
as double,plannedFatG: null == plannedFatG ? _self.plannedFatG : plannedFatG // ignore: cast_nullable_to_non_nullable
as double,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,servingLabelVi: freezed == servingLabelVi ? _self.servingLabelVi : servingLabelVi // ignore: cast_nullable_to_non_nullable
as String?,servingLabelEn: freezed == servingLabelEn ? _self.servingLabelEn : servingLabelEn // ignore: cast_nullable_to_non_nullable
as String?,servingCount: freezed == servingCount ? _self.servingCount : servingCount // ignore: cast_nullable_to_non_nullable
as double?,checkedAt: freezed == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,foodLogId: freezed == foodLogId ? _self.foodLogId : foodLogId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$MealPlanMeal {

 String get id; String get name; int get sortOrder; List<MealPlanItem> get items; MealPlanTotals get plannedTotals; MealPlanTotals get checkedTotals;
/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanMealCopyWith<MealPlanMeal> get copyWith => _$MealPlanMealCopyWithImpl<MealPlanMeal>(this as MealPlanMeal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanMeal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,const DeepCollectionEquality().hash(items),plannedTotals,checkedTotals);

@override
String toString() {
  return 'MealPlanMeal(id: $id, name: $name, sortOrder: $sortOrder, items: $items, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals)';
}


}

/// @nodoc
abstract mixin class $MealPlanMealCopyWith<$Res>  {
  factory $MealPlanMealCopyWith(MealPlanMeal value, $Res Function(MealPlanMeal) _then) = _$MealPlanMealCopyWithImpl;
@useResult
$Res call({
 String id, String name, int sortOrder, List<MealPlanItem> items, MealPlanTotals plannedTotals, MealPlanTotals checkedTotals
});


$MealPlanTotalsCopyWith<$Res> get plannedTotals;$MealPlanTotalsCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class _$MealPlanMealCopyWithImpl<$Res>
    implements $MealPlanMealCopyWith<$Res> {
  _$MealPlanMealCopyWithImpl(this._self, this._then);

  final MealPlanMeal _self;
  final $Res Function(MealPlanMeal) _then;

/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? items = null,Object? plannedTotals = null,Object? checkedTotals = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MealPlanItem>,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,
  ));
}
/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}


/// Adds pattern-matching-related methods to [MealPlanMeal].
extension MealPlanMealPatterns on MealPlanMeal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanMeal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanMeal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanMeal value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanMeal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanMeal value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanMeal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int sortOrder,  List<MealPlanItem> items,  MealPlanTotals plannedTotals,  MealPlanTotals checkedTotals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealPlanMeal() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.items,_that.plannedTotals,_that.checkedTotals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int sortOrder,  List<MealPlanItem> items,  MealPlanTotals plannedTotals,  MealPlanTotals checkedTotals)  $default,) {final _that = this;
switch (_that) {
case _MealPlanMeal():
return $default(_that.id,_that.name,_that.sortOrder,_that.items,_that.plannedTotals,_that.checkedTotals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int sortOrder,  List<MealPlanItem> items,  MealPlanTotals plannedTotals,  MealPlanTotals checkedTotals)?  $default,) {final _that = this;
switch (_that) {
case _MealPlanMeal() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.items,_that.plannedTotals,_that.checkedTotals);case _:
  return null;

}
}

}

/// @nodoc


class _MealPlanMeal implements MealPlanMeal {
  const _MealPlanMeal({required this.id, required this.name, required this.sortOrder, required final  List<MealPlanItem> items, required this.plannedTotals, required this.checkedTotals}): _items = items;
  

@override final  String id;
@override final  String name;
@override final  int sortOrder;
 final  List<MealPlanItem> _items;
@override List<MealPlanItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  MealPlanTotals plannedTotals;
@override final  MealPlanTotals checkedTotals;

/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanMealCopyWith<_MealPlanMeal> get copyWith => __$MealPlanMealCopyWithImpl<_MealPlanMeal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanMeal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,const DeepCollectionEquality().hash(_items),plannedTotals,checkedTotals);

@override
String toString() {
  return 'MealPlanMeal(id: $id, name: $name, sortOrder: $sortOrder, items: $items, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals)';
}


}

/// @nodoc
abstract mixin class _$MealPlanMealCopyWith<$Res> implements $MealPlanMealCopyWith<$Res> {
  factory _$MealPlanMealCopyWith(_MealPlanMeal value, $Res Function(_MealPlanMeal) _then) = __$MealPlanMealCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int sortOrder, List<MealPlanItem> items, MealPlanTotals plannedTotals, MealPlanTotals checkedTotals
});


@override $MealPlanTotalsCopyWith<$Res> get plannedTotals;@override $MealPlanTotalsCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class __$MealPlanMealCopyWithImpl<$Res>
    implements _$MealPlanMealCopyWith<$Res> {
  __$MealPlanMealCopyWithImpl(this._self, this._then);

  final _MealPlanMeal _self;
  final $Res Function(_MealPlanMeal) _then;

/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? items = null,Object? plannedTotals = null,Object? checkedTotals = null,}) {
  return _then(_MealPlanMeal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MealPlanItem>,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,
  ));
}

/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanMeal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}

/// @nodoc
mixin _$MealPlanDay {

 String get userId; DateTime get date; List<MealPlanMeal> get meals; MealPlanTotals get plannedTotals; MealPlanTotals get checkedTotals; int get totalItemCount; int get checkedItemCount; String? get id; String? get notes;
/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanDayCopyWith<MealPlanDay> get copyWith => _$MealPlanDayCopyWithImpl<MealPlanDay>(this as MealPlanDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanDay&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.meals, meals)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals)&&(identical(other.totalItemCount, totalItemCount) || other.totalItemCount == totalItemCount)&&(identical(other.checkedItemCount, checkedItemCount) || other.checkedItemCount == checkedItemCount)&&(identical(other.id, id) || other.id == id)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,userId,date,const DeepCollectionEquality().hash(meals),plannedTotals,checkedTotals,totalItemCount,checkedItemCount,id,notes);

@override
String toString() {
  return 'MealPlanDay(userId: $userId, date: $date, meals: $meals, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals, totalItemCount: $totalItemCount, checkedItemCount: $checkedItemCount, id: $id, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $MealPlanDayCopyWith<$Res>  {
  factory $MealPlanDayCopyWith(MealPlanDay value, $Res Function(MealPlanDay) _then) = _$MealPlanDayCopyWithImpl;
@useResult
$Res call({
 String userId, DateTime date, List<MealPlanMeal> meals, MealPlanTotals plannedTotals, MealPlanTotals checkedTotals, int totalItemCount, int checkedItemCount, String? id, String? notes
});


$MealPlanTotalsCopyWith<$Res> get plannedTotals;$MealPlanTotalsCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class _$MealPlanDayCopyWithImpl<$Res>
    implements $MealPlanDayCopyWith<$Res> {
  _$MealPlanDayCopyWithImpl(this._self, this._then);

  final MealPlanDay _self;
  final $Res Function(MealPlanDay) _then;

/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? date = null,Object? meals = null,Object? plannedTotals = null,Object? checkedTotals = null,Object? totalItemCount = null,Object? checkedItemCount = null,Object? id = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<MealPlanMeal>,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,totalItemCount: null == totalItemCount ? _self.totalItemCount : totalItemCount // ignore: cast_nullable_to_non_nullable
as int,checkedItemCount: null == checkedItemCount ? _self.checkedItemCount : checkedItemCount // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}


/// Adds pattern-matching-related methods to [MealPlanDay].
extension MealPlanDayPatterns on MealPlanDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanDay value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanDay value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  DateTime date,  List<MealPlanMeal> meals,  MealPlanTotals plannedTotals,  MealPlanTotals checkedTotals,  int totalItemCount,  int checkedItemCount,  String? id,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealPlanDay() when $default != null:
return $default(_that.userId,_that.date,_that.meals,_that.plannedTotals,_that.checkedTotals,_that.totalItemCount,_that.checkedItemCount,_that.id,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  DateTime date,  List<MealPlanMeal> meals,  MealPlanTotals plannedTotals,  MealPlanTotals checkedTotals,  int totalItemCount,  int checkedItemCount,  String? id,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _MealPlanDay():
return $default(_that.userId,_that.date,_that.meals,_that.plannedTotals,_that.checkedTotals,_that.totalItemCount,_that.checkedItemCount,_that.id,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  DateTime date,  List<MealPlanMeal> meals,  MealPlanTotals plannedTotals,  MealPlanTotals checkedTotals,  int totalItemCount,  int checkedItemCount,  String? id,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _MealPlanDay() when $default != null:
return $default(_that.userId,_that.date,_that.meals,_that.plannedTotals,_that.checkedTotals,_that.totalItemCount,_that.checkedItemCount,_that.id,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _MealPlanDay extends MealPlanDay {
  const _MealPlanDay({required this.userId, required this.date, required final  List<MealPlanMeal> meals, required this.plannedTotals, required this.checkedTotals, required this.totalItemCount, required this.checkedItemCount, this.id, this.notes}): _meals = meals,super._();
  

@override final  String userId;
@override final  DateTime date;
 final  List<MealPlanMeal> _meals;
@override List<MealPlanMeal> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}

@override final  MealPlanTotals plannedTotals;
@override final  MealPlanTotals checkedTotals;
@override final  int totalItemCount;
@override final  int checkedItemCount;
@override final  String? id;
@override final  String? notes;

/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanDayCopyWith<_MealPlanDay> get copyWith => __$MealPlanDayCopyWithImpl<_MealPlanDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanDay&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._meals, _meals)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals)&&(identical(other.totalItemCount, totalItemCount) || other.totalItemCount == totalItemCount)&&(identical(other.checkedItemCount, checkedItemCount) || other.checkedItemCount == checkedItemCount)&&(identical(other.id, id) || other.id == id)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,userId,date,const DeepCollectionEquality().hash(_meals),plannedTotals,checkedTotals,totalItemCount,checkedItemCount,id,notes);

@override
String toString() {
  return 'MealPlanDay(userId: $userId, date: $date, meals: $meals, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals, totalItemCount: $totalItemCount, checkedItemCount: $checkedItemCount, id: $id, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$MealPlanDayCopyWith<$Res> implements $MealPlanDayCopyWith<$Res> {
  factory _$MealPlanDayCopyWith(_MealPlanDay value, $Res Function(_MealPlanDay) _then) = __$MealPlanDayCopyWithImpl;
@override @useResult
$Res call({
 String userId, DateTime date, List<MealPlanMeal> meals, MealPlanTotals plannedTotals, MealPlanTotals checkedTotals, int totalItemCount, int checkedItemCount, String? id, String? notes
});


@override $MealPlanTotalsCopyWith<$Res> get plannedTotals;@override $MealPlanTotalsCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class __$MealPlanDayCopyWithImpl<$Res>
    implements _$MealPlanDayCopyWith<$Res> {
  __$MealPlanDayCopyWithImpl(this._self, this._then);

  final _MealPlanDay _self;
  final $Res Function(_MealPlanDay) _then;

/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? date = null,Object? meals = null,Object? plannedTotals = null,Object? checkedTotals = null,Object? totalItemCount = null,Object? checkedItemCount = null,Object? id = freezed,Object? notes = freezed,}) {
  return _then(_MealPlanDay(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<MealPlanMeal>,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotals,totalItemCount: null == totalItemCount ? _self.totalItemCount : totalItemCount // ignore: cast_nullable_to_non_nullable
as int,checkedItemCount: null == checkedItemCount ? _self.checkedItemCount : checkedItemCount // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}

// dart format on
