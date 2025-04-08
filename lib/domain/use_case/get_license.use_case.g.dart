// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_license.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLicenseUseCaseHash() => r'2fcb09d1f3b346d755fbe303eb5a09610d610a5d';

/// Provider for GetLicenseUseCase
/// @param [ref] ref
/// @return [Future<LoginResult?>] login result entity
///
///
/// Copied from [getLicenseUseCase].
@ProviderFor(getLicenseUseCase)
final getLicenseUseCaseProvider =
    AutoDisposeFutureProvider<LoginResult?>.internal(
  getLicenseUseCase,
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetLicenseUseCaseRef = AutoDisposeFutureProviderRef<LoginResult?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
