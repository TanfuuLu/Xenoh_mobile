// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Plan {

 String get id; String get name; DateTime get startDate; DateTime get endDate; String get planType;// "Self" | "Coach"
 String get ownerName; int get totalWeeks; int get completedWeeks; int get totalDays; int get completedDays; bool get isActive; String? get coachName;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.planType, planType) || other.planType == planType)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&(identical(other.completedWeeks, completedWeeks) || other.completedWeeks == completedWeeks)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.coachName, coachName) || other.coachName == coachName));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,planType,ownerName,totalWeeks,completedWeeks,totalDays,completedDays,isActive,coachName);

@override
String toString() {
  return 'Plan(id: $id, name: $name, startDate: $startDate, endDate: $endDate, planType: $planType, ownerName: $ownerName, totalWeeks: $totalWeeks, completedWeeks: $completedWeeks, totalDays: $totalDays, completedDays: $completedDays, isActive: $isActive, coachName: $coachName)';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime startDate, DateTime endDate, String planType, String ownerName, int totalWeeks, int completedWeeks, int totalDays, int completedDays, bool isActive, String? coachName
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? planType = null,Object? ownerName = null,Object? totalWeeks = null,Object? completedWeeks = null,Object? totalDays = null,Object? completedDays = null,Object? isActive = null,Object? coachName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,planType: null == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startDate,  DateTime endDate,  String planType,  String ownerName,  int totalWeeks,  int completedWeeks,  int totalDays,  int completedDays,  bool isActive,  String? coachName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startDate,  DateTime endDate,  String planType,  String ownerName,  int totalWeeks,  int completedWeeks,  int totalDays,  int completedDays,  bool isActive,  String? coachName)  $default,) {final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DateTime startDate,  DateTime endDate,  String planType,  String ownerName,  int totalWeeks,  int completedWeeks,  int totalDays,  int completedDays,  bool isActive,  String? coachName)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.planType,_that.ownerName,_that.totalWeeks,_that.completedWeeks,_that.totalDays,_that.completedDays,_that.isActive,_that.coachName);case _:
  return null;

}
}

}

/// @nodoc


class _Plan extends Plan {
  const _Plan({required this.id, required this.name, required this.startDate, required this.endDate, required this.planType, required this.ownerName, required this.totalWeeks, required this.completedWeeks, required this.totalDays, required this.completedDays, required this.isActive, this.coachName}): super._();
  

@override final  String id;
@override final  String name;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String planType;
// "Self" | "Coach"
@override final  String ownerName;
@override final  int totalWeeks;
@override final  int completedWeeks;
@override final  int totalDays;
@override final  int completedDays;
@override final  bool isActive;
@override final  String? coachName;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.planType, planType) || other.planType == planType)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.totalWeeks, totalWeeks) || other.totalWeeks == totalWeeks)&&(identical(other.completedWeeks, completedWeeks) || other.completedWeeks == completedWeeks)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.coachName, coachName) || other.coachName == coachName));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,startDate,endDate,planType,ownerName,totalWeeks,completedWeeks,totalDays,completedDays,isActive,coachName);

@override
String toString() {
  return 'Plan(id: $id, name: $name, startDate: $startDate, endDate: $endDate, planType: $planType, ownerName: $ownerName, totalWeeks: $totalWeeks, completedWeeks: $completedWeeks, totalDays: $totalDays, completedDays: $completedDays, isActive: $isActive, coachName: $coachName)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime startDate, DateTime endDate, String planType, String ownerName, int totalWeeks, int completedWeeks, int totalDays, int completedDays, bool isActive, String? coachName
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? planType = null,Object? ownerName = null,Object? totalWeeks = null,Object? completedWeeks = null,Object? totalDays = null,Object? completedDays = null,Object? isActive = null,Object? coachName = freezed,}) {
  return _then(_Plan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,planType: null == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
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
