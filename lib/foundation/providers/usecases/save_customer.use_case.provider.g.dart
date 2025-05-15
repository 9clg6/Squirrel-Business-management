// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_customer.use_case.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$saveCustomersUseCaseHash() =>
    r'3c361b7bb50461ffa16225c141963977fa8659f1';

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

/// Save customer use case
///
/// Copied from [saveCustomersUseCase].
@ProviderFor(saveCustomersUseCase)
const saveCustomersUseCaseProvider = SaveCustomersUseCaseFamily();

/// Save customer use case
///
/// Copied from [saveCustomersUseCase].
class SaveCustomersUseCaseFamily extends Family<AsyncValue<void>> {
  /// Save customer use case
  ///
  /// Copied from [saveCustomersUseCase].
  const SaveCustomersUseCaseFamily();

  /// Save customer use case
  ///
  /// Copied from [saveCustomersUseCase].
  SaveCustomersUseCaseProvider call({
    required SaveCustomersParam param,
  }) {
    return SaveCustomersUseCaseProvider(
      param: param,
    );
  }

  @override
  SaveCustomersUseCaseProvider getProviderOverride(
    covariant SaveCustomersUseCaseProvider provider,
  ) {
    return call(
      param: provider.param,
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
  String? get name => r'saveCustomersUseCaseProvider';
}

/// Save customer use case
///
/// Copied from [saveCustomersUseCase].
class SaveCustomersUseCaseProvider extends AutoDisposeFutureProvider<void> {
  /// Save customer use case
  ///
  /// Copied from [saveCustomersUseCase].
  SaveCustomersUseCaseProvider({
    required SaveCustomersParam param,
  }) : this._internal(
          (ref) => saveCustomersUseCase(
            ref as SaveCustomersUseCaseRef,
            param: param,
          ),
          from: saveCustomersUseCaseProvider,
          name: r'saveCustomersUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$saveCustomersUseCaseHash,
          dependencies: SaveCustomersUseCaseFamily._dependencies,
          allTransitiveDependencies:
              SaveCustomersUseCaseFamily._allTransitiveDependencies,
          param: param,
        );

  SaveCustomersUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final SaveCustomersParam param;

  @override
  Override overrideWith(
    FutureOr<void> Function(SaveCustomersUseCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SaveCustomersUseCaseProvider._internal(
        (ref) => create(ref as SaveCustomersUseCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SaveCustomersUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveCustomersUseCaseProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SaveCustomersUseCaseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `param` of this provider.
  SaveCustomersParam get param;
}

class _SaveCustomersUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with SaveCustomersUseCaseRef {
  _SaveCustomersUseCaseProviderElement(super.provider);

  @override
  SaveCustomersParam get param =>
      (origin as SaveCustomersUseCaseProvider).param;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
