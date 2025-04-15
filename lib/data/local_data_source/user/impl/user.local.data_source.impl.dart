import 'dart:convert';

import 'package:squirrel/data/local_data_source/user/user.local.data_source.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/logger.service.dart';

/// [UserLocalDataSourceImpl]
class UserLocalDataSourceImpl implements UserLocalDataSource {
  /// Constructor
  /// @param [_secureStorageService] secure storage service
  ///
  UserLocalDataSourceImpl(this._secureStorageService);

  static const String _license = 'licenseKey';

  late final HiveSecureStorageService _secureStorageService;

  /// Get licence
  /// @return [Future<LoginResultLocalModel>] login result local model
  ///
  @override
  Future<LoginResultLocalModel?> getLicence() async {
    try {
      final String? license = await _secureStorageService.get(_license);

      if (license == null) {
        LoggerService.instance.w('⚠️ No license found in secure storage');
        return null;
      }

      LoggerService.instance.i(
        '✅ License found in secure storage, deserializing',
      );
      return LoginResultLocalModel.fromJson(
        jsonDecode(license) as Map<String, dynamic>,
      );
    } on Exception catch (e) {
      LoggerService.instance.e('❌ Error while retrieving license: $e');
      return null;
    }
  }

  /// Save licence
  /// @param [loginResultLocalModel] login result local model
  /// @return [Future<void>] void
  ///
  @override
  Future<void> saveLicense(LoginResultLocalModel loginResultLocalModel) async {
    await _secureStorageService.set(
      _license,
      jsonEncode(loginResultLocalModel.toJson()),
    );
  }
}
