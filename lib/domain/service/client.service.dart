import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

/// [ClientService]
class ClientService extends StateNotifier<ClientState> {
  static const String _storageKey = 'clients';

  final StorageInterface _storage;

  bool _isInitialLoad = true;

  /// Client state
  ClientState get clientState => state;

  /// Constructor
  ///
  ClientService(this._storage) : super(ClientState.initial()) {
    _loadClients();
    _isInitialLoad = true;
    addListener(_save);
  }

  /// Load clients
  ///
  Future<void> _loadClients() async {
    log('Loading clients');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final String? o = await _storage.get(_storageKey);
      if (o != null) {
        final clients = jsonDecode(o) as List;
        final clientsList = clients.map((e) => Client.fromJson(e)).toList();
        state = state.copyWith(clients: clientsList);
      }
      _isInitialLoad = false;
    });
  }

  /// Save orders
  /// @param [os] order state
  ///
  void _save(ClientState os) {
    if (_isInitialLoad) return;

    log('Saving clients');
    if (os.clients.isEmpty) return;
    _storage.set(
      _storageKey,
      jsonEncode(os.clients.map((e) => e.toJson()).toList()),
    );
  }

  /// Get client by id
  /// @param [id] id
  /// @return [Client] client
  ///
  Client getClientById(String id) {
    return state.clients.firstWhere((client) => client.id == id);
  }

  /// Get client by name or create client
  /// @param [clientContact] client contact
  /// @return [Client] client
  ///
  Client? getClientByName(String clientContact) {
    return state.clients.firstWhereOrNull(
      (client) =>
          client.name.toLowerCase().trim() ==
          clientContact.toLowerCase().trim(),
    );
  }

  /// Create client with order
  /// @param [client] client
  /// @param [order] order
  /// @return [Client] client
  ///
  Client createClientWithOrder(String clientName, Order order) {
    final client = Client(
      name: clientName.trim(),
      orderQuantity: 1,
      orderTotalAmount: order.price,
      commissionTotalAmount: order.commission,
      firstOrderDate: order.startDate,
    );

    state = state.copyWith(
      clients: [
        ...state.clients,
        client,
      ],
    );

    if (order.sponsor != null) {
      final sponsor = getClientByName(order.sponsor!);
      if (sponsor != null) {
        final updatedSponsor = sponsor.copyWith(
          sponsorshipQuantity: sponsor.sponsorshipQuantity + 1,
        );

        final int sponsorIndex =
            state.clients.indexWhere((c) => c.id == sponsor.id);
        state = state.copyWith(
          clients: [
            ...state.clients.take(sponsorIndex),
            updatedSponsor,
            ...state.clients.skip(sponsorIndex + 1),
          ],
        );
      }
    }

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
    final int clientIndex = state.clients.indexWhere(
      (c) => c.id == client.id,
    );

    if (clientIndex == -1) {
      throw StateError('Client with id ${client.id} not found');
    }

    state = state.copyWith(
      clients: [
        ...state.clients.take(clientIndex),
        newVersion,
        ...state.clients.skip(clientIndex + 1),
      ],
    );
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
    final int clientIndex = state.clients.indexWhere(
      (c) => c.id == client.id,
    );

    if (clientIndex == -1) {
      throw StateError('Client with id ${client.id} not found');
    }

    final clientTemp = state.clients[clientIndex];
    final DateTime newLastOrderDate = order.startDate.isAfter(
            clientTemp.lastOrderDate ?? DateTime.fromMillisecondsSinceEpoch(0))
        ? order.startDate
        : clientTemp.lastOrderDate ?? order.startDate;

    final clientUpdated = clientTemp.copyWith(
      orderQuantity: isNewOrder
          ? clientTemp.orderQuantity + 1
          : clientTemp.orderQuantity,
      orderTotalAmount: isNewOrder
          ? clientTemp.orderTotalAmount + order.price
          : clientTemp.orderTotalAmount,
      commissionTotalAmount: isNewOrder
          ? clientTemp.commissionTotalAmount + order.commission
          : clientTemp.commissionTotalAmount,
      lastOrderDate: newLastOrderDate,
    );

    state = state.copyWith(
      clients: [
        ...state.clients.take(clientIndex),
        clientUpdated,
        ...state.clients.skip(clientIndex + 1),
      ],
    );

    if (order.sponsor != null) {
      final sponsor = getClientByName(order.sponsor!);
      if (sponsor != null) {
        final updatedSponsor = sponsor.copyWith(
          sponsorshipQuantity: sponsor.sponsorshipQuantity + 1,
        );

        final int sponsorIndex =
            state.clients.indexWhere((c) => c.id == sponsor.id);
        state = state.copyWith(
          clients: [
            ...state.clients.take(sponsorIndex),
            updatedSponsor,
            ...state.clients.skip(sponsorIndex + 1),
          ],
        );
      }
    }
  }
}
