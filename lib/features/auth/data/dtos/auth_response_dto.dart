import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

/// `AuthResponseBody` from login / refresh / external (API ref §3.1).
/// The refresh token is NOT in the body — it arrives as the `xenoh.refresh`
/// cookie.
@Freezed(toStringOverride: false)
abstract class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required String userId,
    required String accessToken,
    required String email,
    required String fullName,
    @Default(<String>[]) List<String> roles,
    String? avatarUrl,
  }) = _AuthResponseDto;

  const AuthResponseDto._();

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);

  AuthSession toEntity() => AuthSession(
    accessToken: accessToken,
    user: User(
      id: userId,
      email: email,
      fullName: fullName,
      roles: roles,
      avatarUrl: avatarUrl,
    ),
  );
}
