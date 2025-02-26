import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'clients.view_state.g.dart';

/// [ClientsScreenState]
@CopyWith()
class ClientsScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Selected client
  final String? selectedClient;

  /// Clients
  final List<Client> clients;

  /// Constructor
  /// @param loading : [bool]
  /// @param selectedClient : [String?]
  /// @param clients : [List<Client>]
  /// 
  ClientsScreenState(
    this.loading,
    this.selectedClient,
    this.clients,
  );

  /// Initial state
  /// 
  ClientsScreenState.initial()
      : loading = true,
        selectedClient = null,
        clients = [];

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        selectedClient,
        clients,
      ];
}
