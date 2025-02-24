import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'request.view_state.g.dart';

/// [RequestViewState]
@CopyWith()
class RequestViewState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Constructor
  /// @param loading: Whether screen is loading
  /// 
  RequestViewState({required this.loading});

  /// Initial state
  /// 
  factory RequestViewState.initial() => RequestViewState(loading: false);

  /// Copy with
  @override
  List<Object?> get props => [loading];
}
