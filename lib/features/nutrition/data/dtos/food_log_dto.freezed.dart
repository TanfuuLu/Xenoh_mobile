// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_log_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FoodLogItemDto {

 String get id; String get foodItemId; String get nameVi; String get nameEn; double get grams; int get computedCalories; double get computedProteinG; double get computedCarbsG; double get computedFatG; String? get servingLabelVi; String? get servingLabelEn; double? get servingCount;
/// Create a copy of FoodLogItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodLogItemDtoCopyWith<FoodLogItemDto> get copyWith => _$FoodLogItemDtoCopyWithImpl<FoodLogItemDto>(this as FoodLogItemDto, _$identity);

  /// Serializes this FoodLogItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodLogItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.computedCalories, computedCalories) || other.computedCalories == computedCalories)&&(identical(other.computedProteinG, computedProteinG) || other.computedProteinG == computedProteinG)&&(identical(other.computedCarbsG, computedCarbsG) || other.computedCarbsG == computedCarbsG)&&(identical(other.computedFatG, computedFatG) || other.computedFatG == computedFatG)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,grams,computedCalories,computedProteinG,computedCarbsG,computedFatG,servingLabelVi,servingLabelEn,servingCount);

@override
String toString() {
  return 'FoodLogItemDto(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, grams: $grams, computedCalories: $computedCalories, computedProteinG: $computedProteinG, computedCarbsG: $computedCarbsG, computedFatG: $computedFatG, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount)';
}


}

/// @nodoc
abstract mixin class $FoodLogItemDtoCopyWith<$Res>  {
  factory $FoodLogItemDtoCopyWith(FoodLogItemDto value, $Res Function(FoodLogItemDto) _then) = _$FoodLogItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, double grams, int computedCalories, double computedProteinG, double computedCarbsG, double computedFatG, String? servingLabelVi, String? servingLabelEn, double? servingCount
});




}
/// @nodoc
class _$FoodLogItemDtoCopyWithImpl<$Res>
    implements $FoodLogItemDtoCopyWith<$Res> {
  _$FoodLogItemDtoCopyWithImpl(this._self, this._then);

  final FoodLogItemDto _self;
  final $Res Function(FoodLogItemDto) _then;

/// Create a copy of FoodLogItemDto
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


/// Adds pattern-matching-related methods to [FoodLogItemDto].
extension FoodLogItemDtoPatterns on FoodLogItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodLogItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodLogItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodLogItemDto value)  $default,){
final _that = this;
switch (_that) {
case _FoodLogItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodLogItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _FoodLogItemDto() when $default != null:
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
case _FoodLogItemDto() when $default != null:
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
case _FoodLogItemDto():
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
case _FoodLogItemDto() when $default != null:
return $default(_that.id,_that.foodItemId,_that.nameVi,_that.nameEn,_that.grams,_that.computedCalories,_that.computedProteinG,_that.computedCarbsG,_that.computedFatG,_that.servingLabelVi,_that.servingLabelEn,_that.servingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodLogItemDto extends FoodLogItemDto {
  const _FoodLogItemDto({required this.id, required this.foodItemId, required this.nameVi, required this.nameEn, required this.grams, required this.computedCalories, required this.computedProteinG, required this.computedCarbsG, required this.computedFatG, this.servingLabelVi, this.servingLabelEn, this.servingCount}): super._();
  factory _FoodLogItemDto.fromJson(Map<String, dynamic> json) => _$FoodLogItemDtoFromJson(json);

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

/// Create a copy of FoodLogItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodLogItemDtoCopyWith<_FoodLogItemDto> get copyWith => __$FoodLogItemDtoCopyWithImpl<_FoodLogItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodLogItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodLogItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.foodItemId, foodItemId) || other.foodItemId == foodItemId)&&(identical(other.nameVi, nameVi) || other.nameVi == nameVi)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.computedCalories, computedCalories) || other.computedCalories == computedCalories)&&(identical(other.computedProteinG, computedProteinG) || other.computedProteinG == computedProteinG)&&(identical(other.computedCarbsG, computedCarbsG) || other.computedCarbsG == computedCarbsG)&&(identical(other.computedFatG, computedFatG) || other.computedFatG == computedFatG)&&(identical(other.servingLabelVi, servingLabelVi) || other.servingLabelVi == servingLabelVi)&&(identical(other.servingLabelEn, servingLabelEn) || other.servingLabelEn == servingLabelEn)&&(identical(other.servingCount, servingCount) || other.servingCount == servingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,foodItemId,nameVi,nameEn,grams,computedCalories,computedProteinG,computedCarbsG,computedFatG,servingLabelVi,servingLabelEn,servingCount);

@override
String toString() {
  return 'FoodLogItemDto(id: $id, foodItemId: $foodItemId, nameVi: $nameVi, nameEn: $nameEn, grams: $grams, computedCalories: $computedCalories, computedProteinG: $computedProteinG, computedCarbsG: $computedCarbsG, computedFatG: $computedFatG, servingLabelVi: $servingLabelVi, servingLabelEn: $servingLabelEn, servingCount: $servingCount)';
}


}

/// @nodoc
abstract mixin class _$FoodLogItemDtoCopyWith<$Res> implements $FoodLogItemDtoCopyWith<$Res> {
  factory _$FoodLogItemDtoCopyWith(_FoodLogItemDto value, $Res Function(_FoodLogItemDto) _then) = __$FoodLogItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String foodItemId, String nameVi, String nameEn, double grams, int computedCalories, double computedProteinG, double computedCarbsG, double computedFatG, String? servingLabelVi, String? servingLabelEn, double? servingCount
});




}
/// @nodoc
class __$FoodLogItemDtoCopyWithImpl<$Res>
    implements _$FoodLogItemDtoCopyWith<$Res> {
  __$FoodLogItemDtoCopyWithImpl(this._self, this._then);

  final _FoodLogItemDto _self;
  final $Res Function(_FoodLogItemDto) _then;

/// Create a copy of FoodLogItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? foodItemId = null,Object? nameVi = null,Object? nameEn = null,Object? grams = null,Object? computedCalories = null,Object? computedProteinG = null,Object? computedCarbsG = null,Object? computedFatG = null,Object? servingLabelVi = freezed,Object? servingLabelEn = freezed,Object? servingCount = freezed,}) {
  return _then(_FoodLogItemDto(
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
mixin _$FoodLogTotalsDto {

 int get totalCalories; double get totalProteinG; double get totalCarbsG; double get totalFatG;
/// Create a copy of FoodLogTotalsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodLogTotalsDtoCopyWith<FoodLogTotalsDto> get copyWith => _$FoodLogTotalsDtoCopyWithImpl<FoodLogTotalsDto>(this as FoodLogTotalsDto, _$identity);

  /// Serializes this FoodLogTotalsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodLogTotalsDto&&(identical(other.totalCalories, totalCalories) || other.totalCalories == totalCalories)&&(identical(other.totalProteinG, totalProteinG) || other.totalProteinG == totalProteinG)&&(identical(other.totalCarbsG, totalCarbsG) || other.totalCarbsG == totalCarbsG)&&(identical(other.totalFatG, totalFatG) || other.totalFatG == totalFatG));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCalories,totalProteinG,totalCarbsG,totalFatG);

@override
String toString() {
  return 'FoodLogTotalsDto(totalCalories: $totalCalories, totalProteinG: $totalProteinG, totalCarbsG: $totalCarbsG, totalFatG: $totalFatG)';
}


}

/// @nodoc
abstract mixin class $FoodLogTotalsDtoCopyWith<$Res>  {
  factory $FoodLogTotalsDtoCopyWith(FoodLogTotalsDto value, $Res Function(FoodLogTotalsDto) _then) = _$FoodLogTotalsDtoCopyWithImpl;
@useResult
$Res call({
 int totalCalories, double totalProteinG, double totalCarbsG, double totalFatG
});




}
/// @nodoc
class _$FoodLogTotalsDtoCopyWithImpl<$Res>
    implements $FoodLogTotalsDtoCopyWith<$Res> {
  _$FoodLogTotalsDtoCopyWithImpl(this._self, this._then);

  final FoodLogTotalsDto _self;
  final $Res Function(FoodLogTotalsDto) _then;

/// Create a copy of FoodLogTotalsDto
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


/// Adds pattern-matching-related methods to [FoodLogTotalsDto].
extension FoodLogTotalsDtoPatterns on FoodLogTotalsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodLogTotalsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodLogTotalsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodLogTotalsDto value)  $default,){
final _that = this;
switch (_that) {
case _FoodLogTotalsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodLogTotalsDto value)?  $default,){
final _that = this;
switch (_that) {
case _FoodLogTotalsDto() when $default != null:
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
case _FoodLogTotalsDto() when $default != null:
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
case _FoodLogTotalsDto():
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
case _FoodLogTotalsDto() when $default != null:
return $default(_that.totalCalories,_that.totalProteinG,_that.totalCarbsG,_that.totalFatG);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodLogTotalsDto extends FoodLogTotalsDto {
  const _FoodLogTotalsDto({required this.totalCalories, required this.totalProteinG, required this.totalCarbsG, required this.totalFatG}): super._();
  factory _FoodLogTotalsDto.fromJson(Map<String, dynamic> json) => _$FoodLogTotalsDtoFromJson(json);

@override final  int totalCalories;
@override final  double totalProteinG;
@override final  double totalCarbsG;
@override final  double totalFatG;

/// Create a copy of FoodLogTotalsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodLogTotalsDtoCopyWith<_FoodLogTotalsDto> get copyWith => __$FoodLogTotalsDtoCopyWithImpl<_FoodLogTotalsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodLogTotalsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodLogTotalsDto&&(identical(other.totalCalories, totalCalories) || other.totalCalories == totalCalories)&&(identical(other.totalProteinG, totalProteinG) || other.totalProteinG == totalProteinG)&&(identical(other.totalCarbsG, totalCarbsG) || other.totalCarbsG == totalCarbsG)&&(identical(other.totalFatG, totalFatG) || other.totalFatG == totalFatG));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCalories,totalProteinG,totalCarbsG,totalFatG);

@override
String toString() {
  return 'FoodLogTotalsDto(totalCalories: $totalCalories, totalProteinG: $totalProteinG, totalCarbsG: $totalCarbsG, totalFatG: $totalFatG)';
}


}

/// @nodoc
abstract mixin class _$FoodLogTotalsDtoCopyWith<$Res> implements $FoodLogTotalsDtoCopyWith<$Res> {
  factory _$FoodLogTotalsDtoCopyWith(_FoodLogTotalsDto value, $Res Function(_FoodLogTotalsDto) _then) = __$FoodLogTotalsDtoCopyWithImpl;
@override @useResult
$Res call({
 int totalCalories, double totalProteinG, double totalCarbsG, double totalFatG
});




}
/// @nodoc
class __$FoodLogTotalsDtoCopyWithImpl<$Res>
    implements _$FoodLogTotalsDtoCopyWith<$Res> {
  __$FoodLogTotalsDtoCopyWithImpl(this._self, this._then);

  final _FoodLogTotalsDto _self;
  final $Res Function(_FoodLogTotalsDto) _then;

/// Create a copy of FoodLogTotalsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCalories = null,Object? totalProteinG = null,Object? totalCarbsG = null,Object? totalFatG = null,}) {
  return _then(_FoodLogTotalsDto(
totalCalories: null == totalCalories ? _self.totalCalories : totalCalories // ignore: cast_nullable_to_non_nullable
as int,totalProteinG: null == totalProteinG ? _self.totalProteinG : totalProteinG // ignore: cast_nullable_to_non_nullable
as double,totalCarbsG: null == totalCarbsG ? _self.totalCarbsG : totalCarbsG // ignore: cast_nullable_to_non_nullable
as double,totalFatG: null == totalFatG ? _self.totalFatG : totalFatG // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$FoodLogsForDateDto {

 String get date; FoodLogTotalsDto get totals; List<FoodLogItemDto> get items;
/// Create a copy of FoodLogsForDateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodLogsForDateDtoCopyWith<FoodLogsForDateDto> get copyWith => _$FoodLogsForDateDtoCopyWithImpl<FoodLogsForDateDto>(this as FoodLogsForDateDto, _$identity);

  /// Serializes this FoodLogsForDateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodLogsForDateDto&&(identical(other.date, date) || other.date == date)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,totals,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'FoodLogsForDateDto(date: $date, totals: $totals, items: $items)';
}


}

/// @nodoc
abstract mixin class $FoodLogsForDateDtoCopyWith<$Res>  {
  factory $FoodLogsForDateDtoCopyWith(FoodLogsForDateDto value, $Res Function(FoodLogsForDateDto) _then) = _$FoodLogsForDateDtoCopyWithImpl;
@useResult
$Res call({
 String date, FoodLogTotalsDto totals, List<FoodLogItemDto> items
});


$FoodLogTotalsDtoCopyWith<$Res> get totals;

}
/// @nodoc
class _$FoodLogsForDateDtoCopyWithImpl<$Res>
    implements $FoodLogsForDateDtoCopyWith<$Res> {
  _$FoodLogsForDateDtoCopyWithImpl(this._self, this._then);

  final FoodLogsForDateDto _self;
  final $Res Function(FoodLogsForDateDto) _then;

/// Create a copy of FoodLogsForDateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? totals = null,Object? items = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FoodLogTotalsDto,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FoodLogItemDto>,
  ));
}
/// Create a copy of FoodLogsForDateDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FoodLogTotalsDtoCopyWith<$Res> get totals {
  
  return $FoodLogTotalsDtoCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [FoodLogsForDateDto].
extension FoodLogsForDateDtoPatterns on FoodLogsForDateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodLogsForDateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodLogsForDateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodLogsForDateDto value)  $default,){
final _that = this;
switch (_that) {
case _FoodLogsForDateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodLogsForDateDto value)?  $default,){
final _that = this;
switch (_that) {
case _FoodLogsForDateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  FoodLogTotalsDto totals,  List<FoodLogItemDto> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodLogsForDateDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  FoodLogTotalsDto totals,  List<FoodLogItemDto> items)  $default,) {final _that = this;
switch (_that) {
case _FoodLogsForDateDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  FoodLogTotalsDto totals,  List<FoodLogItemDto> items)?  $default,) {final _that = this;
switch (_that) {
case _FoodLogsForDateDto() when $default != null:
return $default(_that.date,_that.totals,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodLogsForDateDto extends FoodLogsForDateDto {
  const _FoodLogsForDateDto({required this.date, required this.totals, final  List<FoodLogItemDto> items = const <FoodLogItemDto>[]}): _items = items,super._();
  factory _FoodLogsForDateDto.fromJson(Map<String, dynamic> json) => _$FoodLogsForDateDtoFromJson(json);

@override final  String date;
@override final  FoodLogTotalsDto totals;
 final  List<FoodLogItemDto> _items;
@override@JsonKey() List<FoodLogItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of FoodLogsForDateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodLogsForDateDtoCopyWith<_FoodLogsForDateDto> get copyWith => __$FoodLogsForDateDtoCopyWithImpl<_FoodLogsForDateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodLogsForDateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodLogsForDateDto&&(identical(other.date, date) || other.date == date)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,totals,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'FoodLogsForDateDto(date: $date, totals: $totals, items: $items)';
}


}

/// @nodoc
abstract mixin class _$FoodLogsForDateDtoCopyWith<$Res> implements $FoodLogsForDateDtoCopyWith<$Res> {
  factory _$FoodLogsForDateDtoCopyWith(_FoodLogsForDateDto value, $Res Function(_FoodLogsForDateDto) _then) = __$FoodLogsForDateDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, FoodLogTotalsDto totals, List<FoodLogItemDto> items
});


@override $FoodLogTotalsDtoCopyWith<$Res> get totals;

}
/// @nodoc
class __$FoodLogsForDateDtoCopyWithImpl<$Res>
    implements _$FoodLogsForDateDtoCopyWith<$Res> {
  __$FoodLogsForDateDtoCopyWithImpl(this._self, this._then);

  final _FoodLogsForDateDto _self;
  final $Res Function(_FoodLogsForDateDto) _then;

/// Create a copy of FoodLogsForDateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? totals = null,Object? items = null,}) {
  return _then(_FoodLogsForDateDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FoodLogTotalsDto,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<FoodLogItemDto>,
  ));
}

/// Create a copy of FoodLogsForDateDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FoodLogTotalsDtoCopyWith<$Res> get totals {
  
  return $FoodLogTotalsDtoCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}

// dart format on
