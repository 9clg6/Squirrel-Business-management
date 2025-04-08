import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/preferences/impl/preferences_local.data_source.impl.dart';
import 'package:squirrel/data/local_data_source/preferences/impl/preferences_local.data_source.provider.dart';
import 'package:squirrel/data/repository/preferences/preferences.repository_impl.dart'
    show PreferencesRepositoryImpl;
import 'package:squirrel/domain/repositories/preferences.repository.dart';

part 'preferences.repository.provider.g.dart';

/// [PreferencesRepositoryImpl]
@riverpod
Future<PreferencesRepository> preferencesRepositoryImpl(Ref ref) async {
  final PreferencesLocalDataSourcesImpl localDataSource =
      await ref.watch(preferencesLocalDataSourcesImplProvider.future);

  return PreferencesRepositoryImpl(localDataSource);
}
