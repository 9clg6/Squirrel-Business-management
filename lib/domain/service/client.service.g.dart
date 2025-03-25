// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientServiceHash() => r'd132201a63bdd3b882d394d2a2c52926c8d1a64a';

/// [ClientService]
///
/// Copied from [ClientService].
@ProviderFor(ClientService)
final clientServiceProvider =
    AsyncNotifierProvider<ClientService, ClientState>.internal(
  ClientService.new,
  name: r'clientServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clientServiceHash,
  dependencies: <ProviderOrFamily>[hiveSecureStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    hiveSecureStorageServiceProvider,
    ...?hiveSecureStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$ClientService = AsyncNotifier<ClientState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
