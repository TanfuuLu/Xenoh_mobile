// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanDto {

 String get id; String get name; String get startDate; String get endDate; String get planType; String get ownerName; int get totalWeeks; int get completedWeeks; int get totalDays; int get completedDays; bool get isActive; String? get coachName;
/// Create a copy of PlanDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanDtoCopyWith<PlanDto> get copyWith => _$PlanDtoCopyWithImpl<PlanDto>(this as PlanDto, _$identity);

  /// Serializes this PlanDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.planType, planType) || other.planType == planType)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&(identical(other.completedWeeks, completedWeeks) || other.completedWeeks == completedWeeks)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.coachName, coachName) || other.coachName == coachName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,planType,ownerName,totalWeeks,completedWeeks,totalDays,completedDays,isActive,coachName);

@override
String toString() {
  return 'PlanDto(id: $id, name: $name, startDate: $startDate, endDate: $endDate, planType: $planType, ownerName: $ownerName, totalWeeks: $totalWeeks, completedWeeks: $completedWeeks, totalDays: $totalDays, completedDays: $completedDays, isActive: $isActive, coachName: $coachName)';
}


}

/// @nodoc
abstract mixin class $PlanDtoCopyWith<$Res>  {
  factory $PlanDtoCopyWith(PlanDto value, $Res Function(PlanDto) _then) = _$PlanDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String startDate, String endDate, String planType, String ownerName, int totalWeeks, int completedWeeks, int totalDays, int completedDays, bool isActive, String? coachName
});




}
/// @nodoc
class _$PlanDtoCopyWithImpl<$Res>
    implements $PlanDtoCopyWith<$Res> {
  _$PlanDtoCopyWithImpl(this._self, this._then);

  final PlanDto _self;
  final $Res Function(PlanDto) _then;

/// Create a copy of PlanDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? planType = null,Object? ownerName = null,Object? totalWeeks = null,Object? completedWeeks = null,Object? totalDays = null,Object? completedDays = null,Object? isActive = null,Object? coachName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,planType: null == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,totalWeeks: null == totalWeeks ? _self.totalWeeks : totalWeeks // ignore: cast_nullable_to_non_nullable
as int,completedWeeks: null == completedWeeks ? _self.completedWeeks : completedWeeks // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,coachName: freezed == coachName ? _self.coachName : coachName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanDto].
extension PlanDtoPatterns on PlanDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanDto value)  $default,){
final _that = this;
switch (_that) {
case _PlanDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlanDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String startDate,  String endDate,  String planType,  String ownerName,  int totalWeeks,  int completedWeeks,  int totalDays,  int completedDays,  bool isActive,  String? coachName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanDto() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.planType,_that.ownerName,_that.totalWeeks,_that.completedWeeks,_that.totalDays,_that.completedDays,_that.isActive,_that.coachName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String startDate,  String endDate,  String planType,  String ownerName,  int totalWeeks,  int completedWeeks,  int totalDays,  int completedDays,  bool isActive,  String? coachName)  $default,) {final _that = this;
switch (_that) {
case _PlanDto():
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.planType,_that.ownerName,_that.totalWeeks,_that.completedWeeks,_that.totalDays,_that.completedDays,_that.isActive,_that.coachName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String startDate,  String endDate,  String planType,  String ownerName,  int totalWeeks,  int completedWeeks,  int totalDays,  int completedDays,  bool isActive,  String? coachName)?  $default,) {final _that = this;
switch (_that) {
case _PlanDto() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.planType,_that.ownerName,_that.totalWeeks,_that.completedWeeks,_that.totalDays,_that.completedDays,_that.isActive,_that.coachName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanDto extends PlanDto {
  const _PlanDto({required this.id, required this.name, required this.startDate, required this.endDate, required this.planType, required this.ownerName, required this.totalWeeks, required this.completedWeeks, required this.totalDays, required this.completedDays, required this.isActive, this.coachName}): super._();
  factory _PlanDto.fromJson(Map<String, dynamic> json) => _$PlanDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String startDate;
@override final  String endDate;
@override final  String planType;
@override final  String ownerName;
@override final  int totalWeeks;
@override final  int completedWeeks;
@override final  int totalDays;
@override final  int completedDays;
@override final  bool isActive;
@override final  String? coachName;

/// Create a copy of PlanDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanDtoCopyWith<_PlanDto> get copyWith => __$PlanDtoCopyWithImpl<_PlanDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.planType, planType) || other.planType == planType)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&(identical(other.completedWeeks, completedWeeks) || other.completedWeeks == completedWeeks)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.coachName, coachName) || other.coachName == coachName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,planType,ownerName,totalWeeks,completedWeeks,totalDays,completedDays,isActive,coachName);

@override
String toString() {
  return 'PlanDto(id: $id, name: $name, startDate: $startDate, endDate: $endDate, planType: $planType, ownerName: $ownerName, totalWeeks: $totalWeeks, completedWeeks: $completedWeeks, totalDays: $totalDays, completedDays: $completedDays, isActive: $isActive, coachName: $coachName)';
}


}

/// @nodoc
abstract mixin class _$PlanDtoCopyWith<$Res> implements $PlanDtoCopyWith<$Res> {
  factory _$PlanDtoCopyWith(_PlanDto value, $Res Function(_PlanDto) _then) = __$PlanDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String startDate, String endDate, String planType, String ownerName, int totalWeeks, int completedWeeks, int totalDays, int completedDays, bool isActive, String? coachName
});




}
/// @nodoc
class __$PlanDtoCopyWithImpl<$Res>
    implements _$PlanDtoCopyWith<$Res> {
  __$PlanDtoCopyWithImpl(this._self, this._then);

  final _PlanDto _self;
  final $Res Function(_PlanDto) _then;

/// Create a copy of PlanDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? planType = null,Object? ownerName = null,Object? totalWeeks = null,Object? completedWeeks = null,Object? totalDays = null,Object? completedDays = null,Object? isActive = null,Object? coachName = freezed,}) {
  return _then(_PlanDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,planType: null == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,totalWeeks: null == totalWeeks ? _self.totalWeeks : totalWeeks // ignore: cast_nullable_to_non_nullable
as int,completedWeeks: null == completedWeeks ? _self.completedWeeks : completedWeeks // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,coachName: freezed == coachName ? _self.coachName : coachName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
