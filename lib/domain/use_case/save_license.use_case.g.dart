// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_license.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$saveLicenseUseCaseHash() =>
    r'576c69aa13fc5dde59dcbd34145d7400bac97277';

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

/// Provider for SaveLicenseUseCase
/// @param [ref] ref
/// @param [license] license
/// @return [Future<void>] void
///
///
/// Copied from [saveLicenseUseCase].
@ProviderFor(saveLicenseUseCase)
const saveLicenseUseCaseProvider = SaveLicenseUseCaseFamily();

/// Provider for SaveLicenseUseCase
/// @param [ref] ref
/// @param [license] license
/// @return [Future<void>] void
///
///
/// Copied from [saveLicenseUseCase].
class SaveLicenseUseCaseFamily extends Family<AsyncValue<void>> {
  /// Provider for SaveLicenseUseCase
  /// @param [ref] ref
  /// @param [license] license
  /// @return [Future<void>] void
  ///
  ///
  /// Copied from [saveLicenseUseCase].
  const SaveLicenseUseCaseFamily();

  /// Provider for SaveLicenseUseCase
  /// @param [ref] ref
  /// @param [license] license
  /// @return [Future<void>] void
  ///
  ///
  /// Copied from [saveLicenseUseCase].
  SaveLicenseUseCaseProvider call({
    required LoginResult license,
  }) {
    return SaveLicenseUseCaseProvider(
      license: license,
    );
  }

  @override
  SaveLicenseUseCaseProvider getProviderOverride(
    covariant SaveLicenseUseCaseProvider provider,
  ) {
    return call(
      license: provider.license,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    userRepositoryImplProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    userRepositoryImplProvider,
    ...?userRepositoryImplProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'saveLicenseUseCaseProvider';
}

/// Provider for SaveLicenseUseCase
/// @param [ref] ref
/// @param [license] license
/// @return [Future<void>] void
///
///
/// Copied from [saveLicenseUseCase].
class SaveLicenseUseCaseProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for SaveLicenseUseCase
  /// @param [ref] ref
  /// @param [license] license
  /// @return [Future<void>] void
  ///
  ///
  /// Copied from [saveLicenseUseCase].
  SaveLicenseUseCaseProvider({
    required LoginResult license,
  }) : this._internal(
          (ref) => saveLicenseUseCase(
            ref as SaveLicenseUseCaseRef,
            license: license,
          ),
          from: saveLicenseUseCaseProvider,
          name: r'saveLicenseUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$saveLicenseUseCaseHash,
          dependencies: SaveLicenseUseCaseFamily._dependencies,
          allTransitiveDependencies:
              SaveLicenseUseCaseFamily._allTransitiveDependencies,
          license: license,
        );

  SaveLicenseUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.license,
  }) : super.internal();

  final LoginResult license;

  @override
  Override overrideWith(
    FutureOr<void> Function(SaveLicenseUseCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SaveLicenseUseCaseProvider._internal(
        (ref) => create(ref as SaveLicenseUseCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        license: license,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SaveLicenseUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveLicenseUseCaseProvider && other.license == license;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, license.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SaveLicenseUseCaseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `license` of this provider.
  LoginResult get license;
}

class _SaveLicenseUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<void> with SaveLicenseUseCaseRef {
  _SaveLicenseUseCaseProviderElement(super.provider);

  @override
  LoginResult get license => (origin as SaveLicenseUseCaseProvider).license;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
