// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Subscription {

 String get id; String get tier; bool get isActive; DateTime get createdAt; AiQuota get aiQuota; DateTime? get expiresAt;
/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionCopyWith<Subscription> get copyWith => _$SubscriptionCopyWithImpl<Subscription>(this as Subscription, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subscription&&(identical(other.id, id) || other.id == id)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.aiQuota, aiQuota) || other.aiQuota == aiQuota)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tier,isActive,createdAt,aiQuota,expiresAt);

@override
String toString() {
  return 'Subscription(id: $id, tier: $tier, isActive: $isActive, createdAt: $createdAt, aiQuota: $aiQuota, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $SubscriptionCopyWith<$Res>  {
  factory $SubscriptionCopyWith(Subscription value, $Res Function(Subscription) _then) = _$SubscriptionCopyWithImpl;
@useResult
$Res call({
 String id, String tier, bool isActive, DateTime createdAt, AiQuota aiQuota, DateTime? expiresAt
});


$AiQuotaCopyWith<$Res> get aiQuota;

}
/// @nodoc
class _$SubscriptionCopyWithImpl<$Res>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._self, this._then);

  final Subscription _self;
  final $Res Function(Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tier = null,Object? isActive = null,Object? createdAt = null,Object? aiQuota = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,aiQuota: null == aiQuota ? _self.aiQuota : aiQuota // ignore: cast_nullable_to_non_nullable
as AiQuota,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiQuotaCopyWith<$Res> get aiQuota {
  
  return $AiQuotaCopyWith<$Res>(_self.aiQuota, (value) {
    return _then(_self.copyWith(aiQuota: value));
  });
}
}


/// Adds pattern-matching-related methods to [Subscription].
extension SubscriptionPatterns on Subscription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Subscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Subscription value)  $default,){
final _that = this;
switch (_that) {
case _Subscription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Subscription value)?  $default,){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tier,  bool isActive,  DateTime createdAt,  AiQuota aiQuota,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tier,  bool isActive,  DateTime createdAt,  AiQuota aiQuota,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _Subscription():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tier,  bool isActive,  DateTime createdAt,  AiQuota aiQuota,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that.id,_that.tier,_that.isActive,_that.createdAt,_that.aiQuota,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _Subscription extends Subscription {
  const _Subscription({required this.id, required this.tier, required this.isActive, required this.createdAt, required this.aiQuota, this.expiresAt}): super._();
  

@override final  String id;
@override final  String tier;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  AiQuota aiQuota;
@override final  DateTime? expiresAt;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionCopyWith<_Subscription> get copyWith => __$SubscriptionCopyWithImpl<_Subscription>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subscription&&(identical(other.id, id) || other.id == id)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.aiQuota, aiQuota) || other.aiQuota == aiQuota)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,tier,isActive,createdAt,aiQuota,expiresAt);

@override
String toString() {
  return 'Subscription(id: $id, tier: $tier, isActive: $isActive, createdAt: $createdAt, aiQuota: $aiQuota, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionCopyWith<$Res> implements $SubscriptionCopyWith<$Res> {
  factory _$SubscriptionCopyWith(_Subscription value, $Res Function(_Subscription) _then) = __$SubscriptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String tier, bool isActive, DateTime createdAt, AiQuota aiQuota, DateTime? expiresAt
});


@override $AiQuotaCopyWith<$Res> get aiQuota;

}
/// @nodoc
class __$SubscriptionCopyWithImpl<$Res>
    implements _$SubscriptionCopyWith<$Res> {
  __$SubscriptionCopyWithImpl(this._self, this._then);

  final _Subscription _self;
  final $Res Function(_Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tier = null,Object? isActive = null,Object? createdAt = null,Object? aiQuota = null,Object? expiresAt = freezed,}) {
  return _then(_Subscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,aiQuota: null == aiQuota ? _self.aiQuota : aiQuota // ignore: cast_nullable_to_non_nullable
as AiQuota,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiQuotaCopyWith<$Res> get aiQuota {
  
  return $AiQuotaCopyWith<$Res>(_self.aiQuota, (value) {
    return _then(_self.copyWith(aiQuota: value));
  });
}
}

/// @nodoc
mixin _$AiQuota {

 int get monthlyLimit; int get usedRequests; int get remainingRequests; DateTime get periodStart;
/// Create a copy of AiQuota
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiQuotaCopyWith<AiQuota> get copyWith => _$AiQuotaCopyWithImpl<AiQuota>(this as AiQuota, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiQuota&&(identical(other.monthlyLimit, monthlyLimit) || other.monthlyLimit == monthlyLimit)&&(identical(other.usedRequests, usedRequests) || other.usedRequests == usedRequests)&&(identical(other.remainingRequests, remainingRequests) || other.remainingRequests == remainingRequests)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart));
}


@override
int get hashCode => Object.hash(runtimeType,monthlyLimit,usedRequests,remainingRequests,periodStart);

@override
String toString() {
  return 'AiQuota(monthlyLimit: $monthlyLimit, usedRequests: $usedRequests, remainingRequests: $remainingRequests, periodStart: $periodStart)';
}


}

/// @nodoc
abstract mixin class $AiQuotaCopyWith<$Res>  {
  factory $AiQuotaCopyWith(AiQuota value, $Res Function(AiQuota) _then) = _$AiQuotaCopyWithImpl;
@useResult
$Res call({
 int monthlyLimit, int usedRequests, int remainingRequests, DateTime periodStart
});




}
/// @nodoc
class _$AiQuotaCopyWithImpl<$Res>
    implements $AiQuotaCopyWith<$Res> {
  _$AiQuotaCopyWithImpl(this._self, this._then);

  final AiQuota _self;
  final $Res Function(AiQuota) _then;

/// Create a copy of AiQuota
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthlyLimit = null,Object? usedRequests = null,Object? remainingRequests = null,Object? periodStart = null,}) {
  return _then(_self.copyWith(
monthlyLimit: null == monthlyLimit ? _self.monthlyLimit : monthlyLimit // ignore: cast_nullable_to_non_nullable
as int,usedRequests: null == usedRequests ? _self.usedRequests : usedRequests // ignore: cast_nullable_to_non_nullable
as int,remainingRequests: null == remainingRequests ? _self.remainingRequests : remainingRequests // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AiQuota].
extension AiQuotaPatterns on AiQuota {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiQuota value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiQuota() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiQuota value)  $default,){
final _that = this;
switch (_that) {
case _AiQuota():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiQuota value)?  $default,){
final _that = this;
switch (_that) {
case _AiQuota() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int monthlyLimit,  int usedRequests,  int remainingRequests,  DateTime periodStart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiQuota() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int monthlyLimit,  int usedRequests,  int remainingRequests,  DateTime periodStart)  $default,) {final _that = this;
switch (_that) {
case _AiQuota():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int monthlyLimit,  int usedRequests,  int remainingRequests,  DateTime periodStart)?  $default,) {final _that = this;
switch (_that) {
case _AiQuota() when $default != null:
return $default(_that.monthlyLimit,_that.usedRequests,_that.remainingRequests,_that.periodStart);case _:
  return null;

}
}

}

/// @nodoc


class _AiQuota extends AiQuota {
  const _AiQuota({required this.monthlyLimit, required this.usedRequests, required this.remainingRequests, required this.periodStart}): super._();
  

@override final  int monthlyLimit;
@override final  int usedRequests;
@override final  int remainingRequests;
@override final  DateTime periodStart;

/// Create a copy of AiQuota
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiQuotaCopyWith<_AiQuota> get copyWith => __$AiQuotaCopyWithImpl<_AiQuota>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiQuota&&(identical(other.monthlyLimit, monthlyLimit) || other.monthlyLimit == monthlyLimit)&&(identical(other.usedRequests, usedRequests) || other.usedRequests == usedRequests)&&(identical(other.remainingRequests, remainingRequests) || other.remainingRequests == remainingRequests)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart));
}


@override
int get hashCode => Object.hash(runtimeType,monthlyLimit,usedRequests,remainingRequests,periodStart);

@override
String toString() {
  return 'AiQuota(monthlyLimit: $monthlyLimit, usedRequests: $usedRequests, remainingRequests: $remainingRequests, periodStart: $periodStart)';
}


}

/// @nodoc
abstract mixin class _$AiQuotaCopyWith<$Res> implements $AiQuotaCopyWith<$Res> {
  factory _$AiQuotaCopyWith(_AiQuota value, $Res Function(_AiQuota) _then) = __$AiQuotaCopyWithImpl;
@override @useResult
$Res call({
 int monthlyLimit, int usedRequests, int remainingRequests, DateTime periodStart
});




}
/// @nodoc
class __$AiQuotaCopyWithImpl<$Res>
    implements _$AiQuotaCopyWith<$Res> {
  __$AiQuotaCopyWithImpl(this._self, this._then);

  final _AiQuota _self;
  final $Res Function(_AiQuota) _then;

/// Create a copy of AiQuota
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthlyLimit = null,Object? usedRequests = null,Object? remainingRequests = null,Object? periodStart = null,}) {
  return _then(_AiQuota(
monthlyLimit: null == monthlyLimit ? _self.monthlyLimit : monthlyLimit // ignore: cast_nullable_to_non_nullable
as int,usedRequests: null == usedRequests ? _self.usedRequests : usedRequests // ignore: cast_nullable_to_non_nullable
as int,remainingRequests: null == remainingRequests ? _self.remainingRequests : remainingRequests // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
