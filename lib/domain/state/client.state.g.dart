// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClientStateCWProxy {
  ClientState clients(List<Client> clients);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClientState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClientState(...).copyWith(id: 12, name: "My name")
  /// ````
  ClientState call({
    List<Client>? clients,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClientState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClientState.copyWith.fieldName(...)`
class _$ClientStateCWProxyImpl implements _$ClientStateCWProxy {
  const _$ClientStateCWProxyImpl(this._value);

  final ClientState _value;

  @override
  ClientState clients(List<Client> clients) => this(clients: clients);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClientState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClientState(...).copyWith(id: 12, name: "My name")
  /// ````
  ClientState call({
    Object? clients = const $CopyWithPlaceholder(),
  }) {
    return ClientState(
      clients: clients == const $CopyWithPlaceholder() || clients == null
          ? _value.clients
          // ignore: cast_nullable_to_non_nullable
          : clients as List<Client>,
    );
  }
}

extension $ClientStateCopyWith on ClientState {
  /// Returns a callable class that can be used as follows: `instanceOfClientState.copyWith(...)` or like so:`instanceOfClientState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClientStateCWProxy get copyWith => _$ClientStateCWProxyImpl(this);
}
