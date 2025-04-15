// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_app_lock_state.use_case.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setAppLockStateUseCaseHash() =>
    r'651d5a253f854597846e5fe409780a9fe92e4372';

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

/// Provider for SetAppLockStateUseCase
///
/// Copied from [setAppLockStateUseCase].
@ProviderFor(setAppLockStateUseCase)
const setAppLockStateUseCaseProvider = SetAppLockStateUseCaseFamily();

/// Provider for SetAppLockStateUseCase
///
/// Copied from [setAppLockStateUseCase].
class SetAppLockStateUseCaseFamily extends Family<AsyncValue<void>> {
  /// Provider for SetAppLockStateUseCase
  ///
  /// Copied from [setAppLockStateUseCase].
  const SetAppLockStateUseCaseFamily();

  /// Provider for SetAppLockStateUseCase
  ///
  /// Copied from [setAppLockStateUseCase].
  SetAppLockStateUseCaseProvider call({
    required bool isLocked,
  }) {
    return SetAppLockStateUseCaseProvider(
      isLocked: isLocked,
    );
  }

  @override
  SetAppLockStateUseCaseProvider getProviderOverride(
    covariant SetAppLockStateUseCaseProvider provider,
  ) {
    return call(
      isLocked: provider.isLocked,
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
  String? get name => r'setAppLockStateUseCaseProvider';
}

/// Provider for SetAppLockStateUseCase
///
/// Copied from [setAppLockStateUseCase].
class SetAppLockStateUseCaseProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for SetAppLockStateUseCase
  ///
  /// Copied from [setAppLockStateUseCase].
  SetAppLockStateUseCaseProvider({
    required bool isLocked,
  }) : this._internal(
          (ref) => setAppLockStateUseCase(
            ref as SetAppLockStateUseCaseRef,
            isLocked: isLocked,
          ),
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
  Override overrideWith(
    FutureOr<void> Function(SetAppLockStateUseCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetAppLockStateUseCaseProvider._internal(
        (ref) => create(ref as SetAppLockStateUseCaseRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
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
mixin SetAppLockStateUseCaseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `isLocked` of this provider.
  bool get isLocked;
}

class _SetAppLockStateUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with SetAppLockStateUseCaseRef {
  _SetAppLockStateUseCaseProviderElement(super.provider);

  @override
  bool get isLocked => (origin as SetAppLockStateUseCaseProvider).isLocked;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
