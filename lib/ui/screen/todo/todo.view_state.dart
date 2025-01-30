import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'todo.view_state.g.dart';

///
/// [TodoScreenState]
///
@CopyWith()
class TodoScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  ///
  /// Constructor
  ///
  TodoScreenState(this.loading);

  ///
  /// Initial state
  ///
  TodoScreenState.initial() : loading = true;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
