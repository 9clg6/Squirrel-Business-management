// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'f3096ec44d6e87f8ab37f649adca3c0f9bdc2b41';

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
    dialogServiceProvider,
    navigatorServiceProvider,
    getFailCountUseCaseProvider,
    getLastKnownTimeUseCaseProvider,
    getLicenseUseCaseProvider,
    getAppLockStateUseCaseProvider,
    setFailCountUseCaseProvider,
    setLastCheckSuccessUseCaseProvider,
    setLastKnownTimeUseCaseProvider,
    setAppLockStateUseCaseProvider,
    hiveSecureStorageServiceProvider,
    saveLicenseUseCaseProvider
  },
  allTransitiveDependencies: <ProviderOrFamily>{
    requestServiceProvider,
    ...?requestServiceProvider.allTransitiveDependencies,
    loginUseCaseProvider,
    ...?loginUseCaseProvider.allTransitiveDependencies,
    checkValidityUseCaseProvider,
    ...?checkValidityUseCaseProvider.allTransitiveDependencies,
    dialogServiceProvider,
    ...?dialogServiceProvider.allTransitiveDependencies,
    navigatorServiceProvider,
    ...?navigatorServiceProvider.allTransitiveDependencies,
    getFailCountUseCaseProvider,
    ...?getFailCountUseCaseProvider.allTransitiveDependencies,
    getLastKnownTimeUseCaseProvider,
    ...?getLastKnownTimeUseCaseProvider.allTransitiveDependencies,
    getLicenseUseCaseProvider,
    ...?getLicenseUseCaseProvider.allTransitiveDependencies,
    getAppLockStateUseCaseProvider,
    ...?getAppLockStateUseCaseProvider.allTransitiveDependencies,
    setFailCountUseCaseProvider,
    ...?setFailCountUseCaseProvider.allTransitiveDependencies,
    setLastCheckSuccessUseCaseProvider,
    ...?setLastCheckSuccessUseCaseProvider.allTransitiveDependencies,
    setLastKnownTimeUseCaseProvider,
    ...?setLastKnownTimeUseCaseProvider.allTransitiveDependencies,
    setAppLockStateUseCaseProvider,
    ...?setAppLockStateUseCaseProvider.allTransitiveDependencies,
    hiveSecureStorageServiceProvider,
    ...?hiveSecureStorageServiceProvider.allTransitiveDependencies,
    saveLicenseUseCaseProvider,
    ...?saveLicenseUseCaseProvider.allTransitiveDependencies
  },
);

typedef _$AuthService = AsyncNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
