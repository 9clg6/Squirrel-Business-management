// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RequestStateCWProxy {
  RequestState isRequestShow(bool isRequestShow);

  RequestState requests(List<Request> requests);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestState(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestState call({
    bool? isRequestShow,
    List<Request>? requests,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRequestState.copyWith.fieldName(...)`
class _$RequestStateCWProxyImpl implements _$RequestStateCWProxy {
  const _$RequestStateCWProxyImpl(this._value);

  final RequestState _value;

  @override
  RequestState isRequestShow(bool isRequestShow) =>
      this(isRequestShow: isRequestShow);

  @override
  RequestState requests(List<Request> requests) => this(requests: requests);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestState(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestState call({
    Object? isRequestShow = const $CopyWithPlaceholder(),
    Object? requests = const $CopyWithPlaceholder(),
  }) {
    return RequestState(
      isRequestShow:
          isRequestShow == const $CopyWithPlaceholder() || isRequestShow == null
              ? _value.isRequestShow
              // ignore: cast_nullable_to_non_nullable
              : isRequestShow as bool,
      requests: requests == const $CopyWithPlaceholder() || requests == null
          ? _value.requests
          // ignore: cast_nullable_to_non_nullable
          : requests as List<Request>,
    );
  }
}

extension $RequestStateCopyWith on RequestState {
  /// Returns a callable class that can be used as follows: `instanceOfRequestState.copyWith(...)` or like so:`instanceOfRequestState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestStateCWProxy get copyWith => _$RequestStateCWProxyImpl(this);
}
