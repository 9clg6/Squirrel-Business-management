import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';
import 'package:squirrel/data/model/remote/login_result.remote_model.dart';
import 'package:squirrel/data/remote_data_source/authentication/authentication.data_source.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [AuthenticationDataSourceImpl]
class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  /// Factory constructor
  factory AuthenticationDataSourceImpl([SupabaseClient? supabaseClient]) {
    return AuthenticationDataSourceImpl._(
      supabaseClient: supabaseClient ?? Supabase.instance.client,
    );
  }

  /// Constructor
  /// @param [supabaseClient] supabase client
  ///
  AuthenticationDataSourceImpl._({
    required this.supabaseClient,
  });

  /// Supabase client
  final SupabaseClient supabaseClient;

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

      final FunctionResponse result = await supabaseClient.functions.invoke(
        'login',
        body: <String, String>{
          'licenseKey': licenseKey.trim(),
        },
      );

      return LoginResultRemoteModel.fromJson(
        result.data as Map<String, dynamic>,
      );
    } on Exception catch (e) {
      LoggerService.instance.e('Erreur détaillée dans login: $e');
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
    if (licenseKey.isEmpty) {
      throw Exception('La clé de licence est vide.');
    }

    try {
      final FunctionResponse result = await supabaseClient.functions.invoke(
        'checkValidity',
        body: <String, String>{
          'licenseKey': licenseKey.trim(),
        },
      );

      return CheckValidityRemoteModel.fromJson(
        result.data as Map<String, dynamic>,
      );
    } on Exception catch (e) {
      LoggerService.instance.e('Erreur détaillée dans checkValidity: $e');
      return CheckValidityRemoteModel(
        valid: false,
        expirationDate: DateTime.now(),
      );
    }
  }
}
