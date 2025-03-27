// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_license.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLicenseUseCaseHash() => r'35b646ae157964a8ef0c14c6f09e4828c72b99be';

/// [GetLicenseUseCase]
///
/// Copied from [GetLicenseUseCase].
@ProviderFor(GetLicenseUseCase)
final getLicenseUseCaseProvider = AutoDisposeAsyncNotifierProvider<
    GetLicenseUseCase, LoginResultEntity?>.internal(
  GetLicenseUseCase.new,
  name: r'getLicenseUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLicenseUseCaseHash,
  dependencies: <ProviderOrFamily>[userRepositoryImplProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    userRepositoryImplProvider,
    ...?userRepositoryImplProvider.allTransitiveDependencies
  },
);

typedef _$GetLicenseUseCase = AutoDisposeAsyncNotifier<LoginResultEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
