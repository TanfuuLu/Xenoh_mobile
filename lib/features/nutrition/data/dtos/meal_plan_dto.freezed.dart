// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_plan_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MealPlanTotalsDto {

 int get calories; double get proteinG; double get carbsG; double get fatG;
/// Create a copy of MealPlanTotalsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<MealPlanTotalsDto> get copyWith => _$MealPlanTotalsDtoCopyWithImpl<MealPlanTotalsDto>(this as MealPlanTotalsDto, _$identity);

  /// Serializes this MealPlanTotalsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanTotalsDto&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,calories,proteinG,carbsG,fatG);

@override
String toString() {
  return 'MealPlanTotalsDto(calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class $MealPlanTotalsDtoCopyWith<$Res>  {
  factory $MealPlanTotalsDtoCopyWith(MealPlanTotalsDto value, $Res Function(MealPlanTotalsDto) _then) = _$MealPlanTotalsDtoCopyWithImpl;
@useResult
$Res call({
 int calories, double proteinG, double carbsG, double fatG
});




}
/// @nodoc
class _$MealPlanTotalsDtoCopyWithImpl<$Res>
    implements $MealPlanTotalsDtoCopyWith<$Res> {
  _$MealPlanTotalsDtoCopyWithImpl(this._self, this._then);

  final MealPlanTotalsDto _self;
  final $Res Function(MealPlanTotalsDto) _then;

/// Create a copy of MealPlanTotalsDto
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


/// Adds pattern-matching-related methods to [MealPlanTotalsDto].
extension MealPlanTotalsDtoPatterns on MealPlanTotalsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanTotalsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanTotalsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanTotalsDto value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanTotalsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanTotalsDto value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanTotalsDto() when $default != null:
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
case _MealPlanTotalsDto() when $default != null:
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
case _MealPlanTotalsDto():
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
case _MealPlanTotalsDto() when $default != null:
return $default(_that.calories,_that.proteinG,_that.carbsG,_that.fatG);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MealPlanTotalsDto extends MealPlanTotalsDto {
  const _MealPlanTotalsDto({required this.calories, required this.proteinG, required this.carbsG, required this.fatG}): super._();
  factory _MealPlanTotalsDto.fromJson(Map<String, dynamic> json) => _$MealPlanTotalsDtoFromJson(json);

@override final  int calories;
@override final  double proteinG;
@override final  double carbsG;
@override final  double fatG;

/// Create a copy of MealPlanTotalsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanTotalsDtoCopyWith<_MealPlanTotalsDto> get copyWith => __$MealPlanTotalsDtoCopyWithImpl<_MealPlanTotalsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MealPlanTotalsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanTotalsDto&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,calories,proteinG,carbsG,fatG);

@override
String toString() {
  return 'MealPlanTotalsDto(calories: $calories, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG)';
}


}

/// @nodoc
abstract mixin class _$MealPlanTotalsDtoCopyWith<$Res> implements $MealPlanTotalsDtoCopyWith<$Res> {
  factory _$MealPlanTotalsDtoCopyWith(_MealPlanTotalsDto value, $Res Function(_MealPlanTotalsDto) _then) = __$MealPlanTotalsDtoCopyWithImpl;
@override @useResult
$Res call({
 int calories, double proteinG, double carbsG, double fatG
});




}
/// @nodoc
class __$MealPlanTotalsDtoCopyWithImpl<$Res>
    implements _$MealPlanTotalsDtoCopyWith<$Res> {
  __$MealPlanTotalsDtoCopyWithImpl(this._self, this._then);

  final _MealPlanTotalsDto _self;
  final $Res Function(_MealPlanTotalsDto) _then;

/// Create a copy of MealPlanTotalsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calories = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,}) {
  return _then(_MealPlanTotalsDto(
calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as double,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as double,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MealPlanItemDto {

 String get id; String get foodItemId; String get nameVi; String get nameEn; int get sortOrder; double get grams; int get plannedCalories; double get plannedProteinG; double get plannedCarbsG; double get plannedFatG; bool get isChecked; String? get servingLabelVi; String? get servingLabelEn; double? get servingCount; String? get checkedAt; String? get foodLogId;
/// Create a copy of MealPlanItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanItemDtoCopyWith<MealPlanItemDto> get copyWith => _$MealPlanItemDtoCopyWithImpl<MealPlanItemDto>(this as MealPlanItemDto, _$identity);

  /// Serializes this MealPlanItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.plannedCalories, plannedCalories) || other.plannedCalories == plannedCalories)&&(identical(other.plannedProteinG, plannedProteinG) || other.plannedProteinG == plannedProteinG)&&(identical(other.plannedCarbsG, plannedCarbsG) || other.plannedCarbsG == plannedCarbsG)&&(identical(other.plannedFatG, plannedFatG) || other.plannedFatG == plannedFatG)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.foodLogId, foodLogId) || other.foodLogId == foodLogId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,sortOrder,grams,plannedCalories,plannedProteinG,plannedCarbsG,plannedFatG,isChecked,servingLabelVi,servingLabelEn,servingCount,checkedAt,foodLogId);

@override
String toString() {
  return 'MealPlanItemDto(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, sortOrder: $sortOrder, grams: $grams, plannedCalories: $plannedCalories, plannedProteinG: $plannedProteinG, plannedCarbsG: $plannedCarbsG, plannedFatG: $plannedFatG, isChecked: $isChecked, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount, checkedAt: $checkedAt, foodLogId: $foodLogId)';
}


}

/// @nodoc
abstract mixin class $MealPlanItemDtoCopyWith<$Res>  {
  factory $MealPlanItemDtoCopyWith(MealPlanItemDto value, $Res Function(MealPlanItemDto) _then) = _$MealPlanItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, int sortOrder, double grams, int plannedCalories, double plannedProteinG, double plannedCarbsG, double plannedFatG, bool isChecked, String? servingLabelVi, String? servingLabelEn, double? servingCount, String? checkedAt, String? foodLogId
});




}
/// @nodoc
class _$MealPlanItemDtoCopyWithImpl<$Res>
    implements $MealPlanItemDtoCopyWith<$Res> {
  _$MealPlanItemDtoCopyWithImpl(this._self, this._then);

  final MealPlanItemDto _self;
  final $Res Function(MealPlanItemDto) _then;

/// Create a copy of MealPlanItemDto
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
as String?,foodLogId: freezed == foodLogId ? _self.foodLogId : foodLogId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MealPlanItemDto].
extension MealPlanItemDtoPatterns on MealPlanItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanItemDto value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String foodItemId,  String nameVi,  String nameEn,  int sortOrder,  double grams,  int plannedCalories,  double plannedProteinG,  double plannedCarbsG,  double plannedFatG,  bool isChecked,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount,  String? checkedAt,  String? foodLogId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealPlanItemDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String foodItemId,  String nameVi,  String nameEn,  int sortOrder,  double grams,  int plannedCalories,  double plannedProteinG,  double plannedCarbsG,  double plannedFatG,  bool isChecked,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount,  String? checkedAt,  String? foodLogId)  $default,) {final _that = this;
switch (_that) {
case _MealPlanItemDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String foodItemId,  String nameVi,  String nameEn,  int sortOrder,  double grams,  int plannedCalories,  double plannedProteinG,  double plannedCarbsG,  double plannedFatG,  bool isChecked,  String? servingLabelVi,  String? servingLabelEn,  double? servingCount,  String? checkedAt,  String? foodLogId)?  $default,) {final _that = this;
switch (_that) {
case _MealPlanItemDto() when $default != null:
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.sortOrder,_that.grams,_that.plannedCalories,_that.plannedProteinG,_that.plannedCarbsG,_that.plannedFatG,_that.isChecked,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount,_that.checkedAt,_that.foodLogId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MealPlanItemDto extends MealPlanItemDto {
  const _MealPlanItemDto({required this.id, required this.foodItemId, required this.nameVi, required this.nameEn, required this.sortOrder, required this.grams, required this.plannedCalories, required this.plannedProteinG, required this.plannedCarbsG, required this.plannedFatG, required this.isChecked, this.servingLabelVi, this.servingLabelEn, this.servingCount, this.checkedAt, this.foodLogId}): super._();
  factory _MealPlanItemDto.fromJson(Map<String, dynamic> json) => _$MealPlanItemDtoFromJson(json);

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
@override final  String? checkedAt;
@override final  String? foodLogId;

/// Create a copy of MealPlanItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanItemDtoCopyWith<_MealPlanItemDto> get copyWith => __$MealPlanItemDtoCopyWithImpl<_MealPlanItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MealPlanItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.plannedCalories, plannedCalories) || other.plannedCalories == plannedCalories)&&(identical(other.plannedProteinG, plannedProteinG) || other.plannedProteinG == plannedProteinG)&&(identical(other.plannedCarbsG, plannedCarbsG) || other.plannedCarbsG == plannedCarbsG)&&(identical(other.plannedFatG, plannedFatG) || other.plannedFatG == plannedFatG)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.foodLogId, foodLogId) || other.foodLogId == foodLogId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,sortOrder,grams,plannedCalories,plannedProteinG,plannedCarbsG,plannedFatG,isChecked,servingLabelVi,servingLabelEn,servingCount,checkedAt,foodLogId);

@override
String toString() {
  return 'MealPlanItemDto(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, sortOrder: $sortOrder, grams: $grams, plannedCalories: $plannedCalories, plannedProteinG: $plannedProteinG, plannedCarbsG: $plannedCarbsG, plannedFatG: $plannedFatG, isChecked: $isChecked, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount, checkedAt: $checkedAt, foodLogId: $foodLogId)';
}


}

/// @nodoc
abstract mixin class _$MealPlanItemDtoCopyWith<$Res> implements $MealPlanItemDtoCopyWith<$Res> {
  factory _$MealPlanItemDtoCopyWith(_MealPlanItemDto value, $Res Function(_MealPlanItemDto) _then) = __$MealPlanItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, int sortOrder, double grams, int plannedCalories, double plannedProteinG, double plannedCarbsG, double plannedFatG, bool isChecked, String? servingLabelVi, String? servingLabelEn, double? servingCount, String? checkedAt, String? foodLogId
});




}
/// @nodoc
class __$MealPlanItemDtoCopyWithImpl<$Res>
    implements _$MealPlanItemDtoCopyWith<$Res> {
  __$MealPlanItemDtoCopyWithImpl(this._self, this._then);

  final _MealPlanItemDto _self;
  final $Res Function(_MealPlanItemDto) _then;

/// Create a copy of MealPlanItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? foodItemId = null,Object? nameVi = null,Object? nameEn = null,Object? sortOrder = null,Object? grams = null,Object? plannedCalories = null,Object? plannedProteinG = null,Object? plannedCarbsG = null,Object? plannedFatG = null,Object? isChecked = null,Object? servingLabelVi = freezed,Object? servingLabelEn = freezed,Object? servingCount = freezed,Object? checkedAt = freezed,Object? foodLogId = freezed,}) {
  return _then(_MealPlanItemDto(
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
as String?,foodLogId: freezed == foodLogId ? _self.foodLogId : foodLogId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MealPlanMealDto {

 String get id; String get name; int get sortOrder; MealPlanTotalsDto get plannedTotals; MealPlanTotalsDto get checkedTotals; List<MealPlanItemDto> get items;
/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanMealDtoCopyWith<MealPlanMealDto> get copyWith => _$MealPlanMealDtoCopyWithImpl<MealPlanMealDto>(this as MealPlanMealDto, _$identity);

  /// Serializes this MealPlanMealDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanMealDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,plannedTotals,checkedTotals,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'MealPlanMealDto(id: $id, name: $name, sortOrder: $sortOrder, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals, items: $items)';
}


}

/// @nodoc
abstract mixin class $MealPlanMealDtoCopyWith<$Res>  {
  factory $MealPlanMealDtoCopyWith(MealPlanMealDto value, $Res Function(MealPlanMealDto) _then) = _$MealPlanMealDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, int sortOrder, MealPlanTotalsDto plannedTotals, MealPlanTotalsDto checkedTotals, List<MealPlanItemDto> items
});


$MealPlanTotalsDtoCopyWith<$Res> get plannedTotals;$MealPlanTotalsDtoCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class _$MealPlanMealDtoCopyWithImpl<$Res>
    implements $MealPlanMealDtoCopyWith<$Res> {
  _$MealPlanMealDtoCopyWithImpl(this._self, this._then);

  final MealPlanMealDto _self;
  final $Res Function(MealPlanMealDto) _then;

/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? plannedTotals = null,Object? checkedTotals = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MealPlanItemDto>,
  ));
}
/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}


/// Adds pattern-matching-related methods to [MealPlanMealDto].
extension MealPlanMealDtoPatterns on MealPlanMealDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanMealDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanMealDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanMealDto value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanMealDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanMealDto value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanMealDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int sortOrder,  MealPlanTotalsDto plannedTotals,  MealPlanTotalsDto checkedTotals,  List<MealPlanItemDto> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealPlanMealDto() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.plannedTotals,_that.checkedTotals,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int sortOrder,  MealPlanTotalsDto plannedTotals,  MealPlanTotalsDto checkedTotals,  List<MealPlanItemDto> items)  $default,) {final _that = this;
switch (_that) {
case _MealPlanMealDto():
return $default(_that.id,_that.name,_that.sortOrder,_that.plannedTotals,_that.checkedTotals,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int sortOrder,  MealPlanTotalsDto plannedTotals,  MealPlanTotalsDto checkedTotals,  List<MealPlanItemDto> items)?  $default,) {final _that = this;
switch (_that) {
case _MealPlanMealDto() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.plannedTotals,_that.checkedTotals,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MealPlanMealDto extends MealPlanMealDto {
  const _MealPlanMealDto({required this.id, required this.name, required this.sortOrder, required this.plannedTotals, required this.checkedTotals, final  List<MealPlanItemDto> items = const <MealPlanItemDto>[]}): _items = items,super._();
  factory _MealPlanMealDto.fromJson(Map<String, dynamic> json) => _$MealPlanMealDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  int sortOrder;
@override final  MealPlanTotalsDto plannedTotals;
@override final  MealPlanTotalsDto checkedTotals;
 final  List<MealPlanItemDto> _items;
@override@JsonKey() List<MealPlanItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanMealDtoCopyWith<_MealPlanMealDto> get copyWith => __$MealPlanMealDtoCopyWithImpl<_MealPlanMealDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MealPlanMealDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanMealDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,plannedTotals,checkedTotals,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'MealPlanMealDto(id: $id, name: $name, sortOrder: $sortOrder, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MealPlanMealDtoCopyWith<$Res> implements $MealPlanMealDtoCopyWith<$Res> {
  factory _$MealPlanMealDtoCopyWith(_MealPlanMealDto value, $Res Function(_MealPlanMealDto) _then) = __$MealPlanMealDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int sortOrder, MealPlanTotalsDto plannedTotals, MealPlanTotalsDto checkedTotals, List<MealPlanItemDto> items
});


@override $MealPlanTotalsDtoCopyWith<$Res> get plannedTotals;@override $MealPlanTotalsDtoCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class __$MealPlanMealDtoCopyWithImpl<$Res>
    implements _$MealPlanMealDtoCopyWith<$Res> {
  __$MealPlanMealDtoCopyWithImpl(this._self, this._then);

  final _MealPlanMealDto _self;
  final $Res Function(_MealPlanMealDto) _then;

/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? plannedTotals = null,Object? checkedTotals = null,Object? items = null,}) {
  return _then(_MealPlanMealDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MealPlanItemDto>,
  ));
}

/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanMealDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}


/// @nodoc
mixin _$MealPlanDayDto {

 String get userId; String get date; MealPlanTotalsDto get plannedTotals; MealPlanTotalsDto get checkedTotals; int get totalItemCount; int get checkedItemCount; List<MealPlanMealDto> get meals; String? get id; String? get notes;
/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealPlanDayDtoCopyWith<MealPlanDayDto> get copyWith => _$MealPlanDayDtoCopyWithImpl<MealPlanDayDto>(this as MealPlanDayDto, _$identity);

  /// Serializes this MealPlanDayDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealPlanDayDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals)&&(identical(other.totalItemCount, totalItemCount) || other.totalItemCount == totalItemCount)&&(identical(other.checkedItemCount, checkedItemCount) || other.checkedItemCount == checkedItemCount)&&const DeepCollectionEquality().equals(other.meals, meals)&&(identical(other.id, id) || other.id == id)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,date,plannedTotals,checkedTotals,totalItemCount,checkedItemCount,const DeepCollectionEquality().hash(meals),id,notes);

@override
String toString() {
  return 'MealPlanDayDto(userId: $userId, date: $date, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals, totalItemCount: $totalItemCount, checkedItemCount: $checkedItemCount, meals: $meals, id: $id, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $MealPlanDayDtoCopyWith<$Res>  {
  factory $MealPlanDayDtoCopyWith(MealPlanDayDto value, $Res Function(MealPlanDayDto) _then) = _$MealPlanDayDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String date, MealPlanTotalsDto plannedTotals, MealPlanTotalsDto checkedTotals, int totalItemCount, int checkedItemCount, List<MealPlanMealDto> meals, String? id, String? notes
});


$MealPlanTotalsDtoCopyWith<$Res> get plannedTotals;$MealPlanTotalsDtoCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class _$MealPlanDayDtoCopyWithImpl<$Res>
    implements $MealPlanDayDtoCopyWith<$Res> {
  _$MealPlanDayDtoCopyWithImpl(this._self, this._then);

  final MealPlanDayDto _self;
  final $Res Function(MealPlanDayDto) _then;

/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? date = null,Object? plannedTotals = null,Object? checkedTotals = null,Object? totalItemCount = null,Object? checkedItemCount = null,Object? meals = null,Object? id = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,totalItemCount: null == totalItemCount ? _self.totalItemCount : totalItemCount // ignore: cast_nullable_to_non_nullable
as int,checkedItemCount: null == checkedItemCount ? _self.checkedItemCount : checkedItemCount // ignore: cast_nullable_to_non_nullable
as int,meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<MealPlanMealDto>,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}


/// Adds pattern-matching-related methods to [MealPlanDayDto].
extension MealPlanDayDtoPatterns on MealPlanDayDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MealPlanDayDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MealPlanDayDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MealPlanDayDto value)  $default,){
final _that = this;
switch (_that) {
case _MealPlanDayDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MealPlanDayDto value)?  $default,){
final _that = this;
switch (_that) {
case _MealPlanDayDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String date,  MealPlanTotalsDto plannedTotals,  MealPlanTotalsDto checkedTotals,  int totalItemCount,  int checkedItemCount,  List<MealPlanMealDto> meals,  String? id,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MealPlanDayDto() when $default != null:
return $default(_that.userId,_that.date,_that.plannedTotals,_that.checkedTotals,_that.totalItemCount,_that.checkedItemCount,_that.meals,_that.id,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String date,  MealPlanTotalsDto plannedTotals,  MealPlanTotalsDto checkedTotals,  int totalItemCount,  int checkedItemCount,  List<MealPlanMealDto> meals,  String? id,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _MealPlanDayDto():
return $default(_that.userId,_that.date,_that.plannedTotals,_that.checkedTotals,_that.totalItemCount,_that.checkedItemCount,_that.meals,_that.id,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String date,  MealPlanTotalsDto plannedTotals,  MealPlanTotalsDto checkedTotals,  int totalItemCount,  int checkedItemCount,  List<MealPlanMealDto> meals,  String? id,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _MealPlanDayDto() when $default != null:
return $default(_that.userId,_that.date,_that.plannedTotals,_that.checkedTotals,_that.totalItemCount,_that.checkedItemCount,_that.meals,_that.id,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MealPlanDayDto extends MealPlanDayDto {
  const _MealPlanDayDto({required this.userId, required this.date, required this.plannedTotals, required this.checkedTotals, required this.totalItemCount, required this.checkedItemCount, final  List<MealPlanMealDto> meals = const <MealPlanMealDto>[], this.id, this.notes}): _meals = meals,super._();
  factory _MealPlanDayDto.fromJson(Map<String, dynamic> json) => _$MealPlanDayDtoFromJson(json);

@override final  String userId;
@override final  String date;
@override final  MealPlanTotalsDto plannedTotals;
@override final  MealPlanTotalsDto checkedTotals;
@override final  int totalItemCount;
@override final  int checkedItemCount;
 final  List<MealPlanMealDto> _meals;
@override@JsonKey() List<MealPlanMealDto> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}

@override final  String? id;
@override final  String? notes;

/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealPlanDayDtoCopyWith<_MealPlanDayDto> get copyWith => __$MealPlanDayDtoCopyWithImpl<_MealPlanDayDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MealPlanDayDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MealPlanDayDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.plannedTotals, plannedTotals) || other.plannedTotals == plannedTotals)&&(identical(other.checkedTotals, checkedTotals) || other.checkedTotals == checkedTotals)&&(identical(other.totalItemCount, totalItemCount) || other.totalItemCount == totalItemCount)&&(identical(other.checkedItemCount, checkedItemCount) || other.checkedItemCount == checkedItemCount)&&const DeepCollectionEquality().equals(other._meals, _meals)&&(identical(other.id, id) || other.id == id)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,date,plannedTotals,checkedTotals,totalItemCount,checkedItemCount,const DeepCollectionEquality().hash(_meals),id,notes);

@override
String toString() {
  return 'MealPlanDayDto(userId: $userId, date: $date, plannedTotals: $plannedTotals, checkedTotals: $checkedTotals, totalItemCount: $totalItemCount, checkedItemCount: $checkedItemCount, meals: $meals, id: $id, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$MealPlanDayDtoCopyWith<$Res> implements $MealPlanDayDtoCopyWith<$Res> {
  factory _$MealPlanDayDtoCopyWith(_MealPlanDayDto value, $Res Function(_MealPlanDayDto) _then) = __$MealPlanDayDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String date, MealPlanTotalsDto plannedTotals, MealPlanTotalsDto checkedTotals, int totalItemCount, int checkedItemCount, List<MealPlanMealDto> meals, String? id, String? notes
});


@override $MealPlanTotalsDtoCopyWith<$Res> get plannedTotals;@override $MealPlanTotalsDtoCopyWith<$Res> get checkedTotals;

}
/// @nodoc
class __$MealPlanDayDtoCopyWithImpl<$Res>
    implements _$MealPlanDayDtoCopyWith<$Res> {
  __$MealPlanDayDtoCopyWithImpl(this._self, this._then);

  final _MealPlanDayDto _self;
  final $Res Function(_MealPlanDayDto) _then;

/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? date = null,Object? plannedTotals = null,Object? checkedTotals = null,Object? totalItemCount = null,Object? checkedItemCount = null,Object? meals = null,Object? id = freezed,Object? notes = freezed,}) {
  return _then(_MealPlanDayDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,plannedTotals: null == plannedTotals ? _self.plannedTotals : plannedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,checkedTotals: null == checkedTotals ? _self.checkedTotals : checkedTotals // ignore: cast_nullable_to_non_nullable
as MealPlanTotalsDto,totalItemCount: null == totalItemCount ? _self.totalItemCount : totalItemCount // ignore: cast_nullable_to_non_nullable
as int,checkedItemCount: null == checkedItemCount ? _self.checkedItemCount : checkedItemCount // ignore: cast_nullable_to_non_nullable
as int,meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<MealPlanMealDto>,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get plannedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.plannedTotals, (value) {
    return _then(_self.copyWith(plannedTotals: value));
  });
}/// Create a copy of MealPlanDayDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MealPlanTotalsDtoCopyWith<$Res> get checkedTotals {
  
  return $MealPlanTotalsDtoCopyWith<$Res>(_self.checkedTotals, (value) {
    return _then(_self.copyWith(checkedTotals: value));
  });
}
}

// dart format on
