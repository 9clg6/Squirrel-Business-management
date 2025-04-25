// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_type.service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$businessTypeServiceHash() =>
    r'a4f948a68e1d4a34614da60bccc03684f19a1d52';

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
