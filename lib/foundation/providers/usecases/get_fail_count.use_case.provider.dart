
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/get_fail_count.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/security.repository.provider.dart';

part 'get_fail_count.use_case.provider.g.dart';

/// Provider for GetFailCountUseCase
/// @param [ref] ref
/// @return [Future<int>] the fail count
///
@riverpod
Future<int> getFailCountUseCase(Ref ref) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );
  
  return GetFailCountUseCase(repository: repository).execute();
}
