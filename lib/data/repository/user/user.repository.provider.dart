import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/user/impl/user.local.data_source.impl.dart';
import 'package:squirrel/data/repository/user/user.repository.impl.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';

part 'user.repository.provider.g.dart';

/// [UserRepository] provider
/// @param [ref] ref
/// @return [Future<UserRepository>] user repository
///
@riverpod
Future<UserRepository> userRepository(Ref ref) async {
  return UserRepositoryImpl(
    await ref.watch(userLocalDataSourceImplProvider.future),
  );
}
