// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'942ac71494537107eec09b4d1f9866695d687abb';

/// Custom app router
///
/// Copied from [router].
@ProviderFor(router)
final routerProvider = Provider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: <ProviderOrFamily>[authServiceProvider, requestServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authServiceProvider,
    ...?authServiceProvider.allTransitiveDependencies,
    requestServiceProvider,
    ...?requestServiceProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
