// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_app_lock_state.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setAppLockStateUseCaseHash() =>
    r'd9a1493fa76d08328198391d90bfeefafea8a2b5';

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

abstract class _$SetAppLockStateUseCase
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final bool isLocked;

  FutureOr<void> build(
    bool isLocked,
  );
}

/// Use case to set the app lock state
///
/// Copied from [SetAppLockStateUseCase].
@ProviderFor(SetAppLockStateUseCase)
const setAppLockStateUseCaseProvider = SetAppLockStateUseCaseFamily();

/// Use case to set the app lock state
///
/// Copied from [SetAppLockStateUseCase].
class SetAppLockStateUseCaseFamily extends Family<AsyncValue<void>> {
  /// Use case to set the app lock state
  ///
  /// Copied from [SetAppLockStateUseCase].
  const SetAppLockStateUseCaseFamily();

  /// Use case to set the app lock state
  ///
  /// Copied from [SetAppLockStateUseCase].
  SetAppLockStateUseCaseProvider call(
    bool isLocked,
  ) {
    return SetAppLockStateUseCaseProvider(
      isLocked,
    );
  }

  @override
  SetAppLockStateUseCaseProvider getProviderOverride(
    covariant SetAppLockStateUseCaseProvider provider,
  ) {
    return call(
      provider.isLocked,
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
  String? get name => r'setAppLockStateUseCaseProvider';
}

/// Use case to set the app lock state
///
/// Copied from [SetAppLockStateUseCase].
class SetAppLockStateUseCaseProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SetAppLockStateUseCase, void> {
  /// Use case to set the app lock state
  ///
  /// Copied from [SetAppLockStateUseCase].
  SetAppLockStateUseCaseProvider(
    bool isLocked,
  ) : this._internal(
          () => SetAppLockStateUseCase()..isLocked = isLocked,
          from: setAppLockStateUseCaseProvider,
          name: r'setAppLockStateUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setAppLockStateUseCaseHash,
          dependencies: SetAppLockStateUseCaseFamily._dependencies,
          allTransitiveDependencies:
              SetAppLockStateUseCaseFamily._allTransitiveDependencies,
          isLocked: isLocked,
        );

  SetAppLockStateUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isLocked,
  }) : super.internal();

  final bool isLocked;

  @override
  FutureOr<void> runNotifierBuild(
    covariant SetAppLockStateUseCase notifier,
  ) {
    return notifier.build(
      isLocked,
    );
  }

  @override
  Override overrideWith(SetAppLockStateUseCase Function() create) {
    return ProviderOverride(
      origin: this,
      override: SetAppLockStateUseCaseProvider._internal(
        () => create()..isLocked = isLocked,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isLocked: isLocked,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SetAppLockStateUseCase, void>
      createElement() {
    return _SetAppLockStateUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetAppLockStateUseCaseProvider &&
        other.isLocked == isLocked;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isLocked.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetAppLockStateUseCaseRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `isLocked` of this provider.
  bool get isLocked;
}

class _SetAppLockStateUseCaseProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SetAppLockStateUseCase,
        void> with SetAppLockStateUseCaseRef {
  _SetAppLockStateUseCaseProviderElement(super.provider);

  @override
  bool get isLocked => (origin as SetAppLockStateUseCaseProvider).isLocked;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
