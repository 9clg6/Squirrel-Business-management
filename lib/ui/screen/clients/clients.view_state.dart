import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'clients.view_state.g.dart';

/// [ClientsScreenState]
@CopyWith(copyWithNull: true)
class ClientsScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Selected client
  final Client? selectedClient;

  /// Clients
  final List<Client> clients;

  /// Constructor
  /// @param loading : [bool]
  /// @param selectedClient : [String?]
  /// @param clients : [List<Client>]
  ///
  ClientsScreenState({
    required this.loading,
    required this.selectedClient,
    required this.clients,
  });

  /// Initial state
  ///
  ClientsScreenState.initial(this.clients)
      : loading = true,
        selectedClient = null;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        selectedClient,
        clients,
      ];
}
