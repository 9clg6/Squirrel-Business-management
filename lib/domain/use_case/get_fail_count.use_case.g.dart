// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fail_count.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFailCountUseCaseHash() =>
    r'2f467136efe19cebf94554a97086442a71f69f3d';

/// Provider for GetFailCountUseCase
/// @param [ref] ref
/// @return [Future<int>] the fail count
///
///
/// Copied from [getFailCountUseCase].
@ProviderFor(getFailCountUseCase)
final getFailCountUseCaseProvider = AutoDisposeFutureProvider<int>.internal(
  getFailCountUseCase,
  name: r'getFailCountUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFailCountUseCaseHash,
  dependencies: <ProviderOrFamily>[securityRepositoryImplProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    securityRepositoryImplProvider,
    ...?securityRepositoryImplProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetFailCountUseCaseRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
