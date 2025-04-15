import 'package:squirrel/application/config/app_config.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:squirrel/foundation/utils/logger.util.dart';
import 'package:squirrel/kernel.dart';

/// The main function of the application.
void main() async {
  try {
    logInfo('Application démarrée');

    /// Kernel with app config
    final Kernel kernel = Kernel(
      appConfig: AppConfig.fromEnvironment(),
    );

    /// Bootstrap the kernel
    await kernel.bootstrap();
    await LoggerService.init();

    /// Run the kernel
    kernel.run();
  } catch (e, stackTrace) {
    logException(e, stackTrace, 'Erreur fatale dans main');
    rethrow; // Relancer l'exception pour que Flutter puisse l'afficher
  }
}
