import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';
import 'package:squirrel/domain/use_case/get_license.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/user.repository.provider.dart';

part 'get_license.use_case.provider.g.dart';

/// Provider for GetLicenseUseCase
/// @param [ref] ref
/// @return [Future<LoginResult?>] login result entity
///
@riverpod
Future<LoginResult?> getLicenseUseCase(Ref ref) async {
  final UserRepository repository = await ref.watch(
    userRepositoryProvider.future,
  );
  
  return GetLicenseUseCase(repository: repository).execute();
}
