import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/security/impl/security.local.data_source.impl.dart';
import 'package:squirrel/data/local_data_source/security/security.local.data_source.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';

part 'security.local.data_source.provider.g.dart';

/// @param [ref] ref
/// @return [SecurityLocalDataSource] security local data source
///
@riverpod
Future<SecurityLocalDataSource> securityLocalDataSourceImpl(Ref ref) async {
  final HiveSecureStorageService? secureStorageService =
      await ref.watch(hiveSecureStorageServiceProvider.future);

  return SecurityLocalDataSourceImpl(secureStorageService);
}
