// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CycleDailyLog {

 DateTime get date; List<String> get symptoms; String? get flow; String? get mood; int? get energyLevel; String? get notes;
/// Create a copy of CycleDailyLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleDailyLogCopyWith<CycleDailyLog> get copyWith => _$CycleDailyLogCopyWithImpl<CycleDailyLog>(this as CycleDailyLog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleDailyLog&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.symptoms, symptoms)&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.energyLevel, energyLevel) || other.energyLevel == energyLevel)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(symptoms),flow,mood,energyLevel,notes);

@override
String toString() {
  return 'CycleDailyLog(date: $date, symptoms: $symptoms, flow: $flow, mood: $mood, energyLevel: $energyLevel, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CycleDailyLogCopyWith<$Res>  {
  factory $CycleDailyLogCopyWith(CycleDailyLog value, $Res Function(CycleDailyLog) _then) = _$CycleDailyLogCopyWithImpl;
@useResult
$Res call({
 DateTime date, List<String> symptoms, String? flow, String? mood, int? energyLevel, String? notes
});




}
/// @nodoc
class _$CycleDailyLogCopyWithImpl<$Res>
    implements $CycleDailyLogCopyWith<$Res> {
  _$CycleDailyLogCopyWithImpl(this._self, this._then);

  final CycleDailyLog _self;
  final $Res Function(CycleDailyLog) _then;

/// Create a copy of CycleDailyLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? symptoms = null,Object? flow = freezed,Object? mood = freezed,Object? energyLevel = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,symptoms: null == symptoms ? _self.symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<String>,flow: freezed == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as String?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,energyLevel: freezed == energyLevel ? _self.energyLevel : energyLevel // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleDailyLog].
extension CycleDailyLogPatterns on CycleDailyLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleDailyLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleDailyLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleDailyLog value)  $default,){
final _that = this;
switch (_that) {
case _CycleDailyLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleDailyLog value)?  $default,){
final _that = this;
switch (_that) {
case _CycleDailyLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  List<String> symptoms,  String? flow,  String? mood,  int? energyLevel,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleDailyLog() when $default != null:
return $default(_that.date,_that.symptoms,_that.flow,_that.mood,_that.energyLevel,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  List<String> symptoms,  String? flow,  String? mood,  int? energyLevel,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _CycleDailyLog():
return $default(_that.date,_that.symptoms,_that.flow,_that.mood,_that.energyLevel,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  List<String> symptoms,  String? flow,  String? mood,  int? energyLevel,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _CycleDailyLog() when $default != null:
return $default(_that.date,_that.symptoms,_that.flow,_that.mood,_that.energyLevel,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _CycleDailyLog implements CycleDailyLog {
  const _CycleDailyLog({required this.date, required final  List<String> symptoms, this.flow, this.mood, this.energyLevel, this.notes}): _symptoms = symptoms;
  

@override final  DateTime date;
 final  List<String> _symptoms;
@override List<String> get symptoms {
  if (_symptoms is EqualUnmodifiableListView) return _symptoms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symptoms);
}

@override final  String? flow;
@override final  String? mood;
@override final  int? energyLevel;
@override final  String? notes;

/// Create a copy of CycleDailyLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleDailyLogCopyWith<_CycleDailyLog> get copyWith => __$CycleDailyLogCopyWithImpl<_CycleDailyLog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleDailyLog&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._symptoms, _symptoms)&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.energyLevel, energyLevel) || other.energyLevel == energyLevel)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_symptoms),flow,mood,energyLevel,notes);

@override
String toString() {
  return 'CycleDailyLog(date: $date, symptoms: $symptoms, flow: $flow, mood: $mood, energyLevel: $energyLevel, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CycleDailyLogCopyWith<$Res> implements $CycleDailyLogCopyWith<$Res> {
  factory _$CycleDailyLogCopyWith(_CycleDailyLog value, $Res Function(_CycleDailyLog) _then) = __$CycleDailyLogCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, List<String> symptoms, String? flow, String? mood, int? energyLevel, String? notes
});




}
/// @nodoc
class __$CycleDailyLogCopyWithImpl<$Res>
    implements _$CycleDailyLogCopyWith<$Res> {
  __$CycleDailyLogCopyWithImpl(this._self, this._then);

  final _CycleDailyLog _self;
  final $Res Function(_CycleDailyLog) _then;

/// Create a copy of CycleDailyLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? symptoms = null,Object? flow = freezed,Object? mood = freezed,Object? energyLevel = freezed,Object? notes = freezed,}) {
  return _then(_CycleDailyLog(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,symptoms: null == symptoms ? _self._symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<String>,flow: freezed == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as String?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,energyLevel: freezed == energyLevel ? _self.energyLevel : energyLevel // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CycleOverview {

 String get currentPhase; int get effectiveCycleLengthDays; int get effectivePeriodLengthDays; bool get isRegular; String get confidence; bool get needsData; List<PredictedPeriod> get predictedPeriods; List<DateTime> get ovulationDates; List<FertileWindow> get fertileWindows; int? get cycleDay; int? get daysUntilNextPeriod; int? get daysLate; DateTime? get lastPeriodStart; DateTime? get nextPeriodStart; DateTime? get currentPeriodPredictedEnd; int? get avgCycleLengthDays; int? get avgPeriodLengthDays; int? get cycleVariabilityDays;
/// Create a copy of CycleOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleOverviewCopyWith<CycleOverview> get copyWith => _$CycleOverviewCopyWithImpl<CycleOverview>(this as CycleOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleOverview&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.effectiveCycleLengthDays, effectiveCycleLengthDays) || other.effectiveCycleLengthDays == effectiveCycleLengthDays)&&(identical(other.effectivePeriodLengthDays, effectivePeriodLengthDays) || other.effectivePeriodLengthDays == effectivePeriodLengthDays)&&(identical(other.isRegular, isRegular) || other.isRegular == isRegular)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.needsData, needsData) || other.needsData == needsData)&&const DeepCollectionEquality().equals(other.predictedPeriods, predictedPeriods)&&const DeepCollectionEquality().equals(other.ovulationDates, ovulationDates)&&const DeepCollectionEquality().equals(other.fertileWindows, fertileWindows)&&(identical(other.cycleDay, cycleDay) || other.cycleDay == cycleDay)&&(identical(other.daysUntilNextPeriod, daysUntilNextPeriod) || other.daysUntilNextPeriod == daysUntilNextPeriod)&&(identical(other.daysLate, daysLate) || other.daysLate == daysLate)&&(identical(other.lastPeriodStart, lastPeriodStart) || other.lastPeriodStart == lastPeriodStart)&&(identical(other.nextPeriodStart, nextPeriodStart) || other.nextPeriodStart == nextPeriodStart)&&(identical(other.currentPeriodPredictedEnd, currentPeriodPredictedEnd) || other.currentPeriodPredictedEnd == currentPeriodPredictedEnd)&&(identical(other.avgCycleLengthDays, avgCycleLengthDays) || other.avgCycleLengthDays == avgCycleLengthDays)&&(identical(other.avgPeriodLengthDays, avgPeriodLengthDays) || other.avgPeriodLengthDays == avgPeriodLengthDays)&&(identical(other.cycleVariabilityDays, cycleVariabilityDays) || other.cycleVariabilityDays == cycleVariabilityDays));
}


@override
int get hashCode => Object.hash(runtimeType,currentPhase,effectiveCycleLengthDays,effectivePeriodLengthDays,isRegular,confidence,needsData,const DeepCollectionEquality().hash(predictedPeriods),const DeepCollectionEquality().hash(ovulationDates),const DeepCollectionEquality().hash(fertileWindows),cycleDay,daysUntilNextPeriod,daysLate,lastPeriodStart,nextPeriodStart,currentPeriodPredictedEnd,avgCycleLengthDays,avgPeriodLengthDays,cycleVariabilityDays);

@override
String toString() {
  return 'CycleOverview(currentPhase: $currentPhase, effectiveCycleLengthDays: $effectiveCycleLengthDays, effectivePeriodLengthDays: $effectivePeriodLengthDays, isRegular: $isRegular, confidence: $confidence, needsData: $needsData, predictedPeriods: $predictedPeriods, ovulationDates: $ovulationDates, fertileWindows: $fertileWindows, cycleDay: $cycleDay, daysUntilNextPeriod: $daysUntilNextPeriod, daysLate: $daysLate, lastPeriodStart: $lastPeriodStart, nextPeriodStart: $nextPeriodStart, currentPeriodPredictedEnd: $currentPeriodPredictedEnd, avgCycleLengthDays: $avgCycleLengthDays, avgPeriodLengthDays: $avgPeriodLengthDays, cycleVariabilityDays: $cycleVariabilityDays)';
}


}

/// @nodoc
abstract mixin class $CycleOverviewCopyWith<$Res>  {
  factory $CycleOverviewCopyWith(CycleOverview value, $Res Function(CycleOverview) _then) = _$CycleOverviewCopyWithImpl;
@useResult
$Res call({
 String currentPhase, int effectiveCycleLengthDays, int effectivePeriodLengthDays, bool isRegular, String confidence, bool needsData, List<PredictedPeriod> predictedPeriods, List<DateTime> ovulationDates, List<FertileWindow> fertileWindows, int? cycleDay, int? daysUntilNextPeriod, int? daysLate, DateTime? lastPeriodStart, DateTime? nextPeriodStart, DateTime? currentPeriodPredictedEnd, int? avgCycleLengthDays, int? avgPeriodLengthDays, int? cycleVariabilityDays
});




}
/// @nodoc
class _$CycleOverviewCopyWithImpl<$Res>
    implements $CycleOverviewCopyWith<$Res> {
  _$CycleOverviewCopyWithImpl(this._self, this._then);

  final CycleOverview _self;
  final $Res Function(CycleOverview) _then;

/// Create a copy of CycleOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPhase = null,Object? effectiveCycleLengthDays = null,Object? effectivePeriodLengthDays = null,Object? isRegular = null,Object? confidence = null,Object? needsData = null,Object? predictedPeriods = null,Object? ovulationDates = null,Object? fertileWindows = null,Object? cycleDay = freezed,Object? daysUntilNextPeriod = freezed,Object? daysLate = freezed,Object? lastPeriodStart = freezed,Object? nextPeriodStart = freezed,Object? currentPeriodPredictedEnd = freezed,Object? avgCycleLengthDays = freezed,Object? avgPeriodLengthDays = freezed,Object? cycleVariabilityDays = freezed,}) {
  return _then(_self.copyWith(
currentPhase: null == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as String,effectiveCycleLengthDays: null == effectiveCycleLengthDays ? _self.effectiveCycleLengthDays : effectiveCycleLengthDays // ignore: cast_nullable_to_non_nullable
as int,effectivePeriodLengthDays: null == effectivePeriodLengthDays ? _self.effectivePeriodLengthDays : effectivePeriodLengthDays // ignore: cast_nullable_to_non_nullable
as int,isRegular: null == isRegular ? _self.isRegular : isRegular // ignore: cast_nullable_to_non_nullable
as bool,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,needsData: null == needsData ? _self.needsData : needsData // ignore: cast_nullable_to_non_nullable
as bool,predictedPeriods: null == predictedPeriods ? _self.predictedPeriods : predictedPeriods // ignore: cast_nullable_to_non_nullable
as List<PredictedPeriod>,ovulationDates: null == ovulationDates ? _self.ovulationDates : ovulationDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,fertileWindows: null == fertileWindows ? _self.fertileWindows : fertileWindows // ignore: cast_nullable_to_non_nullable
as List<FertileWindow>,cycleDay: freezed == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int?,daysUntilNextPeriod: freezed == daysUntilNextPeriod ? _self.daysUntilNextPeriod : daysUntilNextPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysLate: freezed == daysLate ? _self.daysLate : daysLate // ignore: cast_nullable_to_non_nullable
as int?,lastPeriodStart: freezed == lastPeriodStart ? _self.lastPeriodStart : lastPeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime?,nextPeriodStart: freezed == nextPeriodStart ? _self.nextPeriodStart : nextPeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime?,currentPeriodPredictedEnd: freezed == currentPeriodPredictedEnd ? _self.currentPeriodPredictedEnd : currentPeriodPredictedEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,avgCycleLengthDays: freezed == avgCycleLengthDays ? _self.avgCycleLengthDays : avgCycleLengthDays // ignore: cast_nullable_to_non_nullable
as int?,avgPeriodLengthDays: freezed == avgPeriodLengthDays ? _self.avgPeriodLengthDays : avgPeriodLengthDays // ignore: cast_nullable_to_non_nullable
as int?,cycleVariabilityDays: freezed == cycleVariabilityDays ? _self.cycleVariabilityDays : cycleVariabilityDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleOverview].
extension CycleOverviewPatterns on CycleOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleOverview value)  $default,){
final _that = this;
switch (_that) {
case _CycleOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleOverview value)?  $default,){
final _that = this;
switch (_that) {
case _CycleOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currentPhase,  int effectiveCycleLengthDays,  int effectivePeriodLengthDays,  bool isRegular,  String confidence,  bool needsData,  List<PredictedPeriod> predictedPeriods,  List<DateTime> ovulationDates,  List<FertileWindow> fertileWindows,  int? cycleDay,  int? daysUntilNextPeriod,  int? daysLate,  DateTime? lastPeriodStart,  DateTime? nextPeriodStart,  DateTime? currentPeriodPredictedEnd,  int? avgCycleLengthDays,  int? avgPeriodLengthDays,  int? cycleVariabilityDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleOverview() when $default != null:
return $default(_that.currentPhase,_that.effectiveCycleLengthDays,_that.effectivePeriodLengthDays,_that.isRegular,_that.confidence,_that.needsData,_that.predictedPeriods,_that.ovulationDates,_that.fertileWindows,_that.cycleDay,_that.daysUntilNextPeriod,_that.daysLate,_that.lastPeriodStart,_that.nextPeriodStart,_that.currentPeriodPredictedEnd,_that.avgCycleLengthDays,_that.avgPeriodLengthDays,_that.cycleVariabilityDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currentPhase,  int effectiveCycleLengthDays,  int effectivePeriodLengthDays,  bool isRegular,  String confidence,  bool needsData,  List<PredictedPeriod> predictedPeriods,  List<DateTime> ovulationDates,  List<FertileWindow> fertileWindows,  int? cycleDay,  int? daysUntilNextPeriod,  int? daysLate,  DateTime? lastPeriodStart,  DateTime? nextPeriodStart,  DateTime? currentPeriodPredictedEnd,  int? avgCycleLengthDays,  int? avgPeriodLengthDays,  int? cycleVariabilityDays)  $default,) {final _that = this;
switch (_that) {
case _CycleOverview():
return $default(_that.currentPhase,_that.effectiveCycleLengthDays,_that.effectivePeriodLengthDays,_that.isRegular,_that.confidence,_that.needsData,_that.predictedPeriods,_that.ovulationDates,_that.fertileWindows,_that.cycleDay,_that.daysUntilNextPeriod,_that.daysLate,_that.lastPeriodStart,_that.nextPeriodStart,_that.currentPeriodPredictedEnd,_that.avgCycleLengthDays,_that.avgPeriodLengthDays,_that.cycleVariabilityDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currentPhase,  int effectiveCycleLengthDays,  int effectivePeriodLengthDays,  bool isRegular,  String confidence,  bool needsData,  List<PredictedPeriod> predictedPeriods,  List<DateTime> ovulationDates,  List<FertileWindow> fertileWindows,  int? cycleDay,  int? daysUntilNextPeriod,  int? daysLate,  DateTime? lastPeriodStart,  DateTime? nextPeriodStart,  DateTime? currentPeriodPredictedEnd,  int? avgCycleLengthDays,  int? avgPeriodLengthDays,  int? cycleVariabilityDays)?  $default,) {final _that = this;
switch (_that) {
case _CycleOverview() when $default != null:
return $default(_that.currentPhase,_that.effectiveCycleLengthDays,_that.effectivePeriodLengthDays,_that.isRegular,_that.confidence,_that.needsData,_that.predictedPeriods,_that.ovulationDates,_that.fertileWindows,_that.cycleDay,_that.daysUntilNextPeriod,_that.daysLate,_that.lastPeriodStart,_that.nextPeriodStart,_that.currentPeriodPredictedEnd,_that.avgCycleLengthDays,_that.avgPeriodLengthDays,_that.cycleVariabilityDays);case _:
  return null;

}
}

}

/// @nodoc


class _CycleOverview implements CycleOverview {
  const _CycleOverview({required this.currentPhase, required this.effectiveCycleLengthDays, required this.effectivePeriodLengthDays, required this.isRegular, required this.confidence, required this.needsData, required final  List<PredictedPeriod> predictedPeriods, required final  List<DateTime> ovulationDates, required final  List<FertileWindow> fertileWindows, this.cycleDay, this.daysUntilNextPeriod, this.daysLate, this.lastPeriodStart, this.nextPeriodStart, this.currentPeriodPredictedEnd, this.avgCycleLengthDays, this.avgPeriodLengthDays, this.cycleVariabilityDays}): _predictedPeriods = predictedPeriods,_ovulationDates = ovulationDates,_fertileWindows = fertileWindows;
  

@override final  String currentPhase;
@override final  int effectiveCycleLengthDays;
@override final  int effectivePeriodLengthDays;
@override final  bool isRegular;
@override final  String confidence;
@override final  bool needsData;
 final  List<PredictedPeriod> _predictedPeriods;
@override List<PredictedPeriod> get predictedPeriods {
  if (_predictedPeriods is EqualUnmodifiableListView) return _predictedPeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_predictedPeriods);
}

 final  List<DateTime> _ovulationDates;
@override List<DateTime> get ovulationDates {
  if (_ovulationDates is EqualUnmodifiableListView) return _ovulationDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ovulationDates);
}

 final  List<FertileWindow> _fertileWindows;
@override List<FertileWindow> get fertileWindows {
  if (_fertileWindows is EqualUnmodifiableListView) return _fertileWindows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fertileWindows);
}

@override final  int? cycleDay;
@override final  int? daysUntilNextPeriod;
@override final  int? daysLate;
@override final  DateTime? lastPeriodStart;
@override final  DateTime? nextPeriodStart;
@override final  DateTime? currentPeriodPredictedEnd;
@override final  int? avgCycleLengthDays;
@override final  int? avgPeriodLengthDays;
@override final  int? cycleVariabilityDays;

/// Create a copy of CycleOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleOverviewCopyWith<_CycleOverview> get copyWith => __$CycleOverviewCopyWithImpl<_CycleOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleOverview&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.effectiveCycleLengthDays, effectiveCycleLengthDays) || other.effectiveCycleLengthDays == effectiveCycleLengthDays)&&(identical(other.effectivePeriodLengthDays, effectivePeriodLengthDays) || other.effectivePeriodLengthDays == effectivePeriodLengthDays)&&(identical(other.isRegular, isRegular) || other.isRegular == isRegular)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.needsData, needsData) || other.needsData == needsData)&&const DeepCollectionEquality().equals(other._predictedPeriods, _predictedPeriods)&&const DeepCollectionEquality().equals(other._ovulationDates, _ovulationDates)&&const DeepCollectionEquality().equals(other._fertileWindows, _fertileWindows)&&(identical(other.cycleDay, cycleDay) || other.cycleDay == cycleDay)&&(identical(other.daysUntilNextPeriod, daysUntilNextPeriod) || other.daysUntilNextPeriod == daysUntilNextPeriod)&&(identical(other.daysLate, daysLate) || other.daysLate == daysLate)&&(identical(other.lastPeriodStart, lastPeriodStart) || other.lastPeriodStart == lastPeriodStart)&&(identical(other.nextPeriodStart, nextPeriodStart) || other.nextPeriodStart == nextPeriodStart)&&(identical(other.currentPeriodPredictedEnd, currentPeriodPredictedEnd) || other.currentPeriodPredictedEnd == currentPeriodPredictedEnd)&&(identical(other.avgCycleLengthDays, avgCycleLengthDays) || other.avgCycleLengthDays == avgCycleLengthDays)&&(identical(other.avgPeriodLengthDays, avgPeriodLengthDays) || other.avgPeriodLengthDays == avgPeriodLengthDays)&&(identical(other.cycleVariabilityDays, cycleVariabilityDays) || other.cycleVariabilityDays == cycleVariabilityDays));
}


@override
int get hashCode => Object.hash(runtimeType,currentPhase,effectiveCycleLengthDays,effectivePeriodLengthDays,isRegular,confidence,needsData,const DeepCollectionEquality().hash(_predictedPeriods),const DeepCollectionEquality().hash(_ovulationDates),const DeepCollectionEquality().hash(_fertileWindows),cycleDay,daysUntilNextPeriod,daysLate,lastPeriodStart,nextPeriodStart,currentPeriodPredictedEnd,avgCycleLengthDays,avgPeriodLengthDays,cycleVariabilityDays);

@override
String toString() {
  return 'CycleOverview(currentPhase: $currentPhase, effectiveCycleLengthDays: $effectiveCycleLengthDays, effectivePeriodLengthDays: $effectivePeriodLengthDays, isRegular: $isRegular, confidence: $confidence, needsData: $needsData, predictedPeriods: $predictedPeriods, ovulationDates: $ovulationDates, fertileWindows: $fertileWindows, cycleDay: $cycleDay, daysUntilNextPeriod: $daysUntilNextPeriod, daysLate: $daysLate, lastPeriodStart: $lastPeriodStart, nextPeriodStart: $nextPeriodStart, currentPeriodPredictedEnd: $currentPeriodPredictedEnd, avgCycleLengthDays: $avgCycleLengthDays, avgPeriodLengthDays: $avgPeriodLengthDays, cycleVariabilityDays: $cycleVariabilityDays)';
}


}

/// @nodoc
abstract mixin class _$CycleOverviewCopyWith<$Res> implements $CycleOverviewCopyWith<$Res> {
  factory _$CycleOverviewCopyWith(_CycleOverview value, $Res Function(_CycleOverview) _then) = __$CycleOverviewCopyWithImpl;
@override @useResult
$Res call({
 String currentPhase, int effectiveCycleLengthDays, int effectivePeriodLengthDays, bool isRegular, String confidence, bool needsData, List<PredictedPeriod> predictedPeriods, List<DateTime> ovulationDates, List<FertileWindow> fertileWindows, int? cycleDay, int? daysUntilNextPeriod, int? daysLate, DateTime? lastPeriodStart, DateTime? nextPeriodStart, DateTime? currentPeriodPredictedEnd, int? avgCycleLengthDays, int? avgPeriodLengthDays, int? cycleVariabilityDays
});




}
/// @nodoc
class __$CycleOverviewCopyWithImpl<$Res>
    implements _$CycleOverviewCopyWith<$Res> {
  __$CycleOverviewCopyWithImpl(this._self, this._then);

  final _CycleOverview _self;
  final $Res Function(_CycleOverview) _then;

/// Create a copy of CycleOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPhase = null,Object? effectiveCycleLengthDays = null,Object? effectivePeriodLengthDays = null,Object? isRegular = null,Object? confidence = null,Object? needsData = null,Object? predictedPeriods = null,Object? ovulationDates = null,Object? fertileWindows = null,Object? cycleDay = freezed,Object? daysUntilNextPeriod = freezed,Object? daysLate = freezed,Object? lastPeriodStart = freezed,Object? nextPeriodStart = freezed,Object? currentPeriodPredictedEnd = freezed,Object? avgCycleLengthDays = freezed,Object? avgPeriodLengthDays = freezed,Object? cycleVariabilityDays = freezed,}) {
  return _then(_CycleOverview(
currentPhase: null == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as String,effectiveCycleLengthDays: null == effectiveCycleLengthDays ? _self.effectiveCycleLengthDays : effectiveCycleLengthDays // ignore: cast_nullable_to_non_nullable
as int,effectivePeriodLengthDays: null == effectivePeriodLengthDays ? _self.effectivePeriodLengthDays : effectivePeriodLengthDays // ignore: cast_nullable_to_non_nullable
as int,isRegular: null == isRegular ? _self.isRegular : isRegular // ignore: cast_nullable_to_non_nullable
as bool,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,needsData: null == needsData ? _self.needsData : needsData // ignore: cast_nullable_to_non_nullable
as bool,predictedPeriods: null == predictedPeriods ? _self._predictedPeriods : predictedPeriods // ignore: cast_nullable_to_non_nullable
as List<PredictedPeriod>,ovulationDates: null == ovulationDates ? _self._ovulationDates : ovulationDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,fertileWindows: null == fertileWindows ? _self._fertileWindows : fertileWindows // ignore: cast_nullable_to_non_nullable
as List<FertileWindow>,cycleDay: freezed == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int?,daysUntilNextPeriod: freezed == daysUntilNextPeriod ? _self.daysUntilNextPeriod : daysUntilNextPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysLate: freezed == daysLate ? _self.daysLate : daysLate // ignore: cast_nullable_to_non_nullable
as int?,lastPeriodStart: freezed == lastPeriodStart ? _self.lastPeriodStart : lastPeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime?,nextPeriodStart: freezed == nextPeriodStart ? _self.nextPeriodStart : nextPeriodStart // ignore: cast_nullable_to_non_nullable
as DateTime?,currentPeriodPredictedEnd: freezed == currentPeriodPredictedEnd ? _self.currentPeriodPredictedEnd : currentPeriodPredictedEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,avgCycleLengthDays: freezed == avgCycleLengthDays ? _self.avgCycleLengthDays : avgCycleLengthDays // ignore: cast_nullable_to_non_nullable
as int?,avgPeriodLengthDays: freezed == avgPeriodLengthDays ? _self.avgPeriodLengthDays : avgPeriodLengthDays // ignore: cast_nullable_to_non_nullable
as int?,cycleVariabilityDays: freezed == cycleVariabilityDays ? _self.cycleVariabilityDays : cycleVariabilityDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$PredictedPeriod {

 DateTime get start; DateTime get end;
/// Create a copy of PredictedPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictedPeriodCopyWith<PredictedPeriod> get copyWith => _$PredictedPeriodCopyWithImpl<PredictedPeriod>(this as PredictedPeriod, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictedPeriod&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'PredictedPeriod(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $PredictedPeriodCopyWith<$Res>  {
  factory $PredictedPeriodCopyWith(PredictedPeriod value, $Res Function(PredictedPeriod) _then) = _$PredictedPeriodCopyWithImpl;
@useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class _$PredictedPeriodCopyWithImpl<$Res>
    implements $PredictedPeriodCopyWith<$Res> {
  _$PredictedPeriodCopyWithImpl(this._self, this._then);

  final PredictedPeriod _self;
  final $Res Function(PredictedPeriod) _then;

/// Create a copy of PredictedPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PredictedPeriod].
extension PredictedPeriodPatterns on PredictedPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PredictedPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PredictedPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PredictedPeriod value)  $default,){
final _that = this;
switch (_that) {
case _PredictedPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PredictedPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _PredictedPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime start,  DateTime end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PredictedPeriod() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime start,  DateTime end)  $default,) {final _that = this;
switch (_that) {
case _PredictedPeriod():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime start,  DateTime end)?  $default,) {final _that = this;
switch (_that) {
case _PredictedPeriod() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _PredictedPeriod implements PredictedPeriod {
  const _PredictedPeriod({required this.start, required this.end});
  

@override final  DateTime start;
@override final  DateTime end;

/// Create a copy of PredictedPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictedPeriodCopyWith<_PredictedPeriod> get copyWith => __$PredictedPeriodCopyWithImpl<_PredictedPeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PredictedPeriod&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'PredictedPeriod(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$PredictedPeriodCopyWith<$Res> implements $PredictedPeriodCopyWith<$Res> {
  factory _$PredictedPeriodCopyWith(_PredictedPeriod value, $Res Function(_PredictedPeriod) _then) = __$PredictedPeriodCopyWithImpl;
@override @useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class __$PredictedPeriodCopyWithImpl<$Res>
    implements _$PredictedPeriodCopyWith<$Res> {
  __$PredictedPeriodCopyWithImpl(this._self, this._then);

  final _PredictedPeriod _self;
  final $Res Function(_PredictedPeriod) _then;

/// Create a copy of PredictedPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_PredictedPeriod(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$FertileWindow {

 DateTime get start; DateTime get end;
/// Create a copy of FertileWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FertileWindowCopyWith<FertileWindow> get copyWith => _$FertileWindowCopyWithImpl<FertileWindow>(this as FertileWindow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FertileWindow&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FertileWindow(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $FertileWindowCopyWith<$Res>  {
  factory $FertileWindowCopyWith(FertileWindow value, $Res Function(FertileWindow) _then) = _$FertileWindowCopyWithImpl;
@useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class _$FertileWindowCopyWithImpl<$Res>
    implements $FertileWindowCopyWith<$Res> {
  _$FertileWindowCopyWithImpl(this._self, this._then);

  final FertileWindow _self;
  final $Res Function(FertileWindow) _then;

/// Create a copy of FertileWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FertileWindow].
extension FertileWindowPatterns on FertileWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FertileWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FertileWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FertileWindow value)  $default,){
final _that = this;
switch (_that) {
case _FertileWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FertileWindow value)?  $default,){
final _that = this;
switch (_that) {
case _FertileWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime start,  DateTime end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FertileWindow() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime start,  DateTime end)  $default,) {final _that = this;
switch (_that) {
case _FertileWindow():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime start,  DateTime end)?  $default,) {final _that = this;
switch (_that) {
case _FertileWindow() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _FertileWindow implements FertileWindow {
  const _FertileWindow({required this.start, required this.end});
  

@override final  DateTime start;
@override final  DateTime end;

/// Create a copy of FertileWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FertileWindowCopyWith<_FertileWindow> get copyWith => __$FertileWindowCopyWithImpl<_FertileWindow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FertileWindow&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FertileWindow(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$FertileWindowCopyWith<$Res> implements $FertileWindowCopyWith<$Res> {
  factory _$FertileWindowCopyWith(_FertileWindow value, $Res Function(_FertileWindow) _then) = __$FertileWindowCopyWithImpl;
@override @useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class __$FertileWindowCopyWithImpl<$Res>
    implements _$FertileWindowCopyWith<$Res> {
  __$FertileWindowCopyWithImpl(this._self, this._then);

  final _FertileWindow _self;
  final $Res Function(_FertileWindow) _then;

/// Create a copy of FertileWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_FertileWindow(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$CycleSettings {

 bool get shareWithCoach; int? get averageCycleLengthOverride; int? get averagePeriodLengthOverride;
/// Create a copy of CycleSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleSettingsCopyWith<CycleSettings> get copyWith => _$CycleSettingsCopyWithImpl<CycleSettings>(this as CycleSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleSettings&&(identical(other.shareWithCoach, shareWithCoach) || other.shareWithCoach == shareWithCoach)&&(identical(other.averageCycleLengthOverride, averageCycleLengthOverride) || other.averageCycleLengthOverride == averageCycleLengthOverride)&&(identical(other.averagePeriodLengthOverride, averagePeriodLengthOverride) || other.averagePeriodLengthOverride == averagePeriodLengthOverride));
}


@override
int get hashCode => Object.hash(runtimeType,shareWithCoach,averageCycleLengthOverride,averagePeriodLengthOverride);

@override
String toString() {
  return 'CycleSettings(shareWithCoach: $shareWithCoach, averageCycleLengthOverride: $averageCycleLengthOverride, averagePeriodLengthOverride: $averagePeriodLengthOverride)';
}


}

/// @nodoc
abstract mixin class $CycleSettingsCopyWith<$Res>  {
  factory $CycleSettingsCopyWith(CycleSettings value, $Res Function(CycleSettings) _then) = _$CycleSettingsCopyWithImpl;
@useResult
$Res call({
 bool shareWithCoach, int? averageCycleLengthOverride, int? averagePeriodLengthOverride
});




}
/// @nodoc
class _$CycleSettingsCopyWithImpl<$Res>
    implements $CycleSettingsCopyWith<$Res> {
  _$CycleSettingsCopyWithImpl(this._self, this._then);

  final CycleSettings _self;
  final $Res Function(CycleSettings) _then;

/// Create a copy of CycleSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shareWithCoach = null,Object? averageCycleLengthOverride = freezed,Object? averagePeriodLengthOverride = freezed,}) {
  return _then(_self.copyWith(
shareWithCoach: null == shareWithCoach ? _self.shareWithCoach : shareWithCoach // ignore: cast_nullable_to_non_nullable
as bool,averageCycleLengthOverride: freezed == averageCycleLengthOverride ? _self.averageCycleLengthOverride : averageCycleLengthOverride // ignore: cast_nullable_to_non_nullable
as int?,averagePeriodLengthOverride: freezed == averagePeriodLengthOverride ? _self.averagePeriodLengthOverride : averagePeriodLengthOverride // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleSettings].
extension CycleSettingsPatterns on CycleSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleSettings value)  $default,){
final _that = this;
switch (_that) {
case _CycleSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleSettings value)?  $default,){
final _that = this;
switch (_that) {
case _CycleSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool shareWithCoach,  int? averageCycleLengthOverride,  int? averagePeriodLengthOverride)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleSettings() when $default != null:
return $default(_that.shareWithCoach,_that.averageCycleLengthOverride,_that.averagePeriodLengthOverride);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool shareWithCoach,  int? averageCycleLengthOverride,  int? averagePeriodLengthOverride)  $default,) {final _that = this;
switch (_that) {
case _CycleSettings():
return $default(_that.shareWithCoach,_that.averageCycleLengthOverride,_that.averagePeriodLengthOverride);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool shareWithCoach,  int? averageCycleLengthOverride,  int? averagePeriodLengthOverride)?  $default,) {final _that = this;
switch (_that) {
case _CycleSettings() when $default != null:
return $default(_that.shareWithCoach,_that.averageCycleLengthOverride,_that.averagePeriodLengthOverride);case _:
  return null;

}
}

}

/// @nodoc


class _CycleSettings implements CycleSettings {
  const _CycleSettings({required this.shareWithCoach, this.averageCycleLengthOverride, this.averagePeriodLengthOverride});
  

@override final  bool shareWithCoach;
@override final  int? averageCycleLengthOverride;
@override final  int? averagePeriodLengthOverride;

/// Create a copy of CycleSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleSettingsCopyWith<_CycleSettings> get copyWith => __$CycleSettingsCopyWithImpl<_CycleSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleSettings&&(identical(other.shareWithCoach, shareWithCoach) || other.shareWithCoach == shareWithCoach)&&(identical(other.averageCycleLengthOverride, averageCycleLengthOverride) || other.averageCycleLengthOverride == averageCycleLengthOverride)&&(identical(other.averagePeriodLengthOverride, averagePeriodLengthOverride) || other.averagePeriodLengthOverride == averagePeriodLengthOverride));
}


@override
int get hashCode => Object.hash(runtimeType,shareWithCoach,averageCycleLengthOverride,averagePeriodLengthOverride);

@override
String toString() {
  return 'CycleSettings(shareWithCoach: $shareWithCoach, averageCycleLengthOverride: $averageCycleLengthOverride, averagePeriodLengthOverride: $averagePeriodLengthOverride)';
}


}

/// @nodoc
abstract mixin class _$CycleSettingsCopyWith<$Res> implements $CycleSettingsCopyWith<$Res> {
  factory _$CycleSettingsCopyWith(_CycleSettings value, $Res Function(_CycleSettings) _then) = __$CycleSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool shareWithCoach, int? averageCycleLengthOverride, int? averagePeriodLengthOverride
});




}
/// @nodoc
class __$CycleSettingsCopyWithImpl<$Res>
    implements _$CycleSettingsCopyWith<$Res> {
  __$CycleSettingsCopyWithImpl(this._self, this._then);

  final _CycleSettings _self;
  final $Res Function(_CycleSettings) _then;

/// Create a copy of CycleSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shareWithCoach = null,Object? averageCycleLengthOverride = freezed,Object? averagePeriodLengthOverride = freezed,}) {
  return _then(_CycleSettings(
shareWithCoach: null == shareWithCoach ? _self.shareWithCoach : shareWithCoach // ignore: cast_nullable_to_non_nullable
as bool,averageCycleLengthOverride: freezed == averageCycleLengthOverride ? _self.averageCycleLengthOverride : averageCycleLengthOverride // ignore: cast_nullable_to_non_nullable
as int?,averagePeriodLengthOverride: freezed == averagePeriodLengthOverride ? _self.averagePeriodLengthOverride : averagePeriodLengthOverride // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$CycleInsight {

 String get language; DateTime get generatedAt; bool get cached; CycleInsightContent get content;
/// Create a copy of CycleInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleInsightCopyWith<CycleInsight> get copyWith => _$CycleInsightCopyWithImpl<CycleInsight>(this as CycleInsight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleInsight&&(identical(other.language, language) || other.language == language)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.cached, cached) || other.cached == cached)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,language,generatedAt,cached,content);

@override
String toString() {
  return 'CycleInsight(language: $language, generatedAt: $generatedAt, cached: $cached, content: $content)';
}


}

/// @nodoc
abstract mixin class $CycleInsightCopyWith<$Res>  {
  factory $CycleInsightCopyWith(CycleInsight value, $Res Function(CycleInsight) _then) = _$CycleInsightCopyWithImpl;
@useResult
$Res call({
 String language, DateTime generatedAt, bool cached, CycleInsightContent content
});


$CycleInsightContentCopyWith<$Res> get content;

}
/// @nodoc
class _$CycleInsightCopyWithImpl<$Res>
    implements $CycleInsightCopyWith<$Res> {
  _$CycleInsightCopyWithImpl(this._self, this._then);

  final CycleInsight _self;
  final $Res Function(CycleInsight) _then;

/// Create a copy of CycleInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? generatedAt = null,Object? cached = null,Object? content = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CycleInsightContent,
  ));
}
/// Create a copy of CycleInsight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CycleInsightContentCopyWith<$Res> get content {
  
  return $CycleInsightContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [CycleInsight].
extension CycleInsightPatterns on CycleInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleInsight value)  $default,){
final _that = this;
switch (_that) {
case _CycleInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleInsight value)?  $default,){
final _that = this;
switch (_that) {
case _CycleInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language,  DateTime generatedAt,  bool cached,  CycleInsightContent content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleInsight() when $default != null:
return $default(_that.language,_that.generatedAt,_that.cached,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language,  DateTime generatedAt,  bool cached,  CycleInsightContent content)  $default,) {final _that = this;
switch (_that) {
case _CycleInsight():
return $default(_that.language,_that.generatedAt,_that.cached,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language,  DateTime generatedAt,  bool cached,  CycleInsightContent content)?  $default,) {final _that = this;
switch (_that) {
case _CycleInsight() when $default != null:
return $default(_that.language,_that.generatedAt,_that.cached,_that.content);case _:
  return null;

}
}

}

/// @nodoc


class _CycleInsight implements CycleInsight {
  const _CycleInsight({required this.language, required this.generatedAt, required this.cached, required this.content});
  

@override final  String language;
@override final  DateTime generatedAt;
@override final  bool cached;
@override final  CycleInsightContent content;

/// Create a copy of CycleInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleInsightCopyWith<_CycleInsight> get copyWith => __$CycleInsightCopyWithImpl<_CycleInsight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleInsight&&(identical(other.language, language) || other.language == language)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.cached, cached) || other.cached == cached)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,language,generatedAt,cached,content);

@override
String toString() {
  return 'CycleInsight(language: $language, generatedAt: $generatedAt, cached: $cached, content: $content)';
}


}

/// @nodoc
abstract mixin class _$CycleInsightCopyWith<$Res> implements $CycleInsightCopyWith<$Res> {
  factory _$CycleInsightCopyWith(_CycleInsight value, $Res Function(_CycleInsight) _then) = __$CycleInsightCopyWithImpl;
@override @useResult
$Res call({
 String language, DateTime generatedAt, bool cached, CycleInsightContent content
});


@override $CycleInsightContentCopyWith<$Res> get content;

}
/// @nodoc
class __$CycleInsightCopyWithImpl<$Res>
    implements _$CycleInsightCopyWith<$Res> {
  __$CycleInsightCopyWithImpl(this._self, this._then);

  final _CycleInsight _self;
  final $Res Function(_CycleInsight) _then;

/// Create a copy of CycleInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? generatedAt = null,Object? cached = null,Object? content = null,}) {
  return _then(_CycleInsight(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CycleInsightContent,
  ));
}

/// Create a copy of CycleInsight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CycleInsightContentCopyWith<$Res> get content {
  
  return $CycleInsightContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}

/// @nodoc
mixin _$CycleInsightContent {

 String get summary; List<String> get cyclePatterns; List<String> get symptomPatterns; List<String> get trainingCorrelations; List<CyclePhaseRecommendation> get phaseRecommendations; List<String> get cautions; String get disclaimer;
/// Create a copy of CycleInsightContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleInsightContentCopyWith<CycleInsightContent> get copyWith => _$CycleInsightContentCopyWithImpl<CycleInsightContent>(this as CycleInsightContent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleInsightContent&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.cyclePatterns, cyclePatterns)&&const DeepCollectionEquality().equals(other.symptomPatterns, symptomPatterns)&&const DeepCollectionEquality().equals(other.trainingCorrelations, trainingCorrelations)&&const DeepCollectionEquality().equals(other.phaseRecommendations, phaseRecommendations)&&const DeepCollectionEquality().equals(other.cautions, cautions)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}


@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(cyclePatterns),const DeepCollectionEquality().hash(symptomPatterns),const DeepCollectionEquality().hash(trainingCorrelations),const DeepCollectionEquality().hash(phaseRecommendations),const DeepCollectionEquality().hash(cautions),disclaimer);

@override
String toString() {
  return 'CycleInsightContent(summary: $summary, cyclePatterns: $cyclePatterns, symptomPatterns: $symptomPatterns, trainingCorrelations: $trainingCorrelations, phaseRecommendations: $phaseRecommendations, cautions: $cautions, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class $CycleInsightContentCopyWith<$Res>  {
  factory $CycleInsightContentCopyWith(CycleInsightContent value, $Res Function(CycleInsightContent) _then) = _$CycleInsightContentCopyWithImpl;
@useResult
$Res call({
 String summary, List<String> cyclePatterns, List<String> symptomPatterns, List<String> trainingCorrelations, List<CyclePhaseRecommendation> phaseRecommendations, List<String> cautions, String disclaimer
});




}
/// @nodoc
class _$CycleInsightContentCopyWithImpl<$Res>
    implements $CycleInsightContentCopyWith<$Res> {
  _$CycleInsightContentCopyWithImpl(this._self, this._then);

  final CycleInsightContent _self;
  final $Res Function(CycleInsightContent) _then;

/// Create a copy of CycleInsightContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? cyclePatterns = null,Object? symptomPatterns = null,Object? trainingCorrelations = null,Object? phaseRecommendations = null,Object? cautions = null,Object? disclaimer = null,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,cyclePatterns: null == cyclePatterns ? _self.cyclePatterns : cyclePatterns // ignore: cast_nullable_to_non_nullable
as List<String>,symptomPatterns: null == symptomPatterns ? _self.symptomPatterns : symptomPatterns // ignore: cast_nullable_to_non_nullable
as List<String>,trainingCorrelations: null == trainingCorrelations ? _self.trainingCorrelations : trainingCorrelations // ignore: cast_nullable_to_non_nullable
as List<String>,phaseRecommendations: null == phaseRecommendations ? _self.phaseRecommendations : phaseRecommendations // ignore: cast_nullable_to_non_nullable
as List<CyclePhaseRecommendation>,cautions: null == cautions ? _self.cautions : cautions // ignore: cast_nullable_to_non_nullable
as List<String>,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleInsightContent].
extension CycleInsightContentPatterns on CycleInsightContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleInsightContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleInsightContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleInsightContent value)  $default,){
final _that = this;
switch (_that) {
case _CycleInsightContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleInsightContent value)?  $default,){
final _that = this;
switch (_that) {
case _CycleInsightContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String summary,  List<String> cyclePatterns,  List<String> symptomPatterns,  List<String> trainingCorrelations,  List<CyclePhaseRecommendation> phaseRecommendations,  List<String> cautions,  String disclaimer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleInsightContent() when $default != null:
return $default(_that.summary,_that.cyclePatterns,_that.symptomPatterns,_that.trainingCorrelations,_that.phaseRecommendations,_that.cautions,_that.disclaimer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String summary,  List<String> cyclePatterns,  List<String> symptomPatterns,  List<String> trainingCorrelations,  List<CyclePhaseRecommendation> phaseRecommendations,  List<String> cautions,  String disclaimer)  $default,) {final _that = this;
switch (_that) {
case _CycleInsightContent():
return $default(_that.summary,_that.cyclePatterns,_that.symptomPatterns,_that.trainingCorrelations,_that.phaseRecommendations,_that.cautions,_that.disclaimer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String summary,  List<String> cyclePatterns,  List<String> symptomPatterns,  List<String> trainingCorrelations,  List<CyclePhaseRecommendation> phaseRecommendations,  List<String> cautions,  String disclaimer)?  $default,) {final _that = this;
switch (_that) {
case _CycleInsightContent() when $default != null:
return $default(_that.summary,_that.cyclePatterns,_that.symptomPatterns,_that.trainingCorrelations,_that.phaseRecommendations,_that.cautions,_that.disclaimer);case _:
  return null;

}
}

}

/// @nodoc


class _CycleInsightContent implements CycleInsightContent {
  const _CycleInsightContent({required this.summary, required final  List<String> cyclePatterns, required final  List<String> symptomPatterns, required final  List<String> trainingCorrelations, required final  List<CyclePhaseRecommendation> phaseRecommendations, required final  List<String> cautions, required this.disclaimer}): _cyclePatterns = cyclePatterns,_symptomPatterns = symptomPatterns,_trainingCorrelations = trainingCorrelations,_phaseRecommendations = phaseRecommendations,_cautions = cautions;
  

@override final  String summary;
 final  List<String> _cyclePatterns;
@override List<String> get cyclePatterns {
  if (_cyclePatterns is EqualUnmodifiableListView) return _cyclePatterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cyclePatterns);
}

 final  List<String> _symptomPatterns;
@override List<String> get symptomPatterns {
  if (_symptomPatterns is EqualUnmodifiableListView) return _symptomPatterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symptomPatterns);
}

 final  List<String> _trainingCorrelations;
@override List<String> get trainingCorrelations {
  if (_trainingCorrelations is EqualUnmodifiableListView) return _trainingCorrelations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trainingCorrelations);
}

 final  List<CyclePhaseRecommendation> _phaseRecommendations;
@override List<CyclePhaseRecommendation> get phaseRecommendations {
  if (_phaseRecommendations is EqualUnmodifiableListView) return _phaseRecommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phaseRecommendations);
}

 final  List<String> _cautions;
@override List<String> get cautions {
  if (_cautions is EqualUnmodifiableListView) return _cautions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cautions);
}

@override final  String disclaimer;

/// Create a copy of CycleInsightContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleInsightContentCopyWith<_CycleInsightContent> get copyWith => __$CycleInsightContentCopyWithImpl<_CycleInsightContent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleInsightContent&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._cyclePatterns, _cyclePatterns)&&const DeepCollectionEquality().equals(other._symptomPatterns, _symptomPatterns)&&const DeepCollectionEquality().equals(other._trainingCorrelations, _trainingCorrelations)&&const DeepCollectionEquality().equals(other._phaseRecommendations, _phaseRecommendations)&&const DeepCollectionEquality().equals(other._cautions, _cautions)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}


@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_cyclePatterns),const DeepCollectionEquality().hash(_symptomPatterns),const DeepCollectionEquality().hash(_trainingCorrelations),const DeepCollectionEquality().hash(_phaseRecommendations),const DeepCollectionEquality().hash(_cautions),disclaimer);

@override
String toString() {
  return 'CycleInsightContent(summary: $summary, cyclePatterns: $cyclePatterns, symptomPatterns: $symptomPatterns, trainingCorrelations: $trainingCorrelations, phaseRecommendations: $phaseRecommendations, cautions: $cautions, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class _$CycleInsightContentCopyWith<$Res> implements $CycleInsightContentCopyWith<$Res> {
  factory _$CycleInsightContentCopyWith(_CycleInsightContent value, $Res Function(_CycleInsightContent) _then) = __$CycleInsightContentCopyWithImpl;
@override @useResult
$Res call({
 String summary, List<String> cyclePatterns, List<String> symptomPatterns, List<String> trainingCorrelations, List<CyclePhaseRecommendation> phaseRecommendations, List<String> cautions, String disclaimer
});




}
/// @nodoc
class __$CycleInsightContentCopyWithImpl<$Res>
    implements _$CycleInsightContentCopyWith<$Res> {
  __$CycleInsightContentCopyWithImpl(this._self, this._then);

  final _CycleInsightContent _self;
  final $Res Function(_CycleInsightContent) _then;

/// Create a copy of CycleInsightContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? cyclePatterns = null,Object? symptomPatterns = null,Object? trainingCorrelations = null,Object? phaseRecommendations = null,Object? cautions = null,Object? disclaimer = null,}) {
  return _then(_CycleInsightContent(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,cyclePatterns: null == cyclePatterns ? _self._cyclePatterns : cyclePatterns // ignore: cast_nullable_to_non_nullable
as List<String>,symptomPatterns: null == symptomPatterns ? _self._symptomPatterns : symptomPatterns // ignore: cast_nullable_to_non_nullable
as List<String>,trainingCorrelations: null == trainingCorrelations ? _self._trainingCorrelations : trainingCorrelations // ignore: cast_nullable_to_non_nullable
as List<String>,phaseRecommendations: null == phaseRecommendations ? _self._phaseRecommendations : phaseRecommendations // ignore: cast_nullable_to_non_nullable
as List<CyclePhaseRecommendation>,cautions: null == cautions ? _self._cautions : cautions // ignore: cast_nullable_to_non_nullable
as List<String>,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CyclePhaseRecommendation {

 String get phase; String get training; String get nutrition;
/// Create a copy of CyclePhaseRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CyclePhaseRecommendationCopyWith<CyclePhaseRecommendation> get copyWith => _$CyclePhaseRecommendationCopyWithImpl<CyclePhaseRecommendation>(this as CyclePhaseRecommendation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CyclePhaseRecommendation&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.training, training) || other.training == training)&&(identical(other.nutrition, nutrition) || other.nutrition == nutrition));
}


@override
int get hashCode => Object.hash(runtimeType,phase,training,nutrition);

@override
String toString() {
  return 'CyclePhaseRecommendation(phase: $phase, training: $training, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class $CyclePhaseRecommendationCopyWith<$Res>  {
  factory $CyclePhaseRecommendationCopyWith(CyclePhaseRecommendation value, $Res Function(CyclePhaseRecommendation) _then) = _$CyclePhaseRecommendationCopyWithImpl;
@useResult
$Res call({
 String phase, String training, String nutrition
});




}
/// @nodoc
class _$CyclePhaseRecommendationCopyWithImpl<$Res>
    implements $CyclePhaseRecommendationCopyWith<$Res> {
  _$CyclePhaseRecommendationCopyWithImpl(this._self, this._then);

  final CyclePhaseRecommendation _self;
  final $Res Function(CyclePhaseRecommendation) _then;

/// Create a copy of CyclePhaseRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? training = null,Object? nutrition = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String,training: null == training ? _self.training : training // ignore: cast_nullable_to_non_nullable
as String,nutrition: null == nutrition ? _self.nutrition : nutrition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CyclePhaseRecommendation].
extension CyclePhaseRecommendationPatterns on CyclePhaseRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CyclePhaseRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CyclePhaseRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CyclePhaseRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _CyclePhaseRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CyclePhaseRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _CyclePhaseRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phase,  String training,  String nutrition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CyclePhaseRecommendation() when $default != null:
return $default(_that.phase,_that.training,_that.nutrition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phase,  String training,  String nutrition)  $default,) {final _that = this;
switch (_that) {
case _CyclePhaseRecommendation():
return $default(_that.phase,_that.training,_that.nutrition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phase,  String training,  String nutrition)?  $default,) {final _that = this;
switch (_that) {
case _CyclePhaseRecommendation() when $default != null:
return $default(_that.phase,_that.training,_that.nutrition);case _:
  return null;

}
}

}

/// @nodoc


class _CyclePhaseRecommendation implements CyclePhaseRecommendation {
  const _CyclePhaseRecommendation({required this.phase, required this.training, required this.nutrition});
  

@override final  String phase;
@override final  String training;
@override final  String nutrition;

/// Create a copy of CyclePhaseRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CyclePhaseRecommendationCopyWith<_CyclePhaseRecommendation> get copyWith => __$CyclePhaseRecommendationCopyWithImpl<_CyclePhaseRecommendation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CyclePhaseRecommendation&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.training, training) || other.training == training)&&(identical(other.nutrition, nutrition) || other.nutrition == nutrition));
}


@override
int get hashCode => Object.hash(runtimeType,phase,training,nutrition);

@override
String toString() {
  return 'CyclePhaseRecommendation(phase: $phase, training: $training, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class _$CyclePhaseRecommendationCopyWith<$Res> implements $CyclePhaseRecommendationCopyWith<$Res> {
  factory _$CyclePhaseRecommendationCopyWith(_CyclePhaseRecommendation value, $Res Function(_CyclePhaseRecommendation) _then) = __$CyclePhaseRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String phase, String training, String nutrition
});




}
/// @nodoc
class __$CyclePhaseRecommendationCopyWithImpl<$Res>
    implements _$CyclePhaseRecommendationCopyWith<$Res> {
  __$CyclePhaseRecommendationCopyWithImpl(this._self, this._then);

  final _CyclePhaseRecommendation _self;
  final $Res Function(_CyclePhaseRecommendation) _then;

/// Create a copy of CyclePhaseRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? training = null,Object? nutrition = null,}) {
  return _then(_CyclePhaseRecommendation(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String,training: null == training ? _self.training : training // ignore: cast_nullable_to_non_nullable
as String,nutrition: null == nutrition ? _self.nutrition : nutrition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
