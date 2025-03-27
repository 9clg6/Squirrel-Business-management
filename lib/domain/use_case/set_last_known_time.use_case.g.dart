// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_last_known_time.use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setLastKnownTimeUseCaseHash() =>
    r'ae463ff9569504b7bb05d4f5b733e82101ae7eda';

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

abstract class _$SetLastKnownTimeUseCase
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final DateTime date;

  FutureOr<void> build(
    DateTime date,
  );
}

/// Use case to set the last known time
///
/// Copied from [SetLastKnownTimeUseCase].
@ProviderFor(SetLastKnownTimeUseCase)
const setLastKnownTimeUseCaseProvider = SetLastKnownTimeUseCaseFamily();

/// Use case to set the last known time
///
/// Copied from [SetLastKnownTimeUseCase].
class SetLastKnownTimeUseCaseFamily extends Family<AsyncValue<void>> {
  /// Use case to set the last known time
  ///
  /// Copied from [SetLastKnownTimeUseCase].
  const SetLastKnownTimeUseCaseFamily();

  /// Use case to set the last known time
  ///
  /// Copied from [SetLastKnownTimeUseCase].
  SetLastKnownTimeUseCaseProvider call(
    DateTime date,
  ) {
    return SetLastKnownTimeUseCaseProvider(
      date,
    );
  }

  @override
  SetLastKnownTimeUseCaseProvider getProviderOverride(
    covariant SetLastKnownTimeUseCaseProvider provider,
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
  String? get name => r'setLastKnownTimeUseCaseProvider';
}

/// Use case to set the last known time
///
/// Copied from [SetLastKnownTimeUseCase].
class SetLastKnownTimeUseCaseProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SetLastKnownTimeUseCase,
        void> {
  /// Use case to set the last known time
  ///
  /// Copied from [SetLastKnownTimeUseCase].
  SetLastKnownTimeUseCaseProvider(
    DateTime date,
  ) : this._internal(
          () => SetLastKnownTimeUseCase()..date = date,
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
  FutureOr<void> runNotifierBuild(
    covariant SetLastKnownTimeUseCase notifier,
  ) {
    return notifier.build(
      date,
    );
  }

  @override
  Override overrideWith(SetLastKnownTimeUseCase Function() create) {
    return ProviderOverride(
      origin: this,
      override: SetLastKnownTimeUseCaseProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SetLastKnownTimeUseCase, void>
      createElement() {
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
mixin SetLastKnownTimeUseCaseRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _SetLastKnownTimeUseCaseProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SetLastKnownTimeUseCase,
        void> with SetLastKnownTimeUseCaseRef {
  _SetLastKnownTimeUseCaseProviderElement(super.provider);

  @override
  DateTime get date => (origin as SetLastKnownTimeUseCaseProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
