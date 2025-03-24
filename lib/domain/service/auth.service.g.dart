// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'a85fa0e538ecddd7fc03cc61b34cd07846c3af31';

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
  dependencies: <ProviderOrFamily>[
    requestServiceProvider,
    loginUseCaseProvider,
    checkValidityUseCaseProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    requestServiceProvider,
    ...?requestServiceProvider.allTransitiveDependencies,
    loginUseCaseProvider,
    ...?loginUseCaseProvider.allTransitiveDependencies,
    checkValidityUseCaseProvider,
    ...?checkValidityUseCaseProvider.allTransitiveDependencies
  },
);

typedef _$AuthService = AsyncNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
