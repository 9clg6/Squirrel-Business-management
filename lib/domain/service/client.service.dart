import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

part 'client.service.g.dart';

/// [ClientService]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    HiveSecureStorageService,
  ],
)
class ClientService extends _$ClientService {
  /// Storage
  late final StorageInterface<dynamic> _storage;

  /// Storage key
  static const String _storageKey = 'clients';

  bool _isInitialized = false;

  /// Build
  ///
  @override
  Future<ClientState> build() async {
    if (!_isInitialized) {
      LoggerService.instance.i('🔌 Initializing ClientService');
      _storage = ref.watch(hiveSecureStorageServiceProvider.notifier);
      _isInitialized = true;
    }

    return _loadClients();
  }

  /// Load clients
  ///
  Future<ClientState> _loadClients() async {
    LoggerService.instance.i('📚 Loading clients');
    final String? o = await _storage.get(_storageKey) as String?;
    if (o != null) {
      final List<dynamic> clients = jsonDecode(o) as List<dynamic>;

      return ClientState.initial(
        clients: clients
            .map((dynamic e) => Client.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    return ClientState.initial();
  }

  /// Save orders
  /// @param [os] order state
  ///
  void _save(ClientState os) {
    LoggerService.instance.i('📚💾 Saving clients');
    if (os.clients.isEmpty) return;
    _storage.set(
      _storageKey,
      jsonEncode(os.clients.map((Client e) => e.toJson()).toList()),
    );
  }

  /// Get client by id
  /// @param [id] id
  /// @return [Client] client
  ///
  Client getClientById(String id) {
    return state.value!.clients.firstWhere((Client client) => client.id == id);
  }

  /// Get client by name or create client
  /// @param [clientContact] client contact
  /// @return [Client] client
  ///
  Client? getClientByName(String clientContact) {
    return state.value!.clients.firstWhereOrNull(
      (Client client) =>
          client.name.toLowerCase().trim() ==
          clientContact.toLowerCase().trim(),
    );
  }

  /// Create client with order
  /// @param [clientName] client
  /// @param [order] order
  /// @return [Client] client
  ///
  Client createClientWithOrder(String clientName, Order order) {
    final Client client = Client(
      name: clientName.trim(),
      orderQuantity: 1,
      orderTotalAmount: order.price,
      commissionTotalAmount: order.commission,
      firstOrderDate: order.startDate,
    );

    state = AsyncData<ClientState>(
      state.value!.copyWith(
        clients: <Client>[
          ...state.value!.clients,
          client,
        ],
      ),
    );

    if (order.sponsor != null) {
      final Client? sponsor = getClientByName(order.sponsor!);
      if (sponsor != null) {
        final Client updatedSponsor = sponsor.copyWith(
          sponsorshipQuantity: sponsor.sponsorshipQuantity + 1,
        );

        final int sponsorIndex =
            state.value!.clients.indexWhere((Client c) => c.id == sponsor.id);

        state = AsyncData<ClientState>(
          state.value!.copyWith(
            clients: <Client>[
              ...state.value!.clients.take(sponsorIndex),
              updatedSponsor,
              ...state.value!.clients.skip(sponsorIndex + 1),
            ],
          ),
        );
      }
    }

    _save(state.value!);

    return client;
  }

  /// Update client with new order information
  /// @param [client] client to update
  /// @param [newVersion] new version of client
  /// @throws StateError if client is not found
  ///
  void updateClient(
    Client client, {
    required Client newVersion,
  }) {
    final int clientIndex = state.value!.clients.indexWhere(
      (Client c) => c.id == client.id,
    );

    if (clientIndex == -1) {
      throw StateError('Client with id ${client.id} not found');
    }

    state = AsyncData<ClientState>(
      state.value!.copyWith(
        clients: <Client>[
          ...state.value!.clients.take(clientIndex),
          newVersion,
          ...state.value!.clients.skip(clientIndex + 1),
        ],
      ),
    );

    _save(state.value!);
  }

  /// Update client with new order information
  /// @param [client] client to update
  /// @param [order] order to add to client statistics
  /// @throws StateError if client is not found
  ///
  void updateClientWithOrder(
    Client client, {
    required Order order,
    required bool isNewOrder,
  }) {
    final int clientIndex = state.value!.clients.indexWhere(
      (Client c) => c.id == client.id,
    );

    if (clientIndex == -1) {
      throw StateError('Client with id ${client.id} not found');
    }

    final Client clientTemp = state.value!.clients[clientIndex];
    final DateTime newLastOrderDate = order.startDate.isAfter(
      clientTemp.lastOrderDate ?? DateTime.fromMillisecondsSinceEpoch(0),
    )
        ? order.startDate
        : clientTemp.lastOrderDate ?? order.startDate;

    final Client clientUpdated = clientTemp.copyWith(
      orderQuantity:
          isNewOrder ? clientTemp.orderQuantity + 1 : clientTemp.orderQuantity,
      orderTotalAmount: isNewOrder
          ? clientTemp.orderTotalAmount + order.price
          : clientTemp.orderTotalAmount,
      commissionTotalAmount: isNewOrder
          ? clientTemp.commissionTotalAmount + order.commission
          : clientTemp.commissionTotalAmount,
      lastOrderDate: newLastOrderDate,
    );

    state = AsyncData<ClientState>(
      state.value!.copyWith(
        clients: <Client>[
          ...state.value!.clients.take(clientIndex),
          clientUpdated,
          ...state.value!.clients.skip(clientIndex + 1),
        ],
      ),
    );

    if (order.sponsor != null) {
      final Client? sponsor = getClientByName(order.sponsor!);
      if (sponsor != null) {
        final Client updatedSponsor = sponsor.copyWith(
          sponsorshipQuantity: sponsor.sponsorshipQuantity + 1,
        );

        final int sponsorIndex =
            state.value!.clients.indexWhere((Client c) => c.id == sponsor.id);
        state = AsyncData<ClientState>(
          state.value!.copyWith(
            clients: <Client>[
              ...state.value!.clients.take(sponsorIndex),
              updatedSponsor,
              ...state.value!.clients.skip(sponsorIndex + 1),
            ],
          ),
        );
      }
    }

    _save(state.value!);
  }
}
