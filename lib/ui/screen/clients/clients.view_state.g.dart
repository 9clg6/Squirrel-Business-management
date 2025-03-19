// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClientsScreenStateCWProxy {
  ClientsScreenState loading(bool loading);

  ClientsScreenState selectedClient(Client? selectedClient);

  ClientsScreenState clients(List<Client> clients);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClientsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClientsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  ClientsScreenState call({
    bool? loading,
    Client? selectedClient,
    List<Client>? clients,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClientsScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClientsScreenState.copyWith.fieldName(...)`
class _$ClientsScreenStateCWProxyImpl implements _$ClientsScreenStateCWProxy {
  const _$ClientsScreenStateCWProxyImpl(this._value);

  final ClientsScreenState _value;

  @override
  ClientsScreenState loading(bool loading) => this(loading: loading);

  @override
  ClientsScreenState selectedClient(Client? selectedClient) =>
      this(selectedClient: selectedClient);

  @override
  ClientsScreenState clients(List<Client> clients) => this(clients: clients);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClientsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClientsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  ClientsScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
    Object? selectedClient = const $CopyWithPlaceholder(),
    Object? clients = const $CopyWithPlaceholder(),
  }) {
    return ClientsScreenState(
      loading: loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
      selectedClient: selectedClient == const $CopyWithPlaceholder()
          ? _value.selectedClient
          // ignore: cast_nullable_to_non_nullable
          : selectedClient as Client?,
      clients: clients == const $CopyWithPlaceholder() || clients == null
          ? _value.clients
          // ignore: cast_nullable_to_non_nullable
          : clients as List<Client>,
    );
  }
}

extension $ClientsScreenStateCopyWith on ClientsScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfClientsScreenState.copyWith(...)` or like so:`instanceOfClientsScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClientsScreenStateCWProxy get copyWith =>
      _$ClientsScreenStateCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `ClientsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClientsScreenState(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  ClientsScreenState copyWithNull({
    bool selectedClient = false,
  }) {
    return ClientsScreenState(
      loading: loading,
      selectedClient: selectedClient == true ? null : this.selectedClient,
      clients: clients,
    );
  }
}
