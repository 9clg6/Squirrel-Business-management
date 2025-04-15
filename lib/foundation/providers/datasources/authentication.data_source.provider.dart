import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/remote_data_source/authentication/authentication.data_source.dart';
import 'package:squirrel/data/remote_data_source/authentication/impl/authentication.data_source.impl.dart';

part 'authentication.data_source.provider.g.dart';

/// [AuthenticationDataSource] provider
/// @param [ref] ref
/// @return [AuthenticationDataSource] authentication data source
///
@riverpod
AuthenticationDataSource authenticationDataSource(Ref ref) {
  return AuthenticationDataSourceImpl();
}
