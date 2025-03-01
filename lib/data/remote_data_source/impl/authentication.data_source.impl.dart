import 'dart:developer';

import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';
import 'package:squirrel/data/model/remote/login_result.remote_model.dart';
import 'package:squirrel/data/remote_data_source/authentication.data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationDataSourceImpl extends AuthenticationDataSource {
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
        body: {
          'licenseKey': licenseKey.trim(),
        },
      );

      return LoginResultRemoteModel.fromJson(result.data);
    } catch (e) {
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
        body: {
          'licenseKey': licenseKey.trim(),
        },
      );

      return CheckValidityRemoteModel.fromJson(result.data);
    } catch (e) {
      log('Erreur détaillée dans checkValidity: $e');
      return CheckValidityRemoteModel(
        valid: false,
        expirationDate: DateTime.now(),
      );
    }
  }
}
