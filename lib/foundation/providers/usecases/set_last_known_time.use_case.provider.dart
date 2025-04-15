import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/set_last_known_time.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/security.repository.provider.dart';

part 'set_last_known_time.use_case.provider.g.dart';

/// Provider for SetLastKnownTimeUseCase
/// @param [ref] ref
/// @param date [DateTime] the date to set
/// @return [Future<void>] the last known time
///
@riverpod
Future<void> setLastKnownTimeUseCase(
  Ref ref, {
  required DateTime date,
}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return SetLastKnownTimeUseCase(repository: repository).execute(date);
}
