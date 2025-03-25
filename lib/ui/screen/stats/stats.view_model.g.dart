// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statsViewModelHash() => r'4751c00c1ece1c7b5eab4def32eb3e3e591904c0';

/// [StatsViewModel]
///
/// Copied from [StatsViewModel].
@ProviderFor(StatsViewModel)
final statsViewModelProvider =
    NotifierProvider<StatsViewModel, StatsScreenState>.internal(
  StatsViewModel.new,
  name: r'statsViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsViewModelHash,
  dependencies: <ProviderOrFamily>[orderServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    orderServiceProvider,
    ...?orderServiceProvider.allTransitiveDependencies
  },
);

typedef _$StatsViewModel = Notifier<StatsScreenState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
