import 'dart:convert';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:init/data/model/remote/login_result.remote_model.dart';
import 'package:init/data/remote_data_source/authentication.data_source.dart';
import 'package:init/foundation/enums/function.enum.dart';

class AuthenticationDataSourceImpl extends AuthenticationDataSource {
  @override
  Future<LoginResultRemoteModel> login(String licenseKey) async {
    try {
      final callable = FirebaseFunctions.instance.httpsCallable(
        Functions.login.name,
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 30),
        ),
      );

      // Vérifiez que la licenseKey n'est pas vide ou nulle
      if (licenseKey.isEmpty) {
        throw Exception('La clé de licence est vide.');
      }

      // Construction du payload
      final Map<String, dynamic> payload = {
        'licenseKey': licenseKey.trim(),
      };

      // Appel de la fonction Cloud
      final result = await callable.call(jsonEncode(payload));

      final bool isValid = result.data['valid'] as bool? ?? false;
      return LoginResultRemoteModel(
        valid: isValid,
        licenseKey: licenseKey,
        expirationDate: DateTime.parse(result.data['expirationDate']),
      );
    } catch (e) {
      log('Erreur détaillée dans login: $e');
      if (e is FirebaseFunctionsException) {
        log('Code Firebase: ${e.code}');
        log('Message Firebase: ${e.message}');
        log('Détails Firebase: ${e.details}');
      }
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
  Future<bool> checkValidity(String licenseKey) async {
    try {
      final callable = FirebaseFunctions.instance.httpsCallable(
        Functions.checkValidity.name,
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 30),
        ),
      );

      // Construction du payload
      final Map<String, dynamic> payload = {
        'licenseKey': licenseKey.trim(),
      };

      // Appel de la fonction Cloud
      final result = await callable.call(jsonEncode(payload));
      return result.data['valid'] as bool? ?? false;
    } catch (e) {
      log('Erreur détaillée dans checkValidity: $e');
      if (e is FirebaseFunctionsException) {
        log('Code Firebase: ${e.code}');
        log('Message Firebase: ${e.message}');
        log('Détails Firebase: ${e.details}');
      }
      return false;
    }
  }
}
