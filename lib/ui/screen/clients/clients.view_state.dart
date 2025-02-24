import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'clients.view_state.g.dart';

///
/// [ClientsScreenState]
///
@CopyWith()
class ClientsScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Selected client
  final String? selectedClient;

  ///
  /// Clients
  ///
  final Map<String, Map<String, dynamic>> clients;

  ///
  /// Constructor
  ///
  ClientsScreenState(
    this.loading,
    this.selectedClient,
    this.clients,
  );

  ///
  /// Initial state
  ///
  ClientsScreenState.initial()
      : loading = true,
        selectedClient = null,
        clients = {};

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        selectedClient,
        clients,
      ];
}
