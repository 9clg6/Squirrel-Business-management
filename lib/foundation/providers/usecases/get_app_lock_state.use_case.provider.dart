import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/get_app_lock_state.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/security.repository.provider.dart';

part 'get_app_lock_state.use_case.provider.g.dart';

/// Provider for GetAppLockStateUseCase
/// @param [ref] ref
/// @return [Future<bool>] if the app is locked
///
@riverpod
Future<bool> getAppLockStateUseCase(Ref ref) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return GetAppLockStateUseCase(repository: repository).execute();
}
