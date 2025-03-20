import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/ui/screen/clients/clients.view_state.dart';

part 'clients.view_model.g.dart';

/// [Clients]
@Riverpod(keepAlive: true)
class Clients extends _$Clients {
  bool _isInitialized = false;
  late final DialogService _dialogService;

  /// Build
  ///
  @override
  ClientsScreenState build() {
    if (!_isInitialized) {
      _dialogService = injector<DialogService>();
      _isInitialized = true;
    }

    ref.listen(clientServiceProvider, (_, next) {
      _onClientStateChanged(next.value!);
    });

    return ClientsScreenState.initial(
      ref.watch(clientServiceProvider).value!.clients,
    );
  }

  /// Gestionnaire de changement d'état
  /// @param s : [ClientState]
  ///
  void _onClientStateChanged(ClientState s) {
    state = state.copyWith(
      loading: false,
      clients: s.clients,
    );
  }

  /// Select client
  /// @param key : [String]
  ///
  Future<void> selectClient(Client key) async {
    await _dialogService.showClientDetailsDialog(key);
  }
}
