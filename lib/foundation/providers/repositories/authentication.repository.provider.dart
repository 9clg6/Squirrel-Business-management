import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/remote_data_source/authentication/authentication.data_source.dart';
import 'package:squirrel/data/repository/authentification/authentication.repository.impl.dart'
    show AuthenticationRepositoryImpl;
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/foundation/providers/datasources/authentication.data_source.provider.dart';

part 'authentication.repository.provider.g.dart';

/// [AuthenticationRepositoryImpl]
@riverpod
AuthenticationRepository authenticationRepositoryImpl(Ref ref) {
  final AuthenticationDataSource authenticationDataSource =
      ref.watch(authenticationDataSourceProvider);

  return AuthenticationRepositoryImpl(authenticationDataSource);
}
