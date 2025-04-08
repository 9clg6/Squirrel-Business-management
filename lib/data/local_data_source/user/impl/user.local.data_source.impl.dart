import 'dart:convert';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/user/user.local.data_source.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';

part 'user.local.data_source.impl.g.dart';

/// [UserLocalDataSourceImpl]

@Riverpod(
  dependencies: <Object>[
    HiveSecureStorageService,
  ],
)
class UserLocalDataSourceImpl extends _$UserLocalDataSourceImpl
    implements UserLocalDataSource {
  /// Default constructor
  /// 
  UserLocalDataSourceImpl();

  /// Constructor
  /// @param [_secureStorageService] secure storage service
  ///
  UserLocalDataSourceImpl._(this._secureStorageService);

  static const String _license = 'licenseKey';

  late final HiveSecureStorageService _secureStorageService;

  @override
  Future<UserLocalDataSourceImpl> build() async {
    final HiveSecureStorageService secureStorageService =
        await ref.watch(hiveSecureStorageServiceProvider.future);

    return UserLocalDataSourceImpl._(secureStorageService);
  }

  /// Get licence
  /// @return [Future<LoginResultLocalModel>] login result local model
  ///
  @override
  Future<LoginResultLocalModel?> getLicence() async {
    try {
      // S'assurer que le service de stockage est initialisé
      final String? license = await _secureStorageService.get(_license);

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
    await _secureStorageService.set(
      _license,
      jsonEncode(loginResultLocalModel.toJson()),
    );
  }
}
