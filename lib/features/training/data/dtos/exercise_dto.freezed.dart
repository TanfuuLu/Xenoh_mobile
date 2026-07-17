// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseSetDto {

 String get id; int get setNumber; int get plannedReps; bool get isCompleted; double? get plannedWeight; int? get actualReps; double? get actualWeight; double? get rpe; DateTime? get completedAt;
/// Create a copy of ExerciseSetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseSetDtoCopyWith<ExerciseSetDto> get copyWith => _$ExerciseSetDtoCopyWithImpl<ExerciseSetDto>(this as ExerciseSetDto, _$identity);

  /// Serializes this ExerciseSetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseSetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.plannedReps, plannedReps) || other.plannedReps == plannedReps)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.plannedWeight, plannedWeight) || other.plannedWeight == plannedWeight)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.actualWeight, actualWeight) || other.actualWeight == actualWeight)&&(identical(other.rpe, rpe) || other.rpe == rpe)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,setNumber,plannedReps,isCompleted,plannedWeight,actualReps,actualWeight,rpe,completedAt);

@override
String toString() {
  return 'ExerciseSetDto(id: $id, setNumber: $setNumber, plannedReps: $plannedReps, isCompleted: $isCompleted, plannedWeight: $plannedWeight, actualReps: $actualReps, actualWeight: $actualWeight, rpe: $rpe, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $ExerciseSetDtoCopyWith<$Res>  {
  factory $ExerciseSetDtoCopyWith(ExerciseSetDto value, $Res Function(ExerciseSetDto) _then) = _$ExerciseSetDtoCopyWithImpl;
@useResult
$Res call({
 String id, int setNumber, int plannedReps, bool isCompleted, double? plannedWeight, int? actualReps, double? actualWeight, double? rpe, DateTime? completedAt
});




}
/// @nodoc
class _$ExerciseSetDtoCopyWithImpl<$Res>
    implements $ExerciseSetDtoCopyWith<$Res> {
  _$ExerciseSetDtoCopyWithImpl(this._self, this._then);

  final ExerciseSetDto _self;
  final $Res Function(ExerciseSetDto) _then;

/// Create a copy of ExerciseSetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? setNumber = null,Object? plannedReps = null,Object? isCompleted = null,Object? plannedWeight = freezed,Object? actualReps = freezed,Object? actualWeight = freezed,Object? rpe = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,plannedReps: null == plannedReps ? _self.plannedReps : plannedReps // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,plannedWeight: freezed == plannedWeight ? _self.plannedWeight : plannedWeight // ignore: cast_nullable_to_non_nullable
as double?,actualReps: freezed == actualReps ? _self.actualReps : actualReps // ignore: cast_nullable_to_non_nullable
as int?,actualWeight: freezed == actualWeight ? _self.actualWeight : actualWeight // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseSetDto].
extension ExerciseSetDtoPatterns on ExerciseSetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseSetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseSetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseSetDto value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseSetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseSetDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseSetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int setNumber,  int plannedReps,  bool isCompleted,  double? plannedWeight,  int? actualReps,  double? actualWeight,  double? rpe,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseSetDto() when $default != null:
return $default(_that.id,_that.setNumber,_that.plannedReps,_that.isCompleted,_that.plannedWeight,_that.actualReps,_that.actualWeight,_that.rpe,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int setNumber,  int plannedReps,  bool isCompleted,  double? plannedWeight,  int? actualReps,  double? actualWeight,  double? rpe,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _ExerciseSetDto():
return $default(_that.id,_that.setNumber,_that.plannedReps,_that.isCompleted,_that.plannedWeight,_that.actualReps,_that.actualWeight,_that.rpe,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int setNumber,  int plannedReps,  bool isCompleted,  double? plannedWeight,  int? actualReps,  double? actualWeight,  double? rpe,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseSetDto() when $default != null:
return $default(_that.id,_that.setNumber,_that.plannedReps,_that.isCompleted,_that.plannedWeight,_that.actualReps,_that.actualWeight,_that.rpe,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseSetDto extends ExerciseSetDto {
  const _ExerciseSetDto({required this.id, required this.setNumber, required this.plannedReps, required this.isCompleted, this.plannedWeight, this.actualReps, this.actualWeight, this.rpe, this.completedAt}): super._();
  factory _ExerciseSetDto.fromJson(Map<String, dynamic> json) => _$ExerciseSetDtoFromJson(json);

@override final  String id;
@override final  int setNumber;
@override final  int plannedReps;
@override final  bool isCompleted;
@override final  double? plannedWeight;
@override final  int? actualReps;
@override final  double? actualWeight;
@override final  double? rpe;
@override final  DateTime? completedAt;

/// Create a copy of ExerciseSetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseSetDtoCopyWith<_ExerciseSetDto> get copyWith => __$ExerciseSetDtoCopyWithImpl<_ExerciseSetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseSetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseSetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.plannedReps, plannedReps) || other.plannedReps == plannedReps)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.plannedWeight, plannedWeight) || other.plannedWeight == plannedWeight)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.actualWeight, actualWeight) || other.actualWeight == actualWeight)&&(identical(other.rpe, rpe) || other.rpe == rpe)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,setNumber,plannedReps,isCompleted,plannedWeight,actualReps,actualWeight,rpe,completedAt);

@override
String toString() {
  return 'ExerciseSetDto(id: $id, setNumber: $setNumber, plannedReps: $plannedReps, isCompleted: $isCompleted, plannedWeight: $plannedWeight, actualReps: $actualReps, actualWeight: $actualWeight, rpe: $rpe, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$ExerciseSetDtoCopyWith<$Res> implements $ExerciseSetDtoCopyWith<$Res> {
  factory _$ExerciseSetDtoCopyWith(_ExerciseSetDto value, $Res Function(_ExerciseSetDto) _then) = __$ExerciseSetDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int setNumber, int plannedReps, bool isCompleted, double? plannedWeight, int? actualReps, double? actualWeight, double? rpe, DateTime? completedAt
});




}
/// @nodoc
class __$ExerciseSetDtoCopyWithImpl<$Res>
    implements _$ExerciseSetDtoCopyWith<$Res> {
  __$ExerciseSetDtoCopyWithImpl(this._self, this._then);

  final _ExerciseSetDto _self;
  final $Res Function(_ExerciseSetDto) _then;

/// Create a copy of ExerciseSetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? setNumber = null,Object? plannedReps = null,Object? isCompleted = null,Object? plannedWeight = freezed,Object? actualReps = freezed,Object? actualWeight = freezed,Object? rpe = freezed,Object? completedAt = freezed,}) {
  return _then(_ExerciseSetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,plannedReps: null == plannedReps ? _self.plannedReps : plannedReps // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,plannedWeight: freezed == plannedWeight ? _self.plannedWeight : plannedWeight // ignore: cast_nullable_to_non_nullable
as double?,actualReps: freezed == actualReps ? _self.actualReps : actualReps // ignore: cast_nullable_to_non_nullable
as int?,actualWeight: freezed == actualWeight ? _self.actualWeight : actualWeight // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ExerciseDto {

 String get id; String get exerciseTemplateId; String get name; String get primaryMuscleGroup; String get exerciseKind; int get plannedSets; int get plannedReps; int get completedSetsCount; bool get isCompleted; bool get isSkipped; String get dailyWorkoutId; int get sortOrder; List<ExerciseSetDto> get sets; List<String> get secondaryMuscleGroups; double? get plannedWeight; String? get notes; double? get personalRecordWeight; DateTime? get startedAtUtc; DateTime? get endedAtUtc; int? get durationSeconds; bool? get isCompetitionLift; String? get imageUrl;
/// Create a copy of ExerciseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseDtoCopyWith<ExerciseDto> get copyWith => _$ExerciseDtoCopyWithImpl<ExerciseDto>(this as ExerciseDto, _$identity);

  /// Serializes this ExerciseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.exerciseTemplateId, exerciseTemplateId) || other.exerciseTemplateId == exerciseTemplateId)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.plannedSets, plannedSets) || other.plannedSets == plannedSets)&&(identical(other.plannedReps, plannedReps) || other.plannedReps == plannedReps)&&(identical(other.completedSetsCount, completedSetsCount) || other.completedSetsCount == completedSetsCount)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.dailyWorkoutId, dailyWorkoutId) || other.dailyWorkoutId == dailyWorkoutId)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.sets, sets)&&const DeepCollectionEquality().equals(other.secondaryMuscleGroups, secondaryMuscleGroups)&&(identical(other.plannedWeight, plannedWeight) || other.plannedWeight == plannedWeight)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.personalRecordWeight, personalRecordWeight) || other.personalRecordWeight == personalRecordWeight)&&(identical(other.startedAtUtc, startedAtUtc) || other.startedAtUtc == startedAtUtc)&&(identical(other.endedAtUtc, endedAtUtc) || other.endedAtUtc == endedAtUtc)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.isCompetitionLift, isCompetitionLift) || other.isCompetitionLift == isCompetitionLift)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,exerciseTemplateId,name,primaryMuscleGroup,exerciseKind,plannedSets,plannedReps,completedSetsCount,isCompleted,isSkipped,dailyWorkoutId,sortOrder,const DeepCollectionEquality().hash(sets),const DeepCollectionEquality().hash(secondaryMuscleGroups),plannedWeight,notes,personalRecordWeight,startedAtUtc,endedAtUtc,durationSeconds,isCompetitionLift,imageUrl]);

@override
String toString() {
  return 'ExerciseDto(id: $id, exerciseTemplateId: $exerciseTemplateId, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, plannedSets: $plannedSets, plannedReps: $plannedReps, completedSetsCount: $completedSetsCount, isCompleted: $isCompleted, isSkipped: $isSkipped, dailyWorkoutId: $dailyWorkoutId, sortOrder: $sortOrder, sets: $sets, secondaryMuscleGroups: $secondaryMuscleGroups, plannedWeight: $plannedWeight, notes: $notes, personalRecordWeight: $personalRecordWeight, startedAtUtc: $startedAtUtc, endedAtUtc: $endedAtUtc, durationSeconds: $durationSeconds, isCompetitionLift: $isCompetitionLift, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ExerciseDtoCopyWith<$Res>  {
  factory $ExerciseDtoCopyWith(ExerciseDto value, $Res Function(ExerciseDto) _then) = _$ExerciseDtoCopyWithImpl;
@useResult
$Res call({
 String id, String exerciseTemplateId, String name, String primaryMuscleGroup, String exerciseKind, int plannedSets, int plannedReps, int completedSetsCount, bool isCompleted, bool isSkipped, String dailyWorkoutId, int sortOrder, List<ExerciseSetDto> sets, List<String> secondaryMuscleGroups, double? plannedWeight, String? notes, double? personalRecordWeight, DateTime? startedAtUtc, DateTime? endedAtUtc, int? durationSeconds, bool? isCompetitionLift, String? imageUrl
});




}
/// @nodoc
class _$ExerciseDtoCopyWithImpl<$Res>
    implements $ExerciseDtoCopyWith<$Res> {
  _$ExerciseDtoCopyWithImpl(this._self, this._then);

  final ExerciseDto _self;
  final $Res Function(ExerciseDto) _then;

/// Create a copy of ExerciseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? exerciseTemplateId = null,Object? name = null,Object? primaryMuscleGroup = null,Object? exerciseKind = null,Object? plannedSets = null,Object? plannedReps = null,Object? completedSetsCount = null,Object? isCompleted = null,Object? isSkipped = null,Object? dailyWorkoutId = null,Object? sortOrder = null,Object? sets = null,Object? secondaryMuscleGroups = null,Object? plannedWeight = freezed,Object? notes = freezed,Object? personalRecordWeight = freezed,Object? startedAtUtc = freezed,Object? endedAtUtc = freezed,Object? durationSeconds = freezed,Object? isCompetitionLift = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exerciseTemplateId: null == exerciseTemplateId ? _self.exerciseTemplateId : exerciseTemplateId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscleGroup: null == primaryMuscleGroup ? _self.primaryMuscleGroup : primaryMuscleGroup // ignore: cast_nullable_to_non_nullable
as String,exerciseKind: null == exerciseKind ? _self.exerciseKind : exerciseKind // ignore: cast_nullable_to_non_nullable
as String,plannedSets: null == plannedSets ? _self.plannedSets : plannedSets // ignore: cast_nullable_to_non_nullable
as int,plannedReps: null == plannedReps ? _self.plannedReps : plannedReps // ignore: cast_nullable_to_non_nullable
as int,completedSetsCount: null == completedSetsCount ? _self.completedSetsCount : completedSetsCount // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,dailyWorkoutId: null == dailyWorkoutId ? _self.dailyWorkoutId : dailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSetDto>,secondaryMuscleGroups: null == secondaryMuscleGroups ? _self.secondaryMuscleGroups : secondaryMuscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,plannedWeight: freezed == plannedWeight ? _self.plannedWeight : plannedWeight // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,personalRecordWeight: freezed == personalRecordWeight ? _self.personalRecordWeight : personalRecordWeight // ignore: cast_nullable_to_non_nullable
as double?,startedAtUtc: freezed == startedAtUtc ? _self.startedAtUtc : startedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAtUtc: freezed == endedAtUtc ? _self.endedAtUtc : endedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,isCompetitionLift: freezed == isCompetitionLift ? _self.isCompetitionLift : isCompetitionLift // ignore: cast_nullable_to_non_nullable
as bool?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseDto].
extension ExerciseDtoPatterns on ExerciseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseDto value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String exerciseTemplateId,  String name,  String primaryMuscleGroup,  String exerciseKind,  int plannedSets,  int plannedReps,  int completedSetsCount,  bool isCompleted,  bool isSkipped,  String dailyWorkoutId,  int sortOrder,  List<ExerciseSetDto> sets,  List<String> secondaryMuscleGroups,  double? plannedWeight,  String? notes,  double? personalRecordWeight,  DateTime? startedAtUtc,  DateTime? endedAtUtc,  int? durationSeconds,  bool? isCompetitionLift,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseDto() when $default != null:
return $default(_that.id,_that.exerciseTemplateId,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.plannedSets,_that.plannedReps,_that.completedSetsCount,_that.isCompleted,_that.isSkipped,_that.dailyWorkoutId,_that.sortOrder,_that.sets,_that.secondaryMuscleGroups,_that.plannedWeight,_that.notes,_that.personalRecordWeight,_that.startedAtUtc,_that.endedAtUtc,_that.durationSeconds,_that.isCompetitionLift,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String exerciseTemplateId,  String name,  String primaryMuscleGroup,  String exerciseKind,  int plannedSets,  int plannedReps,  int completedSetsCount,  bool isCompleted,  bool isSkipped,  String dailyWorkoutId,  int sortOrder,  List<ExerciseSetDto> sets,  List<String> secondaryMuscleGroups,  double? plannedWeight,  String? notes,  double? personalRecordWeight,  DateTime? startedAtUtc,  DateTime? endedAtUtc,  int? durationSeconds,  bool? isCompetitionLift,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ExerciseDto():
return $default(_that.id,_that.exerciseTemplateId,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.plannedSets,_that.plannedReps,_that.completedSetsCount,_that.isCompleted,_that.isSkipped,_that.dailyWorkoutId,_that.sortOrder,_that.sets,_that.secondaryMuscleGroups,_that.plannedWeight,_that.notes,_that.personalRecordWeight,_that.startedAtUtc,_that.endedAtUtc,_that.durationSeconds,_that.isCompetitionLift,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String exerciseTemplateId,  String name,  String primaryMuscleGroup,  String exerciseKind,  int plannedSets,  int plannedReps,  int completedSetsCount,  bool isCompleted,  bool isSkipped,  String dailyWorkoutId,  int sortOrder,  List<ExerciseSetDto> sets,  List<String> secondaryMuscleGroups,  double? plannedWeight,  String? notes,  double? personalRecordWeight,  DateTime? startedAtUtc,  DateTime? endedAtUtc,  int? durationSeconds,  bool? isCompetitionLift,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseDto() when $default != null:
return $default(_that.id,_that.exerciseTemplateId,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.plannedSets,_that.plannedReps,_that.completedSetsCount,_that.isCompleted,_that.isSkipped,_that.dailyWorkoutId,_that.sortOrder,_that.sets,_that.secondaryMuscleGroups,_that.plannedWeight,_that.notes,_that.personalRecordWeight,_that.startedAtUtc,_that.endedAtUtc,_that.durationSeconds,_that.isCompetitionLift,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseDto extends ExerciseDto {
  const _ExerciseDto({required this.id, required this.exerciseTemplateId, required this.name, required this.primaryMuscleGroup, required this.exerciseKind, required this.plannedSets, required this.plannedReps, required this.completedSetsCount, required this.isCompleted, required this.isSkipped, required this.dailyWorkoutId, required this.sortOrder, final  List<ExerciseSetDto> sets = const <ExerciseSetDto>[], final  List<String> secondaryMuscleGroups = const <String>[], this.plannedWeight, this.notes, this.personalRecordWeight, this.startedAtUtc, this.endedAtUtc, this.durationSeconds, this.isCompetitionLift, this.imageUrl}): _sets = sets,_secondaryMuscleGroups = secondaryMuscleGroups,super._();
  factory _ExerciseDto.fromJson(Map<String, dynamic> json) => _$ExerciseDtoFromJson(json);

@override final  String id;
@override final  String exerciseTemplateId;
@override final  String name;
@override final  String primaryMuscleGroup;
@override final  String exerciseKind;
@override final  int plannedSets;
@override final  int plannedReps;
@override final  int completedSetsCount;
@override final  bool isCompleted;
@override final  bool isSkipped;
@override final  String dailyWorkoutId;
@override final  int sortOrder;
 final  List<ExerciseSetDto> _sets;
@override@JsonKey() List<ExerciseSetDto> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

 final  List<String> _secondaryMuscleGroups;
@override@JsonKey() List<String> get secondaryMuscleGroups {
  if (_secondaryMuscleGroups is EqualUnmodifiableListView) return _secondaryMuscleGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryMuscleGroups);
}

@override final  double? plannedWeight;
@override final  String? notes;
@override final  double? personalRecordWeight;
@override final  DateTime? startedAtUtc;
@override final  DateTime? endedAtUtc;
@override final  int? durationSeconds;
@override final  bool? isCompetitionLift;
@override final  String? imageUrl;

/// Create a copy of ExerciseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseDtoCopyWith<_ExerciseDto> get copyWith => __$ExerciseDtoCopyWithImpl<_ExerciseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.exerciseTemplateId, exerciseTemplateId) || other.exerciseTemplateId == exerciseTemplateId)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.plannedSets, plannedSets) || other.plannedSets == plannedSets)&&(identical(other.plannedReps, plannedReps) || other.plannedReps == plannedReps)&&(identical(other.completedSetsCount, completedSetsCount) || other.completedSetsCount == completedSetsCount)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.dailyWorkoutId, dailyWorkoutId) || other.dailyWorkoutId == dailyWorkoutId)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other._sets, _sets)&&const DeepCollectionEquality().equals(other._secondaryMuscleGroups, _secondaryMuscleGroups)&&(identical(other.plannedWeight, plannedWeight) || other.plannedWeight == plannedWeight)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.personalRecordWeight, personalRecordWeight) || other.personalRecordWeight == personalRecordWeight)&&(identical(other.startedAtUtc, startedAtUtc) || other.startedAtUtc == startedAtUtc)&&(identical(other.endedAtUtc, endedAtUtc) || other.endedAtUtc == endedAtUtc)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.isCompetitionLift, isCompetitionLift) || other.isCompetitionLift == isCompetitionLift)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,exerciseTemplateId,name,primaryMuscleGroup,exerciseKind,plannedSets,plannedReps,completedSetsCount,isCompleted,isSkipped,dailyWorkoutId,sortOrder,const DeepCollectionEquality().hash(_sets),const DeepCollectionEquality().hash(_secondaryMuscleGroups),plannedWeight,notes,personalRecordWeight,startedAtUtc,endedAtUtc,durationSeconds,isCompetitionLift,imageUrl]);

@override
String toString() {
  return 'ExerciseDto(id: $id, exerciseTemplateId: $exerciseTemplateId, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, plannedSets: $plannedSets, plannedReps: $plannedReps, completedSetsCount: $completedSetsCount, isCompleted: $isCompleted, isSkipped: $isSkipped, dailyWorkoutId: $dailyWorkoutId, sortOrder: $sortOrder, sets: $sets, secondaryMuscleGroups: $secondaryMuscleGroups, plannedWeight: $plannedWeight, notes: $notes, personalRecordWeight: $personalRecordWeight, startedAtUtc: $startedAtUtc, endedAtUtc: $endedAtUtc, durationSeconds: $durationSeconds, isCompetitionLift: $isCompetitionLift, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ExerciseDtoCopyWith<$Res> implements $ExerciseDtoCopyWith<$Res> {
  factory _$ExerciseDtoCopyWith(_ExerciseDto value, $Res Function(_ExerciseDto) _then) = __$ExerciseDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String exerciseTemplateId, String name, String primaryMuscleGroup, String exerciseKind, int plannedSets, int plannedReps, int completedSetsCount, bool isCompleted, bool isSkipped, String dailyWorkoutId, int sortOrder, List<ExerciseSetDto> sets, List<String> secondaryMuscleGroups, double? plannedWeight, String? notes, double? personalRecordWeight, DateTime? startedAtUtc, DateTime? endedAtUtc, int? durationSeconds, bool? isCompetitionLift, String? imageUrl
});




}
/// @nodoc
class __$ExerciseDtoCopyWithImpl<$Res>
    implements _$ExerciseDtoCopyWith<$Res> {
  __$ExerciseDtoCopyWithImpl(this._self, this._then);

  final _ExerciseDto _self;
  final $Res Function(_ExerciseDto) _then;

/// Create a copy of ExerciseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? exerciseTemplateId = null,Object? name = null,Object? primaryMuscleGroup = null,Object? exerciseKind = null,Object? plannedSets = null,Object? plannedReps = null,Object? completedSetsCount = null,Object? isCompleted = null,Object? isSkipped = null,Object? dailyWorkoutId = null,Object? sortOrder = null,Object? sets = null,Object? secondaryMuscleGroups = null,Object? plannedWeight = freezed,Object? notes = freezed,Object? personalRecordWeight = freezed,Object? startedAtUtc = freezed,Object? endedAtUtc = freezed,Object? durationSeconds = freezed,Object? isCompetitionLift = freezed,Object? imageUrl = freezed,}) {
  return _then(_ExerciseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exerciseTemplateId: null == exerciseTemplateId ? _self.exerciseTemplateId : exerciseTemplateId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscleGroup: null == primaryMuscleGroup ? _self.primaryMuscleGroup : primaryMuscleGroup // ignore: cast_nullable_to_non_nullable
as String,exerciseKind: null == exerciseKind ? _self.exerciseKind : exerciseKind // ignore: cast_nullable_to_non_nullable
as String,plannedSets: null == plannedSets ? _self.plannedSets : plannedSets // ignore: cast_nullable_to_non_nullable
as int,plannedReps: null == plannedReps ? _self.plannedReps : plannedReps // ignore: cast_nullable_to_non_nullable
as int,completedSetsCount: null == completedSetsCount ? _self.completedSetsCount : completedSetsCount // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,dailyWorkoutId: null == dailyWorkoutId ? _self.dailyWorkoutId : dailyWorkoutId // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSetDto>,secondaryMuscleGroups: null == secondaryMuscleGroups ? _self._secondaryMuscleGroups : secondaryMuscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,plannedWeight: freezed == plannedWeight ? _self.plannedWeight : plannedWeight // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,personalRecordWeight: freezed == personalRecordWeight ? _self.personalRecordWeight : personalRecordWeight // ignore: cast_nullable_to_non_nullable
as double?,startedAtUtc: freezed == startedAtUtc ? _self.startedAtUtc : startedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAtUtc: freezed == endedAtUtc ? _self.endedAtUtc : endedAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,isCompetitionLift: freezed == isCompetitionLift ? _self.isCompetitionLift : isCompetitionLift // ignore: cast_nullable_to_non_nullable
as bool?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
