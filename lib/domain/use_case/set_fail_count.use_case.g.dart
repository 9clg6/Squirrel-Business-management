// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_fail_count.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setFailCountUseCaseHash() =>
    r'2757acc470dc629b288c38cb2ec308b4decbb22a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for SetFailCountUseCase
/// @param [ref] ref
/// @param [count] the count
/// @return [Future<void>]
///
///
/// Copied from [setFailCountUseCase].
@ProviderFor(setFailCountUseCase)
const setFailCountUseCaseProvider = SetFailCountUseCaseFamily();

/// Provider for SetFailCountUseCase
/// @param [ref] ref
/// @param [count] the count
/// @return [Future<void>]
///
///
/// Copied from [setFailCountUseCase].
class SetFailCountUseCaseFamily extends Family<AsyncValue<void>> {
  /// Provider for SetFailCountUseCase
  /// @param [ref] ref
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  ///
  /// Copied from [setFailCountUseCase].
  const SetFailCountUseCaseFamily();

  /// Provider for SetFailCountUseCase
  /// @param [ref] ref
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  ///
  /// Copied from [setFailCountUseCase].
  SetFailCountUseCaseProvider call({
    required int count,
  }) {
    return SetFailCountUseCaseProvider(
      count: count,
    );
  }

  @override
  SetFailCountUseCaseProvider getProviderOverride(
    covariant SetFailCountUseCaseProvider provider,
  ) {
    return call(
      count: provider.count,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'setFailCountUseCaseProvider';
}

/// Provider for SetFailCountUseCase
/// @param [ref] ref
/// @param [count] the count
/// @return [Future<void>]
///
///
/// Copied from [setFailCountUseCase].
class SetFailCountUseCaseProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for SetFailCountUseCase
  /// @param [ref] ref
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  ///
  /// Copied from [setFailCountUseCase].
  SetFailCountUseCaseProvider({
    required int count,
  }) : this._internal(
          (ref) => setFailCountUseCase(
            ref as SetFailCountUseCaseRef,
            count: count,
          ),
          from: setFailCountUseCaseProvider,
          name: r'setFailCountUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setFailCountUseCaseHash,
          dependencies: SetFailCountUseCaseFamily._dependencies,
          allTransitiveDependencies:
              SetFailCountUseCaseFamily._allTransitiveDependencies,
          count: count,
        );

  SetFailCountUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.count,
  }) : super.internal();

  final int count;

  @override
  Override overrideWith(
    FutureOr<void> Function(SetFailCountUseCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetFailCountUseCaseProvider._internal(
        (ref) => create(ref as SetFailCountUseCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        count: count,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SetFailCountUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetFailCountUseCaseProvider && other.count == count;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, count.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetFailCountUseCaseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `count` of this provider.
  int get count;
}

class _SetFailCountUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<void> with SetFailCountUseCaseRef {
  _SetFailCountUseCaseProviderElement(super.provider);

  @override
  int get count => (origin as SetFailCountUseCaseProvider).count;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
