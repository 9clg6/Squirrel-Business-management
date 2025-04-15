import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/set_last_check_success.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/security.repository.provider.dart';

part 'set_last_check_success.use_case.provider.g.dart';

/// Provider for SetLastCheckSuccessUseCase
/// @param [ref] ref
/// @param [date] the date (as String)
/// @return [Future<void>]
///
@riverpod
Future<void> setLastCheckSuccessUseCase(
  Ref ref, {
  required String date,
}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return SetLastCheckSuccessUseCase(repository: repository).execute(date);
}
