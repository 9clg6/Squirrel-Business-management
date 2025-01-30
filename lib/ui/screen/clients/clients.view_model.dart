import 'package:init/ui/screen/clients/clients.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clients.view_model.g.dart';

///
/// [ClientsViewModel]
///
@riverpod
class ClientsViewModel extends _$ClientsViewModel {
  ///
  /// Constructor
  ///
  factory ClientsViewModel() {
    return ClientsViewModel._();
  }

  ///
  /// Private constructor
  ///
  ClientsViewModel._() {
    init();
  }

  ///
  /// Build
  ///
  @override
  ClientsScreenState build() => ClientsScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init() async {}
}
