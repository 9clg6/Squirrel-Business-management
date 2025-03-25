import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';
import 'package:squirrel/data/model/remote/login_result.remote_model.dart';
import 'package:squirrel/data/remote_data_source/authentication.data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication.data_source.impl.g.dart';

/// [AuthenticationDataSourceImpl]
@Riverpod(
  dependencies: <Object>[],
)
class AuthenticationDataSourceImpl extends _$AuthenticationDataSourceImpl
    implements AuthenticationDataSource {
  /// Injector
  ///
  @override
  AuthenticationDataSourceImpl build() {
    return AuthenticationDataSourceImpl();
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [Future<LoginResultRemoteModel>] login result remote model
  ///
  @override
  Future<LoginResultRemoteModel> login(String licenseKey) async {
    try {
      // Vérifiez que la licenseKey n'est pas vide ou nulle
      if (licenseKey.isEmpty) {
        throw Exception('La clé de licence est vide.');
      }

      final FunctionResponse result =
          await Supabase.instance.client.functions.invoke(
        'login',
        body: <String, String>{
          'licenseKey': licenseKey.trim(),
        },
      );

      return LoginResultRemoteModel.fromJson(
        result.data as Map<String, dynamic>,
      );
    } on Exception catch (e) {
      log('Erreur détaillée dans login: $e');
      return LoginResultRemoteModel(
        valid: false,
        licenseKey: '',
        expirationDate: null,
      );
    }
  }

  /// Check validity of license
  /// @param [licenseKey] license key
  /// @return [LoginResultRemoteModel] login result remote model
  ///
  @override
  Future<CheckValidityRemoteModel> checkValidity(String licenseKey) async {
    try {
      final FunctionResponse result =
          await Supabase.instance.client.functions.invoke(
        'checkValidity',
        body: <String, String>{
          'licenseKey': licenseKey.trim(),
        },
      );

      return CheckValidityRemoteModel.fromJson(
        result.data as Map<String, dynamic>,
      );
    } on Exception catch (e) {
      log('Erreur détaillée dans checkValidity: $e');
      return CheckValidityRemoteModel(
        valid: false,
        expirationDate: DateTime.now(),
      );
    }
  }
}
