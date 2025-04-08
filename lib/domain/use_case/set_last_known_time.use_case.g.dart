// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_last_known_time.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setLastKnownTimeUseCaseHash() =>
    r'e0bc6729b05062f69e4f0e3a2d2ee22840d6b4e6';

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

/// Provider for SetLastKnownTimeUseCase
/// @param [ref] ref
/// @param date [DateTime] the date to set
/// @return [Future<void>] the last known time
///
///
/// Copied from [setLastKnownTimeUseCase].
@ProviderFor(setLastKnownTimeUseCase)
const setLastKnownTimeUseCaseProvider = SetLastKnownTimeUseCaseFamily();

/// Provider for SetLastKnownTimeUseCase
/// @param [ref] ref
/// @param date [DateTime] the date to set
/// @return [Future<void>] the last known time
///
///
/// Copied from [setLastKnownTimeUseCase].
class SetLastKnownTimeUseCaseFamily extends Family<AsyncValue<void>> {
  /// Provider for SetLastKnownTimeUseCase
  /// @param [ref] ref
  /// @param date [DateTime] the date to set
  /// @return [Future<void>] the last known time
  ///
  ///
  /// Copied from [setLastKnownTimeUseCase].
  const SetLastKnownTimeUseCaseFamily();

  /// Provider for SetLastKnownTimeUseCase
  /// @param [ref] ref
  /// @param date [DateTime] the date to set
  /// @return [Future<void>] the last known time
  ///
  ///
  /// Copied from [setLastKnownTimeUseCase].
  SetLastKnownTimeUseCaseProvider call({
    required DateTime date,
  }) {
    return SetLastKnownTimeUseCaseProvider(
      date: date,
    );
  }

  @override
  SetLastKnownTimeUseCaseProvider getProviderOverride(
    covariant SetLastKnownTimeUseCaseProvider provider,
  ) {
    return call(
      date: provider.date,
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
  String? get name => r'setLastKnownTimeUseCaseProvider';
}

/// Provider for SetLastKnownTimeUseCase
/// @param [ref] ref
/// @param date [DateTime] the date to set
/// @return [Future<void>] the last known time
///
///
/// Copied from [setLastKnownTimeUseCase].
class SetLastKnownTimeUseCaseProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for SetLastKnownTimeUseCase
  /// @param [ref] ref
  /// @param date [DateTime] the date to set
  /// @return [Future<void>] the last known time
  ///
  ///
  /// Copied from [setLastKnownTimeUseCase].
  SetLastKnownTimeUseCaseProvider({
    required DateTime date,
  }) : this._internal(
          (ref) => setLastKnownTimeUseCase(
            ref as SetLastKnownTimeUseCaseRef,
            date: date,
          ),
          from: setLastKnownTimeUseCaseProvider,
          name: r'setLastKnownTimeUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setLastKnownTimeUseCaseHash,
          dependencies: SetLastKnownTimeUseCaseFamily._dependencies,
          allTransitiveDependencies:
              SetLastKnownTimeUseCaseFamily._allTransitiveDependencies,
          date: date,
        );

  SetLastKnownTimeUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<void> Function(SetLastKnownTimeUseCaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetLastKnownTimeUseCaseProvider._internal(
        (ref) => create(ref as SetLastKnownTimeUseCaseRef),
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
    return _SetLastKnownTimeUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetLastKnownTimeUseCaseProvider && other.date == date;
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
mixin SetLastKnownTimeUseCaseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _SetLastKnownTimeUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with SetLastKnownTimeUseCaseRef {
  _SetLastKnownTimeUseCaseProviderElement(super.provider);

  @override
  DateTime get date => (origin as SetLastKnownTimeUseCaseProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
