// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrainingActivity {

 int get totalDurationSeconds; double get totalWeightTrainedKg; DateTime get accountCreatedAt; int get year; int get month; List<DateTime> get trainedDates;
/// Create a copy of TrainingActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingActivityCopyWith<TrainingActivity> get copyWith => _$TrainingActivityCopyWithImpl<TrainingActivity>(this as TrainingActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingActivity&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.totalWeightTrainedKg, totalWeightTrainedKg) || other.totalWeightTrainedKg == totalWeightTrainedKg)&&(identical(other.accountCreatedAt, accountCreatedAt) || other.accountCreatedAt == accountCreatedAt)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.trainedDates, trainedDates));
}


@override
int get hashCode => Object.hash(runtimeType,totalDurationSeconds,totalWeightTrainedKg,accountCreatedAt,year,month,const DeepCollectionEquality().hash(trainedDates));

@override
String toString() {
  return 'TrainingActivity(totalDurationSeconds: $totalDurationSeconds, totalWeightTrainedKg: $totalWeightTrainedKg, accountCreatedAt: $accountCreatedAt, year: $year, month: $month, trainedDates: $trainedDates)';
}


}

/// @nodoc
abstract mixin class $TrainingActivityCopyWith<$Res>  {
  factory $TrainingActivityCopyWith(TrainingActivity value, $Res Function(TrainingActivity) _then) = _$TrainingActivityCopyWithImpl;
@useResult
$Res call({
 int totalDurationSeconds, double totalWeightTrainedKg, DateTime accountCreatedAt, int year, int month, List<DateTime> trainedDates
});




}
/// @nodoc
class _$TrainingActivityCopyWithImpl<$Res>
    implements $TrainingActivityCopyWith<$Res> {
  _$TrainingActivityCopyWithImpl(this._self, this._then);

  final TrainingActivity _self;
  final $Res Function(TrainingActivity) _then;

/// Create a copy of TrainingActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDurationSeconds = null,Object? totalWeightTrainedKg = null,Object? accountCreatedAt = null,Object? year = null,Object? month = null,Object? trainedDates = null,}) {
  return _then(_self.copyWith(
totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalWeightTrainedKg: null == totalWeightTrainedKg ? _self.totalWeightTrainedKg : totalWeightTrainedKg // ignore: cast_nullable_to_non_nullable
as double,accountCreatedAt: null == accountCreatedAt ? _self.accountCreatedAt : accountCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,trainedDates: null == trainedDates ? _self.trainedDates : trainedDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingActivity].
extension TrainingActivityPatterns on TrainingActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingActivity value)  $default,){
final _that = this;
switch (_that) {
case _TrainingActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingActivity value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalDurationSeconds,  double totalWeightTrainedKg,  DateTime accountCreatedAt,  int year,  int month,  List<DateTime> trainedDates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingActivity() when $default != null:
return $default(_that.totalDurationSeconds,_that.totalWeightTrainedKg,_that.accountCreatedAt,_that.year,_that.month,_that.trainedDates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalDurationSeconds,  double totalWeightTrainedKg,  DateTime accountCreatedAt,  int year,  int month,  List<DateTime> trainedDates)  $default,) {final _that = this;
switch (_that) {
case _TrainingActivity():
return $default(_that.totalDurationSeconds,_that.totalWeightTrainedKg,_that.accountCreatedAt,_that.year,_that.month,_that.trainedDates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalDurationSeconds,  double totalWeightTrainedKg,  DateTime accountCreatedAt,  int year,  int month,  List<DateTime> trainedDates)?  $default,) {final _that = this;
switch (_that) {
case _TrainingActivity() when $default != null:
return $default(_that.totalDurationSeconds,_that.totalWeightTrainedKg,_that.accountCreatedAt,_that.year,_that.month,_that.trainedDates);case _:
  return null;

}
}

}

/// @nodoc


class _TrainingActivity extends TrainingActivity {
  const _TrainingActivity({required this.totalDurationSeconds, required this.totalWeightTrainedKg, required this.accountCreatedAt, required this.year, required this.month, final  List<DateTime> trainedDates = const <DateTime>[]}): _trainedDates = trainedDates,super._();
  

@override final  int totalDurationSeconds;
@override final  double totalWeightTrainedKg;
@override final  DateTime accountCreatedAt;
@override final  int year;
@override final  int month;
 final  List<DateTime> _trainedDates;
@override@JsonKey() List<DateTime> get trainedDates {
  if (_trainedDates is EqualUnmodifiableListView) return _trainedDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trainedDates);
}


/// Create a copy of TrainingActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingActivityCopyWith<_TrainingActivity> get copyWith => __$TrainingActivityCopyWithImpl<_TrainingActivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingActivity&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.totalWeightTrainedKg, totalWeightTrainedKg) || other.totalWeightTrainedKg == totalWeightTrainedKg)&&(identical(other.accountCreatedAt, accountCreatedAt) || other.accountCreatedAt == accountCreatedAt)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other._trainedDates, _trainedDates));
}


@override
int get hashCode => Object.hash(runtimeType,totalDurationSeconds,totalWeightTrainedKg,accountCreatedAt,year,month,const DeepCollectionEquality().hash(_trainedDates));

@override
String toString() {
  return 'TrainingActivity(totalDurationSeconds: $totalDurationSeconds, totalWeightTrainedKg: $totalWeightTrainedKg, accountCreatedAt: $accountCreatedAt, year: $year, month: $month, trainedDates: $trainedDates)';
}


}

/// @nodoc
abstract mixin class _$TrainingActivityCopyWith<$Res> implements $TrainingActivityCopyWith<$Res> {
  factory _$TrainingActivityCopyWith(_TrainingActivity value, $Res Function(_TrainingActivity) _then) = __$TrainingActivityCopyWithImpl;
@override @useResult
$Res call({
 int totalDurationSeconds, double totalWeightTrainedKg, DateTime accountCreatedAt, int year, int month, List<DateTime> trainedDates
});




}
/// @nodoc
class __$TrainingActivityCopyWithImpl<$Res>
    implements _$TrainingActivityCopyWith<$Res> {
  __$TrainingActivityCopyWithImpl(this._self, this._then);

  final _TrainingActivity _self;
  final $Res Function(_TrainingActivity) _then;

/// Create a copy of TrainingActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDurationSeconds = null,Object? totalWeightTrainedKg = null,Object? accountCreatedAt = null,Object? year = null,Object? month = null,Object? trainedDates = null,}) {
  return _then(_TrainingActivity(
totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,totalWeightTrainedKg: null == totalWeightTrainedKg ? _self.totalWeightTrainedKg : totalWeightTrainedKg // ignore: cast_nullable_to_non_nullable
as double,accountCreatedAt: null == accountCreatedAt ? _self.accountCreatedAt : accountCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,trainedDates: null == trainedDates ? _self._trainedDates : trainedDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}


}

// dart format on
