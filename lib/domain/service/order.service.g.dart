// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderServiceHash() => r'07a256829bbf5cbcc06f530c867c248c5c1a06fb';

/// [OrderService]
///
/// Copied from [OrderService].
@ProviderFor(OrderService)
final orderServiceProvider =
    AsyncNotifierProvider<OrderService, OrderState>.internal(
  OrderService.new,
  name: r'orderServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderServiceHash,
  dependencies: <ProviderOrFamily>[
    hiveSecureStorageServiceProvider,
    customerServiceProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    hiveSecureStorageServiceProvider,
    ...?hiveSecureStorageServiceProvider.allTransitiveDependencies,
    customerServiceProvider,
    ...?customerServiceProvider.allTransitiveDependencies
  },
);

typedef _$OrderService = AsyncNotifier<OrderState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
