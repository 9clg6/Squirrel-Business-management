// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_fail_count.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setFailCountUseCaseHash() =>
    r'b64f082f5e134d8917e13ca87a1f44c05ec4c5a6';

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

abstract class _$SetFailCountUseCase
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final int count;

  FutureOr<void> build(
    int count,
  );
}

/// Use case to set the fail count
///
/// Copied from [SetFailCountUseCase].
@ProviderFor(SetFailCountUseCase)
const setFailCountUseCaseProvider = SetFailCountUseCaseFamily();

/// Use case to set the fail count
///
/// Copied from [SetFailCountUseCase].
class SetFailCountUseCaseFamily extends Family<AsyncValue<void>> {
  /// Use case to set the fail count
  ///
  /// Copied from [SetFailCountUseCase].
  const SetFailCountUseCaseFamily();

  /// Use case to set the fail count
  ///
  /// Copied from [SetFailCountUseCase].
  SetFailCountUseCaseProvider call(
    int count,
  ) {
    return SetFailCountUseCaseProvider(
      count,
    );
  }

  @override
  SetFailCountUseCaseProvider getProviderOverride(
    covariant SetFailCountUseCaseProvider provider,
  ) {
    return call(
      provider.count,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    securityRepositoryImplProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    securityRepositoryImplProvider,
    ...?securityRepositoryImplProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'setFailCountUseCaseProvider';
}

/// Use case to set the fail count
///
/// Copied from [SetFailCountUseCase].
class SetFailCountUseCaseProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SetFailCountUseCase, void> {
  /// Use case to set the fail count
  ///
  /// Copied from [SetFailCountUseCase].
  SetFailCountUseCaseProvider(
    int count,
  ) : this._internal(
          () => SetFailCountUseCase()..count = count,
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
  FutureOr<void> runNotifierBuild(
    covariant SetFailCountUseCase notifier,
  ) {
    return notifier.build(
      count,
    );
  }

  @override
  Override overrideWith(SetFailCountUseCase Function() create) {
    return ProviderOverride(
      origin: this,
      override: SetFailCountUseCaseProvider._internal(
        () => create()..count = count,
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
  AutoDisposeAsyncNotifierProviderElement<SetFailCountUseCase, void>
      createElement() {
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
mixin SetFailCountUseCaseRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `count` of this provider.
  int get count;
}

class _SetFailCountUseCaseProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SetFailCountUseCase, void>
    with SetFailCountUseCaseRef {
  _SetFailCountUseCaseProviderElement(super.provider);

  @override
  int get count => (origin as SetFailCountUseCaseProvider).count;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
