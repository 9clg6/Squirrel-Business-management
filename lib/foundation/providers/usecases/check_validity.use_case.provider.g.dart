// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_validity.use_case.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$checkValidityUseCaseHash() =>
    r'1add9795680fbd20fca6deb5b7c306ad35336174';

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

/// Check Validity Use Case Provider
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<CheckValidityEntity>>] result
///
///
/// Copied from [checkValidityUseCase].
@ProviderFor(checkValidityUseCase)
const checkValidityUseCaseProvider = CheckValidityUseCaseFamily();

/// Check Validity Use Case Provider
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<CheckValidityEntity>>] result
///
///
/// Copied from [checkValidityUseCase].
class CheckValidityUseCaseFamily
    extends Family<AsyncValue<ResultState<CheckValidityEntity>>> {
  /// Check Validity Use Case Provider
  /// @param [ref] ref
  /// @param [params] params
  /// @return [ResultState<Future<CheckValidityEntity>>] result
  ///
  ///
  /// Copied from [checkValidityUseCase].
  const CheckValidityUseCaseFamily();

  /// Check Validity Use Case Provider
  /// @param [ref] ref
  /// @param [params] params
  /// @return [ResultState<Future<CheckValidityEntity>>] result
  ///
  ///
  /// Copied from [checkValidityUseCase].
  CheckValidityUseCaseProvider call(
    CheckValidityUseCaseParams params,
  ) {
    return CheckValidityUseCaseProvider(
      params,
    );
  }

  @override
  CheckValidityUseCaseProvider getProviderOverride(
    covariant CheckValidityUseCaseProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'checkValidityUseCaseProvider';
}

/// Check Validity Use Case Provider
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<CheckValidityEntity>>] result
///
///
/// Copied from [checkValidityUseCase].
class CheckValidityUseCaseProvider
    extends AutoDisposeFutureProvider<ResultState<CheckValidityEntity>> {
  /// Check Validity Use Case Provider
  /// @param [ref] ref
  /// @param [params] params
  /// @return [ResultState<Future<CheckValidityEntity>>] result
  ///
  ///
  /// Copied from [checkValidityUseCase].
  CheckValidityUseCaseProvider(
    CheckValidityUseCaseParams params,
  ) : this._internal(
          (ref) => checkValidityUseCase(
            ref as CheckValidityUseCaseRef,
            params,
          ),
          from: checkValidityUseCaseProvider,
          name: r'checkValidityUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkValidityUseCaseHash,
          dependencies: CheckValidityUseCaseFamily._dependencies,
          allTransitiveDependencies:
              CheckValidityUseCaseFamily._allTransitiveDependencies,
          params: params,
        );

  CheckValidityUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final CheckValidityUseCaseParams params;

  @override
  Override overrideWith(
    FutureOr<ResultState<CheckValidityEntity>> Function(
            CheckValidityUseCaseRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckValidityUseCaseProvider._internal(
        (ref) => create(ref as CheckValidityUseCaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ResultState<CheckValidityEntity>>
      createElement() {
    return _CheckValidityUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckValidityUseCaseProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckValidityUseCaseRef
    on AutoDisposeFutureProviderRef<ResultState<CheckValidityEntity>> {
  /// The parameter `params` of this provider.
  CheckValidityUseCaseParams get params;
}

class _CheckValidityUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<ResultState<CheckValidityEntity>>
    with CheckValidityUseCaseRef {
  _CheckValidityUseCaseProviderElement(super.provider);

  @override
  CheckValidityUseCaseParams get params =>
      (origin as CheckValidityUseCaseProvider).params;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
