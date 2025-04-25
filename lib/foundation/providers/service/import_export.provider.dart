import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/import_export.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/constants/constants.dart';
import 'package:squirrel/foundation/providers/service/dialog.service.provider.dart';

part 'import_export.provider.g.dart';

/// Import export service provider
/// @param ref: The ref object
/// @return ImportExportService: The import export service
///
@riverpod
Future<ImportExportService> importExportService(Ref ref) async {
  final Directory dir = await getApplicationDocumentsDirectory();
  final Directory createdDirectory = await Directory(
    '${dir.path}/$appFolderName',
  ).create(
    recursive: true,
  );

  final OrderService orderService =
      await ref.watch(orderServiceProvider.notifier);
  final ClientService clientService =
      await ref.watch(clientServiceProvider.notifier);
  final DialogService dialogService = await ref.watch(dialogServiceProvider);

  final OrderState orderState = await ref.watch(orderServiceProvider.future);
  final ClientState clientState = await ref.watch(clientServiceProvider.future);

  return ImportExportService(
    file: File('${createdDirectory.path}/export.json'),
    dataToExport: await _mergeData(
      orderState: orderState,
      clientState: clientState,
    ),
    dialogService: dialogService,
    onImportSuccess: (List<Order> orders, List<Client> clients) {
      orderService.loadOrders(orders);
      clientService.loadClients(clients);
    },
  );
}

/// Merge data
/// @return [Future<Map<String, Map<String, dynamic>>>] merged data
///
Future<Map<String, List<Map<String, dynamic>>>> _mergeData({
  required OrderState orderState,
  required ClientState clientState,
}) async {
  final Map<String, List<Map<String, dynamic>>> data =
      <String, List<Map<String, dynamic>>>{
    'orders': orderState.orders.map((Order order) => order.toJson()).toList(),
    'clients':
        clientState.clients.map((Client client) => client.toJson()).toList(),
  };
  return data;
}
