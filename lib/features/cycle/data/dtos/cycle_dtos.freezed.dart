// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CycleDailyLogDto {

 String get date; List<String> get symptoms; String? get flow; String? get mood; int? get energyLevel; String? get notes;
/// Create a copy of CycleDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleDailyLogDtoCopyWith<CycleDailyLogDto> get copyWith => _$CycleDailyLogDtoCopyWithImpl<CycleDailyLogDto>(this as CycleDailyLogDto, _$identity);

  /// Serializes this CycleDailyLogDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleDailyLogDto&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.symptoms, symptoms)&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.energyLevel, energyLevel) || other.energyLevel == energyLevel)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(symptoms),flow,mood,energyLevel,notes);

@override
String toString() {
  return 'CycleDailyLogDto(date: $date, symptoms: $symptoms, flow: $flow, mood: $mood, energyLevel: $energyLevel, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CycleDailyLogDtoCopyWith<$Res>  {
  factory $CycleDailyLogDtoCopyWith(CycleDailyLogDto value, $Res Function(CycleDailyLogDto) _then) = _$CycleDailyLogDtoCopyWithImpl;
@useResult
$Res call({
 String date, List<String> symptoms, String? flow, String? mood, int? energyLevel, String? notes
});




}
/// @nodoc
class _$CycleDailyLogDtoCopyWithImpl<$Res>
    implements $CycleDailyLogDtoCopyWith<$Res> {
  _$CycleDailyLogDtoCopyWithImpl(this._self, this._then);

  final CycleDailyLogDto _self;
  final $Res Function(CycleDailyLogDto) _then;

/// Create a copy of CycleDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? symptoms = null,Object? flow = freezed,Object? mood = freezed,Object? energyLevel = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symptoms: null == symptoms ? _self.symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<String>,flow: freezed == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as String?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,energyLevel: freezed == energyLevel ? _self.energyLevel : energyLevel // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleDailyLogDto].
extension CycleDailyLogDtoPatterns on CycleDailyLogDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleDailyLogDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleDailyLogDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleDailyLogDto value)  $default,){
final _that = this;
switch (_that) {
case _CycleDailyLogDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleDailyLogDto value)?  $default,){
final _that = this;
switch (_that) {
case _CycleDailyLogDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  List<String> symptoms,  String? flow,  String? mood,  int? energyLevel,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleDailyLogDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  List<String> symptoms,  String? flow,  String? mood,  int? energyLevel,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _CycleDailyLogDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  List<String> symptoms,  String? flow,  String? mood,  int? energyLevel,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _CycleDailyLogDto() when $default != null:
return $default(_that.date,_that.symptoms,_that.flow,_that.mood,_that.energyLevel,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleDailyLogDto extends CycleDailyLogDto {
  const _CycleDailyLogDto({required this.date, final  List<String> symptoms = const <String>[], this.flow, this.mood, this.energyLevel, this.notes}): _symptoms = symptoms,super._();
  factory _CycleDailyLogDto.fromJson(Map<String, dynamic> json) => _$CycleDailyLogDtoFromJson(json);

@override final  String date;
 final  List<String> _symptoms;
@override@JsonKey() List<String> get symptoms {
  if (_symptoms is EqualUnmodifiableListView) return _symptoms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symptoms);
}

@override final  String? flow;
@override final  String? mood;
@override final  int? energyLevel;
@override final  String? notes;

/// Create a copy of CycleDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleDailyLogDtoCopyWith<_CycleDailyLogDto> get copyWith => __$CycleDailyLogDtoCopyWithImpl<_CycleDailyLogDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleDailyLogDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleDailyLogDto&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._symptoms, _symptoms)&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.energyLevel, energyLevel) || other.energyLevel == energyLevel)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_symptoms),flow,mood,energyLevel,notes);

@override
String toString() {
  return 'CycleDailyLogDto(date: $date, symptoms: $symptoms, flow: $flow, mood: $mood, energyLevel: $energyLevel, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CycleDailyLogDtoCopyWith<$Res> implements $CycleDailyLogDtoCopyWith<$Res> {
  factory _$CycleDailyLogDtoCopyWith(_CycleDailyLogDto value, $Res Function(_CycleDailyLogDto) _then) = __$CycleDailyLogDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, List<String> symptoms, String? flow, String? mood, int? energyLevel, String? notes
});




}
/// @nodoc
class __$CycleDailyLogDtoCopyWithImpl<$Res>
    implements _$CycleDailyLogDtoCopyWith<$Res> {
  __$CycleDailyLogDtoCopyWithImpl(this._self, this._then);

  final _CycleDailyLogDto _self;
  final $Res Function(_CycleDailyLogDto) _then;

/// Create a copy of CycleDailyLogDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? symptoms = null,Object? flow = freezed,Object? mood = freezed,Object? energyLevel = freezed,Object? notes = freezed,}) {
  return _then(_CycleDailyLogDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symptoms: null == symptoms ? _self._symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<String>,flow: freezed == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as String?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,energyLevel: freezed == energyLevel ? _self.energyLevel : energyLevel // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CycleOverviewDto {

 String get currentPhase; int get effectiveCycleLengthDays; int get effectivePeriodLengthDays; bool get isRegular; String get confidence; bool get needsData; List<PredictedPeriodDto> get predictedPeriods; List<String> get ovulationDates; List<FertileWindowDto> get fertileWindows; int? get cycleDay; int? get daysUntilNextPeriod; int? get daysLate; String? get lastPeriodStart; String? get nextPeriodStart; String? get currentPeriodPredictedEnd; int? get avgCycleLengthDays; int? get avgPeriodLengthDays; int? get cycleVariabilityDays;
/// Create a copy of CycleOverviewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleOverviewDtoCopyWith<CycleOverviewDto> get copyWith => _$CycleOverviewDtoCopyWithImpl<CycleOverviewDto>(this as CycleOverviewDto, _$identity);

  /// Serializes this CycleOverviewDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleOverviewDto&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.effectiveCycleLengthDays, effectiveCycleLengthDays) || other.effectiveCycleLengthDays == effectiveCycleLengthDays)&&(identical(other.effectivePeriodLengthDays, effectivePeriodLengthDays) || other.effectivePeriodLengthDays == effectivePeriodLengthDays)&&(identical(other.isRegular, isRegular) || other.isRegular == isRegular)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.needsData, needsData) || other.needsData == needsData)&&const DeepCollectionEquality().equals(other.predictedPeriods, predictedPeriods)&&const DeepCollectionEquality().equals(other.ovulationDates, ovulationDates)&&const DeepCollectionEquality().equals(other.fertileWindows, fertileWindows)&&(identical(other.cycleDay, cycleDay) || other.cycleDay == cycleDay)&&(identical(other.daysUntilNextPeriod, daysUntilNextPeriod) || other.daysUntilNextPeriod == daysUntilNextPeriod)&&(identical(other.daysLate, daysLate) || other.daysLate == daysLate)&&(identical(other.lastPeriodStart, lastPeriodStart) || other.lastPeriodStart == lastPeriodStart)&&(identical(other.nextPeriodStart, nextPeriodStart) || other.nextPeriodStart == nextPeriodStart)&&(identical(other.currentPeriodPredictedEnd, currentPeriodPredictedEnd) || other.currentPeriodPredictedEnd == currentPeriodPredictedEnd)&&(identical(other.avgCycleLengthDays, avgCycleLengthDays) || other.avgCycleLengthDays == avgCycleLengthDays)&&(identical(other.avgPeriodLengthDays, avgPeriodLengthDays) || other.avgPeriodLengthDays == avgPeriodLengthDays)&&(identical(other.cycleVariabilityDays, cycleVariabilityDays) || other.cycleVariabilityDays == cycleVariabilityDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPhase,effectiveCycleLengthDays,effectivePeriodLengthDays,isRegular,confidence,needsData,const DeepCollectionEquality().hash(predictedPeriods),const DeepCollectionEquality().hash(ovulationDates),const DeepCollectionEquality().hash(fertileWindows),cycleDay,daysUntilNextPeriod,daysLate,lastPeriodStart,nextPeriodStart,currentPeriodPredictedEnd,avgCycleLengthDays,avgPeriodLengthDays,cycleVariabilityDays);

@override
String toString() {
  return 'CycleOverviewDto(currentPhase: $currentPhase, effectiveCycleLengthDays: $effectiveCycleLengthDays, effectivePeriodLengthDays: $effectivePeriodLengthDays, isRegular: $isRegular, confidence: $confidence, needsData: $needsData, predictedPeriods: $predictedPeriods, ovulationDates: $ovulationDates, fertileWindows: $fertileWindows, cycleDay: $cycleDay, daysUntilNextPeriod: $daysUntilNextPeriod, daysLate: $daysLate, lastPeriodStart: $lastPeriodStart, nextPeriodStart: $nextPeriodStart, currentPeriodPredictedEnd: $currentPeriodPredictedEnd, avgCycleLengthDays: $avgCycleLengthDays, avgPeriodLengthDays: $avgPeriodLengthDays, cycleVariabilityDays: $cycleVariabilityDays)';
}


}

/// @nodoc
abstract mixin class $CycleOverviewDtoCopyWith<$Res>  {
  factory $CycleOverviewDtoCopyWith(CycleOverviewDto value, $Res Function(CycleOverviewDto) _then) = _$CycleOverviewDtoCopyWithImpl;
@useResult
$Res call({
 String currentPhase, int effectiveCycleLengthDays, int effectivePeriodLengthDays, bool isRegular, String confidence, bool needsData, List<PredictedPeriodDto> predictedPeriods, List<String> ovulationDates, List<FertileWindowDto> fertileWindows, int? cycleDay, int? daysUntilNextPeriod, int? daysLate, String? lastPeriodStart, String? nextPeriodStart, String? currentPeriodPredictedEnd, int? avgCycleLengthDays, int? avgPeriodLengthDays, int? cycleVariabilityDays
});




}
/// @nodoc
class _$CycleOverviewDtoCopyWithImpl<$Res>
    implements $CycleOverviewDtoCopyWith<$Res> {
  _$CycleOverviewDtoCopyWithImpl(this._self, this._then);

  final CycleOverviewDto _self;
  final $Res Function(CycleOverviewDto) _then;

/// Create a copy of CycleOverviewDto
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
as List<PredictedPeriodDto>,ovulationDates: null == ovulationDates ? _self.ovulationDates : ovulationDates // ignore: cast_nullable_to_non_nullable
as List<String>,fertileWindows: null == fertileWindows ? _self.fertileWindows : fertileWindows // ignore: cast_nullable_to_non_nullable
as List<FertileWindowDto>,cycleDay: freezed == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int?,daysUntilNextPeriod: freezed == daysUntilNextPeriod ? _self.daysUntilNextPeriod : daysUntilNextPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysLate: freezed == daysLate ? _self.daysLate : daysLate // ignore: cast_nullable_to_non_nullable
as int?,lastPeriodStart: freezed == lastPeriodStart ? _self.lastPeriodStart : lastPeriodStart // ignore: cast_nullable_to_non_nullable
as String?,nextPeriodStart: freezed == nextPeriodStart ? _self.nextPeriodStart : nextPeriodStart // ignore: cast_nullable_to_non_nullable
as String?,currentPeriodPredictedEnd: freezed == currentPeriodPredictedEnd ? _self.currentPeriodPredictedEnd : currentPeriodPredictedEnd // ignore: cast_nullable_to_non_nullable
as String?,avgCycleLengthDays: freezed == avgCycleLengthDays ? _self.avgCycleLengthDays : avgCycleLengthDays // ignore: cast_nullable_to_non_nullable
as int?,avgPeriodLengthDays: freezed == avgPeriodLengthDays ? _self.avgPeriodLengthDays : avgPeriodLengthDays // ignore: cast_nullable_to_non_nullable
as int?,cycleVariabilityDays: freezed == cycleVariabilityDays ? _self.cycleVariabilityDays : cycleVariabilityDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleOverviewDto].
extension CycleOverviewDtoPatterns on CycleOverviewDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleOverviewDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleOverviewDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleOverviewDto value)  $default,){
final _that = this;
switch (_that) {
case _CycleOverviewDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleOverviewDto value)?  $default,){
final _that = this;
switch (_that) {
case _CycleOverviewDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currentPhase,  int effectiveCycleLengthDays,  int effectivePeriodLengthDays,  bool isRegular,  String confidence,  bool needsData,  List<PredictedPeriodDto> predictedPeriods,  List<String> ovulationDates,  List<FertileWindowDto> fertileWindows,  int? cycleDay,  int? daysUntilNextPeriod,  int? daysLate,  String? lastPeriodStart,  String? nextPeriodStart,  String? currentPeriodPredictedEnd,  int? avgCycleLengthDays,  int? avgPeriodLengthDays,  int? cycleVariabilityDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleOverviewDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currentPhase,  int effectiveCycleLengthDays,  int effectivePeriodLengthDays,  bool isRegular,  String confidence,  bool needsData,  List<PredictedPeriodDto> predictedPeriods,  List<String> ovulationDates,  List<FertileWindowDto> fertileWindows,  int? cycleDay,  int? daysUntilNextPeriod,  int? daysLate,  String? lastPeriodStart,  String? nextPeriodStart,  String? currentPeriodPredictedEnd,  int? avgCycleLengthDays,  int? avgPeriodLengthDays,  int? cycleVariabilityDays)  $default,) {final _that = this;
switch (_that) {
case _CycleOverviewDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currentPhase,  int effectiveCycleLengthDays,  int effectivePeriodLengthDays,  bool isRegular,  String confidence,  bool needsData,  List<PredictedPeriodDto> predictedPeriods,  List<String> ovulationDates,  List<FertileWindowDto> fertileWindows,  int? cycleDay,  int? daysUntilNextPeriod,  int? daysLate,  String? lastPeriodStart,  String? nextPeriodStart,  String? currentPeriodPredictedEnd,  int? avgCycleLengthDays,  int? avgPeriodLengthDays,  int? cycleVariabilityDays)?  $default,) {final _that = this;
switch (_that) {
case _CycleOverviewDto() when $default != null:
return $default(_that.currentPhase,_that.effectiveCycleLengthDays,_that.effectivePeriodLengthDays,_that.isRegular,_that.confidence,_that.needsData,_that.predictedPeriods,_that.ovulationDates,_that.fertileWindows,_that.cycleDay,_that.daysUntilNextPeriod,_that.daysLate,_that.lastPeriodStart,_that.nextPeriodStart,_that.currentPeriodPredictedEnd,_that.avgCycleLengthDays,_that.avgPeriodLengthDays,_that.cycleVariabilityDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleOverviewDto extends CycleOverviewDto {
  const _CycleOverviewDto({required this.currentPhase, required this.effectiveCycleLengthDays, required this.effectivePeriodLengthDays, required this.isRegular, required this.confidence, required this.needsData, final  List<PredictedPeriodDto> predictedPeriods = const <PredictedPeriodDto>[], final  List<String> ovulationDates = const <String>[], final  List<FertileWindowDto> fertileWindows = const <FertileWindowDto>[], this.cycleDay, this.daysUntilNextPeriod, this.daysLate, this.lastPeriodStart, this.nextPeriodStart, this.currentPeriodPredictedEnd, this.avgCycleLengthDays, this.avgPeriodLengthDays, this.cycleVariabilityDays}): _predictedPeriods = predictedPeriods,_ovulationDates = ovulationDates,_fertileWindows = fertileWindows,super._();
  factory _CycleOverviewDto.fromJson(Map<String, dynamic> json) => _$CycleOverviewDtoFromJson(json);

@override final  String currentPhase;
@override final  int effectiveCycleLengthDays;
@override final  int effectivePeriodLengthDays;
@override final  bool isRegular;
@override final  String confidence;
@override final  bool needsData;
 final  List<PredictedPeriodDto> _predictedPeriods;
@override@JsonKey() List<PredictedPeriodDto> get predictedPeriods {
  if (_predictedPeriods is EqualUnmodifiableListView) return _predictedPeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_predictedPeriods);
}

 final  List<String> _ovulationDates;
@override@JsonKey() List<String> get ovulationDates {
  if (_ovulationDates is EqualUnmodifiableListView) return _ovulationDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ovulationDates);
}

 final  List<FertileWindowDto> _fertileWindows;
@override@JsonKey() List<FertileWindowDto> get fertileWindows {
  if (_fertileWindows is EqualUnmodifiableListView) return _fertileWindows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fertileWindows);
}

@override final  int? cycleDay;
@override final  int? daysUntilNextPeriod;
@override final  int? daysLate;
@override final  String? lastPeriodStart;
@override final  String? nextPeriodStart;
@override final  String? currentPeriodPredictedEnd;
@override final  int? avgCycleLengthDays;
@override final  int? avgPeriodLengthDays;
@override final  int? cycleVariabilityDays;

/// Create a copy of CycleOverviewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleOverviewDtoCopyWith<_CycleOverviewDto> get copyWith => __$CycleOverviewDtoCopyWithImpl<_CycleOverviewDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleOverviewDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleOverviewDto&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.effectiveCycleLengthDays, effectiveCycleLengthDays) || other.effectiveCycleLengthDays == effectiveCycleLengthDays)&&(identical(other.effectivePeriodLengthDays, effectivePeriodLengthDays) || other.effectivePeriodLengthDays == effectivePeriodLengthDays)&&(identical(other.isRegular, isRegular) || other.isRegular == isRegular)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.needsData, needsData) || other.needsData == needsData)&&const DeepCollectionEquality().equals(other._predictedPeriods, _predictedPeriods)&&const DeepCollectionEquality().equals(other._ovulationDates, _ovulationDates)&&const DeepCollectionEquality().equals(other._fertileWindows, _fertileWindows)&&(identical(other.cycleDay, cycleDay) || other.cycleDay == cycleDay)&&(identical(other.daysUntilNextPeriod, daysUntilNextPeriod) || other.daysUntilNextPeriod == daysUntilNextPeriod)&&(identical(other.daysLate, daysLate) || other.daysLate == daysLate)&&(identical(other.lastPeriodStart, lastPeriodStart) || other.lastPeriodStart == lastPeriodStart)&&(identical(other.nextPeriodStart, nextPeriodStart) || other.nextPeriodStart == nextPeriodStart)&&(identical(other.currentPeriodPredictedEnd, currentPeriodPredictedEnd) || other.currentPeriodPredictedEnd == currentPeriodPredictedEnd)&&(identical(other.avgCycleLengthDays, avgCycleLengthDays) || other.avgCycleLengthDays == avgCycleLengthDays)&&(identical(other.avgPeriodLengthDays, avgPeriodLengthDays) || other.avgPeriodLengthDays == avgPeriodLengthDays)&&(identical(other.cycleVariabilityDays, cycleVariabilityDays) || other.cycleVariabilityDays == cycleVariabilityDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPhase,effectiveCycleLengthDays,effectivePeriodLengthDays,isRegular,confidence,needsData,const DeepCollectionEquality().hash(_predictedPeriods),const DeepCollectionEquality().hash(_ovulationDates),const DeepCollectionEquality().hash(_fertileWindows),cycleDay,daysUntilNextPeriod,daysLate,lastPeriodStart,nextPeriodStart,currentPeriodPredictedEnd,avgCycleLengthDays,avgPeriodLengthDays,cycleVariabilityDays);

@override
String toString() {
  return 'CycleOverviewDto(currentPhase: $currentPhase, effectiveCycleLengthDays: $effectiveCycleLengthDays, effectivePeriodLengthDays: $effectivePeriodLengthDays, isRegular: $isRegular, confidence: $confidence, needsData: $needsData, predictedPeriods: $predictedPeriods, ovulationDates: $ovulationDates, fertileWindows: $fertileWindows, cycleDay: $cycleDay, daysUntilNextPeriod: $daysUntilNextPeriod, daysLate: $daysLate, lastPeriodStart: $lastPeriodStart, nextPeriodStart: $nextPeriodStart, currentPeriodPredictedEnd: $currentPeriodPredictedEnd, avgCycleLengthDays: $avgCycleLengthDays, avgPeriodLengthDays: $avgPeriodLengthDays, cycleVariabilityDays: $cycleVariabilityDays)';
}


}

/// @nodoc
abstract mixin class _$CycleOverviewDtoCopyWith<$Res> implements $CycleOverviewDtoCopyWith<$Res> {
  factory _$CycleOverviewDtoCopyWith(_CycleOverviewDto value, $Res Function(_CycleOverviewDto) _then) = __$CycleOverviewDtoCopyWithImpl;
@override @useResult
$Res call({
 String currentPhase, int effectiveCycleLengthDays, int effectivePeriodLengthDays, bool isRegular, String confidence, bool needsData, List<PredictedPeriodDto> predictedPeriods, List<String> ovulationDates, List<FertileWindowDto> fertileWindows, int? cycleDay, int? daysUntilNextPeriod, int? daysLate, String? lastPeriodStart, String? nextPeriodStart, String? currentPeriodPredictedEnd, int? avgCycleLengthDays, int? avgPeriodLengthDays, int? cycleVariabilityDays
});




}
/// @nodoc
class __$CycleOverviewDtoCopyWithImpl<$Res>
    implements _$CycleOverviewDtoCopyWith<$Res> {
  __$CycleOverviewDtoCopyWithImpl(this._self, this._then);

  final _CycleOverviewDto _self;
  final $Res Function(_CycleOverviewDto) _then;

/// Create a copy of CycleOverviewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPhase = null,Object? effectiveCycleLengthDays = null,Object? effectivePeriodLengthDays = null,Object? isRegular = null,Object? confidence = null,Object? needsData = null,Object? predictedPeriods = null,Object? ovulationDates = null,Object? fertileWindows = null,Object? cycleDay = freezed,Object? daysUntilNextPeriod = freezed,Object? daysLate = freezed,Object? lastPeriodStart = freezed,Object? nextPeriodStart = freezed,Object? currentPeriodPredictedEnd = freezed,Object? avgCycleLengthDays = freezed,Object? avgPeriodLengthDays = freezed,Object? cycleVariabilityDays = freezed,}) {
  return _then(_CycleOverviewDto(
currentPhase: null == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as String,effectiveCycleLengthDays: null == effectiveCycleLengthDays ? _self.effectiveCycleLengthDays : effectiveCycleLengthDays // ignore: cast_nullable_to_non_nullable
as int,effectivePeriodLengthDays: null == effectivePeriodLengthDays ? _self.effectivePeriodLengthDays : effectivePeriodLengthDays // ignore: cast_nullable_to_non_nullable
as int,isRegular: null == isRegular ? _self.isRegular : isRegular // ignore: cast_nullable_to_non_nullable
as bool,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,needsData: null == needsData ? _self.needsData : needsData // ignore: cast_nullable_to_non_nullable
as bool,predictedPeriods: null == predictedPeriods ? _self._predictedPeriods : predictedPeriods // ignore: cast_nullable_to_non_nullable
as List<PredictedPeriodDto>,ovulationDates: null == ovulationDates ? _self._ovulationDates : ovulationDates // ignore: cast_nullable_to_non_nullable
as List<String>,fertileWindows: null == fertileWindows ? _self._fertileWindows : fertileWindows // ignore: cast_nullable_to_non_nullable
as List<FertileWindowDto>,cycleDay: freezed == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int?,daysUntilNextPeriod: freezed == daysUntilNextPeriod ? _self.daysUntilNextPeriod : daysUntilNextPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysLate: freezed == daysLate ? _self.daysLate : daysLate // ignore: cast_nullable_to_non_nullable
as int?,lastPeriodStart: freezed == lastPeriodStart ? _self.lastPeriodStart : lastPeriodStart // ignore: cast_nullable_to_non_nullable
as String?,nextPeriodStart: freezed == nextPeriodStart ? _self.nextPeriodStart : nextPeriodStart // ignore: cast_nullable_to_non_nullable
as String?,currentPeriodPredictedEnd: freezed == currentPeriodPredictedEnd ? _self.currentPeriodPredictedEnd : currentPeriodPredictedEnd // ignore: cast_nullable_to_non_nullable
as String?,avgCycleLengthDays: freezed == avgCycleLengthDays ? _self.avgCycleLengthDays : avgCycleLengthDays // ignore: cast_nullable_to_non_nullable
as int?,avgPeriodLengthDays: freezed == avgPeriodLengthDays ? _self.avgPeriodLengthDays : avgPeriodLengthDays // ignore: cast_nullable_to_non_nullable
as int?,cycleVariabilityDays: freezed == cycleVariabilityDays ? _self.cycleVariabilityDays : cycleVariabilityDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PredictedPeriodDto {

 String get start; String get end;
/// Create a copy of PredictedPeriodDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictedPeriodDtoCopyWith<PredictedPeriodDto> get copyWith => _$PredictedPeriodDtoCopyWithImpl<PredictedPeriodDto>(this as PredictedPeriodDto, _$identity);

  /// Serializes this PredictedPeriodDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictedPeriodDto&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'PredictedPeriodDto(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $PredictedPeriodDtoCopyWith<$Res>  {
  factory $PredictedPeriodDtoCopyWith(PredictedPeriodDto value, $Res Function(PredictedPeriodDto) _then) = _$PredictedPeriodDtoCopyWithImpl;
@useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class _$PredictedPeriodDtoCopyWithImpl<$Res>
    implements $PredictedPeriodDtoCopyWith<$Res> {
  _$PredictedPeriodDtoCopyWithImpl(this._self, this._then);

  final PredictedPeriodDto _self;
  final $Res Function(PredictedPeriodDto) _then;

/// Create a copy of PredictedPeriodDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PredictedPeriodDto].
extension PredictedPeriodDtoPatterns on PredictedPeriodDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PredictedPeriodDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PredictedPeriodDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PredictedPeriodDto value)  $default,){
final _that = this;
switch (_that) {
case _PredictedPeriodDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PredictedPeriodDto value)?  $default,){
final _that = this;
switch (_that) {
case _PredictedPeriodDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String start,  String end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PredictedPeriodDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String start,  String end)  $default,) {final _that = this;
switch (_that) {
case _PredictedPeriodDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String start,  String end)?  $default,) {final _that = this;
switch (_that) {
case _PredictedPeriodDto() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PredictedPeriodDto extends PredictedPeriodDto {
  const _PredictedPeriodDto({required this.start, required this.end}): super._();
  factory _PredictedPeriodDto.fromJson(Map<String, dynamic> json) => _$PredictedPeriodDtoFromJson(json);

@override final  String start;
@override final  String end;

/// Create a copy of PredictedPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictedPeriodDtoCopyWith<_PredictedPeriodDto> get copyWith => __$PredictedPeriodDtoCopyWithImpl<_PredictedPeriodDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PredictedPeriodDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PredictedPeriodDto&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'PredictedPeriodDto(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$PredictedPeriodDtoCopyWith<$Res> implements $PredictedPeriodDtoCopyWith<$Res> {
  factory _$PredictedPeriodDtoCopyWith(_PredictedPeriodDto value, $Res Function(_PredictedPeriodDto) _then) = __$PredictedPeriodDtoCopyWithImpl;
@override @useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class __$PredictedPeriodDtoCopyWithImpl<$Res>
    implements _$PredictedPeriodDtoCopyWith<$Res> {
  __$PredictedPeriodDtoCopyWithImpl(this._self, this._then);

  final _PredictedPeriodDto _self;
  final $Res Function(_PredictedPeriodDto) _then;

/// Create a copy of PredictedPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_PredictedPeriodDto(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FertileWindowDto {

 String get start; String get end;
/// Create a copy of FertileWindowDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FertileWindowDtoCopyWith<FertileWindowDto> get copyWith => _$FertileWindowDtoCopyWithImpl<FertileWindowDto>(this as FertileWindowDto, _$identity);

  /// Serializes this FertileWindowDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FertileWindowDto&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FertileWindowDto(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $FertileWindowDtoCopyWith<$Res>  {
  factory $FertileWindowDtoCopyWith(FertileWindowDto value, $Res Function(FertileWindowDto) _then) = _$FertileWindowDtoCopyWithImpl;
@useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class _$FertileWindowDtoCopyWithImpl<$Res>
    implements $FertileWindowDtoCopyWith<$Res> {
  _$FertileWindowDtoCopyWithImpl(this._self, this._then);

  final FertileWindowDto _self;
  final $Res Function(FertileWindowDto) _then;

/// Create a copy of FertileWindowDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FertileWindowDto].
extension FertileWindowDtoPatterns on FertileWindowDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FertileWindowDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FertileWindowDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FertileWindowDto value)  $default,){
final _that = this;
switch (_that) {
case _FertileWindowDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FertileWindowDto value)?  $default,){
final _that = this;
switch (_that) {
case _FertileWindowDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String start,  String end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FertileWindowDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String start,  String end)  $default,) {final _that = this;
switch (_that) {
case _FertileWindowDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String start,  String end)?  $default,) {final _that = this;
switch (_that) {
case _FertileWindowDto() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FertileWindowDto extends FertileWindowDto {
  const _FertileWindowDto({required this.start, required this.end}): super._();
  factory _FertileWindowDto.fromJson(Map<String, dynamic> json) => _$FertileWindowDtoFromJson(json);

@override final  String start;
@override final  String end;

/// Create a copy of FertileWindowDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FertileWindowDtoCopyWith<_FertileWindowDto> get copyWith => __$FertileWindowDtoCopyWithImpl<_FertileWindowDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FertileWindowDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FertileWindowDto&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FertileWindowDto(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$FertileWindowDtoCopyWith<$Res> implements $FertileWindowDtoCopyWith<$Res> {
  factory _$FertileWindowDtoCopyWith(_FertileWindowDto value, $Res Function(_FertileWindowDto) _then) = __$FertileWindowDtoCopyWithImpl;
@override @useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class __$FertileWindowDtoCopyWithImpl<$Res>
    implements _$FertileWindowDtoCopyWith<$Res> {
  __$FertileWindowDtoCopyWithImpl(this._self, this._then);

  final _FertileWindowDto _self;
  final $Res Function(_FertileWindowDto) _then;

/// Create a copy of FertileWindowDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_FertileWindowDto(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CycleSettingsDto {

 bool get shareWithCoach; int? get averageCycleLengthOverride; int? get averagePeriodLengthOverride;
/// Create a copy of CycleSettingsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleSettingsDtoCopyWith<CycleSettingsDto> get copyWith => _$CycleSettingsDtoCopyWithImpl<CycleSettingsDto>(this as CycleSettingsDto, _$identity);

  /// Serializes this CycleSettingsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleSettingsDto&&(identical(other.shareWithCoach, shareWithCoach) || other.shareWithCoach == shareWithCoach)&&(identical(other.averageCycleLengthOverride, averageCycleLengthOverride) || other.averageCycleLengthOverride == averageCycleLengthOverride)&&(identical(other.averagePeriodLengthOverride, averagePeriodLengthOverride) || other.averagePeriodLengthOverride == averagePeriodLengthOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shareWithCoach,averageCycleLengthOverride,averagePeriodLengthOverride);

@override
String toString() {
  return 'CycleSettingsDto(shareWithCoach: $shareWithCoach, averageCycleLengthOverride: $averageCycleLengthOverride, averagePeriodLengthOverride: $averagePeriodLengthOverride)';
}


}

/// @nodoc
abstract mixin class $CycleSettingsDtoCopyWith<$Res>  {
  factory $CycleSettingsDtoCopyWith(CycleSettingsDto value, $Res Function(CycleSettingsDto) _then) = _$CycleSettingsDtoCopyWithImpl;
@useResult
$Res call({
 bool shareWithCoach, int? averageCycleLengthOverride, int? averagePeriodLengthOverride
});




}
/// @nodoc
class _$CycleSettingsDtoCopyWithImpl<$Res>
    implements $CycleSettingsDtoCopyWith<$Res> {
  _$CycleSettingsDtoCopyWithImpl(this._self, this._then);

  final CycleSettingsDto _self;
  final $Res Function(CycleSettingsDto) _then;

/// Create a copy of CycleSettingsDto
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


/// Adds pattern-matching-related methods to [CycleSettingsDto].
extension CycleSettingsDtoPatterns on CycleSettingsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleSettingsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleSettingsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleSettingsDto value)  $default,){
final _that = this;
switch (_that) {
case _CycleSettingsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleSettingsDto value)?  $default,){
final _that = this;
switch (_that) {
case _CycleSettingsDto() when $default != null:
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
case _CycleSettingsDto() when $default != null:
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
case _CycleSettingsDto():
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
case _CycleSettingsDto() when $default != null:
return $default(_that.shareWithCoach,_that.averageCycleLengthOverride,_that.averagePeriodLengthOverride);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleSettingsDto extends CycleSettingsDto {
  const _CycleSettingsDto({required this.shareWithCoach, this.averageCycleLengthOverride, this.averagePeriodLengthOverride}): super._();
  factory _CycleSettingsDto.fromJson(Map<String, dynamic> json) => _$CycleSettingsDtoFromJson(json);

@override final  bool shareWithCoach;
@override final  int? averageCycleLengthOverride;
@override final  int? averagePeriodLengthOverride;

/// Create a copy of CycleSettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleSettingsDtoCopyWith<_CycleSettingsDto> get copyWith => __$CycleSettingsDtoCopyWithImpl<_CycleSettingsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleSettingsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleSettingsDto&&(identical(other.shareWithCoach, shareWithCoach) || other.shareWithCoach == shareWithCoach)&&(identical(other.averageCycleLengthOverride, averageCycleLengthOverride) || other.averageCycleLengthOverride == averageCycleLengthOverride)&&(identical(other.averagePeriodLengthOverride, averagePeriodLengthOverride) || other.averagePeriodLengthOverride == averagePeriodLengthOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shareWithCoach,averageCycleLengthOverride,averagePeriodLengthOverride);

@override
String toString() {
  return 'CycleSettingsDto(shareWithCoach: $shareWithCoach, averageCycleLengthOverride: $averageCycleLengthOverride, averagePeriodLengthOverride: $averagePeriodLengthOverride)';
}


}

/// @nodoc
abstract mixin class _$CycleSettingsDtoCopyWith<$Res> implements $CycleSettingsDtoCopyWith<$Res> {
  factory _$CycleSettingsDtoCopyWith(_CycleSettingsDto value, $Res Function(_CycleSettingsDto) _then) = __$CycleSettingsDtoCopyWithImpl;
@override @useResult
$Res call({
 bool shareWithCoach, int? averageCycleLengthOverride, int? averagePeriodLengthOverride
});




}
/// @nodoc
class __$CycleSettingsDtoCopyWithImpl<$Res>
    implements _$CycleSettingsDtoCopyWith<$Res> {
  __$CycleSettingsDtoCopyWithImpl(this._self, this._then);

  final _CycleSettingsDto _self;
  final $Res Function(_CycleSettingsDto) _then;

/// Create a copy of CycleSettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shareWithCoach = null,Object? averageCycleLengthOverride = freezed,Object? averagePeriodLengthOverride = freezed,}) {
  return _then(_CycleSettingsDto(
shareWithCoach: null == shareWithCoach ? _self.shareWithCoach : shareWithCoach // ignore: cast_nullable_to_non_nullable
as bool,averageCycleLengthOverride: freezed == averageCycleLengthOverride ? _self.averageCycleLengthOverride : averageCycleLengthOverride // ignore: cast_nullable_to_non_nullable
as int?,averagePeriodLengthOverride: freezed == averagePeriodLengthOverride ? _self.averagePeriodLengthOverride : averagePeriodLengthOverride // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CycleInsightDto {

 String get language; String get generatedAt; bool get cached; CycleInsightContentDto get content;
/// Create a copy of CycleInsightDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleInsightDtoCopyWith<CycleInsightDto> get copyWith => _$CycleInsightDtoCopyWithImpl<CycleInsightDto>(this as CycleInsightDto, _$identity);

  /// Serializes this CycleInsightDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleInsightDto&&(identical(other.language, language) || other.language == language)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.cached, cached) || other.cached == cached)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,generatedAt,cached,content);

@override
String toString() {
  return 'CycleInsightDto(language: $language, generatedAt: $generatedAt, cached: $cached, content: $content)';
}


}

/// @nodoc
abstract mixin class $CycleInsightDtoCopyWith<$Res>  {
  factory $CycleInsightDtoCopyWith(CycleInsightDto value, $Res Function(CycleInsightDto) _then) = _$CycleInsightDtoCopyWithImpl;
@useResult
$Res call({
 String language, String generatedAt, bool cached, CycleInsightContentDto content
});


$CycleInsightContentDtoCopyWith<$Res> get content;

}
/// @nodoc
class _$CycleInsightDtoCopyWithImpl<$Res>
    implements $CycleInsightDtoCopyWith<$Res> {
  _$CycleInsightDtoCopyWithImpl(this._self, this._then);

  final CycleInsightDto _self;
  final $Res Function(CycleInsightDto) _then;

/// Create a copy of CycleInsightDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? generatedAt = null,Object? cached = null,Object? content = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CycleInsightContentDto,
  ));
}
/// Create a copy of CycleInsightDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CycleInsightContentDtoCopyWith<$Res> get content {
  
  return $CycleInsightContentDtoCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [CycleInsightDto].
extension CycleInsightDtoPatterns on CycleInsightDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleInsightDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleInsightDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleInsightDto value)  $default,){
final _that = this;
switch (_that) {
case _CycleInsightDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleInsightDto value)?  $default,){
final _that = this;
switch (_that) {
case _CycleInsightDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language,  String generatedAt,  bool cached,  CycleInsightContentDto content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleInsightDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language,  String generatedAt,  bool cached,  CycleInsightContentDto content)  $default,) {final _that = this;
switch (_that) {
case _CycleInsightDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language,  String generatedAt,  bool cached,  CycleInsightContentDto content)?  $default,) {final _that = this;
switch (_that) {
case _CycleInsightDto() when $default != null:
return $default(_that.language,_that.generatedAt,_that.cached,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleInsightDto extends CycleInsightDto {
  const _CycleInsightDto({required this.language, required this.generatedAt, required this.cached, required this.content}): super._();
  factory _CycleInsightDto.fromJson(Map<String, dynamic> json) => _$CycleInsightDtoFromJson(json);

@override final  String language;
@override final  String generatedAt;
@override final  bool cached;
@override final  CycleInsightContentDto content;

/// Create a copy of CycleInsightDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleInsightDtoCopyWith<_CycleInsightDto> get copyWith => __$CycleInsightDtoCopyWithImpl<_CycleInsightDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleInsightDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleInsightDto&&(identical(other.language, language) || other.language == language)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.cached, cached) || other.cached == cached)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,generatedAt,cached,content);

@override
String toString() {
  return 'CycleInsightDto(language: $language, generatedAt: $generatedAt, cached: $cached, content: $content)';
}


}

/// @nodoc
abstract mixin class _$CycleInsightDtoCopyWith<$Res> implements $CycleInsightDtoCopyWith<$Res> {
  factory _$CycleInsightDtoCopyWith(_CycleInsightDto value, $Res Function(_CycleInsightDto) _then) = __$CycleInsightDtoCopyWithImpl;
@override @useResult
$Res call({
 String language, String generatedAt, bool cached, CycleInsightContentDto content
});


@override $CycleInsightContentDtoCopyWith<$Res> get content;

}
/// @nodoc
class __$CycleInsightDtoCopyWithImpl<$Res>
    implements _$CycleInsightDtoCopyWith<$Res> {
  __$CycleInsightDtoCopyWithImpl(this._self, this._then);

  final _CycleInsightDto _self;
  final $Res Function(_CycleInsightDto) _then;

/// Create a copy of CycleInsightDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? generatedAt = null,Object? cached = null,Object? content = null,}) {
  return _then(_CycleInsightDto(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as CycleInsightContentDto,
  ));
}

/// Create a copy of CycleInsightDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CycleInsightContentDtoCopyWith<$Res> get content {
  
  return $CycleInsightContentDtoCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// @nodoc
mixin _$CycleInsightContentDto {

 String get summary; String get disclaimer; List<String> get cyclePatterns; List<String> get symptomPatterns; List<String> get trainingCorrelations; List<CyclePhaseRecommendationDto> get phaseRecommendations; List<String> get cautions;
/// Create a copy of CycleInsightContentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleInsightContentDtoCopyWith<CycleInsightContentDto> get copyWith => _$CycleInsightContentDtoCopyWithImpl<CycleInsightContentDto>(this as CycleInsightContentDto, _$identity);

  /// Serializes this CycleInsightContentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleInsightContentDto&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer)&&const DeepCollectionEquality().equals(other.cyclePatterns, cyclePatterns)&&const DeepCollectionEquality().equals(other.symptomPatterns, symptomPatterns)&&const DeepCollectionEquality().equals(other.trainingCorrelations, trainingCorrelations)&&const DeepCollectionEquality().equals(other.phaseRecommendations, phaseRecommendations)&&const DeepCollectionEquality().equals(other.cautions, cautions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,disclaimer,const DeepCollectionEquality().hash(cyclePatterns),const DeepCollectionEquality().hash(symptomPatterns),const DeepCollectionEquality().hash(trainingCorrelations),const DeepCollectionEquality().hash(phaseRecommendations),const DeepCollectionEquality().hash(cautions));

@override
String toString() {
  return 'CycleInsightContentDto(summary: $summary, disclaimer: $disclaimer, cyclePatterns: $cyclePatterns, symptomPatterns: $symptomPatterns, trainingCorrelations: $trainingCorrelations, phaseRecommendations: $phaseRecommendations, cautions: $cautions)';
}


}

/// @nodoc
abstract mixin class $CycleInsightContentDtoCopyWith<$Res>  {
  factory $CycleInsightContentDtoCopyWith(CycleInsightContentDto value, $Res Function(CycleInsightContentDto) _then) = _$CycleInsightContentDtoCopyWithImpl;
@useResult
$Res call({
 String summary, String disclaimer, List<String> cyclePatterns, List<String> symptomPatterns, List<String> trainingCorrelations, List<CyclePhaseRecommendationDto> phaseRecommendations, List<String> cautions
});




}
/// @nodoc
class _$CycleInsightContentDtoCopyWithImpl<$Res>
    implements $CycleInsightContentDtoCopyWith<$Res> {
  _$CycleInsightContentDtoCopyWithImpl(this._self, this._then);

  final CycleInsightContentDto _self;
  final $Res Function(CycleInsightContentDto) _then;

/// Create a copy of CycleInsightContentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? disclaimer = null,Object? cyclePatterns = null,Object? symptomPatterns = null,Object? trainingCorrelations = null,Object? phaseRecommendations = null,Object? cautions = null,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,cyclePatterns: null == cyclePatterns ? _self.cyclePatterns : cyclePatterns // ignore: cast_nullable_to_non_nullable
as List<String>,symptomPatterns: null == symptomPatterns ? _self.symptomPatterns : symptomPatterns // ignore: cast_nullable_to_non_nullable
as List<String>,trainingCorrelations: null == trainingCorrelations ? _self.trainingCorrelations : trainingCorrelations // ignore: cast_nullable_to_non_nullable
as List<String>,phaseRecommendations: null == phaseRecommendations ? _self.phaseRecommendations : phaseRecommendations // ignore: cast_nullable_to_non_nullable
as List<CyclePhaseRecommendationDto>,cautions: null == cautions ? _self.cautions : cautions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleInsightContentDto].
extension CycleInsightContentDtoPatterns on CycleInsightContentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleInsightContentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleInsightContentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleInsightContentDto value)  $default,){
final _that = this;
switch (_that) {
case _CycleInsightContentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleInsightContentDto value)?  $default,){
final _that = this;
switch (_that) {
case _CycleInsightContentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String summary,  String disclaimer,  List<String> cyclePatterns,  List<String> symptomPatterns,  List<String> trainingCorrelations,  List<CyclePhaseRecommendationDto> phaseRecommendations,  List<String> cautions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleInsightContentDto() when $default != null:
return $default(_that.summary,_that.disclaimer,_that.cyclePatterns,_that.symptomPatterns,_that.trainingCorrelations,_that.phaseRecommendations,_that.cautions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String summary,  String disclaimer,  List<String> cyclePatterns,  List<String> symptomPatterns,  List<String> trainingCorrelations,  List<CyclePhaseRecommendationDto> phaseRecommendations,  List<String> cautions)  $default,) {final _that = this;
switch (_that) {
case _CycleInsightContentDto():
return $default(_that.summary,_that.disclaimer,_that.cyclePatterns,_that.symptomPatterns,_that.trainingCorrelations,_that.phaseRecommendations,_that.cautions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String summary,  String disclaimer,  List<String> cyclePatterns,  List<String> symptomPatterns,  List<String> trainingCorrelations,  List<CyclePhaseRecommendationDto> phaseRecommendations,  List<String> cautions)?  $default,) {final _that = this;
switch (_that) {
case _CycleInsightContentDto() when $default != null:
return $default(_that.summary,_that.disclaimer,_that.cyclePatterns,_that.symptomPatterns,_that.trainingCorrelations,_that.phaseRecommendations,_that.cautions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleInsightContentDto extends CycleInsightContentDto {
  const _CycleInsightContentDto({required this.summary, required this.disclaimer, final  List<String> cyclePatterns = const <String>[], final  List<String> symptomPatterns = const <String>[], final  List<String> trainingCorrelations = const <String>[], final  List<CyclePhaseRecommendationDto> phaseRecommendations = const <CyclePhaseRecommendationDto>[], final  List<String> cautions = const <String>[]}): _cyclePatterns = cyclePatterns,_symptomPatterns = symptomPatterns,_trainingCorrelations = trainingCorrelations,_phaseRecommendations = phaseRecommendations,_cautions = cautions,super._();
  factory _CycleInsightContentDto.fromJson(Map<String, dynamic> json) => _$CycleInsightContentDtoFromJson(json);

@override final  String summary;
@override final  String disclaimer;
 final  List<String> _cyclePatterns;
@override@JsonKey() List<String> get cyclePatterns {
  if (_cyclePatterns is EqualUnmodifiableListView) return _cyclePatterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cyclePatterns);
}

 final  List<String> _symptomPatterns;
@override@JsonKey() List<String> get symptomPatterns {
  if (_symptomPatterns is EqualUnmodifiableListView) return _symptomPatterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symptomPatterns);
}

 final  List<String> _trainingCorrelations;
@override@JsonKey() List<String> get trainingCorrelations {
  if (_trainingCorrelations is EqualUnmodifiableListView) return _trainingCorrelations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trainingCorrelations);
}

 final  List<CyclePhaseRecommendationDto> _phaseRecommendations;
@override@JsonKey() List<CyclePhaseRecommendationDto> get phaseRecommendations {
  if (_phaseRecommendations is EqualUnmodifiableListView) return _phaseRecommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phaseRecommendations);
}

 final  List<String> _cautions;
@override@JsonKey() List<String> get cautions {
  if (_cautions is EqualUnmodifiableListView) return _cautions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cautions);
}


/// Create a copy of CycleInsightContentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleInsightContentDtoCopyWith<_CycleInsightContentDto> get copyWith => __$CycleInsightContentDtoCopyWithImpl<_CycleInsightContentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleInsightContentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleInsightContentDto&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer)&&const DeepCollectionEquality().equals(other._cyclePatterns, _cyclePatterns)&&const DeepCollectionEquality().equals(other._symptomPatterns, _symptomPatterns)&&const DeepCollectionEquality().equals(other._trainingCorrelations, _trainingCorrelations)&&const DeepCollectionEquality().equals(other._phaseRecommendations, _phaseRecommendations)&&const DeepCollectionEquality().equals(other._cautions, _cautions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,disclaimer,const DeepCollectionEquality().hash(_cyclePatterns),const DeepCollectionEquality().hash(_symptomPatterns),const DeepCollectionEquality().hash(_trainingCorrelations),const DeepCollectionEquality().hash(_phaseRecommendations),const DeepCollectionEquality().hash(_cautions));

@override
String toString() {
  return 'CycleInsightContentDto(summary: $summary, disclaimer: $disclaimer, cyclePatterns: $cyclePatterns, symptomPatterns: $symptomPatterns, trainingCorrelations: $trainingCorrelations, phaseRecommendations: $phaseRecommendations, cautions: $cautions)';
}


}

/// @nodoc
abstract mixin class _$CycleInsightContentDtoCopyWith<$Res> implements $CycleInsightContentDtoCopyWith<$Res> {
  factory _$CycleInsightContentDtoCopyWith(_CycleInsightContentDto value, $Res Function(_CycleInsightContentDto) _then) = __$CycleInsightContentDtoCopyWithImpl;
@override @useResult
$Res call({
 String summary, String disclaimer, List<String> cyclePatterns, List<String> symptomPatterns, List<String> trainingCorrelations, List<CyclePhaseRecommendationDto> phaseRecommendations, List<String> cautions
});




}
/// @nodoc
class __$CycleInsightContentDtoCopyWithImpl<$Res>
    implements _$CycleInsightContentDtoCopyWith<$Res> {
  __$CycleInsightContentDtoCopyWithImpl(this._self, this._then);

  final _CycleInsightContentDto _self;
  final $Res Function(_CycleInsightContentDto) _then;

/// Create a copy of CycleInsightContentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? disclaimer = null,Object? cyclePatterns = null,Object? symptomPatterns = null,Object? trainingCorrelations = null,Object? phaseRecommendations = null,Object? cautions = null,}) {
  return _then(_CycleInsightContentDto(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,cyclePatterns: null == cyclePatterns ? _self._cyclePatterns : cyclePatterns // ignore: cast_nullable_to_non_nullable
as List<String>,symptomPatterns: null == symptomPatterns ? _self._symptomPatterns : symptomPatterns // ignore: cast_nullable_to_non_nullable
as List<String>,trainingCorrelations: null == trainingCorrelations ? _self._trainingCorrelations : trainingCorrelations // ignore: cast_nullable_to_non_nullable
as List<String>,phaseRecommendations: null == phaseRecommendations ? _self._phaseRecommendations : phaseRecommendations // ignore: cast_nullable_to_non_nullable
as List<CyclePhaseRecommendationDto>,cautions: null == cautions ? _self._cautions : cautions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$CyclePhaseRecommendationDto {

 String get phase; String get training; String get nutrition;
/// Create a copy of CyclePhaseRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CyclePhaseRecommendationDtoCopyWith<CyclePhaseRecommendationDto> get copyWith => _$CyclePhaseRecommendationDtoCopyWithImpl<CyclePhaseRecommendationDto>(this as CyclePhaseRecommendationDto, _$identity);

  /// Serializes this CyclePhaseRecommendationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CyclePhaseRecommendationDto&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.training, training) || other.training == training)&&(identical(other.nutrition, nutrition) || other.nutrition == nutrition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phase,training,nutrition);

@override
String toString() {
  return 'CyclePhaseRecommendationDto(phase: $phase, training: $training, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class $CyclePhaseRecommendationDtoCopyWith<$Res>  {
  factory $CyclePhaseRecommendationDtoCopyWith(CyclePhaseRecommendationDto value, $Res Function(CyclePhaseRecommendationDto) _then) = _$CyclePhaseRecommendationDtoCopyWithImpl;
@useResult
$Res call({
 String phase, String training, String nutrition
});




}
/// @nodoc
class _$CyclePhaseRecommendationDtoCopyWithImpl<$Res>
    implements $CyclePhaseRecommendationDtoCopyWith<$Res> {
  _$CyclePhaseRecommendationDtoCopyWithImpl(this._self, this._then);

  final CyclePhaseRecommendationDto _self;
  final $Res Function(CyclePhaseRecommendationDto) _then;

/// Create a copy of CyclePhaseRecommendationDto
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


/// Adds pattern-matching-related methods to [CyclePhaseRecommendationDto].
extension CyclePhaseRecommendationDtoPatterns on CyclePhaseRecommendationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CyclePhaseRecommendationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CyclePhaseRecommendationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CyclePhaseRecommendationDto value)  $default,){
final _that = this;
switch (_that) {
case _CyclePhaseRecommendationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CyclePhaseRecommendationDto value)?  $default,){
final _that = this;
switch (_that) {
case _CyclePhaseRecommendationDto() when $default != null:
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
case _CyclePhaseRecommendationDto() when $default != null:
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
case _CyclePhaseRecommendationDto():
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
case _CyclePhaseRecommendationDto() when $default != null:
return $default(_that.phase,_that.training,_that.nutrition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CyclePhaseRecommendationDto extends CyclePhaseRecommendationDto {
  const _CyclePhaseRecommendationDto({required this.phase, required this.training, required this.nutrition}): super._();
  factory _CyclePhaseRecommendationDto.fromJson(Map<String, dynamic> json) => _$CyclePhaseRecommendationDtoFromJson(json);

@override final  String phase;
@override final  String training;
@override final  String nutrition;

/// Create a copy of CyclePhaseRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CyclePhaseRecommendationDtoCopyWith<_CyclePhaseRecommendationDto> get copyWith => __$CyclePhaseRecommendationDtoCopyWithImpl<_CyclePhaseRecommendationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CyclePhaseRecommendationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CyclePhaseRecommendationDto&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.training, training) || other.training == training)&&(identical(other.nutrition, nutrition) || other.nutrition == nutrition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phase,training,nutrition);

@override
String toString() {
  return 'CyclePhaseRecommendationDto(phase: $phase, training: $training, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class _$CyclePhaseRecommendationDtoCopyWith<$Res> implements $CyclePhaseRecommendationDtoCopyWith<$Res> {
  factory _$CyclePhaseRecommendationDtoCopyWith(_CyclePhaseRecommendationDto value, $Res Function(_CyclePhaseRecommendationDto) _then) = __$CyclePhaseRecommendationDtoCopyWithImpl;
@override @useResult
$Res call({
 String phase, String training, String nutrition
});




}
/// @nodoc
class __$CyclePhaseRecommendationDtoCopyWithImpl<$Res>
    implements _$CyclePhaseRecommendationDtoCopyWith<$Res> {
  __$CyclePhaseRecommendationDtoCopyWithImpl(this._self, this._then);

  final _CyclePhaseRecommendationDto _self;
  final $Res Function(_CyclePhaseRecommendationDto) _then;

/// Create a copy of CyclePhaseRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? training = null,Object? nutrition = null,}) {
  return _then(_CyclePhaseRecommendationDto(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String,training: null == training ? _self.training : training // ignore: cast_nullable_to_non_nullable
as String,nutrition: null == nutrition ? _self.nutrition : nutrition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
