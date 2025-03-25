/// Environment field
enum EnvField {
  /// Supabase URL
  supabaseUrl('SUPABASE_URL'),

  /// Supabase Anon Key
  supabaseAnonKey('SUPABASE_ANON_KEY');

  /// Constructor
  const EnvField(this.path);

  /// Path
  final String path;
}
