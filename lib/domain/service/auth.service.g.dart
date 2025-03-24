// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'3da1f7f476f1c4514e4c8d867dc94a6c89a3f091';

/// [AuthService]
///
/// Copied from [AuthService].
@ProviderFor(AuthService)
final authServiceProvider =
    AsyncNotifierProvider<AuthService, AuthState>.internal(
  AuthService.new,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: <ProviderOrFamily>{
    requestServiceProvider,
    loginUseCaseProvider,
    checkValidityUseCaseProvider,
    hiveSecureStorageServiceProvider
  },
  allTransitiveDependencies: <ProviderOrFamily>{
    requestServiceProvider,
    ...?requestServiceProvider.allTransitiveDependencies,
    loginUseCaseProvider,
    ...?loginUseCaseProvider.allTransitiveDependencies,
    checkValidityUseCaseProvider,
    ...?checkValidityUseCaseProvider.allTransitiveDependencies,
    hiveSecureStorageServiceProvider,
    ...?hiveSecureStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$AuthService = AsyncNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
