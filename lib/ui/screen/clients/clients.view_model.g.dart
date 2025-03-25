// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientsHash() => r'6cf215c37229cc360af5a37efd83c8a5cef50eaa';

/// [Clients]
///
/// Copied from [Clients].
@ProviderFor(Clients)
final clientsProvider = NotifierProvider<Clients, ClientsScreenState>.internal(
  Clients.new,
  name: r'clientsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clientsHash,
  dependencies: <ProviderOrFamily>[clientServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    clientServiceProvider,
    ...?clientServiceProvider.allTransitiveDependencies
  },
);

typedef _$Clients = Notifier<ClientsScreenState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
