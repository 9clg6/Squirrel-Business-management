import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/logger.service.dart';

part 'connectivity.service.g.dart';

/// Service pour gérer la connectivité réseau
@Riverpod()
class ConnectivityService extends _$ConnectivityService {
  /// Vérifie si l'appareil a une connexion internet active
  Future<bool> hasInternetConnection() async {
    try {
      final List<ConnectivityResult> results =
          await Connectivity().checkConnectivity();

      if (results.isEmpty) {
        return false;
      }

      final ConnectivityResult connectivityResult = results.first;
      LoggerService.instance.i('Statut de la connexion: $connectivityResult');

      return connectivityResult != ConnectivityResult.none;
    } on Exception catch (e) {
      LoggerService.instance.e(
        'Erreur lors de la vérification de la connexion internet: $e',
      );
      return false;
    }
  }

  @override
  FutureOr<ConnectivityService> build() {
    return ConnectivityService();
  }
}
