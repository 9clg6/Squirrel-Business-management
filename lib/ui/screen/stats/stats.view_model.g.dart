// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statsViewModelHash() => r'749580bb0ab8551f257166c593e6188799003332';

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
