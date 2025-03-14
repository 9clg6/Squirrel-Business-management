///
/// Environment of the runtime execution
///
enum Environment {
  /// Mock
  mock,

  /// Dev
  dev,

  /// Staging
  staging,

  /// Production
  prod,

  /// Test
  test,
}

///
/// Configuration/Parameters required by the application.
///
class AppConfig {
  /// App Name
  final String appName;

  ///-------------------------------------------

  ///
  /// Constructor
  ///
  const AppConfig.dev({
    required this.appName,
  });

  ///
  /// Staging constructor
  ///
  const AppConfig.staging({
    required this.appName,
  });

  ///
  /// Production constructor
  ///
  const AppConfig.prod({
    required this.appName,
  });

  ///
  /// Test constructor
  ///
  const AppConfig.test({
    this.appName = 'APP NAME',
  });

  // coverage:ignore-start
  /// Create [AppConfig] from environment variables
  factory AppConfig.fromEnvironment() {
    ///-------------------------------------------

    return const AppConfig.prod(
      appName: 'Squirrel',
    );
  }
  // coverage:ignore-end
}
