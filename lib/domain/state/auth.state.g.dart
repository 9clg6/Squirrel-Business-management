// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthStateCWProxy {
  AuthState isUserAuthenticated(bool isUserAuthenticated);

  AuthState isInitialized(bool isInitialized);

  AuthState licenseId(String? licenseId);

  AuthState expirationDate(DateTime? expirationDate);

  AuthState isAppLocked(bool isAppLocked);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthState call({
    bool? isUserAuthenticated,
    bool? isInitialized,
    String? licenseId,
    DateTime? expirationDate,
    bool? isAppLocked,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthState.copyWith.fieldName(...)`
class _$AuthStateCWProxyImpl implements _$AuthStateCWProxy {
  const _$AuthStateCWProxyImpl(this._value);

  final AuthState _value;

  @override
  AuthState isUserAuthenticated(bool isUserAuthenticated) =>
      this(isUserAuthenticated: isUserAuthenticated);

  @override
  AuthState isInitialized(bool isInitialized) =>
      this(isInitialized: isInitialized);

  @override
  AuthState licenseId(String? licenseId) => this(licenseId: licenseId);

  @override
  AuthState expirationDate(DateTime? expirationDate) =>
      this(expirationDate: expirationDate);

  @override
  AuthState isAppLocked(bool isAppLocked) => this(isAppLocked: isAppLocked);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthState call({
    Object? isUserAuthenticated = const $CopyWithPlaceholder(),
    Object? isInitialized = const $CopyWithPlaceholder(),
    Object? licenseId = const $CopyWithPlaceholder(),
    Object? expirationDate = const $CopyWithPlaceholder(),
    Object? isAppLocked = const $CopyWithPlaceholder(),
  }) {
    return AuthState(
      isUserAuthenticated:
          isUserAuthenticated == const $CopyWithPlaceholder() ||
                  isUserAuthenticated == null
              ? _value.isUserAuthenticated
              // ignore: cast_nullable_to_non_nullable
              : isUserAuthenticated as bool,
      isInitialized:
          isInitialized == const $CopyWithPlaceholder() || isInitialized == null
              ? _value.isInitialized
              // ignore: cast_nullable_to_non_nullable
              : isInitialized as bool,
      licenseId: licenseId == const $CopyWithPlaceholder()
          ? _value.licenseId
          // ignore: cast_nullable_to_non_nullable
          : licenseId as String?,
      expirationDate: expirationDate == const $CopyWithPlaceholder()
          ? _value.expirationDate
          // ignore: cast_nullable_to_non_nullable
          : expirationDate as DateTime?,
      isAppLocked:
          isAppLocked == const $CopyWithPlaceholder() || isAppLocked == null
              ? _value.isAppLocked
              // ignore: cast_nullable_to_non_nullable
              : isAppLocked as bool,
    );
  }
}

extension $AuthStateCopyWith on AuthState {
  /// Returns a callable class that can be used as follows: `instanceOfAuthState.copyWith(...)` or like so:`instanceOfAuthState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthStateCWProxy get copyWith => _$AuthStateCWProxyImpl(this);
}
