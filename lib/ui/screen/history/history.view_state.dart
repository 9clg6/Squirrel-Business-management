import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'history.view_state.g.dart';

///
/// [HistoryScreenState]
///
@CopyWith()
class HistoryScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  ///
  /// Constructor
  ///
  HistoryScreenState(this.loading);

  ///
  /// Initial state
  ///
  HistoryScreenState.initial() : loading = true;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
