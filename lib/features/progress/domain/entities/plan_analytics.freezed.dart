// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanAnalytics {

 int get totalWorkoutsCompleted; double get totalVolume; double get consistencyPercent; double get avgSessionsPerWeek; int get completedSets; int get highRpeSets; int get warningDays; int get totalDurationSeconds; int get trainingScore; List<TrainingInsight> get insights; List<WeekCompliancePoint> get weeklyCompliance; List<WeekVolumePoint> get weeklyVolume; List<MuscleGroupVolumePoint> get muscleGroupVolume; double? get avgRpe;/// Present only when the plan contains competition-lift exercises.
 PowerliftingSection? get powerlifting;
/// Create a copy of PlanAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanAnalyticsCopyWith<PlanAnalytics> get copyWith => _$PlanAnalyticsCopyWithImpl<PlanAnalytics>(this as PlanAnalytics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanAnalytics&&(identical(other.totalWorkoutsCompleted, totalWorkoutsCompleted) || other.totalWorkoutsCompleted == totalWorkoutsCompleted)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.consistencyPercent, consistencyPercent) || other.consistencyPercent == consistencyPercent)&&(identical(other.avgSessionsPerWeek, avgSessionsPerWeek) || other.avgSessionsPerWeek == avgSessionsPerWeek)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.highRpeSets, highRpeSets) || other.highRpeSets == highRpeSets)&&(identical(other.warningDays, warningDays) || other.warningDays == warningDays)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.trainingScore, trainingScore) || other.trainingScore == trainingScore)&&const DeepCollectionEquality().equals(other.insights, insights)&&const DeepCollectionEquality().equals(other.weeklyCompliance, weeklyCompliance)&&const DeepCollectionEquality().equals(other.weeklyVolume, weeklyVolume)&&const DeepCollectionEquality().equals(other.muscleGroupVolume, muscleGroupVolume)&&(identical(other.avgRpe, avgRpe) || other.avgRpe == avgRpe)&&(identical(other.powerlifting, powerlifting) || other.powerlifting == powerlifting));
}


@override
int get hashCode => Object.hash(runtimeType,totalWorkoutsCompleted,totalVolume,consistencyPercent,avgSessionsPerWeek,completedSets,highRpeSets,warningDays,totalDurationSeconds,trainingScore,const DeepCollectionEquality().hash(insights),const DeepCollectionEquality().hash(weeklyCompliance),const DeepCollectionEquality().hash(weeklyVolume),const DeepCollectionEquality().hash(muscleGroupVolume),avgRpe,powerlifting);

@override
String toString() {
  return 'PlanAnalytics(totalWorkoutsCompleted: $totalWorkoutsCompleted, totalVolume: $totalVolume, consistencyPercent: $consistencyPercent, avgSessionsPerWeek: $avgSessionsPerWeek, completedSets: $completedSets, highRpeSets: $highRpeSets, warningDays: $warningDays, totalDurationSeconds: $totalDurationSeconds, trainingScore: $trainingScore, insights: $insights, weeklyCompliance: $weeklyCompliance, weeklyVolume: $weeklyVolume, muscleGroupVolume: $muscleGroupVolume, avgRpe: $avgRpe, powerlifting: $powerlifting)';
}


}

/// @nodoc
abstract mixin class $PlanAnalyticsCopyWith<$Res>  {
  factory $PlanAnalyticsCopyWith(PlanAnalytics value, $Res Function(PlanAnalytics) _then) = _$PlanAnalyticsCopyWithImpl;
@useResult
$Res call({
 int totalWorkoutsCompleted, double totalVolume, double consistencyPercent, double avgSessionsPerWeek, int completedSets, int highRpeSets, int warningDays, int totalDurationSeconds, int trainingScore, List<TrainingInsight> insights, List<WeekCompliancePoint> weeklyCompliance, List<WeekVolumePoint> weeklyVolume, List<MuscleGroupVolumePoint> muscleGroupVolume, double? avgRpe, PowerliftingSection? powerlifting
});


$PowerliftingSectionCopyWith<$Res>? get powerlifting;

}
/// @nodoc
class _$PlanAnalyticsCopyWithImpl<$Res>
    implements $PlanAnalyticsCopyWith<$Res> {
  _$PlanAnalyticsCopyWithImpl(this._self, this._then);

  final PlanAnalytics _self;
  final $Res Function(PlanAnalytics) _then;

/// Create a copy of PlanAnalytics
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
as List<TrainingInsight>,weeklyCompliance: null == weeklyCompliance ? _self.weeklyCompliance : weeklyCompliance // ignore: cast_nullable_to_non_nullable
as List<WeekCompliancePoint>,weeklyVolume: null == weeklyVolume ? _self.weeklyVolume : weeklyVolume // ignore: cast_nullable_to_non_nullable
as List<WeekVolumePoint>,muscleGroupVolume: null == muscleGroupVolume ? _self.muscleGroupVolume : muscleGroupVolume // ignore: cast_nullable_to_non_nullable
as List<MuscleGroupVolumePoint>,avgRpe: freezed == avgRpe ? _self.avgRpe : avgRpe // ignore: cast_nullable_to_non_nullable
as double?,powerlifting: freezed == powerlifting ? _self.powerlifting : powerlifting // ignore: cast_nullable_to_non_nullable
as PowerliftingSection?,
  ));
}
/// Create a copy of PlanAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PowerliftingSectionCopyWith<$Res>? get powerlifting {
    if (_self.powerlifting == null) {
    return null;
  }

  return $PowerliftingSectionCopyWith<$Res>(_self.powerlifting!, (value) {
    return _then(_self.copyWith(powerlifting: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanAnalytics].
extension PlanAnalyticsPatterns on PlanAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _PlanAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _PlanAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalWorkoutsCompleted,  double totalVolume,  double consistencyPercent,  double avgSessionsPerWeek,  int completedSets,  int highRpeSets,  int warningDays,  int totalDurationSeconds,  int trainingScore,  List<TrainingInsight> insights,  List<WeekCompliancePoint> weeklyCompliance,  List<WeekVolumePoint> weeklyVolume,  List<MuscleGroupVolumePoint> muscleGroupVolume,  double? avgRpe,  PowerliftingSection? powerlifting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanAnalytics() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalWorkoutsCompleted,  double totalVolume,  double consistencyPercent,  double avgSessionsPerWeek,  int completedSets,  int highRpeSets,  int warningDays,  int totalDurationSeconds,  int trainingScore,  List<TrainingInsight> insights,  List<WeekCompliancePoint> weeklyCompliance,  List<WeekVolumePoint> weeklyVolume,  List<MuscleGroupVolumePoint> muscleGroupVolume,  double? avgRpe,  PowerliftingSection? powerlifting)  $default,) {final _that = this;
switch (_that) {
case _PlanAnalytics():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalWorkoutsCompleted,  double totalVolume,  double consistencyPercent,  double avgSessionsPerWeek,  int completedSets,  int highRpeSets,  int warningDays,  int totalDurationSeconds,  int trainingScore,  List<TrainingInsight> insights,  List<WeekCompliancePoint> weeklyCompliance,  List<WeekVolumePoint> weeklyVolume,  List<MuscleGroupVolumePoint> muscleGroupVolume,  double? avgRpe,  PowerliftingSection? powerlifting)?  $default,) {final _that = this;
switch (_that) {
case _PlanAnalytics() when $default != null:
return $default(_that.totalWorkoutsCompleted,_that.totalVolume,_that.consistencyPercent,_that.avgSessionsPerWeek,_that.completedSets,_that.highRpeSets,_that.warningDays,_that.totalDurationSeconds,_that.trainingScore,_that.insights,_that.weeklyCompliance,_that.weeklyVolume,_that.muscleGroupVolume,_that.avgRpe,_that.powerlifting);case _:
  return null;

}
}

}

/// @nodoc


class _PlanAnalytics extends PlanAnalytics {
  const _PlanAnalytics({required this.totalWorkoutsCompleted, required this.totalVolume, required this.consistencyPercent, required this.avgSessionsPerWeek, required this.completedSets, required this.highRpeSets, required this.warningDays, required this.totalDurationSeconds, required this.trainingScore, required final  List<TrainingInsight> insights, required final  List<WeekCompliancePoint> weeklyCompliance, required final  List<WeekVolumePoint> weeklyVolume, required final  List<MuscleGroupVolumePoint> muscleGroupVolume, this.avgRpe, this.powerlifting}): _insights = insights,_weeklyCompliance = weeklyCompliance,_weeklyVolume = weeklyVolume,_muscleGroupVolume = muscleGroupVolume,super._();
  

@override final  int totalWorkoutsCompleted;
@override final  double totalVolume;
@override final  double consistencyPercent;
@override final  double avgSessionsPerWeek;
@override final  int completedSets;
@override final  int highRpeSets;
@override final  int warningDays;
@override final  int totalDurationSeconds;
@override final  int trainingScore;
 final  List<TrainingInsight> _insights;
@override List<TrainingInsight> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}

 final  List<WeekCompliancePoint> _weeklyCompliance;
@override List<WeekCompliancePoint> get weeklyCompliance {
  if (_weeklyCompliance is EqualUnmodifiableListView) return _weeklyCompliance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyCompliance);
}

 final  List<WeekVolumePoint> _weeklyVolume;
@override List<WeekVolumePoint> get weeklyVolume {
  if (_weeklyVolume is EqualUnmodifiableListView) return _weeklyVolume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyVolume);
}

 final  List<MuscleGroupVolumePoint> _muscleGroupVolume;
@override List<MuscleGroupVolumePoint> get muscleGroupVolume {
  if (_muscleGroupVolume is EqualUnmodifiableListView) return _muscleGroupVolume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_muscleGroupVolume);
}

@override final  double? avgRpe;
/// Present only when the plan contains competition-lift exercises.
@override final  PowerliftingSection? powerlifting;

/// Create a copy of PlanAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanAnalyticsCopyWith<_PlanAnalytics> get copyWith => __$PlanAnalyticsCopyWithImpl<_PlanAnalytics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanAnalytics&&(identical(other.totalWorkoutsCompleted, totalWorkoutsCompleted) || other.totalWorkoutsCompleted == totalWorkoutsCompleted)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.consistencyPercent, consistencyPercent) || other.consistencyPercent == consistencyPercent)&&(identical(other.avgSessionsPerWeek, avgSessionsPerWeek) || other.avgSessionsPerWeek == avgSessionsPerWeek)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.highRpeSets, highRpeSets) || other.highRpeSets == highRpeSets)&&(identical(other.warningDays, warningDays) || other.warningDays == warningDays)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.trainingScore, trainingScore) || other.trainingScore == trainingScore)&&const DeepCollectionEquality().equals(other._insights, _insights)&&const DeepCollectionEquality().equals(other._weeklyCompliance, _weeklyCompliance)&&const DeepCollectionEquality().equals(other._weeklyVolume, _weeklyVolume)&&const DeepCollectionEquality().equals(other._muscleGroupVolume, _muscleGroupVolume)&&(identical(other.avgRpe, avgRpe) || other.avgRpe == avgRpe)&&(identical(other.powerlifting, powerlifting) || other.powerlifting == powerlifting));
}


@override
int get hashCode => Object.hash(runtimeType,totalWorkoutsCompleted,totalVolume,consistencyPercent,avgSessionsPerWeek,completedSets,highRpeSets,warningDays,totalDurationSeconds,trainingScore,const DeepCollectionEquality().hash(_insights),const DeepCollectionEquality().hash(_weeklyCompliance),const DeepCollectionEquality().hash(_weeklyVolume),const DeepCollectionEquality().hash(_muscleGroupVolume),avgRpe,powerlifting);

@override
String toString() {
  return 'PlanAnalytics(totalWorkoutsCompleted: $totalWorkoutsCompleted, totalVolume: $totalVolume, consistencyPercent: $consistencyPercent, avgSessionsPerWeek: $avgSessionsPerWeek, completedSets: $completedSets, highRpeSets: $highRpeSets, warningDays: $warningDays, totalDurationSeconds: $totalDurationSeconds, trainingScore: $trainingScore, insights: $insights, weeklyCompliance: $weeklyCompliance, weeklyVolume: $weeklyVolume, muscleGroupVolume: $muscleGroupVolume, avgRpe: $avgRpe, powerlifting: $powerlifting)';
}


}

/// @nodoc
abstract mixin class _$PlanAnalyticsCopyWith<$Res> implements $PlanAnalyticsCopyWith<$Res> {
  factory _$PlanAnalyticsCopyWith(_PlanAnalytics value, $Res Function(_PlanAnalytics) _then) = __$PlanAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 int totalWorkoutsCompleted, double totalVolume, double consistencyPercent, double avgSessionsPerWeek, int completedSets, int highRpeSets, int warningDays, int totalDurationSeconds, int trainingScore, List<TrainingInsight> insights, List<WeekCompliancePoint> weeklyCompliance, List<WeekVolumePoint> weeklyVolume, List<MuscleGroupVolumePoint> muscleGroupVolume, double? avgRpe, PowerliftingSection? powerlifting
});


@override $PowerliftingSectionCopyWith<$Res>? get powerlifting;

}
/// @nodoc
class __$PlanAnalyticsCopyWithImpl<$Res>
    implements _$PlanAnalyticsCopyWith<$Res> {
  __$PlanAnalyticsCopyWithImpl(this._self, this._then);

  final _PlanAnalytics _self;
  final $Res Function(_PlanAnalytics) _then;

/// Create a copy of PlanAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalWorkoutsCompleted = null,Object? totalVolume = null,Object? consistencyPercent = null,Object? avgSessionsPerWeek = null,Object? completedSets = null,Object? highRpeSets = null,Object? warningDays = null,Object? totalDurationSeconds = null,Object? trainingScore = null,Object? insights = null,Object? weeklyCompliance = null,Object? weeklyVolume = null,Object? muscleGroupVolume = null,Object? avgRpe = freezed,Object? powerlifting = freezed,}) {
  return _then(_PlanAnalytics(
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
as List<TrainingInsight>,weeklyCompliance: null == weeklyCompliance ? _self._weeklyCompliance : weeklyCompliance // ignore: cast_nullable_to_non_nullable
as List<WeekCompliancePoint>,weeklyVolume: null == weeklyVolume ? _self._weeklyVolume : weeklyVolume // ignore: cast_nullable_to_non_nullable
as List<WeekVolumePoint>,muscleGroupVolume: null == muscleGroupVolume ? _self._muscleGroupVolume : muscleGroupVolume // ignore: cast_nullable_to_non_nullable
as List<MuscleGroupVolumePoint>,avgRpe: freezed == avgRpe ? _self.avgRpe : avgRpe // ignore: cast_nullable_to_non_nullable
as double?,powerlifting: freezed == powerlifting ? _self.powerlifting : powerlifting // ignore: cast_nullable_to_non_nullable
as PowerliftingSection?,
  ));
}

/// Create a copy of PlanAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PowerliftingSectionCopyWith<$Res>? get powerlifting {
    if (_self.powerlifting == null) {
    return null;
  }

  return $PowerliftingSectionCopyWith<$Res>(_self.powerlifting!, (value) {
    return _then(_self.copyWith(powerlifting: value));
  });
}
}

/// @nodoc
mixin _$TrainingInsight {

 String get type; String get severity;// "Info" | "Warning" | "Critical" | "Success"
 String get title; String get message; String get metricLabel; String get metricValue;
/// Create a copy of TrainingInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingInsightCopyWith<TrainingInsight> get copyWith => _$TrainingInsightCopyWithImpl<TrainingInsight>(this as TrainingInsight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingInsight&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.metricValue, metricValue) || other.metricValue == metricValue));
}


@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message,metricLabel,metricValue);

@override
String toString() {
  return 'TrainingInsight(type: $type, severity: $severity, title: $title, message: $message, metricLabel: $metricLabel, metricValue: $metricValue)';
}


}

/// @nodoc
abstract mixin class $TrainingInsightCopyWith<$Res>  {
  factory $TrainingInsightCopyWith(TrainingInsight value, $Res Function(TrainingInsight) _then) = _$TrainingInsightCopyWithImpl;
@useResult
$Res call({
 String type, String severity, String title, String message, String metricLabel, String metricValue
});




}
/// @nodoc
class _$TrainingInsightCopyWithImpl<$Res>
    implements $TrainingInsightCopyWith<$Res> {
  _$TrainingInsightCopyWithImpl(this._self, this._then);

  final TrainingInsight _self;
  final $Res Function(TrainingInsight) _then;

/// Create a copy of TrainingInsight
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


/// Adds pattern-matching-related methods to [TrainingInsight].
extension TrainingInsightPatterns on TrainingInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingInsight value)  $default,){
final _that = this;
switch (_that) {
case _TrainingInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingInsight value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingInsight() when $default != null:
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
case _TrainingInsight() when $default != null:
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
case _TrainingInsight():
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
case _TrainingInsight() when $default != null:
return $default(_that.type,_that.severity,_that.title,_that.message,_that.metricLabel,_that.metricValue);case _:
  return null;

}
}

}

/// @nodoc


class _TrainingInsight implements TrainingInsight {
  const _TrainingInsight({required this.type, required this.severity, required this.title, required this.message, required this.metricLabel, required this.metricValue});
  

@override final  String type;
@override final  String severity;
// "Info" | "Warning" | "Critical" | "Success"
@override final  String title;
@override final  String message;
@override final  String metricLabel;
@override final  String metricValue;

/// Create a copy of TrainingInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingInsightCopyWith<_TrainingInsight> get copyWith => __$TrainingInsightCopyWithImpl<_TrainingInsight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingInsight&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.metricValue, metricValue) || other.metricValue == metricValue));
}


@override
int get hashCode => Object.hash(runtimeType,type,severity,title,message,metricLabel,metricValue);

@override
String toString() {
  return 'TrainingInsight(type: $type, severity: $severity, title: $title, message: $message, metricLabel: $metricLabel, metricValue: $metricValue)';
}


}

/// @nodoc
abstract mixin class _$TrainingInsightCopyWith<$Res> implements $TrainingInsightCopyWith<$Res> {
  factory _$TrainingInsightCopyWith(_TrainingInsight value, $Res Function(_TrainingInsight) _then) = __$TrainingInsightCopyWithImpl;
@override @useResult
$Res call({
 String type, String severity, String title, String message, String metricLabel, String metricValue
});




}
/// @nodoc
class __$TrainingInsightCopyWithImpl<$Res>
    implements _$TrainingInsightCopyWith<$Res> {
  __$TrainingInsightCopyWithImpl(this._self, this._then);

  final _TrainingInsight _self;
  final $Res Function(_TrainingInsight) _then;

/// Create a copy of TrainingInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? severity = null,Object? title = null,Object? message = null,Object? metricLabel = null,Object? metricValue = null,}) {
  return _then(_TrainingInsight(
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
mixin _$WeekCompliancePoint {

 int get weekNumber; String get weekName; int get completedDays; int get totalDays;
/// Create a copy of WeekCompliancePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekCompliancePointCopyWith<WeekCompliancePoint> get copyWith => _$WeekCompliancePointCopyWithImpl<WeekCompliancePoint>(this as WeekCompliancePoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeekCompliancePoint&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.weekName, weekName) || other.weekName == weekName)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays));
}


@override
int get hashCode => Object.hash(runtimeType,weekNumber,weekName,completedDays,totalDays);

@override
String toString() {
  return 'WeekCompliancePoint(weekNumber: $weekNumber, weekName: $weekName, completedDays: $completedDays, totalDays: $totalDays)';
}


}

/// @nodoc
abstract mixin class $WeekCompliancePointCopyWith<$Res>  {
  factory $WeekCompliancePointCopyWith(WeekCompliancePoint value, $Res Function(WeekCompliancePoint) _then) = _$WeekCompliancePointCopyWithImpl;
@useResult
$Res call({
 int weekNumber, String weekName, int completedDays, int totalDays
});




}
/// @nodoc
class _$WeekCompliancePointCopyWithImpl<$Res>
    implements $WeekCompliancePointCopyWith<$Res> {
  _$WeekCompliancePointCopyWithImpl(this._self, this._then);

  final WeekCompliancePoint _self;
  final $Res Function(WeekCompliancePoint) _then;

/// Create a copy of WeekCompliancePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekNumber = null,Object? weekName = null,Object? completedDays = null,Object? totalDays = null,}) {
  return _then(_self.copyWith(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeekCompliancePoint].
extension WeekCompliancePointPatterns on WeekCompliancePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeekCompliancePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeekCompliancePoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeekCompliancePoint value)  $default,){
final _that = this;
switch (_that) {
case _WeekCompliancePoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeekCompliancePoint value)?  $default,){
final _that = this;
switch (_that) {
case _WeekCompliancePoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekNumber,  String weekName,  int completedDays,  int totalDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeekCompliancePoint() when $default != null:
return $default(_that.weekNumber,_that.weekName,_that.completedDays,_that.totalDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekNumber,  String weekName,  int completedDays,  int totalDays)  $default,) {final _that = this;
switch (_that) {
case _WeekCompliancePoint():
return $default(_that.weekNumber,_that.weekName,_that.completedDays,_that.totalDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekNumber,  String weekName,  int completedDays,  int totalDays)?  $default,) {final _that = this;
switch (_that) {
case _WeekCompliancePoint() when $default != null:
return $default(_that.weekNumber,_that.weekName,_that.completedDays,_that.totalDays);case _:
  return null;

}
}

}

/// @nodoc


class _WeekCompliancePoint implements WeekCompliancePoint {
  const _WeekCompliancePoint({required this.weekNumber, required this.weekName, required this.completedDays, required this.totalDays});
  

@override final  int weekNumber;
@override final  String weekName;
@override final  int completedDays;
@override final  int totalDays;

/// Create a copy of WeekCompliancePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekCompliancePointCopyWith<_WeekCompliancePoint> get copyWith => __$WeekCompliancePointCopyWithImpl<_WeekCompliancePoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekCompliancePoint&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.weekName, weekName) || other.weekName == weekName)&&(identical(other.completedDays, completedDays) || other.completedDays == completedDays)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays));
}


@override
int get hashCode => Object.hash(runtimeType,weekNumber,weekName,completedDays,totalDays);

@override
String toString() {
  return 'WeekCompliancePoint(weekNumber: $weekNumber, weekName: $weekName, completedDays: $completedDays, totalDays: $totalDays)';
}


}

/// @nodoc
abstract mixin class _$WeekCompliancePointCopyWith<$Res> implements $WeekCompliancePointCopyWith<$Res> {
  factory _$WeekCompliancePointCopyWith(_WeekCompliancePoint value, $Res Function(_WeekCompliancePoint) _then) = __$WeekCompliancePointCopyWithImpl;
@override @useResult
$Res call({
 int weekNumber, String weekName, int completedDays, int totalDays
});




}
/// @nodoc
class __$WeekCompliancePointCopyWithImpl<$Res>
    implements _$WeekCompliancePointCopyWith<$Res> {
  __$WeekCompliancePointCopyWithImpl(this._self, this._then);

  final _WeekCompliancePoint _self;
  final $Res Function(_WeekCompliancePoint) _then;

/// Create a copy of WeekCompliancePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekNumber = null,Object? weekName = null,Object? completedDays = null,Object? totalDays = null,}) {
  return _then(_WeekCompliancePoint(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,completedDays: null == completedDays ? _self.completedDays : completedDays // ignore: cast_nullable_to_non_nullable
as int,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$WeekVolumePoint {

 int get weekNumber; String get weekName; double get totalVolume;
/// Create a copy of WeekVolumePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekVolumePointCopyWith<WeekVolumePoint> get copyWith => _$WeekVolumePointCopyWithImpl<WeekVolumePoint>(this as WeekVolumePoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeekVolumePoint&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.weekName, weekName) || other.weekName == weekName)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume));
}


@override
int get hashCode => Object.hash(runtimeType,weekNumber,weekName,totalVolume);

@override
String toString() {
  return 'WeekVolumePoint(weekNumber: $weekNumber, weekName: $weekName, totalVolume: $totalVolume)';
}


}

/// @nodoc
abstract mixin class $WeekVolumePointCopyWith<$Res>  {
  factory $WeekVolumePointCopyWith(WeekVolumePoint value, $Res Function(WeekVolumePoint) _then) = _$WeekVolumePointCopyWithImpl;
@useResult
$Res call({
 int weekNumber, String weekName, double totalVolume
});




}
/// @nodoc
class _$WeekVolumePointCopyWithImpl<$Res>
    implements $WeekVolumePointCopyWith<$Res> {
  _$WeekVolumePointCopyWithImpl(this._self, this._then);

  final WeekVolumePoint _self;
  final $Res Function(WeekVolumePoint) _then;

/// Create a copy of WeekVolumePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekNumber = null,Object? weekName = null,Object? totalVolume = null,}) {
  return _then(_self.copyWith(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WeekVolumePoint].
extension WeekVolumePointPatterns on WeekVolumePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeekVolumePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeekVolumePoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeekVolumePoint value)  $default,){
final _that = this;
switch (_that) {
case _WeekVolumePoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeekVolumePoint value)?  $default,){
final _that = this;
switch (_that) {
case _WeekVolumePoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekNumber,  String weekName,  double totalVolume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeekVolumePoint() when $default != null:
return $default(_that.weekNumber,_that.weekName,_that.totalVolume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekNumber,  String weekName,  double totalVolume)  $default,) {final _that = this;
switch (_that) {
case _WeekVolumePoint():
return $default(_that.weekNumber,_that.weekName,_that.totalVolume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekNumber,  String weekName,  double totalVolume)?  $default,) {final _that = this;
switch (_that) {
case _WeekVolumePoint() when $default != null:
return $default(_that.weekNumber,_that.weekName,_that.totalVolume);case _:
  return null;

}
}

}

/// @nodoc


class _WeekVolumePoint implements WeekVolumePoint {
  const _WeekVolumePoint({required this.weekNumber, required this.weekName, required this.totalVolume});
  

@override final  int weekNumber;
@override final  String weekName;
@override final  double totalVolume;

/// Create a copy of WeekVolumePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekVolumePointCopyWith<_WeekVolumePoint> get copyWith => __$WeekVolumePointCopyWithImpl<_WeekVolumePoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekVolumePoint&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.weekName, weekName) || other.weekName == weekName)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume));
}


@override
int get hashCode => Object.hash(runtimeType,weekNumber,weekName,totalVolume);

@override
String toString() {
  return 'WeekVolumePoint(weekNumber: $weekNumber, weekName: $weekName, totalVolume: $totalVolume)';
}


}

/// @nodoc
abstract mixin class _$WeekVolumePointCopyWith<$Res> implements $WeekVolumePointCopyWith<$Res> {
  factory _$WeekVolumePointCopyWith(_WeekVolumePoint value, $Res Function(_WeekVolumePoint) _then) = __$WeekVolumePointCopyWithImpl;
@override @useResult
$Res call({
 int weekNumber, String weekName, double totalVolume
});




}
/// @nodoc
class __$WeekVolumePointCopyWithImpl<$Res>
    implements _$WeekVolumePointCopyWith<$Res> {
  __$WeekVolumePointCopyWithImpl(this._self, this._then);

  final _WeekVolumePoint _self;
  final $Res Function(_WeekVolumePoint) _then;

/// Create a copy of WeekVolumePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekNumber = null,Object? weekName = null,Object? totalVolume = null,}) {
  return _then(_WeekVolumePoint(
weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,weekName: null == weekName ? _self.weekName : weekName // ignore: cast_nullable_to_non_nullable
as String,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$MuscleGroupVolumePoint {

 String get muscleGroup; int get completedSets; double get totalVolume; double get percentOfTotal;
/// Create a copy of MuscleGroupVolumePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MuscleGroupVolumePointCopyWith<MuscleGroupVolumePoint> get copyWith => _$MuscleGroupVolumePointCopyWithImpl<MuscleGroupVolumePoint>(this as MuscleGroupVolumePoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MuscleGroupVolumePoint&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.percentOfTotal, percentOfTotal) || other.percentOfTotal == percentOfTotal));
}


@override
int get hashCode => Object.hash(runtimeType,muscleGroup,completedSets,totalVolume,percentOfTotal);

@override
String toString() {
  return 'MuscleGroupVolumePoint(muscleGroup: $muscleGroup, completedSets: $completedSets, totalVolume: $totalVolume, percentOfTotal: $percentOfTotal)';
}


}

/// @nodoc
abstract mixin class $MuscleGroupVolumePointCopyWith<$Res>  {
  factory $MuscleGroupVolumePointCopyWith(MuscleGroupVolumePoint value, $Res Function(MuscleGroupVolumePoint) _then) = _$MuscleGroupVolumePointCopyWithImpl;
@useResult
$Res call({
 String muscleGroup, int completedSets, double totalVolume, double percentOfTotal
});




}
/// @nodoc
class _$MuscleGroupVolumePointCopyWithImpl<$Res>
    implements $MuscleGroupVolumePointCopyWith<$Res> {
  _$MuscleGroupVolumePointCopyWithImpl(this._self, this._then);

  final MuscleGroupVolumePoint _self;
  final $Res Function(MuscleGroupVolumePoint) _then;

/// Create a copy of MuscleGroupVolumePoint
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


/// Adds pattern-matching-related methods to [MuscleGroupVolumePoint].
extension MuscleGroupVolumePointPatterns on MuscleGroupVolumePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MuscleGroupVolumePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MuscleGroupVolumePoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MuscleGroupVolumePoint value)  $default,){
final _that = this;
switch (_that) {
case _MuscleGroupVolumePoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MuscleGroupVolumePoint value)?  $default,){
final _that = this;
switch (_that) {
case _MuscleGroupVolumePoint() when $default != null:
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
case _MuscleGroupVolumePoint() when $default != null:
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
case _MuscleGroupVolumePoint():
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
case _MuscleGroupVolumePoint() when $default != null:
return $default(_that.muscleGroup,_that.completedSets,_that.totalVolume,_that.percentOfTotal);case _:
  return null;

}
}

}

/// @nodoc


class _MuscleGroupVolumePoint implements MuscleGroupVolumePoint {
  const _MuscleGroupVolumePoint({required this.muscleGroup, required this.completedSets, required this.totalVolume, required this.percentOfTotal});
  

@override final  String muscleGroup;
@override final  int completedSets;
@override final  double totalVolume;
@override final  double percentOfTotal;

/// Create a copy of MuscleGroupVolumePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MuscleGroupVolumePointCopyWith<_MuscleGroupVolumePoint> get copyWith => __$MuscleGroupVolumePointCopyWithImpl<_MuscleGroupVolumePoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MuscleGroupVolumePoint&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.completedSets, completedSets) || other.completedSets == completedSets)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.percentOfTotal, percentOfTotal) || other.percentOfTotal == percentOfTotal));
}


@override
int get hashCode => Object.hash(runtimeType,muscleGroup,completedSets,totalVolume,percentOfTotal);

@override
String toString() {
  return 'MuscleGroupVolumePoint(muscleGroup: $muscleGroup, completedSets: $completedSets, totalVolume: $totalVolume, percentOfTotal: $percentOfTotal)';
}


}

/// @nodoc
abstract mixin class _$MuscleGroupVolumePointCopyWith<$Res> implements $MuscleGroupVolumePointCopyWith<$Res> {
  factory _$MuscleGroupVolumePointCopyWith(_MuscleGroupVolumePoint value, $Res Function(_MuscleGroupVolumePoint) _then) = __$MuscleGroupVolumePointCopyWithImpl;
@override @useResult
$Res call({
 String muscleGroup, int completedSets, double totalVolume, double percentOfTotal
});




}
/// @nodoc
class __$MuscleGroupVolumePointCopyWithImpl<$Res>
    implements _$MuscleGroupVolumePointCopyWith<$Res> {
  __$MuscleGroupVolumePointCopyWithImpl(this._self, this._then);

  final _MuscleGroupVolumePoint _self;
  final $Res Function(_MuscleGroupVolumePoint) _then;

/// Create a copy of MuscleGroupVolumePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muscleGroup = null,Object? completedSets = null,Object? totalVolume = null,Object? percentOfTotal = null,}) {
  return _then(_MuscleGroupVolumePoint(
muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,completedSets: null == completedSets ? _self.completedSets : completedSets // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,percentOfTotal: null == percentOfTotal ? _self.percentOfTotal : percentOfTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$PowerliftingSection {

 LiftSeries get squat; LiftSeries get bench; LiftSeries get deadlift; List<DotsPoint> get dots;
/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PowerliftingSectionCopyWith<PowerliftingSection> get copyWith => _$PowerliftingSectionCopyWithImpl<PowerliftingSection>(this as PowerliftingSection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PowerliftingSection&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift)&&const DeepCollectionEquality().equals(other.dots, dots));
}


@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift,const DeepCollectionEquality().hash(dots));

@override
String toString() {
  return 'PowerliftingSection(squat: $squat, bench: $bench, deadlift: $deadlift, dots: $dots)';
}


}

/// @nodoc
abstract mixin class $PowerliftingSectionCopyWith<$Res>  {
  factory $PowerliftingSectionCopyWith(PowerliftingSection value, $Res Function(PowerliftingSection) _then) = _$PowerliftingSectionCopyWithImpl;
@useResult
$Res call({
 LiftSeries squat, LiftSeries bench, LiftSeries deadlift, List<DotsPoint> dots
});


$LiftSeriesCopyWith<$Res> get squat;$LiftSeriesCopyWith<$Res> get bench;$LiftSeriesCopyWith<$Res> get deadlift;

}
/// @nodoc
class _$PowerliftingSectionCopyWithImpl<$Res>
    implements $PowerliftingSectionCopyWith<$Res> {
  _$PowerliftingSectionCopyWithImpl(this._self, this._then);

  final PowerliftingSection _self;
  final $Res Function(PowerliftingSection) _then;

/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? squat = null,Object? bench = null,Object? deadlift = null,Object? dots = null,}) {
  return _then(_self.copyWith(
squat: null == squat ? _self.squat : squat // ignore: cast_nullable_to_non_nullable
as LiftSeries,bench: null == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as LiftSeries,deadlift: null == deadlift ? _self.deadlift : deadlift // ignore: cast_nullable_to_non_nullable
as LiftSeries,dots: null == dots ? _self.dots : dots // ignore: cast_nullable_to_non_nullable
as List<DotsPoint>,
  ));
}
/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesCopyWith<$Res> get squat {
  
  return $LiftSeriesCopyWith<$Res>(_self.squat, (value) {
    return _then(_self.copyWith(squat: value));
  });
}/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesCopyWith<$Res> get bench {
  
  return $LiftSeriesCopyWith<$Res>(_self.bench, (value) {
    return _then(_self.copyWith(bench: value));
  });
}/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesCopyWith<$Res> get deadlift {
  
  return $LiftSeriesCopyWith<$Res>(_self.deadlift, (value) {
    return _then(_self.copyWith(deadlift: value));
  });
}
}


/// Adds pattern-matching-related methods to [PowerliftingSection].
extension PowerliftingSectionPatterns on PowerliftingSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PowerliftingSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PowerliftingSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PowerliftingSection value)  $default,){
final _that = this;
switch (_that) {
case _PowerliftingSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PowerliftingSection value)?  $default,){
final _that = this;
switch (_that) {
case _PowerliftingSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LiftSeries squat,  LiftSeries bench,  LiftSeries deadlift,  List<DotsPoint> dots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PowerliftingSection() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LiftSeries squat,  LiftSeries bench,  LiftSeries deadlift,  List<DotsPoint> dots)  $default,) {final _that = this;
switch (_that) {
case _PowerliftingSection():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LiftSeries squat,  LiftSeries bench,  LiftSeries deadlift,  List<DotsPoint> dots)?  $default,) {final _that = this;
switch (_that) {
case _PowerliftingSection() when $default != null:
return $default(_that.squat,_that.bench,_that.deadlift,_that.dots);case _:
  return null;

}
}

}

/// @nodoc


class _PowerliftingSection extends PowerliftingSection {
  const _PowerliftingSection({required this.squat, required this.bench, required this.deadlift, required final  List<DotsPoint> dots}): _dots = dots,super._();
  

@override final  LiftSeries squat;
@override final  LiftSeries bench;
@override final  LiftSeries deadlift;
 final  List<DotsPoint> _dots;
@override List<DotsPoint> get dots {
  if (_dots is EqualUnmodifiableListView) return _dots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dots);
}


/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PowerliftingSectionCopyWith<_PowerliftingSection> get copyWith => __$PowerliftingSectionCopyWithImpl<_PowerliftingSection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PowerliftingSection&&(identical(other.squat, squat) || other.squat == squat)&&(identical(other.bench, bench) || other.bench == bench)&&(identical(other.deadlift, deadlift) || other.deadlift == deadlift)&&const DeepCollectionEquality().equals(other._dots, _dots));
}


@override
int get hashCode => Object.hash(runtimeType,squat,bench,deadlift,const DeepCollectionEquality().hash(_dots));

@override
String toString() {
  return 'PowerliftingSection(squat: $squat, bench: $bench, deadlift: $deadlift, dots: $dots)';
}


}

/// @nodoc
abstract mixin class _$PowerliftingSectionCopyWith<$Res> implements $PowerliftingSectionCopyWith<$Res> {
  factory _$PowerliftingSectionCopyWith(_PowerliftingSection value, $Res Function(_PowerliftingSection) _then) = __$PowerliftingSectionCopyWithImpl;
@override @useResult
$Res call({
 LiftSeries squat, LiftSeries bench, LiftSeries deadlift, List<DotsPoint> dots
});


@override $LiftSeriesCopyWith<$Res> get squat;@override $LiftSeriesCopyWith<$Res> get bench;@override $LiftSeriesCopyWith<$Res> get deadlift;

}
/// @nodoc
class __$PowerliftingSectionCopyWithImpl<$Res>
    implements _$PowerliftingSectionCopyWith<$Res> {
  __$PowerliftingSectionCopyWithImpl(this._self, this._then);

  final _PowerliftingSection _self;
  final $Res Function(_PowerliftingSection) _then;

/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? squat = null,Object? bench = null,Object? deadlift = null,Object? dots = null,}) {
  return _then(_PowerliftingSection(
squat: null == squat ? _self.squat : squat // ignore: cast_nullable_to_non_nullable
as LiftSeries,bench: null == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as LiftSeries,deadlift: null == deadlift ? _self.deadlift : deadlift // ignore: cast_nullable_to_non_nullable
as LiftSeries,dots: null == dots ? _self._dots : dots // ignore: cast_nullable_to_non_nullable
as List<DotsPoint>,
  ));
}

/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesCopyWith<$Res> get squat {
  
  return $LiftSeriesCopyWith<$Res>(_self.squat, (value) {
    return _then(_self.copyWith(squat: value));
  });
}/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesCopyWith<$Res> get bench {
  
  return $LiftSeriesCopyWith<$Res>(_self.bench, (value) {
    return _then(_self.copyWith(bench: value));
  });
}/// Create a copy of PowerliftingSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiftSeriesCopyWith<$Res> get deadlift {
  
  return $LiftSeriesCopyWith<$Res>(_self.deadlift, (value) {
    return _then(_self.copyWith(deadlift: value));
  });
}
}

/// @nodoc
mixin _$LiftSeries {

 CompetitionLift get lift; List<LiftE1RmPoint> get e1Rm; List<LiftPrEvent> get prTimeline; double? get currentE1Rm; double? get currentTrainingMax; bool get isPlateau;
/// Create a copy of LiftSeries
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiftSeriesCopyWith<LiftSeries> get copyWith => _$LiftSeriesCopyWithImpl<LiftSeries>(this as LiftSeries, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiftSeries&&(identical(other.lift, lift) || other.lift == lift)&&const DeepCollectionEquality().equals(other.e1Rm, e1Rm)&&const DeepCollectionEquality().equals(other.prTimeline, prTimeline)&&(identical(other.currentE1Rm, currentE1Rm) || other.currentE1Rm == currentE1Rm)&&(identical(other.currentTrainingMax, currentTrainingMax) || other.currentTrainingMax == currentTrainingMax)&&(identical(other.isPlateau, isPlateau) || other.isPlateau == isPlateau));
}


@override
int get hashCode => Object.hash(runtimeType,lift,const DeepCollectionEquality().hash(e1Rm),const DeepCollectionEquality().hash(prTimeline),currentE1Rm,currentTrainingMax,isPlateau);

@override
String toString() {
  return 'LiftSeries(lift: $lift, e1Rm: $e1Rm, prTimeline: $prTimeline, currentE1Rm: $currentE1Rm, currentTrainingMax: $currentTrainingMax, isPlateau: $isPlateau)';
}


}

/// @nodoc
abstract mixin class $LiftSeriesCopyWith<$Res>  {
  factory $LiftSeriesCopyWith(LiftSeries value, $Res Function(LiftSeries) _then) = _$LiftSeriesCopyWithImpl;
@useResult
$Res call({
 CompetitionLift lift, List<LiftE1RmPoint> e1Rm, List<LiftPrEvent> prTimeline, double? currentE1Rm, double? currentTrainingMax, bool isPlateau
});




}
/// @nodoc
class _$LiftSeriesCopyWithImpl<$Res>
    implements $LiftSeriesCopyWith<$Res> {
  _$LiftSeriesCopyWithImpl(this._self, this._then);

  final LiftSeries _self;
  final $Res Function(LiftSeries) _then;

/// Create a copy of LiftSeries
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lift = null,Object? e1Rm = null,Object? prTimeline = null,Object? currentE1Rm = freezed,Object? currentTrainingMax = freezed,Object? isPlateau = null,}) {
  return _then(_self.copyWith(
lift: null == lift ? _self.lift : lift // ignore: cast_nullable_to_non_nullable
as CompetitionLift,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as List<LiftE1RmPoint>,prTimeline: null == prTimeline ? _self.prTimeline : prTimeline // ignore: cast_nullable_to_non_nullable
as List<LiftPrEvent>,currentE1Rm: freezed == currentE1Rm ? _self.currentE1Rm : currentE1Rm // ignore: cast_nullable_to_non_nullable
as double?,currentTrainingMax: freezed == currentTrainingMax ? _self.currentTrainingMax : currentTrainingMax // ignore: cast_nullable_to_non_nullable
as double?,isPlateau: null == isPlateau ? _self.isPlateau : isPlateau // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LiftSeries].
extension LiftSeriesPatterns on LiftSeries {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiftSeries value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiftSeries() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiftSeries value)  $default,){
final _that = this;
switch (_that) {
case _LiftSeries():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiftSeries value)?  $default,){
final _that = this;
switch (_that) {
case _LiftSeries() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CompetitionLift lift,  List<LiftE1RmPoint> e1Rm,  List<LiftPrEvent> prTimeline,  double? currentE1Rm,  double? currentTrainingMax,  bool isPlateau)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiftSeries() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CompetitionLift lift,  List<LiftE1RmPoint> e1Rm,  List<LiftPrEvent> prTimeline,  double? currentE1Rm,  double? currentTrainingMax,  bool isPlateau)  $default,) {final _that = this;
switch (_that) {
case _LiftSeries():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CompetitionLift lift,  List<LiftE1RmPoint> e1Rm,  List<LiftPrEvent> prTimeline,  double? currentE1Rm,  double? currentTrainingMax,  bool isPlateau)?  $default,) {final _that = this;
switch (_that) {
case _LiftSeries() when $default != null:
return $default(_that.lift,_that.e1Rm,_that.prTimeline,_that.currentE1Rm,_that.currentTrainingMax,_that.isPlateau);case _:
  return null;

}
}

}

/// @nodoc


class _LiftSeries implements LiftSeries {
  const _LiftSeries({required this.lift, required final  List<LiftE1RmPoint> e1Rm, required final  List<LiftPrEvent> prTimeline, this.currentE1Rm, this.currentTrainingMax, this.isPlateau = false}): _e1Rm = e1Rm,_prTimeline = prTimeline;
  

@override final  CompetitionLift lift;
 final  List<LiftE1RmPoint> _e1Rm;
@override List<LiftE1RmPoint> get e1Rm {
  if (_e1Rm is EqualUnmodifiableListView) return _e1Rm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_e1Rm);
}

 final  List<LiftPrEvent> _prTimeline;
@override List<LiftPrEvent> get prTimeline {
  if (_prTimeline is EqualUnmodifiableListView) return _prTimeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prTimeline);
}

@override final  double? currentE1Rm;
@override final  double? currentTrainingMax;
@override@JsonKey() final  bool isPlateau;

/// Create a copy of LiftSeries
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiftSeriesCopyWith<_LiftSeries> get copyWith => __$LiftSeriesCopyWithImpl<_LiftSeries>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiftSeries&&(identical(other.lift, lift) || other.lift == lift)&&const DeepCollectionEquality().equals(other._e1Rm, _e1Rm)&&const DeepCollectionEquality().equals(other._prTimeline, _prTimeline)&&(identical(other.currentE1Rm, currentE1Rm) || other.currentE1Rm == currentE1Rm)&&(identical(other.currentTrainingMax, currentTrainingMax) || other.currentTrainingMax == currentTrainingMax)&&(identical(other.isPlateau, isPlateau) || other.isPlateau == isPlateau));
}


@override
int get hashCode => Object.hash(runtimeType,lift,const DeepCollectionEquality().hash(_e1Rm),const DeepCollectionEquality().hash(_prTimeline),currentE1Rm,currentTrainingMax,isPlateau);

@override
String toString() {
  return 'LiftSeries(lift: $lift, e1Rm: $e1Rm, prTimeline: $prTimeline, currentE1Rm: $currentE1Rm, currentTrainingMax: $currentTrainingMax, isPlateau: $isPlateau)';
}


}

/// @nodoc
abstract mixin class _$LiftSeriesCopyWith<$Res> implements $LiftSeriesCopyWith<$Res> {
  factory _$LiftSeriesCopyWith(_LiftSeries value, $Res Function(_LiftSeries) _then) = __$LiftSeriesCopyWithImpl;
@override @useResult
$Res call({
 CompetitionLift lift, List<LiftE1RmPoint> e1Rm, List<LiftPrEvent> prTimeline, double? currentE1Rm, double? currentTrainingMax, bool isPlateau
});




}
/// @nodoc
class __$LiftSeriesCopyWithImpl<$Res>
    implements _$LiftSeriesCopyWith<$Res> {
  __$LiftSeriesCopyWithImpl(this._self, this._then);

  final _LiftSeries _self;
  final $Res Function(_LiftSeries) _then;

/// Create a copy of LiftSeries
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lift = null,Object? e1Rm = null,Object? prTimeline = null,Object? currentE1Rm = freezed,Object? currentTrainingMax = freezed,Object? isPlateau = null,}) {
  return _then(_LiftSeries(
lift: null == lift ? _self.lift : lift // ignore: cast_nullable_to_non_nullable
as CompetitionLift,e1Rm: null == e1Rm ? _self._e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as List<LiftE1RmPoint>,prTimeline: null == prTimeline ? _self._prTimeline : prTimeline // ignore: cast_nullable_to_non_nullable
as List<LiftPrEvent>,currentE1Rm: freezed == currentE1Rm ? _self.currentE1Rm : currentE1Rm // ignore: cast_nullable_to_non_nullable
as double?,currentTrainingMax: freezed == currentTrainingMax ? _self.currentTrainingMax : currentTrainingMax // ignore: cast_nullable_to_non_nullable
as double?,isPlateau: null == isPlateau ? _self.isPlateau : isPlateau // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$LiftE1RmPoint {

 String get weekStart; double get e1Rm;
/// Create a copy of LiftE1RmPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiftE1RmPointCopyWith<LiftE1RmPoint> get copyWith => _$LiftE1RmPointCopyWithImpl<LiftE1RmPoint>(this as LiftE1RmPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiftE1RmPoint&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}


@override
int get hashCode => Object.hash(runtimeType,weekStart,e1Rm);

@override
String toString() {
  return 'LiftE1RmPoint(weekStart: $weekStart, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class $LiftE1RmPointCopyWith<$Res>  {
  factory $LiftE1RmPointCopyWith(LiftE1RmPoint value, $Res Function(LiftE1RmPoint) _then) = _$LiftE1RmPointCopyWithImpl;
@useResult
$Res call({
 String weekStart, double e1Rm
});




}
/// @nodoc
class _$LiftE1RmPointCopyWithImpl<$Res>
    implements $LiftE1RmPointCopyWith<$Res> {
  _$LiftE1RmPointCopyWithImpl(this._self, this._then);

  final LiftE1RmPoint _self;
  final $Res Function(LiftE1RmPoint) _then;

/// Create a copy of LiftE1RmPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? e1Rm = null,}) {
  return _then(_self.copyWith(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as String,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiftE1RmPoint].
extension LiftE1RmPointPatterns on LiftE1RmPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiftE1RmPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiftE1RmPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiftE1RmPoint value)  $default,){
final _that = this;
switch (_that) {
case _LiftE1RmPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiftE1RmPoint value)?  $default,){
final _that = this;
switch (_that) {
case _LiftE1RmPoint() when $default != null:
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
case _LiftE1RmPoint() when $default != null:
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
case _LiftE1RmPoint():
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
case _LiftE1RmPoint() when $default != null:
return $default(_that.weekStart,_that.e1Rm);case _:
  return null;

}
}

}

/// @nodoc


class _LiftE1RmPoint implements LiftE1RmPoint {
  const _LiftE1RmPoint({required this.weekStart, required this.e1Rm});
  

@override final  String weekStart;
@override final  double e1Rm;

/// Create a copy of LiftE1RmPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiftE1RmPointCopyWith<_LiftE1RmPoint> get copyWith => __$LiftE1RmPointCopyWithImpl<_LiftE1RmPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiftE1RmPoint&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}


@override
int get hashCode => Object.hash(runtimeType,weekStart,e1Rm);

@override
String toString() {
  return 'LiftE1RmPoint(weekStart: $weekStart, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class _$LiftE1RmPointCopyWith<$Res> implements $LiftE1RmPointCopyWith<$Res> {
  factory _$LiftE1RmPointCopyWith(_LiftE1RmPoint value, $Res Function(_LiftE1RmPoint) _then) = __$LiftE1RmPointCopyWithImpl;
@override @useResult
$Res call({
 String weekStart, double e1Rm
});




}
/// @nodoc
class __$LiftE1RmPointCopyWithImpl<$Res>
    implements _$LiftE1RmPointCopyWith<$Res> {
  __$LiftE1RmPointCopyWithImpl(this._self, this._then);

  final _LiftE1RmPoint _self;
  final $Res Function(_LiftE1RmPoint) _then;

/// Create a copy of LiftE1RmPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? e1Rm = null,}) {
  return _then(_LiftE1RmPoint(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as String,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$LiftPrEvent {

 DateTime get date; double get weight; int get reps; double get e1Rm;
/// Create a copy of LiftPrEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiftPrEventCopyWith<LiftPrEvent> get copyWith => _$LiftPrEventCopyWithImpl<LiftPrEvent>(this as LiftPrEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiftPrEvent&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}


@override
int get hashCode => Object.hash(runtimeType,date,weight,reps,e1Rm);

@override
String toString() {
  return 'LiftPrEvent(date: $date, weight: $weight, reps: $reps, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class $LiftPrEventCopyWith<$Res>  {
  factory $LiftPrEventCopyWith(LiftPrEvent value, $Res Function(LiftPrEvent) _then) = _$LiftPrEventCopyWithImpl;
@useResult
$Res call({
 DateTime date, double weight, int reps, double e1Rm
});




}
/// @nodoc
class _$LiftPrEventCopyWithImpl<$Res>
    implements $LiftPrEventCopyWith<$Res> {
  _$LiftPrEventCopyWithImpl(this._self, this._then);

  final LiftPrEvent _self;
  final $Res Function(LiftPrEvent) _then;

/// Create a copy of LiftPrEvent
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


/// Adds pattern-matching-related methods to [LiftPrEvent].
extension LiftPrEventPatterns on LiftPrEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiftPrEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiftPrEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiftPrEvent value)  $default,){
final _that = this;
switch (_that) {
case _LiftPrEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiftPrEvent value)?  $default,){
final _that = this;
switch (_that) {
case _LiftPrEvent() when $default != null:
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
case _LiftPrEvent() when $default != null:
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
case _LiftPrEvent():
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
case _LiftPrEvent() when $default != null:
return $default(_that.date,_that.weight,_that.reps,_that.e1Rm);case _:
  return null;

}
}

}

/// @nodoc


class _LiftPrEvent implements LiftPrEvent {
  const _LiftPrEvent({required this.date, required this.weight, required this.reps, required this.e1Rm});
  

@override final  DateTime date;
@override final  double weight;
@override final  int reps;
@override final  double e1Rm;

/// Create a copy of LiftPrEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiftPrEventCopyWith<_LiftPrEvent> get copyWith => __$LiftPrEventCopyWithImpl<_LiftPrEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiftPrEvent&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.e1Rm, e1Rm) || other.e1Rm == e1Rm));
}


@override
int get hashCode => Object.hash(runtimeType,date,weight,reps,e1Rm);

@override
String toString() {
  return 'LiftPrEvent(date: $date, weight: $weight, reps: $reps, e1Rm: $e1Rm)';
}


}

/// @nodoc
abstract mixin class _$LiftPrEventCopyWith<$Res> implements $LiftPrEventCopyWith<$Res> {
  factory _$LiftPrEventCopyWith(_LiftPrEvent value, $Res Function(_LiftPrEvent) _then) = __$LiftPrEventCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double weight, int reps, double e1Rm
});




}
/// @nodoc
class __$LiftPrEventCopyWithImpl<$Res>
    implements _$LiftPrEventCopyWith<$Res> {
  __$LiftPrEventCopyWithImpl(this._self, this._then);

  final _LiftPrEvent _self;
  final $Res Function(_LiftPrEvent) _then;

/// Create a copy of LiftPrEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? weight = null,Object? reps = null,Object? e1Rm = null,}) {
  return _then(_LiftPrEvent(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,e1Rm: null == e1Rm ? _self.e1Rm : e1Rm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$DotsPoint {

 String get weekStart; double get dots; double get bodyweightKg;
/// Create a copy of DotsPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DotsPointCopyWith<DotsPoint> get copyWith => _$DotsPointCopyWithImpl<DotsPoint>(this as DotsPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DotsPoint&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.dots, dots) || other.dots == dots)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg));
}


@override
int get hashCode => Object.hash(runtimeType,weekStart,dots,bodyweightKg);

@override
String toString() {
  return 'DotsPoint(weekStart: $weekStart, dots: $dots, bodyweightKg: $bodyweightKg)';
}


}

/// @nodoc
abstract mixin class $DotsPointCopyWith<$Res>  {
  factory $DotsPointCopyWith(DotsPoint value, $Res Function(DotsPoint) _then) = _$DotsPointCopyWithImpl;
@useResult
$Res call({
 String weekStart, double dots, double bodyweightKg
});




}
/// @nodoc
class _$DotsPointCopyWithImpl<$Res>
    implements $DotsPointCopyWith<$Res> {
  _$DotsPointCopyWithImpl(this._self, this._then);

  final DotsPoint _self;
  final $Res Function(DotsPoint) _then;

/// Create a copy of DotsPoint
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


/// Adds pattern-matching-related methods to [DotsPoint].
extension DotsPointPatterns on DotsPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DotsPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DotsPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DotsPoint value)  $default,){
final _that = this;
switch (_that) {
case _DotsPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DotsPoint value)?  $default,){
final _that = this;
switch (_that) {
case _DotsPoint() when $default != null:
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
case _DotsPoint() when $default != null:
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
case _DotsPoint():
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
case _DotsPoint() when $default != null:
return $default(_that.weekStart,_that.dots,_that.bodyweightKg);case _:
  return null;

}
}

}

/// @nodoc


class _DotsPoint implements DotsPoint {
  const _DotsPoint({required this.weekStart, required this.dots, required this.bodyweightKg});
  

@override final  String weekStart;
@override final  double dots;
@override final  double bodyweightKg;

/// Create a copy of DotsPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DotsPointCopyWith<_DotsPoint> get copyWith => __$DotsPointCopyWithImpl<_DotsPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DotsPoint&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.dots, dots) || other.dots == dots)&&(identical(other.bodyweightKg, bodyweightKg) || other.bodyweightKg == bodyweightKg));
}


@override
int get hashCode => Object.hash(runtimeType,weekStart,dots,bodyweightKg);

@override
String toString() {
  return 'DotsPoint(weekStart: $weekStart, dots: $dots, bodyweightKg: $bodyweightKg)';
}


}

/// @nodoc
abstract mixin class _$DotsPointCopyWith<$Res> implements $DotsPointCopyWith<$Res> {
  factory _$DotsPointCopyWith(_DotsPoint value, $Res Function(_DotsPoint) _then) = __$DotsPointCopyWithImpl;
@override @useResult
$Res call({
 String weekStart, double dots, double bodyweightKg
});




}
/// @nodoc
class __$DotsPointCopyWithImpl<$Res>
    implements _$DotsPointCopyWith<$Res> {
  __$DotsPointCopyWithImpl(this._self, this._then);

  final _DotsPoint _self;
  final $Res Function(_DotsPoint) _then;

/// Create a copy of DotsPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? dots = null,Object? bodyweightKg = null,}) {
  return _then(_DotsPoint(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as String,dots: null == dots ? _self.dots : dots // ignore: cast_nullable_to_non_nullable
as double,bodyweightKg: null == bodyweightKg ? _self.bodyweightKg : bodyweightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
