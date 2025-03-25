import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrel/domain/entities/client.entity.dart';

part 'client.state.g.dart';

/// [ClientState]
@CopyWith()
class ClientState with EquatableMixin {
  /// Constructor
  /// @param clients: List<Client>
  ///
  ClientState({
    this.clients = const <Client>[],
  });

  /// Initial
  /// @param clients: List<Client>
  ///
  ClientState.initial({
    this.clients = const <Client>[],
  });

  /// Clients
  final List<Client> clients;

  /// Props
  @override
  List<Object?> get props => <Object?>[
        clients,
      ];
}
