// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_last_check_success.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setLastCheckSuccessUseCaseHash() =>
    r'186418b9a66812f30bf5b640a29ba497c3a0de1e';

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

/// Provider for SetLastCheckSuccessUseCase
/// @param [ref] ref
/// @param [date] the date (as String)
/// @return [Future<void>]
///
///
/// Copied from [setLastCheckSuccessUseCase].
@ProviderFor(setLastCheckSuccessUseCase)
const setLastCheckSuccessUseCaseProvider = SetLastCheckSuccessUseCaseFamily();

/// Provider for SetLastCheckSuccessUseCase
/// @param [ref] ref
/// @param [date] the date (as String)
/// @return [Future<void>]
///
///
/// Copied from [setLastCheckSuccessUseCase].
class SetLastCheckSuccessUseCaseFamily extends Family<AsyncValue<void>> {
  /// Provider for SetLastCheckSuccessUseCase
  /// @param [ref] ref
  /// @param [date] the date (as String)
  /// @return [Future<void>]
  ///
  ///
  /// Copied from [setLastCheckSuccessUseCase].
  const SetLastCheckSuccessUseCaseFamily();

  /// Provider for SetLastCheckSuccessUseCase
  /// @param [ref] ref
  /// @param [date] the date (as String)
  /// @return [Future<void>]
  ///
  ///
  /// Copied from [setLastCheckSuccessUseCase].
  SetLastCheckSuccessUseCaseProvider call({
    required String date,
  }) {
    return SetLastCheckSuccessUseCaseProvider(
      date: date,
    );
  }

  @override
  SetLastCheckSuccessUseCaseProvider getProviderOverride(
    covariant SetLastCheckSuccessUseCaseProvider provider,
  ) {
    return call(
      date: provider.date,
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
  String? get name => r'setLastCheckSuccessUseCaseProvider';
}

/// Provider for SetLastCheckSuccessUseCase
/// @param [ref] ref
/// @param [date] the date (as String)
/// @return [Future<void>]
///
///
/// Copied from [setLastCheckSuccessUseCase].
class SetLastCheckSuccessUseCaseProvider
    extends AutoDisposeFutureProvider<void> {
  /// Provider for SetLastCheckSuccessUseCase
  /// @param [ref] ref
  /// @param [date] the date (as String)
  /// @return [Future<void>]
  ///
  ///
  /// Copied from [setLastCheckSuccessUseCase].
  SetLastCheckSuccessUseCaseProvider({
    required String date,
  }) : this._internal(
          (ref) => setLastCheckSuccessUseCase(
            ref as SetLastCheckSuccessUseCaseRef,
            date: date,
          ),
          from: setLastCheckSuccessUseCaseProvider,
          name: r'setLastCheckSuccessUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setLastCheckSuccessUseCaseHash,
          dependencies: SetLastCheckSuccessUseCaseFamily._dependencies,
          allTransitiveDependencies:
              SetLastCheckSuccessUseCaseFamily._allTransitiveDependencies,
          date: date,
        );

  SetLastCheckSuccessUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final String date;

  @override
  Override overrideWith(
    FutureOr<void> Function(SetLastCheckSuccessUseCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetLastCheckSuccessUseCaseProvider._internal(
        (ref) => create(ref as SetLastCheckSuccessUseCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SetLastCheckSuccessUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetLastCheckSuccessUseCaseProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetLastCheckSuccessUseCaseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `date` of this provider.
  String get date;
}

class _SetLastCheckSuccessUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with SetLastCheckSuccessUseCaseRef {
  _SetLastCheckSuccessUseCaseProviderElement(super.provider);

  @override
  String get date => (origin as SetLastCheckSuccessUseCaseProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
