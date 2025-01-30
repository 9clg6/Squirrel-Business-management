import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'order_details.view_state.g.dart';

///
/// [OrderDetailsScreenState]
///
@CopyWith()
class OrderDetailsScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  ///
  /// Constructor
  ///
  OrderDetailsScreenState(this.loading);

  ///
  /// Initial state
  ///
  OrderDetailsScreenState.initial() : loading = true;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
