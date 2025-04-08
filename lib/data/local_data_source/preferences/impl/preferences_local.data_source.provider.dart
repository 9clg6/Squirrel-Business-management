import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/preferences/impl/preferences_local.data_source.impl.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';

part 'preferences_local.data_source.provider.g.dart';

/// [PreferencesLocalDataSourcesImpl] provider
/// @param [ref] ref
/// @return [PreferencesLocalDataSourcesImpl] preferences local data source impl
///
@riverpod
Future<PreferencesLocalDataSourcesImpl> preferencesLocalDataSourcesImpl(
  Ref ref,
) async {
  final HiveSecureStorageService secureStorageService =
      await ref.watch(hiveSecureStorageServiceProvider.future);

  return PreferencesLocalDataSourcesImpl(secureStorageService);
}
