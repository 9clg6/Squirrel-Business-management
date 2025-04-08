import 'package:squirrel/domain/use_case/results.usecases.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// [FutureUseCase]
abstract class FutureUseCase<T> implements BaseUseCase<Future<ResultState<T>>> {
  /// execute
  /// @return [ResultState] result state
  ///
  @override
  Future<ResultState<T>> execute() async {
    return _futureCatcher<T, void>(invoke);
  }

  /// Invoke
  /// @return [T] result
  ///
  Future<T> invoke();
}

/// [FutureUseCaseWithParams]
abstract class FutureUseCaseWithParams<T, P>
    implements BaseUseCaseWithParams<Future<ResultState<T>>, P> {
  /// execute
  /// @param [params] params
  /// @return [ResultState] result state
  ///
  @override
  Future<ResultState<T>> execute(P params) async {
    return _futureCatcher<T, P>(() => invoke(params));
  }

  /// Invoke
  /// @param [params] params
  /// @return [T] result
  ///
  Future<T> invoke(P params);
}

/// _futureCatcher
/// @param [invoke] invoke
/// @return [ResultState] result state
///
Future<ResultState<T>> _futureCatcher<T, P>(Future<T> Function() invoke) async {
  try {
    final T result = await invoke();
    return ResultState<T>.success(result);
  } on Exception catch (e) {
    return ResultState<T>.failure(e);
  }
}
