/// UseCase Return State statuses
enum StateStatus {
  /// Success
  success,

  /// Failure
  failure,
}

/// UseCase Return State with custom exception
class ResultState<T> {
  /// Constructor
  /// @param [status] status
  /// @param [data] data
  /// @param [exception] exception
  ///
  const ResultState._({
    required this.status,
    this.data,
    this.exception,
  });

  /// Success
  /// @param [data] data
  /// @return [ResultState] success result state
  ///
  factory ResultState.success(T data) =>
      ResultState<T>._(data: data, status: StateStatus.success);

  /// Failure
  /// @param [exception] exception
  /// @return [ResultState] failure result state
  ///
  factory ResultState.failure(Exception exception) =>
      ResultState<T>._(exception: exception, status: StateStatus.failure);

  /// Data
  final T? data;

  /// Exception
  final Exception? exception;

  /// Status
  final StateStatus status;

  /// When
  /// @param [otherwise] otherwise
  /// @param [success] success
  /// @param [failure] failure
  /// @return [R] result
  ///
  R when<R>({
    required R Function() otherwise,
    R Function(T data)? success,
    R Function(Exception exception)? failure,
  }) {
    switch (status) {
      case StateStatus.success:
        return success != null ? success(data as T) : otherwise();
      case StateStatus.failure:
        return failure != null ? failure(exception!) : otherwise();
    }
  }
}
