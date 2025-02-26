// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RequestCWProxy {
  Request name(String? name);

  Request destination(String? destination);

  Request description(String? description);

  Request date(DateTime? date);

  Request parameters(Map<String, String>? parameters);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Request(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Request(...).copyWith(id: 12, name: "My name")
  /// ````
  Request call({
    String? name,
    String? destination,
    String? description,
    DateTime? date,
    Map<String, String>? parameters,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRequest.copyWith.fieldName(...)`
class _$RequestCWProxyImpl implements _$RequestCWProxy {
  const _$RequestCWProxyImpl(this._value);

  final Request _value;

  @override
  Request name(String? name) => this(name: name);

  @override
  Request destination(String? destination) => this(destination: destination);

  @override
  Request description(String? description) => this(description: description);

  @override
  Request date(DateTime? date) => this(date: date);

  @override
  Request parameters(Map<String, String>? parameters) =>
      this(parameters: parameters);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Request(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Request(...).copyWith(id: 12, name: "My name")
  /// ````
  Request call({
    Object? name = const $CopyWithPlaceholder(),
    Object? destination = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? parameters = const $CopyWithPlaceholder(),
  }) {
    return Request(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      destination: destination == const $CopyWithPlaceholder()
          ? _value.destination
          // ignore: cast_nullable_to_non_nullable
          : destination as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      parameters: parameters == const $CopyWithPlaceholder()
          ? _value.parameters
          // ignore: cast_nullable_to_non_nullable
          : parameters as Map<String, String>?,
    );
  }
}

extension $RequestCopyWith on Request {
  /// Returns a callable class that can be used as follows: `instanceOfRequest.copyWith(...)` or like so:`instanceOfRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestCWProxy get copyWith => _$RequestCWProxyImpl(this);
}
