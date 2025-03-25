import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/foundation/enums/env_field.enum.dart';
import 'package:squirrel/foundation/utils/logger.util.dart';

part 'env.g.dart';

/// Environment variables
@Riverpod(keepAlive: true)
class EnvService extends _$EnvService {
  bool _isInitialized = false;

  /// Build
  ///
  @override
  Future<EnvService> build() async {
    if (!_isInitialized) {
      try {
        await dotenv.load();
        logInfo('Fichier .env chargé avec succès');
      } on Exception catch (e, stackTrace) {
        logException(
          e,
          stackTrace,
          'Erreur lors du chargement du fichier .env',
        );
      }
      _isInitialized = true;
    }
    return EnvService();
  }

  /// Supabase URL
  ///
  String get supabaseUrl => dotenv.env[EnvField.supabaseUrl.path] ?? '';

  /// Supabase Anon Key
  ///
  String get supabaseAnonKey => dotenv.env[EnvField.supabaseAnonKey.path] ?? '';
}
