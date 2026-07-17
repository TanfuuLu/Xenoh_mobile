import 'failure.dart';

/// A success-or-failure result. Use for repository methods where the caller
/// should pattern-match rather than catch (`AsyncValue` covers the provider
/// layer; this is for explicit call sites).
sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}
