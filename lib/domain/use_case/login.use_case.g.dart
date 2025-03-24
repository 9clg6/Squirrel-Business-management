// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginUseCaseHash() => r'8a368694355a2fb90ec629174b66439b70f02509';

/// [LoginUseCase]
///
/// Copied from [LoginUseCase].
@ProviderFor(LoginUseCase)
final loginUseCaseProvider =
    AutoDisposeNotifierProvider<LoginUseCase, LoginUseCase>.internal(
  LoginUseCase.new,
  name: r'loginUseCaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginUseCaseHash,
  dependencies: <ProviderOrFamily>[authenticationRepositoryImplProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authenticationRepositoryImplProvider,
    ...?authenticationRepositoryImplProvider.allTransitiveDependencies
  },
);

typedef _$LoginUseCase = AutoDisposeNotifier<LoginUseCase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
