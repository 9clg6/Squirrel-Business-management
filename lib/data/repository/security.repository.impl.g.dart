// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security.repository.impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$securityRepositoryImplHash() =>
    r'0d7b1f76653eec86b7bfd9a36bad2c1f474f03a4';

/// [SecurityRepositoryImpl]
///
/// Copied from [SecurityRepositoryImpl].
@ProviderFor(SecurityRepositoryImpl)
final securityRepositoryImplProvider = AutoDisposeAsyncNotifierProvider<
    SecurityRepositoryImpl, SecurityRepositoryImpl>.internal(
  SecurityRepositoryImpl.new,
  name: r'securityRepositoryImplProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$securityRepositoryImplHash,
  dependencies: <ProviderOrFamily>[securityLocalDataSourceImplProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    securityLocalDataSourceImplProvider,
    ...?securityLocalDataSourceImplProvider.allTransitiveDependencies
  },
);

typedef _$SecurityRepositoryImpl
    = AutoDisposeAsyncNotifier<SecurityRepositoryImpl>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
