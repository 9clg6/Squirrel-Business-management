// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fail_count.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFailCountUseCaseHash() =>
    r'e5e8b5e968c4cb1b74cfa6433c0c91565bc662f1';

/// Use case to get the fail count
///
/// Copied from [GetFailCountUseCase].
@ProviderFor(GetFailCountUseCase)
final getFailCountUseCaseProvider =
    AutoDisposeAsyncNotifierProvider<GetFailCountUseCase, int>.internal(
  GetFailCountUseCase.new,
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

typedef _$GetFailCountUseCase = AutoDisposeAsyncNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
