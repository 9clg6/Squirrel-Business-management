import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'planner.view_state.g.dart';

/// [PlannerScreenState]
@CopyWith()
class PlannerScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  /// Constructor
  /// @param [loading] loading state
  ///
  PlannerScreenState(this.loading);

  /// Initial state
  ///
  PlannerScreenState.initial() : loading = true;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
