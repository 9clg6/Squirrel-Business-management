// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_last_known_time.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLastKnownTimeUseCaseHash() =>
    r'a6435598b8d9d58be305b453199e2badd8239c17';

/// Provider for GetLastKnownTimeUseCase
/// @param [ref] ref
/// @return [Future<DateTime>] the last known time
///
///
/// Copied from [getLastKnownTimeUseCase].
@ProviderFor(getLastKnownTimeUseCase)
final getLastKnownTimeUseCaseProvider =
    AutoDisposeFutureProvider<DateTime>.internal(
  getLastKnownTimeUseCase,
  name: r'getLastKnownTimeUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLastKnownTimeUseCaseHash,
  dependencies: <ProviderOrFamily>[securityRepositoryImplProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    securityRepositoryImplProvider,
    ...?securityRepositoryImplProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetLastKnownTimeUseCaseRef = AutoDisposeFutureProviderRef<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
