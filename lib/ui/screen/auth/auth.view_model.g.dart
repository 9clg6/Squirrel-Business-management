// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authHash() => r'6d4ff872c983e23eefe9ea7d9fe326dd2a276df8';

/// [Auth]
///
/// Copied from [Auth].
@ProviderFor(Auth)
final authProvider = NotifierProvider<Auth, AuthScreenState>.internal(
  Auth.new,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: <ProviderOrFamily>[authServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authServiceProvider,
    ...?authServiceProvider.allTransitiveDependencies
  },
);

typedef _$Auth = Notifier<AuthScreenState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
