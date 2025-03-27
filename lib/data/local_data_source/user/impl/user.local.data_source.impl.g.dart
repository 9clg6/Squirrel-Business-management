// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.local.data_source.impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userLocalDataSourceImplHash() =>
    r'9b7cfe91b7cdb71418c6699c43004bf81cb26ddd';

/// [UserLocalDataSourceImpl]
///
/// Copied from [UserLocalDataSourceImpl].
@ProviderFor(UserLocalDataSourceImpl)
final userLocalDataSourceImplProvider = AutoDisposeAsyncNotifierProvider<
    UserLocalDataSourceImpl, UserLocalDataSourceImpl>.internal(
  UserLocalDataSourceImpl.new,
  name: r'userLocalDataSourceImplProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLocalDataSourceImplHash,
  dependencies: <ProviderOrFamily>[hiveSecureStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    hiveSecureStorageServiceProvider,
    ...?hiveSecureStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$UserLocalDataSourceImpl
    = AutoDisposeAsyncNotifier<UserLocalDataSourceImpl>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
