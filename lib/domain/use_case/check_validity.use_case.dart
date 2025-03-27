import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/authentication.repository.impl.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/use_case/abstraction/use_case_abs.dart';

part 'check_validity.use_case.g.dart';

/// [CheckValidityUseCase]
@Riverpod(
  dependencies: <Object>[
    AuthenticationRepositoryImpl,
  ],
)
class CheckValidityUseCase extends _$CheckValidityUseCase
    implements UseCaseWithParams<Future<CheckValidityEntity>, String> {
  /// Build
  /// @return [CheckValidityUseCase] check validity use case
  ///
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
    return ref
        .read(authenticationRepositoryImplProvider.notifier)
        .checkValidity(params);
  }
}
