// ignore_for_file: one_member_abstracts needed for heritage

/// [UseCaseWithParams]
abstract interface class UseCaseWithParams<T, P> {
  /// Execute use case
  /// @param [params] params of the use case
  /// @return [T] result
  ///
  T execute(P params);
}

/// [UseCase]
abstract interface class UseCase<T> {
  /// Execute use case
  /// @return [T] result
   T execute();
}
