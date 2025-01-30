import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'clients.view_state.g.dart';

///
/// [ClientsScreenState]
///
@CopyWith()
class ClientsScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  ///
  /// Constructor
  ///
  ClientsScreenState(this.loading);

  ///
  /// Initial state
  ///
  ClientsScreenState.initial() : loading = true;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
