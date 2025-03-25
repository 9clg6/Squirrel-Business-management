// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginUseCaseHash() => r'0b201f7a75823e09e1ead0bc8bb6b16e55010bca';

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
