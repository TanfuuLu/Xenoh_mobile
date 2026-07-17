import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'auth_session.freezed.dart';

/// An authenticated session: the user plus the in-memory access token.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required User user,
    required String accessToken,
  }) = _AuthSession;
}
