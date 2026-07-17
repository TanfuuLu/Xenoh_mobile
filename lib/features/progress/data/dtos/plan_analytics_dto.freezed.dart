// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_analytics_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanAnalyticsDto {

 int get totalWorkoutsCompleted; double get totalVolume; double get consistencyPercent; double get avgSessionsPerWeek; int get completedSets; int get highRpeSets; int get warningDays; int get totalDurationSeconds; int get trainingScore; List<TrainingInsightDto> get insights; List<WeekCompliancePointDto> get weeklyCompliance; List<WeekVolumePointDto> get weeklyVolume; List<MuscleGroupPointDto> get muscleGroupVolume; double? get avgRpe; PowerliftingSectionDto? get powerlifting;
/// Create a copy of PlanAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanAnalyticsDtoCopyWith<PlanAnalyticsDto> get copyWith => _$PlanAnalyticsDtoCopyWithImpl<PlanAnalyticsDto>(this as PlanAnalyticsDto, _$identity);

  /// Serializes this PlanAnalyticsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanAnalyticsDto&&(identical(other.totalWorkoutsCompleted, totalWorkoutsCompleted) || other.totalWorkoutsCompleted == totalWorkoutsCompleted)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.consistencyPercent, consistencyPercent) || other.consistencyPercent == consistencyPercent)&&(identical(other.avgSessionsPerWeek, avgSessionsPerWeek) || other.avgSessionsPerWeek == avgSessionsPerWeek)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.highRpeSets, highRpeSets) || other.highRpeSets == highRpeSets)&&(identical(other.warningDays, warningDays) || other.warningDays == warningDays)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.trainingScore, trainingScore) || other.trainingScore == trainingScore)&&const DeepCollectionEquality().equals(other.insights, insights)&&const DeepCollectionEquality().equals(other.weeklyCompliance, weeklyCompliance)&&const DeepCollectionEquality().equals(other.weeklyVolume, weeklyVolume)&&const DeepCollectionEquality().equals(other.muscleGroupVolume, muscleGroupVolume)&&(identical(other.avgRpe, avgRpe) || other.avgRpe == avgRpe)&&(identical(other.powerlifting, powerlifting) || other.powerlifting == powerlifting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalWorkoutsCompleted,totalVolume,consistencyPercent,avgSessionsPerWeek,completedSets,highRpeSets,warningDays,totalDurationSeconds,trainingScore,const DeepCollectionEquality().hash(insights),const DeepCollectionEquality().hash(weeklyCompliance),const DeepCollectionEquality().hash(weeklyVolume),const DeepCollectionEquality().hash(muscleGroupVolume),avgRpe,powerlifting);

@override
String toString() {
  return 'PlanAnalyticsDto(totalWorkoutsCompleted: $totalWorkoutsCompleted, totalVolume: $totalVolume, consistencyPercent: $consistencyPercent, avgSessionsPerWeek: $avgSessionsPerWeek, completedSets: $completedSets, highRpeSets: $highRpeSets, warningDays: $warningDays, totalDurationSeconds: $totalDurationSeconds, trainingScore: $trainingScore, insights: $insights, weeklyCompliance: $weeklyCompliance, weeklyVolume: $weeklyVolume, muscleGroupVolume: $muscleGroupVolume, avgRpe: $avgRpe, powerlifting: $powerlifting)';
}


}

/// @nodoc
abstract mixin class $PlanAnalyticsDtoCopyWith<$Res>  {
  factory $PlanAnalyticsDtoCopyWith(PlanAnalyticsDto value, $Res Function(PlanAnalyticsDto) _then) = _$PlanAnalyticsDtoCopyWithImpl;
@useResult
$Res call({
 int totalWorkoutsCompleted, double totalVolume, double consistencyPercent, double avgSessionsPerWeek, int completedSets, int highRpeSets, int warningDays, int totalDurationSeconds, int trainingScore, List<TrainingInsightDto> insights, List<WeekCompliancePointDto> weeklyCompliance, List<WeekVolumePointDto> weeklyVolume, List<MuscleGroupPointDto> muscleGroupVolume, double? avgRpe, PowerliftingSectionDto? powerlifting
});


$PowerliftingSectionDtoCopyWith<$Res>? get powerlifting;

}
/// @nodoc
class _$PlanAnalyticsDtoCopyWithImpl<$Res>
    implements $PlanAnalyticsDtoCopyWith<$Res> {
  _$PlanAnalyticsDtoCopyWithImpl(this._self, this._then);

  final PlanAnalyticsDto _self;
  final $Res Function(PlanAnalyticsDto) _then;

/// Create a copy of PlanAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalWorkoutsCompleted = null,Object? totalVolume = null,Object? consistencyPercent = null,Object? avgSessionsPerWeek = null,Object? completedSets = null,Object? highRpeSets = null,Object? warningDays = null,Object? totalDurationSeconds = null,Object? trainingScore = null,Object? insights = null,Object? weeklyCompliance = null,Object? weeklyVolume = null,Object? muscleGroupVolume = null,Object? avgRpe = freezed,Object? powerlifting = freezed,}) {
  return _then(_self.copyWith(
totalWorkoutsCompleted: null == totalWorkoutsCompleted ? _self.totalWorkoutsCompleted : totalWorkoutsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,consistencyPercent: null == consistencyPercent ? _self.consistencyPercent : consistencyPercent // ignore: cast_nullable_to_non_nullable
as double,avgSessionsPerWeek: null == avgSessionsPerWeek ? _self.avgSessionsPerWeek : avgSessionsPerWeek // ignore: cast_nullable_to_non_nullable
as double,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,highRpeSets: null == highRpeSets ? _self.highRpeSets : highRpeSets // ignore: cast_nullable_to_non_nullable
as int,warningDays: null == warningDays ? _self.warningDays : warningDays // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,trainingScore: null == trainingScore ? _self.trainingScore : trainingScore // ignore: cast_nullable_to_non_nullable
as int,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<TrainingInsightDto>,weeklyCompliance: null == weeklyCompliance ? _self.weeklyCompliance : weeklyCompliance // ignore: cast_nullable_to_non_nullable
as List<WeekCompliancePointDto>,weeklyVolume: null == weeklyVolume ? _self.weeklyVolume : weeklyVolume // ignore: cast_nullable_to_non_nullable
as List<WeekVolumePointDto>,muscleGroupVolume: null == muscleGroupVolume ? _self.muscleGroupVolume : muscleGroupVolume // ignore: cast_nullable_to_non_nullable
as List<MuscleGroupPointDto>,avgRpe: freezed == avgRpe ? _self.avgRpe : avgRpe // ignore: cast_nullable_to_non_nullable
as double?,powerlifting: freezed == powerlifting ? _self.powerlifting : powerlifting // ignore: cast_nullable_to_non_nullable
as PowerliftingSectionDto?,
  ));
}
/// Create a copy of PlanAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PowerliftingSectionDtoCopyWith<$Res>? get powerlifting {
    if (_self.powerlifting == null) {
    return null;
  }

  return $PowerliftingSectionDtoCopyWith<$Res>(_self.powerlifting!, (value) {
    return _then(_self.copyWith(powerlifting: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanAnalyticsDto].
extension PlanAnalyticsDtoPatterns on PlanAnalyticsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanAnalyticsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanAnalyticsDto value)  $default,){
final _that = this;
switch (_that) {
case _PlanAnalyticsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanAnalyticsDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlanAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalWorkoutsCompleted,  double totalVolume,  double consistencyPercent,  double avgSessionsPerWeek,  int completedSets,  int highRpeSets,  int warningDays,  int totalDurationSeconds,  int trainingScore,  List<TrainingInsightDto> insights,  List<WeekCompliancePointDto> weeklyCompliance,  List<WeekVolumePointDto> weeklyVolume,  List<MuscleGroupPointDto> muscleGroupVolume,  double? avgRpe,  PowerliftingSectionDto? powerlifting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanAnalyticsDto() when $default != null:
return $default(_that.totalWorkoutsCompleted,_that.totalVolume,_that.consistencyPercent,_that.avgSessionsPerWeek,_that.completedSets,_that.highRpeSets,_that.warningDays,_that.totalDurationSeconds,_that.trainingScore,_that.insights,_that.weeklyCompliance,_that.weeklyVolume,_that.muscleGroupVolume,_that.avgRpe,_that.powerlifting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalWorkoutsCompleted,  double totalVolume,  double consistencyPercent,  double avgSessionsPerWeek,  int completedSets,  int highRpeSets,  int warningDays,  int totalDurationSeconds,  int trainingScore,  List<TrainingInsightDto> insights,  List<WeekCompliancePointDto> weeklyCompliance,  List<WeekVolumePointDto> weeklyVolume,  List<MuscleGroupPointDto> muscleGroupVolume,  double? avgRpe,  PowerliftingSectionDto? powerlifting)  $default,) {final _that = this;
switch (_that) {
case _PlanAnalyticsDto():
return $default(_that.totalWorkoutsCompleted,_that.totalVolume,_that.consistencyPercent,_that.avgSessionsPerWeek,_that.completedSets,_that.highRpeSets,_that.warningDays,_that.totalDurationSeconds,_that.trainingScore,_that.insights,_that.weeklyCompliance,_that.weeklyVolume,_that.muscleGroupVolume,_that.avgRpe,_that.powerlifting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalWorkoutsCompleted,  double totalVolume,  double consistencyPercent,  double avgSessionsPerWeek,  int completedSets,  int highRpeSets,  int warningDays,  int totalDurationSeconds,  int trainingScore,  List<TrainingInsightDto> insights,  List<WeekCompliancePointDto> weeklyCompliance,  List<WeekVolumePointDto> weeklyVolume,  List<MuscleGroupPointDto> muscleGroupVolume,  double? avgRpe,  PowerliftingSectionDto? powerlifting)?  $default,) {final _that = this;
switch (_that) {
case _PlanAnalyticsDto() when $default != null:
return $default(_that.totalWorkoutsCompleted,_that.totalVolume,_that.consistencyPercent,_that.avgSessionsPerWeek,_that.completedSets,_that.highRpeSets,_that.warningDays,_that.totalDurationSeconds,_that.trainingScore,_that.insights,_that.weeklyCompliance,_that.weeklyVolume,_that.muscleGroupVolume,_that.avgRpe,_that.powerlifting);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanAnalyticsDto extends PlanAnalyticsDto {
  const _PlanAnalyticsDto({required this.totalWorkoutsCompleted, required this.totalVolume, required this.consistencyPercent, required this.avgSessionsPerWeek, required this.completedSets, required this.highRpeSets, required this.warningDays, required this.totalDurationSeconds, required this.trainingScore, final  List<TrainingInsightDto> insights = const <TrainingInsightDto>[], final  List<WeekCompliancePointDto> weeklyCompliance = const <WeekCompliancePointDto>[], final  List<WeekVolumePointDto> weeklyVolume = const <WeekVolumePointDto>[], final  List<MuscleGroupPointDto> muscleGroupVolume = const <MuscleGroupPointDto>[], this.avgRpe, this.powerlifting}): _insights = insights,_weeklyCompliance = weeklyCompliance,_weeklyVolume = weeklyVolume,_muscleGroupVolume = muscleGroupVolume,super._();
  factory _PlanAnalyticsDto.fromJson(Map<String, dynamic> json) => _$PlanAnalyticsDtoFromJson(json);

@override final  int totalWorkoutsCompleted;
@override final  double totalVolume;
@override final  double consistencyPercent;
@override final  double avgSessionsPerWeek;
@override final  int completedSets;
@override final  int highRpeSets;
@override final  int warningDays;
@override final  int totalDurationSeconds;
@override final  int trainingScore;
 final  List<TrainingInsightDto> _insights;
@override@JsonKey() List<TrainingInsightDto> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}

 final  List<WeekCompliancePointDto> _weeklyCompliance;
@override@JsonKey() List<WeekCompliancePointDto> get weeklyCompliance {
  if (_weeklyCompliance is EqualUnmodifiableListView) return _weeklyCompliance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyCompliance);
}

 final  List<WeekVolumePointDto> _weeklyVolume;
@override@JsonKey() List<WeekVolumePointDto> get weeklyVolume {
  if (_weeklyVolume is EqualUnmodifiableListView) return _weeklyVolume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyVolume);
}

 final  List<MuscleGroupPointDto> _muscleGroupVolume;
@override@JsonKey() List<MuscleGroupPointDto> get muscleGroupVolume {
  if (_muscleGroupVolume is EqualUnmodifiableListView) return _muscleGroupVolume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_muscleGroupVolume);
}

@override final  double? avgRpe;
@override final  PowerliftingSectionDto? powerlifting;

/// Create a copy of PlanAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanAnalyticsDtoCopyWith<_PlanAnalyticsDto> get copyWith => __$PlanAnalyticsDtoCopyWithImpl<_PlanAnalyticsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanAnalyticsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanAnalyticsDto&&(identical(other.totalWorkoutsCompleted, totalWorkoutsCompleted) || other.totalWorkoutsCompleted == totalWorkoutsCompleted)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.consistencyPercent, consistencyPercent) || other.consistencyPercent == consistencyPercent)&&(identical(other.avgSessionsPerWeek, avgSessionsPerWeek) || other.avgSessionsPerWeek == avgSessionsPerWeek)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.highRpeSets, highRpeSets) || other.highRpeSets == highRpeSets)&&(identical(other.warningDays, warningDays) || other.warningDays == warningDays)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.trainingScore, trainingScore) || other.trainingScore == trainingScore)&&const DeepCollectionEquality().equals(other._insights, _insights)&&const DeepCollectionEquality().equals(other._weeklyCompliance, _weeklyCompliance)&&const DeepCollectionEquality().equals(other._weeklyVolume, _weeklyVolume)&&const DeepCollectionEquality().equals(other._muscleGroupVolume, _muscleGroupVolume)&&(identical(other.avgRpe, avgRpe) || other.avgRpe == avgRpe)&&(identical(other.powerlifting, powerlifting) || other.powerlifting == powerlifting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalWorkoutsCompleted,totalVolume,consistencyPercent,avgSessionsPerWeek,completedSets,highRpeSets,warningDays,totalDurationSeconds,trainingScore,const DeepCollectionEquality().hash(_insights),const DeepCollectionEquality().hash(_weeklyCompliance),const DeepCollectionEquality().hash(_weeklyVolume),const DeepCollectionEquality().hash(_muscleGroupVolume),avgRpe,powerlifting);

@override
String toString() {
  return 'PlanAnalyticsDto(totalWorkoutsCompleted: $totalWorkoutsCompleted, totalVolume: $totalVolume, consistencyPercent: $consistencyPercent, avgSessionsPerWeek: $avgSessionsPerWeek, completedSets: $completedSets, highRpeSets: $highRpeSets, warningDays: $warningDays, totalDurationSeconds: $totalDurationSeconds, trainingScore: $trainingScore, insights: $insights, weeklyCompliance: $weeklyCompliance, weeklyVolume: $weeklyVolume, muscleGroupVolume: $muscleGroupVolume, avgRpe: $avgRpe, powerlifting: $powerlifting)';
}


}

/// @nodoc
abstract mixin class _$PlanAnalyticsDtoCopyWith<$Res> implements $PlanAnalyticsDtoCopyWith<$Res> {
  factory _$PlanAnalyticsDtoCopyWith(_PlanAnalyticsDto value, $Res Function(_PlanAnalyticsDto) _then) = __$PlanAnalyticsDtoCopyWithImpl;
@override @useResult
$Res call({
 int totalWorkoutsCompleted, double totalVolume, double consistencyPercent, double avgSessionsPerWeek, int completedSets, int highRpeSets, int warningDays, int totalDurationSeconds, int trainingScore, List<TrainingInsightDto> insights, List<WeekCompliancePointDto> weeklyCompliance, List<WeekVolumePointDto> weeklyVolume, List<MuscleGroupPointDto> muscleGroupVolume, double? avgRpe, PowerliftingSectionDto? powerlifting
});


@override $PowerliftingSectionDtoCopyWith<$Res>? get powerlifting;

}
/// @nodoc
class __$PlanAnalyticsDtoCopyWithImpl<$Res>
    implements _$PlanAnalyticsDtoCopyWith<$Res> {
  __$PlanAnalyticsDtoCopyWithImpl(this._self, this._then);

  final _PlanAnalyticsDto _self;
  final $Res Function(_PlanAnalyticsDto) _then;

/// Create a copy of PlanAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalWorkoutsCompleted = null,Object? totalVolume = null,Object? consistencyPercent = null,Object? avgSessionsPerWeek = null,Object? completedSets = null,Object? highRpeSets = null,Object? warningDays = null,Object? totalDurationSeconds = null,Object? trainingScore = null,Object? insights = null,Object? weeklyCompliance = null,Object? weeklyVolume = null,Object? muscleGroupVolume = null,Object? avgRpe = freezed,Object? powerlifting = freezed,}) {
  return _then(_PlanAnalyticsDto(
totalWorkoutsCompleted: null == totalWorkoutsCompleted ? _self.totalWorkoutsCompleted : totalWorkoutsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,consistencyPercent: null == consistencyPercent ? _self.consistencyPercent : consistencyPercent // ignore: cast_nullable_to_non_nullable
as double,avgSessionsPerWeek: null == avgSessionsPerWeek ? _self.avgSessionsPerWeek : avgSessionsPerWeek // ignore: cast_nullable_to_non_nullable
as double,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,highRpeSets: null == highRpeSets ? _self.highRpeSets : highRpeSets // ignore: cast_nullable_to_non_nullable
as int,warningDays: null == warningDays ? _self.warningDays : warningDays // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,trainingScore: null == trainingScore ? _self.trainingScore : trainingScore // ignore: cast_nullable_to_non_nullable
as int,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<TrainingInsightDto>,weeklyCompliance: null == weeklyCompliance ? _self._weeklyCompliance : weeklyCompliance // ignore: cast_nullable_to_non_nullable
as List<WeekCompliancePointDto>,weeklyVolume: null == weeklyVolume ? _self._weeklyVolume : weeklyVolume // ignore: cast_nullable_to_non_nullable
as List<WeekVolumePointDto>,muscleGroupVolume: null == muscleGroupVolume ? _self._muscleGroupVolume : muscleGroupVolume // ignore: cast_nullable_to_non_nullable
as List<MuscleGroupPointDto>,avgRpe: freezed == avgRpe ? _self.avgRpe : avgRpe // ignore: cast_nullable_to_non_nullable
as double?,powerlifting: freezed == powerlifting ? _self.powerlifting : powerlifting // ignore: cast_nullable_to_non_nullable
as PowerliftingSectionDto?,
  ));
}

/// Create a copy of PlanAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PowerliftingSectionDtoCopyWith<$Res>? get powerlifting {
    if (_self.powerlifting == null) {
    return null;
  }

  return $PowerliftingSectionDtoCopyWith<$Res>(_self.powerlifting!, (value) {
    return _then(_self.copyWith(powerlifting: value));
  });
}
}


/// @nodoc
mixin _$TrainingInsightDto {

 String get type; String get severity; String get title; String get message; String get metricLabel; String get metricValue;
/// Create a copy of TrainingInsightDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingInsightDtoCopyWith<TrainingInsightDto> get copyWith => _$TrainingInsightDtoCopyWithImpl<TrainingInsightDto>(this as TrainingInsightDto, _$identity);

  /// Serializes this TrainingInsightDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingInsightDto&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.metricValue, metricValue) || other.metricValue == metricValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message,metricLabel,metricValue);

@override
String toString() {
  return 'TrainingInsightDto(type: $type, severity: $severity, title: $title, message: $message, metricLabel: $metricLabel, metricValue: $metricValue)';
}


}

/// @nodoc
abstract mixin class $TrainingInsightDtoCopyWith<$Res>  {
  factory $TrainingInsightDtoCopyWith(TrainingInsightDto value, $Res Function(TrainingInsightDto) _then) = _$TrainingInsightDtoCopyWithImpl;
@useResult
$Res call({
 String type, String severity, String title, String message, String metricLabel, String metricValue
});




}
/// @nodoc
class _$TrainingInsightDtoCopyWithImpl<$Res>
    implements $TrainingInsightDtoCopyWith<$Res> {
  _$TrainingInsightDtoCopyWithImpl(this._self, this._then);

  final TrainingInsightDto _self;
  final $Res Function(TrainingInsightDto) _then;

/// Create a copy of TrainingInsightDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? severity = null,Object? title = null,Object? message = null,Object? metricLabel = null,Object? metricValue = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,metricLabel: null == metricLabel ? _self.metricLabel : metricLabel // ignore: cast_nullable_to_non_nullable
as String,metricValue: null == metricValue ? _self.metricValue : metricValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingInsightDto].
extension TrainingInsightDtoPatterns on TrainingInsightDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingInsightDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingInsightDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingInsightDto value)  $default,){
final _that = this;
switch (_that) {
case _TrainingInsightDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingInsightDto value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingInsightDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String severity,  String title,  String message,  String metricLabel,  String metricValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingInsightDto() when $default != null:
return $default(_that.type,_that.severity,_that.title,_that.message,_that.metricLabel,_that.metricValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String severity,  String title,  String message,  String metricLabel,  String metricValue)  $default,) {final _that = this;
switch (_that) {
case _TrainingInsightDto():
return $default(_that.type,_that.severity,_that.title,_that.message,_that.metricLabel,_that.metricValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String severity,  String title,  String message,  String metricLabel,  String metricValue)?  $default,) {final _that = this;
switch (_that) {
case _TrainingInsightDto() when $default != null:
return $default(_that.type,_that.severity,_that.title,_that.message,_that.metricLabel,_that.metricValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingInsightDto extends TrainingInsightDto {
  const _TrainingInsightDto({this.type = '', this.severity = 'Info', this.title = '', this.message = '', this.metricLabel = '', this.metricValue = ''}): super._();
  factory _TrainingInsightDto.fromJson(Map<String, dynamic> json) => _$TrainingInsightDtoFromJson(json);

@override@JsonKey() final  String type;
@override@JsonKey() final  String severity;
@override@JsonKey() final  String title;
@override@JsonKey() final  String message;
@override@JsonKey() final  String metricLabel;
@override@JsonKey() final  String metricValue;

/// Create a copy of TrainingInsightDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingInsightDtoCopyWith<_TrainingInsightDto> get copyWith => __$TrainingInsightDtoCopyWithImpl<_TrainingInsightDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingInsightDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingInsightDto&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.metricValue, metricValue) || other.metricValue == metricValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message,metricLabel,metricValue);

@override
String toString() {
  return 'TrainingInsightDto(type: $type, severity: $severity, title: $title, message: $message, metricLabel: $metricLabel, metricValue: $metricValue)';
}


}

/// @nodoc
abstract mixin class _$TrainingInsightDtoCopyWith<$Res> implements $TrainingInsightDtoCopyWith<$Res> {
  factory _$TrainingInsightDtoCopyWith(_TrainingInsightDto value, $Res Function(_TrainingInsightDto) _then) = __$TrainingInsightDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, String severity, String title, String message, String metricLabel, String metricValue
});




}
/// @nodoc
class __$TrainingInsightDtoCopyWithImpl<$Res>
    implements _$TrainingInsightDtoCopyWith<$Res> {
  __$TrainingInsightDtoCopyWithImpl(this._self, this._then);

  final _TrainingInsightDto _self;
  final $Res Function(_TrainingInsightDto) _then;

/// Create a copy of TrainingInsightDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? severity = null,Object? title = null,Object? message = null,Object? metricLabel = null,Object? metricValue = null,}) {
  return _then(_TrainingInsightDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,metricLabel: null == metricLabel ? _self.metricLabel : metricLabel // ignore: cast_nullable_to_non_nullable
as String,metricValue: null == metricValue ? _self.metricValue : metricValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WeekCompliancePointDto {

 int get weekNumber; int get completedDays; int get totalDays; String get weekName;
/// Create a copy of WeekCompliancePointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekCompliancePointDtoCopyWith<WeekCompliancePointDto> get copyWith => _$WeekCompliancePointDtoCopyWithImpl<WeekCompliancePointDto>(this as WeekCompliancePointDto, _$identity);

  /// Serializes this WeekCompliancePointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeekCompliancePointDto&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.weekName, weekName) || other.weekName == weekName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekNumber,completedDays,totalDays,weekName);

@override
String toString() {
  return 'WeekCompliancePointDto(weekNumber: $weekNumber, completedDays: $completedDays, totalDays: $totalDays, weekName: $weekName)';
}


}

/// @nodoc
abstract mixin class $WeekCompliancePointDtoCopyWith<$Res>  {
  factory $WeekCompliancePointDtoCopyWith(WeekCompliancePointDto value, $Res Function(WeekCompliancePointDto) _then) = _$WeekCompliancePointDtoCopyWithImpl;
@useResult
$Res call({
 int weekNumber, int completedDays, int totalDays, String weekName
});




}
/// @nodoc
class _$WeekCompliancePointDtoCopyWithImpl<$Res>
    implements $WeekCompliancePointDtoCopyWith<$Res> {
  _$WeekCompliancePointDtoCopyWithImpl(this._self, this._then);

  final WeekCompliancePointDto _self;
  final $Res Function(WeekCompliancePointDto) _then;

/// Create a copy of WeekCompliancePointDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekNumber = null,Object? completedDays = null,Object? totalDays = null,Object? weekName = null,}) {
  return _then(_self.copyWith(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WeekCompliancePointDto].
extension WeekCompliancePointDtoPatterns on WeekCompliancePointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeekCompliancePointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeekCompliancePointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeekCompliancePointDto value)  $default,){
final _that = this;
switch (_that) {
case _WeekCompliancePointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeekCompliancePointDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeekCompliancePointDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekNumber,  int completedDays,  int totalDays,  String weekName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeekCompliancePointDto() when $default != null:
return $default(_that.weekNumber,_that.completedDays,_that.totalDays,_that.weekName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekNumber,  int completedDays,  int totalDays,  String weekName)  $default,) {final _that = this;
switch (_that) {
case _WeekCompliancePointDto():
return $default(_that.weekNumber,_that.completedDays,_that.totalDays,_that.weekName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekNumber,  int completedDays,  int totalDays,  String weekName)?  $default,) {final _that = this;
switch (_that) {
case _WeekCompliancePointDto() when $default != null:
return $default(_that.weekNumber,_that.completedDays,_that.totalDays,_that.weekName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeekCompliancePointDto extends WeekCompliancePointDto {
  const _WeekCompliancePointDto({required this.weekNumber, required this.completedDays, required this.totalDays, this.weekName = ''}): super._();
  factory _WeekCompliancePointDto.fromJson(Map<String, dynamic> json) => _$WeekCompliancePointDtoFromJson(json);

@override final  int weekNumber;
@override final  int completedDays;
@override final  int totalDays;
@override@JsonKey() final  String weekName;

/// Create a copy of WeekCompliancePointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekCompliancePointDtoCopyWith<_WeekCompliancePointDto> get copyWith => __$WeekCompliancePointDtoCopyWithImpl<_WeekCompliancePointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeekCompliancePointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekCompliancePointDto&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.weekName, weekName) || other.weekName == weekName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekNumber,completedDays,totalDays,weekName);

@override
String toString() {
  return 'WeekCompliancePointDto(weekNumber: $weekNumber, completedDays: $completedDays, totalDays: $totalDays, weekName: $weekName)';
}


}

/// @nodoc
abstract mixin class _$WeekCompliancePointDtoCopyWith<$Res> implements $WeekCompliancePointDtoCopyWith<$Res> {
  factory _$WeekCompliancePointDtoCopyWith(_WeekCompliancePointDto value, $Res Function(_WeekCompliancePointDto) _then) = __$WeekCompliancePointDtoCopyWithImpl;
@override @useResult
$Res call({
 int weekNumber, int completedDays, int totalDays, String weekName
});




}
/// @nodoc
class __$WeekCompliancePointDtoCopyWithImpl<$Res>
    implements _$WeekCompliancePointDtoCopyWith<$Res> {
  __$WeekCompliancePointDtoCopyWithImpl(this._self, this._then);

  final _WeekCompliancePointDto _self;
  final $Res Function(_WeekCompliancePointDto) _then;

/// Create a copy of WeekCompliancePointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekNumber = null,Object? completedDays = null,Object? totalDays = null,Object? weekName = null,}) {
  return _then(_WeekCompliancePointDto(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WeekVolumePointDto {

 int get weekNumber; double get totalVolume; String get weekName;
/// Create a copy of WeekVolumePointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekVolumePointDtoCopyWith<WeekVolumePointDto> get copyWith => _$WeekVolumePointDtoCopyWithImpl<WeekVolumePointDto>(this as WeekVolumePointDto, _$identity);

  /// Serializes this WeekVolumePointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeekVolumePointDto&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.weekName, weekName) || other.weekName == weekName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekNumber,totalVolume,weekName);

@override
String toString() {
  return 'WeekVolumePointDto(weekNumber: $weekNumber, totalVolume: $totalVolume, weekName: $weekName)';
}


}

/// @nodoc
abstract mixin class $WeekVolumePointDtoCopyWith<$Res>  {
  factory $WeekVolumePointDtoCopyWith(WeekVolumePointDto value, $Res Function(WeekVolumePointDto) _then) = _$WeekVolumePointDtoCopyWithImpl;
@useResult
$Res call({
 int weekNumber, double totalVolume, String weekName
});




}
/// @nodoc
class _$WeekVolumePointDtoCopyWithImpl<$Res>
    implements $WeekVolumePointDtoCopyWith<$Res> {
  _$WeekVolumePointDtoCopyWithImpl(this._self, this._then);

  final WeekVolumePointDto _self;
  final $Res Function(WeekVolumePointDto) _then;

/// Create a copy of WeekVolumePointDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekNumber = null,Object? totalVolume = null,Object? weekName = null,}) {
  return _then(_self.copyWith(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WeekVolumePointDto].
extension WeekVolumePointDtoPatterns on WeekVolumePointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeekVolumePointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeekVolumePointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeekVolumePointDto value)  $default,){
final _that = this;
switch (_that) {
case _WeekVolumePointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeekVolumePointDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeekVolumePointDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekNumber,  double totalVolume,  String weekName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeekVolumePointDto() when $default != null:
return $default(_that.weekNumber,_that.totalVolume,_that.weekName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekNumber,  double totalVolume,  String weekName)  $default,) {final _that = this;
switch (_that) {
case _WeekVolumePointDto():
return $default(_that.weekNumber,_that.totalVolume,_that.weekName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekNumber,  double totalVolume,  String weekName)?  $default,) {final _that = this;
switch (_that) {
case _WeekVolumePointDto() when $default != null:
return $default(_that.weekNumber,_that.totalVolume,_that.weekName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeekVolumePointDto extends WeekVolumePointDto {
  const _WeekVolumePointDto({required this.weekNumber, required this.totalVolume, this.weekName = ''}): super._();
  factory _WeekVolumePointDto.fromJson(Map<String, dynamic> json) => _$WeekVolumePointDtoFromJson(json);

@override final  int weekNumber;
@override final  double totalVolume;
@override@JsonKey() final  String weekName;

/// Create a copy of WeekVolumePointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekVolumePointDtoCopyWith<_WeekVolumePointDto> get copyWith => __$WeekVolumePointDtoCopyWithImpl<_WeekVolumePointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeekVolumePointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekVolumePointDto&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.weekName, weekName) || other.weekName == weekName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekNumber,totalVolume,weekName);

@override
String toString() {
  return 'WeekVolumePointDto(weekNumber: $weekNumber, totalVolume: $totalVolume, weekName: $weekName)';
}


}

/// @nodoc
abstract mixin class _$WeekVolumePointDtoCopyWith<$Res> implements $WeekVolumePointDtoCopyWith<$Res> {
  factory _$WeekVolumePointDtoCopyWith(_WeekVolumePointDto value, $Res Function(_WeekVolumePointDto) _then) = __$WeekVolumePointDtoCopyWithImpl;
@override @useResult
$Res call({
 int weekNumber, double totalVolume, String weekName
});




}
/// @nodoc
class __$WeekVolumePointDtoCopyWithImpl<$Res>
    implements _$WeekVolumePointDtoCopyWith<$Res> {
  __$WeekVolumePointDtoCopyWithImpl(this._self, this._then);

  final _WeekVolumePointDto _self;
  final $Res Function(_WeekVolumePointDto) _then;

/// Create a copy of WeekVolumePointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekNumber = null,Object? totalVolume = null,Object? weekName = null,}) {
  return _then(_WeekVolumePointDto(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MuscleGroupPointDto {

 String get muscleGroup; int get completedSets; double get totalVolume; double get percentOfTotal;
/// Create a copy of MuscleGroupPointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MuscleGroupPointDtoCopyWith<MuscleGroupPointDto> get copyWith => _$MuscleGroupPointDtoCopyWithImpl<MuscleGroupPointDto>(this as MuscleGroupPointDto, _$identity);

  /// Serializes this MuscleGroupPointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MuscleGroupPointDto&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.percentOfTotal, percentOfTotal) || other.percentOfTotal == percentOfTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muscleGroup,completedSets,totalVolume,percentOfTotal);

@override
String toString() {
  return 'MuscleGroupPointDto(muscleGroup: $muscleGroup, completedSets: $completedSets, totalVolume: $totalVolume, percentOfTotal: $percentOfTotal)';
}


}

/// @nodoc
abstract mixin class $MuscleGroupPointDtoCopyWith<$Res>  {
  factory $MuscleGroupPointDtoCopyWith(MuscleGroupPointDto value, $Res Function(MuscleGroupPointDto) _then) = _$MuscleGroupPointDtoCopyWithImpl;
@useResult
$Res call({
 String muscleGroup, int completedSets, double totalVolume, double percentOfTotal
});




}
/// @nodoc
class _$MuscleGroupPointDtoCopyWithImpl<$Res>
    implements $MuscleGroupPointDtoCopyWith<$Res> {
  _$MuscleGroupPointDtoCopyWithImpl(this._self, this._then);

  final MuscleGroupPointDto _self;
  final $Res Function(MuscleGroupPointDto) _then;

/// Create a copy of MuscleGroupPointDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muscleGroup = null,Object? completedSets = null,Object? totalVolume = null,Object? percentOfTotal = null,}) {
  return _then(_self.copyWith(
muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,percentOfTotal: null == percentOfTotal ? _self.percentOfTotal : percentOfTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MuscleGroupPointDto].
extension MuscleGroupPointDtoPatterns on MuscleGroupPointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MuscleGroupPointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MuscleGroupPointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MuscleGroupPointDto value)  $default,){
final _that = this;
switch (_that) {
case _MuscleGroupPointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MuscleGroupPointDto value)?  $default,){
final _that = this;
switch (_that) {
case _MuscleGroupPointDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muscleGroup,  int completedSets,  double totalVolume,  double percentOfTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MuscleGroupPointDto() when $default != null:
return $default(_that.muscleGroup,_that.completedSets,_that.totalVolume,_that.percentOfTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muscleGroup,  int completedSets,  double totalVolume,  double percentOfTotal)  $default,) {final _that = this;
switch (_that) {
case _MuscleGroupPointDto():
return $default(_that.muscleGroup,_that.completedSets,_that.totalVolume,_that.percentOfTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muscleGroup,  int completedSets,  double totalVolume,  double percentOfTotal)?  $default,) {final _that = this;
switch (_that) {
case _MuscleGroupPointDto() when $default != null:
return $default(_that.muscleGroup,_that.completedSets,_that.totalVolume,_that.percentOfTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MuscleGroupPointDto extends MuscleGroupPointDto {
  const _MuscleGroupPointDto({this.muscleGroup = '', this.completedSets = 0, this.totalVolume = 0.0, this.percentOfTotal = 0.0}): super._();
  factory _MuscleGroupPointDto.fromJson(Map<String, dynamic> json) => _$MuscleGroupPointDtoFromJson(json);

@override@JsonKey() final  String muscleGroup;
@override@JsonKey() final  int completedSets;
@override@JsonKey() final  double totalVolume;
@override@JsonKey() final  double percentOfTotal;

/// Create a copy of MuscleGroupPointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MuscleGroupPointDtoCopyWith<_MuscleGroupPointDto> get copyWith => __$MuscleGroupPointDtoCopyWithImpl<_MuscleGroupPointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MuscleGroupPointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MuscleGroupPointDto&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.percentOfTotal, percentOfTotal) || other.percentOfTotal == percentOfTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muscleGroup,completedSets,totalVolume,percentOfTotal);

@override
String toString() {
  return 'MuscleGroupPointDto(muscleGroup: $muscleGroup, completedSets: $completedSets, totalVolume: $totalVolume, percentOfTotal: $percentOfTotal)';
}


}

/// @nodoc
abstract mixin class _$MuscleGroupPointDtoCopyWith<$Res> implements $MuscleGroupPointDtoCopyWith<$Res> {
  factory _$MuscleGroupPointDtoCopyWith(_MuscleGroupPointDto value, $Res Function(_MuscleGroupPointDto) _then) = __$MuscleGroupPointDtoCopyWithImpl;
@override @useResult
$Res call({
 String muscleGroup, int completedSets, double totalVolume, double percentOfTotal
});




}
/// @nodoc
class __$MuscleGroupPointDtoCopyWithImpl<$Res>
    implements _$MuscleGroupPointDtoCopyWith<$Res> {
  __$MuscleGroupPointDtoCopyWithImpl(this._self, this._then);

  final _MuscleGroupPointDto _self;
  final $Res Function(_MuscleGroupPointDto) _then;

/// Create a copy of MuscleGroupPointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muscleGroup = null,Object? completedSets = null,Object? totalVolume = null,Object? percentOfTotal = null,}) {
  return _then(_MuscleGroupPointDto(
muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,percentOfTotal: null == percentOfTotal ? _self.percentOfTotal : percentOfTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PowerliftingSectionDto {

 LiftSeriesDto get squat; LiftSeriesDto get bench; LiftSeriesDto get deadlift; List<DotsPointDto> get dots;
/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PowerliftingSectionDtoCopyWith<PowerliftingSectionDto> get copyWith => _$PowerliftingSectionDtoCopyWithImpl<PowerliftingSectionDto>(this as PowerliftingSectionDto, _$identity);

  /// Serializes this PowerliftingSectionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PowerliftingSectionDto&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift)&&const DeepCollectionEquality().equals(other.dots, dots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift,const DeepCollectionEquality().hash(dots));

@override
String toString() {
  return 'PowerliftingSectionDto(squat: $squat, bench: $bench, deadlift: $deadlift, dots: $dots)';
}


}

/// @nodoc
abstract mixin class $PowerliftingSectionDtoCopyWith<$Res>  {
  factory $PowerliftingSectionDtoCopyWith(PowerliftingSectionDto value, $Res Function(PowerliftingSectionDto) _then) = _$PowerliftingSectionDtoCopyWithImpl;
@useResult
$Res call({
 LiftSeriesDto squat, LiftSeriesDto bench, LiftSeriesDto deadlift, List<DotsPointDto> dots
});


$LiftSeriesDtoCopyWith<$Res> get squat;$LiftSeriesDtoCopyWith<$Res> get bench;$LiftSeriesDtoCopyWith<$Res> get deadlift;

}
/// @nodoc
class _$PowerliftingSectionDtoCopyWithImpl<$Res>
    implements $PowerliftingSectionDtoCopyWith<$Res> {
  _$PowerliftingSectionDtoCopyWithImpl(this._self, this._then);

  final PowerliftingSectionDto _self;
  final $Res Function(PowerliftingSectionDto) _then;

/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? squat = null,Object? bench = null,Object? deadlift = null,Object? dots = null,}) {
  return _then(_self.copyWith(
squat: null == squat ? _self.squat : squat // ignore: cast_nullable_to_non_nullable
as LiftSeriesDto,bench: null == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as LiftSeriesDto,deadlift: null == deadlift ? _self.deadlift : deadlift // ignore: cast_nullable_to_non_nullable
as LiftSeriesDto,dots: null == dots ? _self.dots : dots // ignore: cast_nullable_to_non_nullable
as List<DotsPointDto>,
  ));
}
/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesDtoCopyWith<$Res> get squat {
  
  return $LiftSeriesDtoCopyWith<$Res>(_self.squat, (value) {
    return _then(_self.copyWith(squat: value));
  });
}/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesDtoCopyWith<$Res> get bench {
  
  return $LiftSeriesDtoCopyWith<$Res>(_self.bench, (value) {
    return _then(_self.copyWith(bench: value));
  });
}/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesDtoCopyWith<$Res> get deadlift {
  
  return $LiftSeriesDtoCopyWith<$Res>(_self.deadlift, (value) {
    return _then(_self.copyWith(deadlift: value));
  });
}
}


/// Adds pattern-matching-related methods to [PowerliftingSectionDto].
extension PowerliftingSectionDtoPatterns on PowerliftingSectionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PowerliftingSectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PowerliftingSectionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PowerliftingSectionDto value)  $default,){
final _that = this;
switch (_that) {
case _PowerliftingSectionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PowerliftingSectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _PowerliftingSectionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LiftSeriesDto squat,  LiftSeriesDto bench,  LiftSeriesDto deadlift,  List<DotsPointDto> dots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PowerliftingSectionDto() when $default != null:
return $default(_that.squat,_that.bench,_that.deadlift,_that.dots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LiftSeriesDto squat,  LiftSeriesDto bench,  LiftSeriesDto deadlift,  List<DotsPointDto> dots)  $default,) {final _that = this;
switch (_that) {
case _PowerliftingSectionDto():
return $default(_that.squat,_that.bench,_that.deadlift,_that.dots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LiftSeriesDto squat,  LiftSeriesDto bench,  LiftSeriesDto deadlift,  List<DotsPointDto> dots)?  $default,) {final _that = this;
switch (_that) {
case _PowerliftingSectionDto() when $default != null:
return $default(_that.squat,_that.bench,_that.deadlift,_that.dots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PowerliftingSectionDto extends PowerliftingSectionDto {
  const _PowerliftingSectionDto({required this.squat, required this.bench, required this.deadlift, final  List<DotsPointDto> dots = const <DotsPointDto>[]}): _dots = dots,super._();
  factory _PowerliftingSectionDto.fromJson(Map<String, dynamic> json) => _$PowerliftingSectionDtoFromJson(json);

@override final  LiftSeriesDto squat;
@override final  LiftSeriesDto bench;
@override final  LiftSeriesDto deadlift;
 final  List<DotsPointDto> _dots;
@override@JsonKey() List<DotsPointDto> get dots {
  if (_dots is EqualUnmodifiableListView) return _dots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dots);
}


/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PowerliftingSectionDtoCopyWith<_PowerliftingSectionDto> get copyWith => __$PowerliftingSectionDtoCopyWithImpl<_PowerliftingSectionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PowerliftingSectionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PowerliftingSectionDto&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift)&&const DeepCollectionEquality().equals(other._dots, _dots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift,const DeepCollectionEquality().hash(_dots));

@override
String toString() {
  return 'PowerliftingSectionDto(squat: $squat, bench: $bench, deadlift: $deadlift, dots: $dots)';
}


}

/// @nodoc
abstract mixin class _$PowerliftingSectionDtoCopyWith<$Res> implements $PowerliftingSectionDtoCopyWith<$Res> {
  factory _$PowerliftingSectionDtoCopyWith(_PowerliftingSectionDto value, $Res Function(_PowerliftingSectionDto) _then) = __$PowerliftingSectionDtoCopyWithImpl;
@override @useResult
$Res call({
 LiftSeriesDto squat, LiftSeriesDto bench, LiftSeriesDto deadlift, List<DotsPointDto> dots
});


@override $LiftSeriesDtoCopyWith<$Res> get squat;@override $LiftSeriesDtoCopyWith<$Res> get bench;@override $LiftSeriesDtoCopyWith<$Res> get deadlift;

}
/// @nodoc
class __$PowerliftingSectionDtoCopyWithImpl<$Res>
    implements _$PowerliftingSectionDtoCopyWith<$Res> {
  __$PowerliftingSectionDtoCopyWithImpl(this._self, this._then);

  final _PowerliftingSectionDto _self;
  final $Res Function(_PowerliftingSectionDto) _then;

/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? squat = null,Object? bench = null,Object? deadlift = null,Object? dots = null,}) {
  return _then(_PowerliftingSectionDto(
squat: null == squat ? _self.squat : squat // ignore: cast_nullable_to_non_nullable
as LiftSeriesDto,bench: null == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as LiftSeriesDto,deadlift: null == deadlift ? _self.deadlift : deadlift // ignore: cast_nullable_to_non_nullable
as LiftSeriesDto,dots: null == dots ? _self._dots : dots // ignore: cast_nullable_to_non_nullable
as List<DotsPointDto>,
  ));
}

/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesDtoCopyWith<$Res> get squat {
  
  return $LiftSeriesDtoCopyWith<$Res>(_self.squat, (value) {
    return _then(_self.copyWith(squat: value));
  });
}/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesDtoCopyWith<$Res> get bench {
  
  return $LiftSeriesDtoCopyWith<$Res>(_self.bench, (value) {
    return _then(_self.copyWith(bench: value));
  });
}/// Create a copy of PowerliftingSectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesDtoCopyWith<$Res> get deadlift {
  
  return $LiftSeriesDtoCopyWith<$Res>(_self.deadlift, (value) {
    return _then(_self.copyWith(deadlift: value));
  });
}
}


/// @nodoc
mixin _$LiftSeriesDto {

 String get lift; List<LiftE1RmPointDto> get e1Rm; List<LiftPrEventDto> get prTimeline; double? get currentE1Rm; double? get currentTrainingMax; bool get isPlateau;
/// Create a copy of LiftSeriesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiftSeriesDtoCopyWith<LiftSeriesDto> get copyWith => _$LiftSeriesDtoCopyWithImpl<LiftSeriesDto>(this as LiftSeriesDto, _$identity);

  /// Serializes this LiftSeriesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiftSeriesDto&&(identical(other.lift, lift) || other.lift == lift)&&const DeepCollectionEquality().equals(other.e1Rm, e1Rm)&&const DeepCollectionEquality().equals(other.prTimeline, prTimeline)&&(identical(other.currentE1Rm, currentE1Rm) || other.currentE1Rm == currentE1Rm)&&(identical(other.currentTrainingMax, currentTrainingMax) || other.currentTrainingMax == currentTrainingMax)&&(identical(other.isPlateau, isPlateau) || other.isPlateau == isPlateau));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lift,const DeepCollectionEquality().hash(e1Rm),const DeepCollectionEquality().hash(prTimeline),currentE1Rm,currentTrainingMax,isPlateau);

@override
String toString() {
  return 'LiftSeriesDto(lift: $lift, e1Rm: $e1Rm, prTimeline: $prTimeline, currentE1Rm: $currentE1Rm, currentTrainingMax: $currentTrainingMax, isPlateau: $isPlateau)';
}


}

/// @nodoc
abstract mixin class $LiftSeriesDtoCopyWith<$Res>  {
  factory $LiftSeriesDtoCopyWith(LiftSeriesDto value, $Res Function(LiftSeriesDto) _then) = _$LiftSeriesDtoCopyWithImpl;
@useResult
$Res call({
 String lift, List<LiftE1RmPointDto> e1Rm, List<LiftPrEventDto> prTimeline, double? currentE1Rm, double? currentTrainingMax, bool isPlateau
});




}
/// @nodoc
class _$LiftSeriesDtoCopyWithImpl<$Res>
    implements $LiftSeriesDtoCopyWith<$Res> {
  _$LiftSeriesDtoCopyWithImpl(this._self, this._then);

  final LiftSeriesDto _self;
  final $Res Function(LiftSeriesDto) _then;

/// Create a copy of LiftSeriesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lift = null,Object? e1Rm = null,Object? prTimeline = null,Object? currentE1Rm = freezed,Object? currentTrainingMax = freezed,Object? isPlateau = null,}) {
  return _then(_self.copyWith(
lift: null == lift ? _self.lift : lift // ignore: cast_nullable_to_non_nullable
as String,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as List<LiftE1RmPointDto>,prTimeline: null == prTimeline ? _self.prTimeline : prTimeline // ignore: cast_nullable_to_non_nullable
as List<LiftPrEventDto>,currentE1Rm: freezed == currentE1Rm ? _self.currentE1Rm : currentE1Rm // ignore: cast_nullable_to_non_nullable
as double?,currentTrainingMax: freezed == currentTrainingMax ? _self.currentTrainingMax : currentTrainingMax // ignore: cast_nullable_to_non_nullable
as double?,isPlateau: null == isPlateau ? _self.isPlateau : isPlateau // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LiftSeriesDto].
extension LiftSeriesDtoPatterns on LiftSeriesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiftSeriesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiftSeriesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiftSeriesDto value)  $default,){
final _that = this;
switch (_that) {
case _LiftSeriesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiftSeriesDto value)?  $default,){
final _that = this;
switch (_that) {
case _LiftSeriesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lift,  List<LiftE1RmPointDto> e1Rm,  List<LiftPrEventDto> prTimeline,  double? currentE1Rm,  double? currentTrainingMax,  bool isPlateau)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiftSeriesDto() when $default != null:
return $default(_that.lift,_that.e1Rm,_that.prTimeline,_that.currentE1Rm,_that.currentTrainingMax,_that.isPlateau);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lift,  List<LiftE1RmPointDto> e1Rm,  List<LiftPrEventDto> prTimeline,  double? currentE1Rm,  double? currentTrainingMax,  bool isPlateau)  $default,) {final _that = this;
switch (_that) {
case _LiftSeriesDto():
return $default(_that.lift,_that.e1Rm,_that.prTimeline,_that.currentE1Rm,_that.currentTrainingMax,_that.isPlateau);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lift,  List<LiftE1RmPointDto> e1Rm,  List<LiftPrEventDto> prTimeline,  double? currentE1Rm,  double? currentTrainingMax,  bool isPlateau)?  $default,) {final _that = this;
switch (_that) {
case _LiftSeriesDto() when $default != null:
return $default(_that.lift,_that.e1Rm,_that.prTimeline,_that.currentE1Rm,_that.currentTrainingMax,_that.isPlateau);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiftSeriesDto extends LiftSeriesDto {
  const _LiftSeriesDto({this.lift = '', final  List<LiftE1RmPointDto> e1Rm = const <LiftE1RmPointDto>[], final  List<LiftPrEventDto> prTimeline = const <LiftPrEventDto>[], this.currentE1Rm, this.currentTrainingMax, this.isPlateau = false}): _e1Rm = e1Rm,_prTimeline = prTimeline,super._();
  factory _LiftSeriesDto.fromJson(Map<String, dynamic> json) => _$LiftSeriesDtoFromJson(json);

@override@JsonKey() final  String lift;
 final  List<LiftE1RmPointDto> _e1Rm;
@override@JsonKey() List<LiftE1RmPointDto> get e1Rm {
  if (_e1Rm is EqualUnmodifiableListView) return _e1Rm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_e1Rm);
}

 final  List<LiftPrEventDto> _prTimeline;
@override@JsonKey() List<LiftPrEventDto> get prTimeline {
  if (_prTimeline is EqualUnmodifiableListView) return _prTimeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prTimeline);
}

@override final  double? currentE1Rm;
@override final  double? currentTrainingMax;
@override@JsonKey() final  bool isPlateau;

/// Create a copy of LiftSeriesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiftSeriesDtoCopyWith<_LiftSeriesDto> get copyWith => __$LiftSeriesDtoCopyWithImpl<_LiftSeriesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiftSeriesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiftSeriesDto&&(identical(other.lift, lift) || other.lift == lift)&&const DeepCollectionEquality().equals(other._e1Rm, _e1Rm)&&const DeepCollectionEquality().equals(other._prTimeline, _prTimeline)&&(identical(other.currentE1Rm, currentE1Rm) || other.currentE1Rm == currentE1Rm)&&(identical(other.currentTrainingMax, currentTrainingMax) || other.currentTrainingMax == currentTrainingMax)&&(identical(other.isPlateau, isPlateau) || other.isPlateau == isPlateau));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lift,const DeepCollectionEquality().hash(_e1Rm),const DeepCollectionEquality().hash(_prTimeline),currentE1Rm,currentTrainingMax,isPlateau);

@override
String toString() {
  return 'LiftSeriesDto(lift: $lift, e1Rm: $e1Rm, prTimeline: $prTimeline, currentE1Rm: $currentE1Rm, currentTrainingMax: $currentTrainingMax, isPlateau: $isPlateau)';
}


}

/// @nodoc
abstract mixin class _$LiftSeriesDtoCopyWith<$Res> implements $LiftSeriesDtoCopyWith<$Res> {
  factory _$LiftSeriesDtoCopyWith(_LiftSeriesDto value, $Res Function(_LiftSeriesDto) _then) = __$LiftSeriesDtoCopyWithImpl;
@override @useResult
$Res call({
 String lift, List<LiftE1RmPointDto> e1Rm, List<LiftPrEventDto> prTimeline, double? currentE1Rm, double? currentTrainingMax, bool isPlateau
});




}
/// @nodoc
class __$LiftSeriesDtoCopyWithImpl<$Res>
    implements _$LiftSeriesDtoCopyWith<$Res> {
  __$LiftSeriesDtoCopyWithImpl(this._self, this._then);

  final _LiftSeriesDto _self;
  final $Res Function(_LiftSeriesDto) _then;

/// Create a copy of LiftSeriesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lift = null,Object? e1Rm = null,Object? prTimeline = null,Object? currentE1Rm = freezed,Object? currentTrainingMax = freezed,Object? isPlateau = null,}) {
  return _then(_LiftSeriesDto(
lift: null == lift ? _self.lift : lift // ignore: cast_nullable_to_non_nullable
as String,e1Rm: null == e1Rm ? _self._e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as List<LiftE1RmPointDto>,prTimeline: null == prTimeline ? _self._prTimeline : prTimeline // ignore: cast_nullable_to_non_nullable
as List<LiftPrEventDto>,currentE1Rm: freezed == currentE1Rm ? _self.currentE1Rm : currentE1Rm // ignore: cast_nullable_to_non_nullable
as double?,currentTrainingMax: freezed == currentTrainingMax ? _self.currentTrainingMax : currentTrainingMax // ignore: cast_nullable_to_non_nullable
as double?,isPlateau: null == isPlateau ? _self.isPlateau : isPlateau // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LiftE1RmPointDto {

 String get weekStart; double get e1Rm;
/// Create a copy of LiftE1RmPointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiftE1RmPointDtoCopyWith<LiftE1RmPointDto> get copyWith => _$LiftE1RmPointDtoCopyWithImpl<LiftE1RmPointDto>(this as LiftE1RmPointDto, _$identity);

  /// Serializes this LiftE1RmPointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiftE1RmPointDto&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,e1Rm);

@override
String toString() {
  return 'LiftE1RmPointDto(weekStart: $weekStart, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class $LiftE1RmPointDtoCopyWith<$Res>  {
  factory $LiftE1RmPointDtoCopyWith(LiftE1RmPointDto value, $Res Function(LiftE1RmPointDto) _then) = _$LiftE1RmPointDtoCopyWithImpl;
@useResult
$Res call({
 String weekStart, double e1Rm
});




}
/// @nodoc
class _$LiftE1RmPointDtoCopyWithImpl<$Res>
    implements $LiftE1RmPointDtoCopyWith<$Res> {
  _$LiftE1RmPointDtoCopyWithImpl(this._self, this._then);

  final LiftE1RmPointDto _self;
  final $Res Function(LiftE1RmPointDto) _then;

/// Create a copy of LiftE1RmPointDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? e1Rm = null,}) {
  return _then(_self.copyWith(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as String,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiftE1RmPointDto].
extension LiftE1RmPointDtoPatterns on LiftE1RmPointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiftE1RmPointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiftE1RmPointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiftE1RmPointDto value)  $default,){
final _that = this;
switch (_that) {
case _LiftE1RmPointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiftE1RmPointDto value)?  $default,){
final _that = this;
switch (_that) {
case _LiftE1RmPointDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String weekStart,  double e1Rm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiftE1RmPointDto() when $default != null:
return $default(_that.weekStart,_that.e1Rm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String weekStart,  double e1Rm)  $default,) {final _that = this;
switch (_that) {
case _LiftE1RmPointDto():
return $default(_that.weekStart,_that.e1Rm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String weekStart,  double e1Rm)?  $default,) {final _that = this;
switch (_that) {
case _LiftE1RmPointDto() when $default != null:
return $default(_that.weekStart,_that.e1Rm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiftE1RmPointDto extends LiftE1RmPointDto {
  const _LiftE1RmPointDto({this.weekStart = '', this.e1Rm = 0.0}): super._();
  factory _LiftE1RmPointDto.fromJson(Map<String, dynamic> json) => _$LiftE1RmPointDtoFromJson(json);

@override@JsonKey() final  String weekStart;
@override@JsonKey() final  double e1Rm;

/// Create a copy of LiftE1RmPointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiftE1RmPointDtoCopyWith<_LiftE1RmPointDto> get copyWith => __$LiftE1RmPointDtoCopyWithImpl<_LiftE1RmPointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiftE1RmPointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiftE1RmPointDto&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,e1Rm);

@override
String toString() {
  return 'LiftE1RmPointDto(weekStart: $weekStart, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class _$LiftE1RmPointDtoCopyWith<$Res> implements $LiftE1RmPointDtoCopyWith<$Res> {
  factory _$LiftE1RmPointDtoCopyWith(_LiftE1RmPointDto value, $Res Function(_LiftE1RmPointDto) _then) = __$LiftE1RmPointDtoCopyWithImpl;
@override @useResult
$Res call({
 String weekStart, double e1Rm
});




}
/// @nodoc
class __$LiftE1RmPointDtoCopyWithImpl<$Res>
    implements _$LiftE1RmPointDtoCopyWith<$Res> {
  __$LiftE1RmPointDtoCopyWithImpl(this._self, this._then);

  final _LiftE1RmPointDto _self;
  final $Res Function(_LiftE1RmPointDto) _then;

/// Create a copy of LiftE1RmPointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? e1Rm = null,}) {
  return _then(_LiftE1RmPointDto(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as String,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$LiftPrEventDto {

 DateTime get date; double get weight; int get reps; double get e1Rm;
/// Create a copy of LiftPrEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiftPrEventDtoCopyWith<LiftPrEventDto> get copyWith => _$LiftPrEventDtoCopyWithImpl<LiftPrEventDto>(this as LiftPrEventDto, _$identity);

  /// Serializes this LiftPrEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiftPrEventDto&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,weight,reps,e1Rm);

@override
String toString() {
  return 'LiftPrEventDto(date: $date, weight: $weight, reps: $reps, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class $LiftPrEventDtoCopyWith<$Res>  {
  factory $LiftPrEventDtoCopyWith(LiftPrEventDto value, $Res Function(LiftPrEventDto) _then) = _$LiftPrEventDtoCopyWithImpl;
@useResult
$Res call({
 DateTime date, double weight, int reps, double e1Rm
});




}
/// @nodoc
class _$LiftPrEventDtoCopyWithImpl<$Res>
    implements $LiftPrEventDtoCopyWith<$Res> {
  _$LiftPrEventDtoCopyWithImpl(this._self, this._then);

  final LiftPrEventDto _self;
  final $Res Function(LiftPrEventDto) _then;

/// Create a copy of LiftPrEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? weight = null,Object? reps = null,Object? e1Rm = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiftPrEventDto].
extension LiftPrEventDtoPatterns on LiftPrEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiftPrEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiftPrEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiftPrEventDto value)  $default,){
final _that = this;
switch (_that) {
case _LiftPrEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiftPrEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _LiftPrEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double weight,  int reps,  double e1Rm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiftPrEventDto() when $default != null:
return $default(_that.date,_that.weight,_that.reps,_that.e1Rm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double weight,  int reps,  double e1Rm)  $default,) {final _that = this;
switch (_that) {
case _LiftPrEventDto():
return $default(_that.date,_that.weight,_that.reps,_that.e1Rm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double weight,  int reps,  double e1Rm)?  $default,) {final _that = this;
switch (_that) {
case _LiftPrEventDto() when $default != null:
return $default(_that.date,_that.weight,_that.reps,_that.e1Rm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiftPrEventDto extends LiftPrEventDto {
  const _LiftPrEventDto({required this.date, this.weight = 0.0, this.reps = 0, this.e1Rm = 0.0}): super._();
  factory _LiftPrEventDto.fromJson(Map<String, dynamic> json) => _$LiftPrEventDtoFromJson(json);

@override final  DateTime date;
@override@JsonKey() final  double weight;
@override@JsonKey() final  int reps;
@override@JsonKey() final  double e1Rm;

/// Create a copy of LiftPrEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiftPrEventDtoCopyWith<_LiftPrEventDto> get copyWith => __$LiftPrEventDtoCopyWithImpl<_LiftPrEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiftPrEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiftPrEventDto&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,weight,reps,e1Rm);

@override
String toString() {
  return 'LiftPrEventDto(date: $date, weight: $weight, reps: $reps, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class _$LiftPrEventDtoCopyWith<$Res> implements $LiftPrEventDtoCopyWith<$Res> {
  factory _$LiftPrEventDtoCopyWith(_LiftPrEventDto value, $Res Function(_LiftPrEventDto) _then) = __$LiftPrEventDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double weight, int reps, double e1Rm
});




}
/// @nodoc
class __$LiftPrEventDtoCopyWithImpl<$Res>
    implements _$LiftPrEventDtoCopyWith<$Res> {
  __$LiftPrEventDtoCopyWithImpl(this._self, this._then);

  final _LiftPrEventDto _self;
  final $Res Function(_LiftPrEventDto) _then;

/// Create a copy of LiftPrEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? weight = null,Object? reps = null,Object? e1Rm = null,}) {
  return _then(_LiftPrEventDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$DotsPointDto {

 String get weekStart; double get dots; double get bodyweightKg;
/// Create a copy of DotsPointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotsPointDtoCopyWith<DotsPointDto> get copyWith => _$DotsPointDtoCopyWithImpl<DotsPointDto>(this as DotsPointDto, _$identity);

  /// Serializes this DotsPointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotsPointDto&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.dots, dots) || other.dots == dots)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,dots,bodyweightKg);

@override
String toString() {
  return 'DotsPointDto(weekStart: $weekStart, dots: $dots, bodyweightKg: $bodyweightKg)';
}


}

/// @nodoc
abstract mixin class $DotsPointDtoCopyWith<$Res>  {
  factory $DotsPointDtoCopyWith(DotsPointDto value, $Res Function(DotsPointDto) _then) = _$DotsPointDtoCopyWithImpl;
@useResult
$Res call({
 String weekStart, double dots, double bodyweightKg
});




}
/// @nodoc
class _$DotsPointDtoCopyWithImpl<$Res>
    implements $DotsPointDtoCopyWith<$Res> {
  _$DotsPointDtoCopyWithImpl(this._self, this._then);

  final DotsPointDto _self;
  final $Res Function(DotsPointDto) _then;

/// Create a copy of DotsPointDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? dots = null,Object? bodyweightKg = null,}) {
  return _then(_self.copyWith(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as String,dots: null == dots ? _self.dots : dots // ignore: cast_nullable_to_non_nullable
as double,bodyweightKg: null == bodyweightKg ? _self.bodyweightKg : bodyweightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DotsPointDto].
extension DotsPointDtoPatterns on DotsPointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotsPointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotsPointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotsPointDto value)  $default,){
final _that = this;
switch (_that) {
case _DotsPointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotsPointDto value)?  $default,){
final _that = this;
switch (_that) {
case _DotsPointDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String weekStart,  double dots,  double bodyweightKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DotsPointDto() when $default != null:
return $default(_that.weekStart,_that.dots,_that.bodyweightKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String weekStart,  double dots,  double bodyweightKg)  $default,) {final _that = this;
switch (_that) {
case _DotsPointDto():
return $default(_that.weekStart,_that.dots,_that.bodyweightKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String weekStart,  double dots,  double bodyweightKg)?  $default,) {final _that = this;
switch (_that) {
case _DotsPointDto() when $default != null:
return $default(_that.weekStart,_that.dots,_that.bodyweightKg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DotsPointDto extends DotsPointDto {
  const _DotsPointDto({this.weekStart = '', this.dots = 0.0, this.bodyweightKg = 0.0}): super._();
  factory _DotsPointDto.fromJson(Map<String, dynamic> json) => _$DotsPointDtoFromJson(json);

@override@JsonKey() final  String weekStart;
@override@JsonKey() final  double dots;
@override@JsonKey() final  double bodyweightKg;

/// Create a copy of DotsPointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotsPointDtoCopyWith<_DotsPointDto> get copyWith => __$DotsPointDtoCopyWithImpl<_DotsPointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DotsPointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotsPointDto&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.dots, dots) || other.dots == dots)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,dots,bodyweightKg);

@override
String toString() {
  return 'DotsPointDto(weekStart: $weekStart, dots: $dots, bodyweightKg: $bodyweightKg)';
}


}

/// @nodoc
abstract mixin class _$DotsPointDtoCopyWith<$Res> implements $DotsPointDtoCopyWith<$Res> {
  factory _$DotsPointDtoCopyWith(_DotsPointDto value, $Res Function(_DotsPointDto) _then) = __$DotsPointDtoCopyWithImpl;
@override @useResult
$Res call({
 String weekStart, double dots, double bodyweightKg
});




}
/// @nodoc
class __$DotsPointDtoCopyWithImpl<$Res>
    implements _$DotsPointDtoCopyWith<$Res> {
  __$DotsPointDtoCopyWithImpl(this._self, this._then);

  final _DotsPointDto _self;
  final $Res Function(_DotsPointDto) _then;

/// Create a copy of DotsPointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? dots = null,Object? bodyweightKg = null,}) {
  return _then(_DotsPointDto(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as String,dots: null == dots ? _self.dots : dots // ignore: cast_nullable_to_non_nullable
as double,bodyweightKg: null == bodyweightKg ? _self.bodyweightKg : bodyweightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
