import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/user/user.repository.impl.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';
import 'package:squirrel/foundation/providers/datasources/user.local.data_source.provider.dart';

part 'user.repository.provider.g.dart';

/// [UserRepository] provider
/// @param [ref] ref
/// @return [Future<UserRepository>] user repository
///
@riverpod
Future<UserRepository> userRepository(Ref ref) async {
  return UserRepositoryImpl(
    await ref.watch(userLocalDataSourceProvider.future),
  );
}
