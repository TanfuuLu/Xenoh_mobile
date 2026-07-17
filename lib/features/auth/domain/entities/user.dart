import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// The signed-in user (domain entity — no JSON).
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String fullName,
    required List<String> roles,
    String? avatarUrl,
  }) = _User;

  const User._();

  bool get isCoach => roles.contains('Coach');
  bool get isAdmin => roles.contains('Admin');
  bool get isIndividual => roles.contains('Individual');

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
