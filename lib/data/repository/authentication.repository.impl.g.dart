// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.repository.impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authenticationRepositoryImplHash() =>
    r'ab2ec82b77fdc913d8999a44df1987c89d974965';

/// [AuthenticationRepositoryImpl]
///
/// Copied from [AuthenticationRepositoryImpl].
@ProviderFor(AuthenticationRepositoryImpl)
final authenticationRepositoryImplProvider = AutoDisposeNotifierProvider<
    AuthenticationRepositoryImpl, AuthenticationRepositoryImpl>.internal(
  AuthenticationRepositoryImpl.new,
  name: r'authenticationRepositoryImplProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationRepositoryImplHash,
  dependencies: <ProviderOrFamily>[authenticationDataSourceImplProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authenticationDataSourceImplProvider,
    ...?authenticationDataSourceImplProvider.allTransitiveDependencies
  },
);

typedef _$AuthenticationRepositoryImpl
    = AutoDisposeNotifier<AuthenticationRepositoryImpl>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
