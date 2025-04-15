import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/user/impl/user.local.data_source.impl.dart';
import 'package:squirrel/data/local_data_source/user/user.local.data_source.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';

part 'user.local.data_source.provider.g.dart';

/// [UserLocalDataSource] provider
/// @param [ref] ref
/// @return [Future<UserLocalDataSource>] user local data source
///
@riverpod
Future<UserLocalDataSource> userLocalDataSource(Ref ref) async {
  final HiveSecureStorageService secureStorageService =
      await ref.watch(hiveSecureStorageServiceProvider.future);

  return UserLocalDataSourceImpl(secureStorageService);
}
