import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/auth/authentication.repository.impl.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/use_case/abstraction/use_case_abs.dart';

part 'login.use_case.g.dart';

/// [LoginUseCase]
@Riverpod(
  dependencies: <Object>[
    AuthenticationRepositoryImpl,
  ],
)
class LoginUseCase extends _$LoginUseCase
    implements UseCaseWithParams<Future<LoginResultEntity>, String> {
  @override
  LoginUseCase build() {
    log('🔌 Initializing LoginUseCase');
    return LoginUseCase();
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [LoginResultEntity] login result entity
  ///
  @override
  Future<LoginResultEntity> execute(String licenseKey) async {
    return ref
        .read(authenticationRepositoryImplProvider.notifier)
        .login(licenseKey);
  }
}
