import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/get_last_known_time.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/security.repository.provider.dart';

part 'get_last_known_time.use_case.provider.g.dart';

/// Provider for GetLastKnownTimeUseCase
/// @param [ref] ref
/// @return [Future<DateTime>] the last known time
///
@riverpod
Future<DateTime> getLastKnownTimeUseCase(Ref ref) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return GetLastKnownTimeUseCase(
    repository: repository,
  ).execute();
}
