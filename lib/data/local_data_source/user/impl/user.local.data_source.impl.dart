import 'dart:convert';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/user/user.local.data_source.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

part 'user.local.data_source.impl.g.dart';

/// [UserLocalDataSourceImpl]

@Riverpod(
  dependencies: <Object>[
    HiveSecureStorageService,
  ],
)
class UserLocalDataSourceImpl extends _$UserLocalDataSourceImpl
    implements UserLocalDataSource {
  static const String _license = 'licenseKey';

  StorageInterface<dynamic>? _secureStorageService;

  @override
  Future<UserLocalDataSourceImpl> build() async {
    _secureStorageService =
        await ref.watch(hiveSecureStorageServiceProvider.future);

    return UserLocalDataSourceImpl();
  }

  /// Get licence
  /// @return [Future<LoginResultLocalModel>] login result local model
  ///
  @override
  Future<LoginResultLocalModel?> getLicence() async {
    try {
      // S'assurer que le service de stockage est initialisé
      if (_secureStorageService == null) {
        log('⚠️ Secure storage service not initialized when getting license');
        _secureStorageService = await ref.watch(
          hiveSecureStorageServiceProvider.future,
        );
      }

      final String? license =
          await _secureStorageService?.get(_license) as String?;

      if (license == null) {
        log('⚠️ No license found in secure storage');
        return null;
      }

      log('✅ License found in secure storage, deserializing');
      return LoginResultLocalModel.fromJson(
        jsonDecode(license) as Map<String, dynamic>,
      );
    } on Exception catch (e) {
      log('❌ Error while retrieving license: $e');
      return null;
    }
  }

  /// Save licence
  /// @param [loginResultLocalModel] login result local model
  /// @return [Future<void>] void
  ///
  @override
  Future<void> saveLicense(LoginResultLocalModel loginResultLocalModel) async {
    await _secureStorageService?.set(
      _license,
      jsonEncode(loginResultLocalModel.toJson()),
    );
  }
}
