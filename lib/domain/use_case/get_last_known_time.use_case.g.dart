// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_last_known_time.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLastKnownTimeUseCaseHash() =>
    r'1da0b53c4ded2af340b3e96ef7fa911b6dccbd69';

/// Use case to get the last known time
///
/// Copied from [GetLastKnownTimeUseCase].
@ProviderFor(GetLastKnownTimeUseCase)
final getLastKnownTimeUseCaseProvider = AutoDisposeAsyncNotifierProvider<
    GetLastKnownTimeUseCase, DateTime>.internal(
  GetLastKnownTimeUseCase.new,
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

typedef _$GetLastKnownTimeUseCase = AutoDisposeAsyncNotifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
