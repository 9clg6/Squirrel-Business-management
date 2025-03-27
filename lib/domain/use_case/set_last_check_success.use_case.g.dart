// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_last_check_success.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setLastCheckSuccessUseCaseHash() =>
    r'5db3f0e293b5a7381e1774c39667b0a1f4b63db1';

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

abstract class _$SetLastCheckSuccessUseCase
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final String date;

  FutureOr<void> build(
    String date,
  );
}

/// Use case to set the last check success
///
/// Copied from [SetLastCheckSuccessUseCase].
@ProviderFor(SetLastCheckSuccessUseCase)
const setLastCheckSuccessUseCaseProvider = SetLastCheckSuccessUseCaseFamily();

/// Use case to set the last check success
///
/// Copied from [SetLastCheckSuccessUseCase].
class SetLastCheckSuccessUseCaseFamily extends Family<AsyncValue<void>> {
  /// Use case to set the last check success
  ///
  /// Copied from [SetLastCheckSuccessUseCase].
  const SetLastCheckSuccessUseCaseFamily();

  /// Use case to set the last check success
  ///
  /// Copied from [SetLastCheckSuccessUseCase].
  SetLastCheckSuccessUseCaseProvider call(
    String date,
  ) {
    return SetLastCheckSuccessUseCaseProvider(
      date,
    );
  }

  @override
  SetLastCheckSuccessUseCaseProvider getProviderOverride(
    covariant SetLastCheckSuccessUseCaseProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'setLastCheckSuccessUseCaseProvider';
}

/// Use case to set the last check success
///
/// Copied from [SetLastCheckSuccessUseCase].
class SetLastCheckSuccessUseCaseProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SetLastCheckSuccessUseCase,
        void> {
  /// Use case to set the last check success
  ///
  /// Copied from [SetLastCheckSuccessUseCase].
  SetLastCheckSuccessUseCaseProvider(
    String date,
  ) : this._internal(
          () => SetLastCheckSuccessUseCase()..date = date,
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
  FutureOr<void> runNotifierBuild(
    covariant SetLastCheckSuccessUseCase notifier,
  ) {
    return notifier.build(
      date,
    );
  }

  @override
  Override overrideWith(SetLastCheckSuccessUseCase Function() create) {
    return ProviderOverride(
      origin: this,
      override: SetLastCheckSuccessUseCaseProvider._internal(
        () => create()..date = date,
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
  AutoDisposeAsyncNotifierProviderElement<SetLastCheckSuccessUseCase, void>
      createElement() {
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
mixin SetLastCheckSuccessUseCaseRef
    on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `date` of this provider.
  String get date;
}

class _SetLastCheckSuccessUseCaseProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SetLastCheckSuccessUseCase,
        void> with SetLastCheckSuccessUseCaseRef {
  _SetLastCheckSuccessUseCaseProviderElement(super.provider);

  @override
  String get date => (origin as SetLastCheckSuccessUseCaseProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
