// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_secure_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hiveSecureStorageHash() => r'e5915a32475bc6d7c262b872750dbbe98cb65130';

/// [HiveSecureStorage]
/// Use it when you want to save secured data that
///  won't be backed up by the system.
///
/// Copied from [HiveSecureStorage].
@ProviderFor(HiveSecureStorage)
final hiveSecureStorageProvider =
    AsyncNotifierProvider<HiveSecureStorage, HiveSecureStorage>.internal(
  HiveSecureStorage.new,
  name: r'hiveSecureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hiveSecureStorageHash,
  dependencies: <ProviderOrFamily>[secureStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    secureStorageServiceProvider,
    ...?secureStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$HiveSecureStorage = AsyncNotifier<HiveSecureStorage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
