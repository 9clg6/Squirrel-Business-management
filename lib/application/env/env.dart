import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment variables
///
class EnvService {
  /// Injector
  ///
  static Future<EnvService> injector() async {
    await _init();
    return EnvService();
  }

  /// Supabase URL
  ///
  String get supabaseUrl => dotenv.env['SUPABASE_URL']!;

  /// Supabase Anon Key
  ///
  String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY']!;

  /// Initialize the environment variables
  ///
  static Future<void> _init() async {
    await dotenv.load(fileName: '.env');
  }
}
