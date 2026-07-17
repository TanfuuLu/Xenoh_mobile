// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionDto {

 String get id; String get tier; bool get isActive; DateTime get createdAt; AiQuotaDto get aiQuota; DateTime? get expiresAt;
/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDtoCopyWith<SubscriptionDto> get copyWith => _$SubscriptionDtoCopyWithImpl<SubscriptionDto>(this as SubscriptionDto, _$identity);

  /// Serializes this SubscriptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.aiQuota, aiQuota) || other.aiQuota == aiQuota)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tier,isActive,createdAt,aiQuota,expiresAt);

@override
String toString() {
  return 'SubscriptionDto(id: $id, tier: $tier, isActive: $isActive, createdAt: $createdAt, aiQuota: $aiQuota, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDtoCopyWith<$Res>  {
  factory $SubscriptionDtoCopyWith(SubscriptionDto value, $Res Function(SubscriptionDto) _then) = _$SubscriptionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String tier, bool isActive, DateTime createdAt, AiQuotaDto aiQuota, DateTime? expiresAt
});


$AiQuotaDtoCopyWith<$Res> get aiQuota;

}
/// @nodoc
class _$SubscriptionDtoCopyWithImpl<$Res>
    implements $SubscriptionDtoCopyWith<$Res> {
  _$SubscriptionDtoCopyWithImpl(this._self, this._then);

  final SubscriptionDto _self;
  final $Res Function(SubscriptionDto) _then;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tier = null,Object? isActive = null,Object? createdAt = null,Object? aiQuota = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,aiQuota: null == aiQuota ? _self.aiQuota : aiQuota // ignore: cast_nullable_to_non_nullable
as AiQuotaDto,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiQuotaDtoCopyWith<$Res> get aiQuota {
  
  return $AiQuotaDtoCopyWith<$Res>(_self.aiQuota, (value) {
    return _then(_self.copyWith(aiQuota: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionDto].
extension SubscriptionDtoPatterns on SubscriptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tier,  bool isActive,  DateTime createdAt,  AiQuotaDto aiQuota,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
return $default(_that.id,_that.tier,_that.isActive,_that.createdAt,_that.aiQuota,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tier,  bool isActive,  DateTime createdAt,  AiQuotaDto aiQuota,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDto():
return $default(_that.id,_that.tier,_that.isActive,_that.createdAt,_that.aiQuota,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tier,  bool isActive,  DateTime createdAt,  AiQuotaDto aiQuota,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
return $default(_that.id,_that.tier,_that.isActive,_that.createdAt,_that.aiQuota,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionDto extends SubscriptionDto {
  const _SubscriptionDto({required this.id, required this.tier, required this.isActive, required this.createdAt, required this.aiQuota, this.expiresAt}): super._();
  factory _SubscriptionDto.fromJson(Map<String, dynamic> json) => _$SubscriptionDtoFromJson(json);

@override final  String id;
@override final  String tier;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  AiQuotaDto aiQuota;
@override final  DateTime? expiresAt;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDtoCopyWith<_SubscriptionDto> get copyWith => __$SubscriptionDtoCopyWithImpl<_SubscriptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.aiQuota, aiQuota) || other.aiQuota == aiQuota)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tier,isActive,createdAt,aiQuota,expiresAt);

@override
String toString() {
  return 'SubscriptionDto(id: $id, tier: $tier, isActive: $isActive, createdAt: $createdAt, aiQuota: $aiQuota, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDtoCopyWith<$Res> implements $SubscriptionDtoCopyWith<$Res> {
  factory _$SubscriptionDtoCopyWith(_SubscriptionDto value, $Res Function(_SubscriptionDto) _then) = __$SubscriptionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String tier, bool isActive, DateTime createdAt, AiQuotaDto aiQuota, DateTime? expiresAt
});


@override $AiQuotaDtoCopyWith<$Res> get aiQuota;

}
/// @nodoc
class __$SubscriptionDtoCopyWithImpl<$Res>
    implements _$SubscriptionDtoCopyWith<$Res> {
  __$SubscriptionDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionDto _self;
  final $Res Function(_SubscriptionDto) _then;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tier = null,Object? isActive = null,Object? createdAt = null,Object? aiQuota = null,Object? expiresAt = freezed,}) {
  return _then(_SubscriptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,aiQuota: null == aiQuota ? _self.aiQuota : aiQuota // ignore: cast_nullable_to_non_nullable
as AiQuotaDto,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiQuotaDtoCopyWith<$Res> get aiQuota {
  
  return $AiQuotaDtoCopyWith<$Res>(_self.aiQuota, (value) {
    return _then(_self.copyWith(aiQuota: value));
  });
}
}


/// @nodoc
mixin _$AiQuotaDto {

 int get monthlyLimit; int get usedRequests; int get remainingRequests; String get periodStart;
/// Create a copy of AiQuotaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiQuotaDtoCopyWith<AiQuotaDto> get copyWith => _$AiQuotaDtoCopyWithImpl<AiQuotaDto>(this as AiQuotaDto, _$identity);

  /// Serializes this AiQuotaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiQuotaDto&&(identical(other.monthlyLimit, monthlyLimit) || other.monthlyLimit == monthlyLimit)&&(identical(other.usedRequests, usedRequests) || other.usedRequests == usedRequests)&&(identical(other.remainingRequests, remainingRequests) || other.remainingRequests == remainingRequests)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monthlyLimit,usedRequests,remainingRequests,periodStart);

@override
String toString() {
  return 'AiQuotaDto(monthlyLimit: $monthlyLimit, usedRequests: $usedRequests, remainingRequests: $remainingRequests, periodStart: $periodStart)';
}


}

/// @nodoc
abstract mixin class $AiQuotaDtoCopyWith<$Res>  {
  factory $AiQuotaDtoCopyWith(AiQuotaDto value, $Res Function(AiQuotaDto) _then) = _$AiQuotaDtoCopyWithImpl;
@useResult
$Res call({
 int monthlyLimit, int usedRequests, int remainingRequests, String periodStart
});




}
/// @nodoc
class _$AiQuotaDtoCopyWithImpl<$Res>
    implements $AiQuotaDtoCopyWith<$Res> {
  _$AiQuotaDtoCopyWithImpl(this._self, this._then);

  final AiQuotaDto _self;
  final $Res Function(AiQuotaDto) _then;

/// Create a copy of AiQuotaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthlyLimit = null,Object? usedRequests = null,Object? remainingRequests = null,Object? periodStart = null,}) {
  return _then(_self.copyWith(
monthlyLimit: null == monthlyLimit ? _self.monthlyLimit : monthlyLimit // ignore: cast_nullable_to_non_nullable
as int,usedRequests: null == usedRequests ? _self.usedRequests : usedRequests // ignore: cast_nullable_to_non_nullable
as int,remainingRequests: null == remainingRequests ? _self.remainingRequests : remainingRequests // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiQuotaDto].
extension AiQuotaDtoPatterns on AiQuotaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiQuotaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiQuotaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiQuotaDto value)  $default,){
final _that = this;
switch (_that) {
case _AiQuotaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiQuotaDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiQuotaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int monthlyLimit,  int usedRequests,  int remainingRequests,  String periodStart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiQuotaDto() when $default != null:
return $default(_that.monthlyLimit,_that.usedRequests,_that.remainingRequests,_that.periodStart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int monthlyLimit,  int usedRequests,  int remainingRequests,  String periodStart)  $default,) {final _that = this;
switch (_that) {
case _AiQuotaDto():
return $default(_that.monthlyLimit,_that.usedRequests,_that.remainingRequests,_that.periodStart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int monthlyLimit,  int usedRequests,  int remainingRequests,  String periodStart)?  $default,) {final _that = this;
switch (_that) {
case _AiQuotaDto() when $default != null:
return $default(_that.monthlyLimit,_that.usedRequests,_that.remainingRequests,_that.periodStart);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiQuotaDto extends AiQuotaDto {
  const _AiQuotaDto({required this.monthlyLimit, required this.usedRequests, required this.remainingRequests, required this.periodStart}): super._();
  factory _AiQuotaDto.fromJson(Map<String, dynamic> json) => _$AiQuotaDtoFromJson(json);

@override final  int monthlyLimit;
@override final  int usedRequests;
@override final  int remainingRequests;
@override final  String periodStart;

/// Create a copy of AiQuotaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiQuotaDtoCopyWith<_AiQuotaDto> get copyWith => __$AiQuotaDtoCopyWithImpl<_AiQuotaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiQuotaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiQuotaDto&&(identical(other.monthlyLimit, monthlyLimit) || other.monthlyLimit == monthlyLimit)&&(identical(other.usedRequests, usedRequests) || other.usedRequests == usedRequests)&&(identical(other.remainingRequests, remainingRequests) || other.remainingRequests == remainingRequests)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monthlyLimit,usedRequests,remainingRequests,periodStart);

@override
String toString() {
  return 'AiQuotaDto(monthlyLimit: $monthlyLimit, usedRequests: $usedRequests, remainingRequests: $remainingRequests, periodStart: $periodStart)';
}


}

/// @nodoc
abstract mixin class _$AiQuotaDtoCopyWith<$Res> implements $AiQuotaDtoCopyWith<$Res> {
  factory _$AiQuotaDtoCopyWith(_AiQuotaDto value, $Res Function(_AiQuotaDto) _then) = __$AiQuotaDtoCopyWithImpl;
@override @useResult
$Res call({
 int monthlyLimit, int usedRequests, int remainingRequests, String periodStart
});




}
/// @nodoc
class __$AiQuotaDtoCopyWithImpl<$Res>
    implements _$AiQuotaDtoCopyWith<$Res> {
  __$AiQuotaDtoCopyWithImpl(this._self, this._then);

  final _AiQuotaDto _self;
  final $Res Function(_AiQuotaDto) _then;

/// Create a copy of AiQuotaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthlyLimit = null,Object? usedRequests = null,Object? remainingRequests = null,Object? periodStart = null,}) {
  return _then(_AiQuotaDto(
monthlyLimit: null == monthlyLimit ? _self.monthlyLimit : monthlyLimit // ignore: cast_nullable_to_non_nullable
as int,usedRequests: null == usedRequests ? _self.usedRequests : usedRequests // ignore: cast_nullable_to_non_nullable
as int,remainingRequests: null == remainingRequests ? _self.remainingRequests : remainingRequests // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
