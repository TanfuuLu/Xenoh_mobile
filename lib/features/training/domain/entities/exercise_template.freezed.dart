// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseTemplate {

 String get id; String get name; String get primaryMuscleGroup; String get exerciseKind;// "Strength" | "Cardio"
 bool get isCustom; List<String> get secondaryMuscleGroups; String? get description; String? get ownerId; String? get imageUrl;
/// Create a copy of ExerciseTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseTemplateCopyWith<ExerciseTemplate> get copyWith => _$ExerciseTemplateCopyWithImpl<ExerciseTemplate>(this as ExerciseTemplate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&const DeepCollectionEquality().equals(other.secondaryMuscleGroups, secondaryMuscleGroups)&&(identical(other.description, description) || other.description == description)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,primaryMuscleGroup,exerciseKind,isCustom,const DeepCollectionEquality().hash(secondaryMuscleGroups),description,ownerId,imageUrl);

@override
String toString() {
  return 'ExerciseTemplate(id: $id, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, isCustom: $isCustom, secondaryMuscleGroups: $secondaryMuscleGroups, description: $description, ownerId: $ownerId, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ExerciseTemplateCopyWith<$Res>  {
  factory $ExerciseTemplateCopyWith(ExerciseTemplate value, $Res Function(ExerciseTemplate) _then) = _$ExerciseTemplateCopyWithImpl;
@useResult
$Res call({
 String id, String name, String primaryMuscleGroup, String exerciseKind, bool isCustom, List<String> secondaryMuscleGroups, String? description, String? ownerId, String? imageUrl
});




}
/// @nodoc
class _$ExerciseTemplateCopyWithImpl<$Res>
    implements $ExerciseTemplateCopyWith<$Res> {
  _$ExerciseTemplateCopyWithImpl(this._self, this._then);

  final ExerciseTemplate _self;
  final $Res Function(ExerciseTemplate) _then;

/// Create a copy of ExerciseTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? primaryMuscleGroup = null,Object? exerciseKind = null,Object? isCustom = null,Object? secondaryMuscleGroups = null,Object? description = freezed,Object? ownerId = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscleGroup: null == primaryMuscleGroup ? _self.primaryMuscleGroup : primaryMuscleGroup // ignore: cast_nullable_to_non_nullable
as String,exerciseKind: null == exerciseKind ? _self.exerciseKind : exerciseKind // ignore: cast_nullable_to_non_nullable
as String,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,secondaryMuscleGroups: null == secondaryMuscleGroups ? _self.secondaryMuscleGroups : secondaryMuscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseTemplate].
extension ExerciseTemplatePatterns on ExerciseTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseTemplate value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  bool isCustom,  List<String> secondaryMuscleGroups,  String? description,  String? ownerId,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseTemplate() when $default != null:
return $default(_that.id,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.isCustom,_that.secondaryMuscleGroups,_that.description,_that.ownerId,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  bool isCustom,  List<String> secondaryMuscleGroups,  String? description,  String? ownerId,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ExerciseTemplate():
return $default(_that.id,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.isCustom,_that.secondaryMuscleGroups,_that.description,_that.ownerId,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String primaryMuscleGroup,  String exerciseKind,  bool isCustom,  List<String> secondaryMuscleGroups,  String? description,  String? ownerId,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseTemplate() when $default != null:
return $default(_that.id,_that.name,_that.primaryMuscleGroup,_that.exerciseKind,_that.isCustom,_that.secondaryMuscleGroups,_that.description,_that.ownerId,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseTemplate implements ExerciseTemplate {
  const _ExerciseTemplate({required this.id, required this.name, required this.primaryMuscleGroup, required this.exerciseKind, required this.isCustom, final  List<String> secondaryMuscleGroups = const <String>[], this.description, this.ownerId, this.imageUrl}): _secondaryMuscleGroups = secondaryMuscleGroups;
  

@override final  String id;
@override final  String name;
@override final  String primaryMuscleGroup;
@override final  String exerciseKind;
// "Strength" | "Cardio"
@override final  bool isCustom;
 final  List<String> _secondaryMuscleGroups;
@override@JsonKey() List<String> get secondaryMuscleGroups {
  if (_secondaryMuscleGroups is EqualUnmodifiableListView) return _secondaryMuscleGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryMuscleGroups);
}

@override final  String? description;
@override final  String? ownerId;
@override final  String? imageUrl;

/// Create a copy of ExerciseTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseTemplateCopyWith<_ExerciseTemplate> get copyWith => __$ExerciseTemplateCopyWithImpl<_ExerciseTemplate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscleGroup, primaryMuscleGroup) || other.primaryMuscleGroup == primaryMuscleGroup)&&(identical(other.exerciseKind, exerciseKind) || other.exerciseKind == exerciseKind)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&const DeepCollectionEquality().equals(other._secondaryMuscleGroups, _secondaryMuscleGroups)&&(identical(other.description, description) || other.description == description)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,primaryMuscleGroup,exerciseKind,isCustom,const DeepCollectionEquality().hash(_secondaryMuscleGroups),description,ownerId,imageUrl);

@override
String toString() {
  return 'ExerciseTemplate(id: $id, name: $name, primaryMuscleGroup: $primaryMuscleGroup, exerciseKind: $exerciseKind, isCustom: $isCustom, secondaryMuscleGroups: $secondaryMuscleGroups, description: $description, ownerId: $ownerId, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ExerciseTemplateCopyWith<$Res> implements $ExerciseTemplateCopyWith<$Res> {
  factory _$ExerciseTemplateCopyWith(_ExerciseTemplate value, $Res Function(_ExerciseTemplate) _then) = __$ExerciseTemplateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String primaryMuscleGroup, String exerciseKind, bool isCustom, List<String> secondaryMuscleGroups, String? description, String? ownerId, String? imageUrl
});




}
/// @nodoc
class __$ExerciseTemplateCopyWithImpl<$Res>
    implements _$ExerciseTemplateCopyWith<$Res> {
  __$ExerciseTemplateCopyWithImpl(this._self, this._then);

  final _ExerciseTemplate _self;
  final $Res Function(_ExerciseTemplate) _then;

/// Create a copy of ExerciseTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? primaryMuscleGroup = null,Object? exerciseKind = null,Object? isCustom = null,Object? secondaryMuscleGroups = null,Object? description = freezed,Object? ownerId = freezed,Object? imageUrl = freezed,}) {
  return _then(_ExerciseTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscleGroup: null == primaryMuscleGroup ? _self.primaryMuscleGroup : primaryMuscleGroup // ignore: cast_nullable_to_non_nullable
as String,exerciseKind: null == exerciseKind ? _self.exerciseKind : exerciseKind // ignore: cast_nullable_to_non_nullable
as String,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,secondaryMuscleGroups: null == secondaryMuscleGroups ? _self._secondaryMuscleGroups : secondaryMuscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
