// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_app_lock_state.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAppLockStateUseCaseHash() =>
    r'f4c519888d7693d1a1696bb9eda3d24dc3183809';

/// Use case to get the app lock state
///
/// Copied from [GetAppLockStateUseCase].
@ProviderFor(GetAppLockStateUseCase)
final getAppLockStateUseCaseProvider =
    AutoDisposeAsyncNotifierProvider<GetAppLockStateUseCase, bool>.internal(
  GetAppLockStateUseCase.new,
  name: r'getAppLockStateUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAppLockStateUseCaseHash,
  dependencies: <ProviderOrFamily>[securityRepositoryImplProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    securityRepositoryImplProvider,
    ...?securityRepositoryImplProvider.allTransitiveDependencies
  },
);

typedef _$GetAppLockStateUseCase = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
