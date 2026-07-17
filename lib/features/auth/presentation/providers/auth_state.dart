import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_session.dart';

part 'auth_state.freezed.dart';

/// Top-level authentication state. `unknown` is the startup state while we try
/// a silent refresh; the router shows a splash until it resolves.
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unknown() = AuthUnknown;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated(AuthSession session) = Authenticated;
}

extension AuthStateX on AuthState {
  bool get isAuthed => this is Authenticated;
  bool get isResolved => this is! AuthUnknown;

  AuthSession? get sessionOrNull =>
      this is Authenticated ? (this as Authenticated).session : null;
}
