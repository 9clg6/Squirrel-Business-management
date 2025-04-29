// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.use_case.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginUseCaseHash() => r'91d88f9dfe7e9d26ab3555c61bba0c3108800925';

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

/// Login Use Case Provider
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<LoginResult>>] result
///
///
/// Copied from [loginUseCase].
@ProviderFor(loginUseCase)
const loginUseCaseProvider = LoginUseCaseFamily();

/// Login Use Case Provider
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<LoginResult>>] result
///
///
/// Copied from [loginUseCase].
class LoginUseCaseFamily extends Family<AsyncValue<ResultState<LoginResult>>> {
  /// Login Use Case Provider
  /// @param [ref] ref
  /// @param [params] params
  /// @return [ResultState<Future<LoginResult>>] result
  ///
  ///
  /// Copied from [loginUseCase].
  const LoginUseCaseFamily();

  /// Login Use Case Provider
  /// @param [ref] ref
  /// @param [params] params
  /// @return [ResultState<Future<LoginResult>>] result
  ///
  ///
  /// Copied from [loginUseCase].
  LoginUseCaseProvider call(
    LoginUseCaseParams params,
  ) {
    return LoginUseCaseProvider(
      params,
    );
  }

  @override
  LoginUseCaseProvider getProviderOverride(
    covariant LoginUseCaseProvider provider,
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
  String? get name => r'loginUseCaseProvider';
}

/// Login Use Case Provider
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<LoginResult>>] result
///
///
/// Copied from [loginUseCase].
class LoginUseCaseProvider
    extends AutoDisposeFutureProvider<ResultState<LoginResult>> {
  /// Login Use Case Provider
  /// @param [ref] ref
  /// @param [params] params
  /// @return [ResultState<Future<LoginResult>>] result
  ///
  ///
  /// Copied from [loginUseCase].
  LoginUseCaseProvider(
    LoginUseCaseParams params,
  ) : this._internal(
          (ref) => loginUseCase(
            ref as LoginUseCaseRef,
            params,
          ),
          from: loginUseCaseProvider,
          name: r'loginUseCaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginUseCaseHash,
          dependencies: LoginUseCaseFamily._dependencies,
          allTransitiveDependencies:
              LoginUseCaseFamily._allTransitiveDependencies,
          params: params,
        );

  LoginUseCaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final LoginUseCaseParams params;

  @override
  Override overrideWith(
    FutureOr<ResultState<LoginResult>> Function(LoginUseCaseRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginUseCaseProvider._internal(
        (ref) => create(ref as LoginUseCaseRef),
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
  AutoDisposeFutureProviderElement<ResultState<LoginResult>> createElement() {
    return _LoginUseCaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginUseCaseProvider && other.params == params;
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
mixin LoginUseCaseRef
    on AutoDisposeFutureProviderRef<ResultState<LoginResult>> {
  /// The parameter `params` of this provider.
  LoginUseCaseParams get params;
}

class _LoginUseCaseProviderElement
    extends AutoDisposeFutureProviderElement<ResultState<LoginResult>>
    with LoginUseCaseRef {
  _LoginUseCaseProviderElement(super.provider);

  @override
  LoginUseCaseParams get params => (origin as LoginUseCaseProvider).params;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
