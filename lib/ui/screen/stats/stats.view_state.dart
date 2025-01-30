import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'stats.view_state.g.dart';

///
/// [StatsScreenState]
///
@CopyWith()
class StatsScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  ///
  /// Constructor
  ///
  StatsScreenState(this.loading);

  ///
  /// Initial state
  ///
  StatsScreenState.initial() : loading = true;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
