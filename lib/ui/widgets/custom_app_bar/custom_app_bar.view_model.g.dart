// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_app_bar.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customAppBarViewModelHash() =>
    r'bd3acc63398f41201f35010e59544c5b5676c4df';

/// [CustomAppBarViewModel]
///
/// Copied from [CustomAppBarViewModel].
@ProviderFor(CustomAppBarViewModel)
final customAppBarViewModelProvider =
    NotifierProvider<CustomAppBarViewModel, CustomAppBarState>.internal(
  CustomAppBarViewModel.new,
  name: r'customAppBarViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customAppBarViewModelHash,
  dependencies: <ProviderOrFamily>[authServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authServiceProvider,
    ...?authServiceProvider.allTransitiveDependencies
  },
);

typedef _$CustomAppBarViewModel = Notifier<CustomAppBarState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
