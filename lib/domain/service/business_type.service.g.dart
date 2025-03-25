// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_type.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$businessTypeServiceHash() =>
    r'2ac9f6aedf6b82fe0c51e85ac749e3cc058c15a1';

/// [BusinessTypeService]
///
/// Copied from [BusinessTypeService].
@ProviderFor(BusinessTypeService)
final businessTypeServiceProvider = AutoDisposeAsyncNotifierProvider<
    BusinessTypeService, BusinessTypeState>.internal(
  BusinessTypeService.new,
  name: r'businessTypeServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$businessTypeServiceHash,
  dependencies: <ProviderOrFamily>[hiveSecureStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    hiveSecureStorageServiceProvider,
    ...?hiveSecureStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$BusinessTypeService = AutoDisposeAsyncNotifier<BusinessTypeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
