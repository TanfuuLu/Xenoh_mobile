// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponseDto _$AuthResponseDtoFromJson(Map<String, dynamic> json) =>
    _AuthResponseDto(
      userId: json['userId'] as String,
      accessToken: json['accessToken'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$AuthResponseDtoToJson(_AuthResponseDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'accessToken': instance.accessToken,
      'email': instance.email,
      'fullName': instance.fullName,
      'roles': instance.roles,
      'avatarUrl': instance.avatarUrl,
    };
