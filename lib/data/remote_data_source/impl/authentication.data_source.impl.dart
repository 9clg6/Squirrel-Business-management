import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:init/data/remote_data_source/authentication.data_source.dart';
import 'package:init/foundation/enums/function.enum.dart';

class AuthenticationDataSourceImpl extends AuthenticationDataSource {
  @override
  Future<bool> login(String licenseKey) async {
    try {
      final callable = FirebaseFunctions.instance.httpsCallable(
        Functions.verifyLicenseKey.name,
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
      return isValid;
    } catch (e) {
      print('Erreur détaillée dans login: $e');
      if (e is FirebaseFunctionsException) {
        print('Code Firebase: ${e.code}');
        print('Message Firebase: ${e.message}');
        print('Détails Firebase: ${e.details}');
      }
      return false;
    }
  }
}
