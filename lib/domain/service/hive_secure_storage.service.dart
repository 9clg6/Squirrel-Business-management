import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

///
/// [HiveSecureStorageService]
///
/// Use it when you want to save secured data that won't be backed up by the system.
class HiveSecureStorageService implements StorageInterface<String?> {
  final Box<String> _box;

  static String get _boxName => r'hive_local_storage';

  HiveSecureStorageService._(this._box);

  /// Static method to create a new instance of [HiveSecureStorageService]
  static Future<HiveSecureStorageService> inject(
    SecureStorageService secureStorageService,
  ) async {
    return HiveSecureStorageService._(
      await Hive.openBox<String>(
        _boxName,
        encryptionCipher:
            HiveAesCipher(_keyFromString(secureStorageService.key)),
      ),
    );
  }

  /// Get list of int from [encryptionKey]
  static List<int> _keyFromString(String encryptionKey) {
    String key = encryptionKey;
    if (key.length > 32) {
      key = key.substring(0, 32);
    } else if (key.length < 32) {
      key = key + key.substring(0, 32 - key.length);
    }
    return utf8.encode(key);
  }

  /// Get data from storage
  @override
  Future<String?> get(String key) async => _box.get(key);

  ///
  @override
  Future<void> deleteAll() => _box.deleteFromDisk();

  ///
  @override
  Future<void> clearAll() => _box.clear();

  @override
  Future<bool> contains(String key) async => _box.containsKey(key);

  @override
  Future<List<String?>> getAll() async => _box.values.toList();

  @override
  Future<void> remove(String key) => _box.delete(key);

  @override
  Future<void> set(String key, String value) => _box.put(key, value);
}
