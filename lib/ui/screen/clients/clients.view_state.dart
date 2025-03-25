import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'clients.view_state.g.dart';

/// [ClientsScreenState]
@CopyWith(copyWithNull: true)
class ClientsScreenState extends ViewStateAbs {
  /// Constructor
  /// @param [selectedClient] selected client
  /// @param [clients] clients
  ///
  ClientsScreenState({
    required this.selectedClient,
    required this.clients,
  });

  /// Initial state
  /// @param [clients] clients
  ///
  ClientsScreenState.initial(this.clients) : selectedClient = null;

  /// Selected client
  final Client? selectedClient;

  /// Clients
  final List<Client> clients;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        selectedClient,
        clients,
      ];
}
