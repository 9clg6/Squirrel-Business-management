import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/remote_data_source/impl/authentication.data_source.impl.dart';
import 'package:squirrel/data/repository/authentification/authentication.repository.impl.dart'
    show AuthenticationRepositoryImpl;
import 'package:squirrel/domain/repositories/authentication.repository.dart';

part 'authentication.repository.provider.g.dart';

/// [AuthenticationRepositoryImpl]
@riverpod
AuthenticationRepository authenticationRepositoryImpl(Ref ref) {
  final AuthenticationDataSourceImpl authenticationDataSource =
      ref.watch(authenticationDataSourceImplProvider);

  return AuthenticationRepositoryImpl(authenticationDataSource);
}
