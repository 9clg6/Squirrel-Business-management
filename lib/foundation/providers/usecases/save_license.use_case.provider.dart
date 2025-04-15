import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';
import 'package:squirrel/domain/use_case/save_license.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/user.repository.provider.dart';

part 'save_license.use_case.provider.g.dart';

/// Provider for SaveLicenseUseCase
/// @param [ref] ref
/// @param [license] license
/// @return [Future<void>] void
///
@riverpod
Future<void> saveLicenseUseCase(
  Ref ref, {
  required LoginResult license,
}) async {
  final UserRepository repository = await ref.watch(
    userRepositoryProvider.future,
  );
  
  return SaveLicenseUseCase(repository: repository).execute(license);
}
