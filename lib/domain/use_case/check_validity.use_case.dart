import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/auth/impl/authentication.repository.impl.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/use_case/abstraction/use_case_abs.dart';

part 'check_validity.use_case.g.dart';

/// [CheckValidityUseCase]
@Riverpod(
  dependencies: [
    AuthenticationRepositoryImpl,
  ],
)
class CheckValidityUseCase extends _$CheckValidityUseCase
    implements UseCaseWithParams<Future<CheckValidityEntity>, String> {
  @override
  CheckValidityUseCase build() {
    return CheckValidityUseCase();
  }
  
  /// Execute use case
  /// @param [params] params
  /// @return [CheckValidityEntity] check validity entity
  ///
  @override
  Future<CheckValidityEntity> execute(String params) async {
    return await ref
        .read(authenticationRepositoryImplProvider.notifier)
        .checkValidity(params);
  }
}
