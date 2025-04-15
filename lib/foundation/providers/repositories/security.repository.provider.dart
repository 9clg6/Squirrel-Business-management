import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/security/security.local.data_source.dart';
import 'package:squirrel/data/repository/security/security.repository.impl.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/foundation/providers/security/security.local.data_source.provider.dart';

part 'security.repository.provider.g.dart';

/// [SecurityRepositoryImpl]
/// @param [ref] ref
/// @return [SecurityRepository] security repository
///
@riverpod
Future<SecurityRepository> securityRepositoryImpl(Ref ref) async {
  final SecurityLocalDataSource localDataSource =
      await ref.watch(securityLocalDataSourceImplProvider.future);

  return SecurityRepositoryImpl(localDataSource);
}
