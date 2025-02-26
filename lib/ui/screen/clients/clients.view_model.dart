import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/ui/screen/clients/clients.view_state.dart';

part 'clients.view_model.g.dart';

/// [Clients]
@riverpod
class Clients extends _$Clients {
  late final ClientService _clientService;

  /// Public constructor
  /// 
  Clients() : _clientService = injector<ClientService>();

  /// Build
  ///
  @override
  ClientsScreenState build() {
    _clientService.addListener(_onClientStateChanged);
    
    return ClientsScreenState.initial().copyWith(
      loading: false,
      clients: _clientService.clientState.clients,
    );
  }

  /// Gestionnaire de changement d'état
  /// @param s : [ClientState]
  /// 
  void _onClientStateChanged(ClientState s) {
    state = ClientsScreenState.initial().copyWith(
      loading: false,
      clients: s.clients,
    );
  }

  /// Select client
  /// @param key : [String]
  /// 
  void selectClient(String key) {
    state = state.copyWith(selectedClient: key);
  }
}
