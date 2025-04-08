// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_app_lock_state.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAppLockStateUseCaseHash() =>
    r'782110aed58bed6cdce4575bf817962062511c25';

/// Provider for GetAppLockStateUseCase
/// @param [ref] ref
/// @return [Future<bool>] if the app is locked
///
///
/// Copied from [getAppLockStateUseCase].
@ProviderFor(getAppLockStateUseCase)
final getAppLockStateUseCaseProvider = AutoDisposeFutureProvider<bool>.internal(
  getAppLockStateUseCase,
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAppLockStateUseCaseRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
