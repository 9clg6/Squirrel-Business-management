import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'planner.view_state.g.dart';

/// [PlannerScreenState]
@CopyWith()
class PlannerScreenState extends ViewStateAbs {
  /// Constructor
  /// @param [loading] loading state
  ///
  PlannerScreenState({
    required this.loading,
  });

  /// Initial state
  ///
  PlannerScreenState.initial() : loading = true;

  /// Loading state
  final bool? loading;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
