import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/ui/screen/clients/clients.view_state.dart';

part 'clients.view_model.g.dart';

/// [Clients]
@riverpod
class Clients extends _$Clients {
  late final ClientService _clientService;
  late final DialogService _dialogService;
  /// Public constructor
  /// 
  Clients() : _clientService = injector<ClientService>(), _dialogService = injector<DialogService>();

  /// Build
  ///
  @override
  ClientsScreenState build() {
    _clientService.addListener(_onClientStateChanged);
    listenSelf(stateListener);
    
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
  void selectClient(Client key) {
    if (state.selectedClient == key) {
      state = state.copyWithNull(selectedClient: true);
    } else {
      state = state.copyWith(selectedClient: key);
    }
  }

  /// State listener
  /// @param previous : [ClientsScreenState]
  /// @param next : [ClientsScreenState]
  /// 
  Future<void> stateListener(ClientsScreenState? previous, ClientsScreenState next) async {
    if (next.selectedClient != null) {
      await _dialogService.showClientDetailsDialog(next.selectedClient!);
      state = state.copyWithNull(selectedClient: true);
    }
  }
}
