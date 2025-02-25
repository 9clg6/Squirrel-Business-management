import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/ui/screen/clients/clients.view_state.dart';

part 'clients.view_model.g.dart';

///
/// [Clients]
///
@riverpod
class Clients extends _$Clients {
  ///
  /// Client service
  ///
  final ClientService _clientService;

  ///
  /// Private constructor
  ///
  Clients() : _clientService = injector<ClientService>();

  ///
  /// Build
  ///
  @override
  ClientsScreenState build() => ClientsScreenState.initial().copyWith(
        loading: false,
        clients: _clientService.clientState.clients,
      );

  ///
  /// Init
  ///
  Future<void> init() async {}

  ///
  /// Select client
  ///
  void selectClient(String key) {
    state = state.copyWith(selectedClient: key);
  }
}
