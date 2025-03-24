import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrel/domain/entities/client.entity.dart';

part 'client.state.g.dart';

/// [ClientState]
@CopyWith()
class ClientState with EquatableMixin {
  /// Clients
  final List<Client> clients;

  /// Constructor
  /// @param clients: List<Client>
  ///
  ClientState({
    this.clients = const [],
  });

  /// Initial
  /// @param clients: List<Client>
  ///
  ClientState.initial({
    this.clients = const [],
  });

  /// Props
  @override
  List<Object?> get props => [
        clients,
      ];
}
