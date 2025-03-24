// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_secure_storage.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hiveSecureStorageServiceHash() =>
    r'd73fc656d29371fc1a6403f61dc2a811a0d73ed2';

/// Use it when you want to save secured data that won't be backed up by the system.
///
/// Copied from [HiveSecureStorageService].
@ProviderFor(HiveSecureStorageService)
final hiveSecureStorageServiceProvider = AsyncNotifierProvider<
    HiveSecureStorageService, HiveSecureStorageService>.internal(
  HiveSecureStorageService.new,
  name: r'hiveSecureStorageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hiveSecureStorageServiceHash,
  dependencies: <ProviderOrFamily>[secureStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    secureStorageServiceProvider,
    ...?secureStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$HiveSecureStorageService = AsyncNotifier<HiveSecureStorageService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
