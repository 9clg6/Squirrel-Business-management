// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoViewModelHash() => r'ed76bc8bac8a7688366366f631553aea086a3023';

/// [TodoViewModel]
///
/// Copied from [TodoViewModel].
@ProviderFor(TodoViewModel)
final todoViewModelProvider =
    NotifierProvider<TodoViewModel, TodoScreenState>.internal(
  TodoViewModel.new,
  name: r'todoViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoViewModelHash,
  dependencies: <ProviderOrFamily>[orderServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    orderServiceProvider,
    ...?orderServiceProvider.allTransitiveDependencies
  },
);

typedef _$TodoViewModel = Notifier<TodoScreenState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
