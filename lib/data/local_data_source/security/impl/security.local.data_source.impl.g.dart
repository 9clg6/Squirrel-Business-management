// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security.local.data_source.impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$securityLocalDataSourceImplHash() =>
    r'f4cd49f4f031c25870d632f7f6de28cf0355b74a';

/// [SecurityLocalDataSourceImpl]
///
/// Copied from [SecurityLocalDataSourceImpl].
@ProviderFor(SecurityLocalDataSourceImpl)
final securityLocalDataSourceImplProvider = AutoDisposeAsyncNotifierProvider<
    SecurityLocalDataSourceImpl, SecurityLocalDataSourceImpl>.internal(
  SecurityLocalDataSourceImpl.new,
  name: r'securityLocalDataSourceImplProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$securityLocalDataSourceImplHash,
  dependencies: <ProviderOrFamily>[hiveSecureStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    hiveSecureStorageServiceProvider,
    ...?hiveSecureStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$SecurityLocalDataSourceImpl
    = AutoDisposeAsyncNotifier<SecurityLocalDataSourceImpl>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
