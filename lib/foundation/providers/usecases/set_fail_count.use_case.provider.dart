import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/set_fail_count.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/security.repository.provider.dart';

part 'set_fail_count.use_case.provider.g.dart';

/// Provider for SetFailCountUseCase
/// @param [ref] ref
/// @param [count] the count
/// @return [Future<void>]
///
@riverpod
Future<void> setFailCountUseCase(Ref ref, {required int count}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return SetFailCountUseCase(repository: repository).execute(count);
}
