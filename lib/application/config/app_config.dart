import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

/// Configuration/Parameters required by the application.
@Riverpod(keepAlive: true)
class AppConfig extends _$AppConfig {
  /// Constructor
  ///
  AppConfig();

  /// Production constructor
  ///
  AppConfig.prod({
    required this.appName,
  });

  /// Constructor
  ///
  AppConfig.dev({
    required this.appName,
  });

  /// Staging constructor
  ///
  AppConfig.staging({
    required this.appName,
  });

  /// Test constructor
  ///
  AppConfig.test({
    this.appName = 'APP NAME',
  });

  // coverage:ignore-start
  /// Create [AppConfig] from environment variables
  factory AppConfig.fromEnvironment() {
    return AppConfig.prod(
      appName: 'Squirrel',
    );
  }

  /// Build
  ///
  @override
  AppConfig build() {
    return AppConfig.prod(
      appName: 'Squirrel',
    );
  }

  /// App Name
  late final String appName;
  // coverage:ignore-end
}
