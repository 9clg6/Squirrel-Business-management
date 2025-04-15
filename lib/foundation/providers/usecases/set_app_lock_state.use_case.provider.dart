import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/set_app_lock_state.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/security.repository.provider.dart';

part 'set_app_lock_state.use_case.provider.g.dart';

/// Provider for SetAppLockStateUseCase
@riverpod
Future<void> setAppLockStateUseCase(
  Ref ref, {
  required bool isLocked,
}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return SetAppLockStateUseCase(
    repository: repository,
  ).execute(isLocked);
}
