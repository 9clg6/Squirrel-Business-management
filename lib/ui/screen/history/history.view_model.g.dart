// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyHash() => r'a89cb306e4d8fc652030e46eda76eaa17e75a81f';

/// [History]
///
/// Copied from [History].
@ProviderFor(History)
final historyProvider = NotifierProvider<History, HistoryState>.internal(
  History.new,
  name: r'historyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$historyHash,
  dependencies: <ProviderOrFamily>[orderServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    orderServiceProvider,
    ...?orderServiceProvider.allTransitiveDependencies
  },
);

typedef _$History = Notifier<HistoryState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
