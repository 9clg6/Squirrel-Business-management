import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

part 'hive_secure_storage.g.dart';

/// [HiveSecureStorage]
/// Use it when you want to save secured data that won't be backed up by the system.
@Riverpod(
  keepAlive: true,
  dependencies: [
    SecureStorageService,
  ],
)
class HiveSecureStorage extends _$HiveSecureStorage
    implements StorageInterface<String?> {
  /// Hive box
  late final Box<String> _box;

  /// Box name
  static String get _boxName => r'hive_local_storage';

  /// Constructor
  /// @param [box] box
  ///
  HiveSecureStorage._(this._box);
  HiveSecureStorage();

  /// Build
  /// @param [secureStorageService] secure storage service
  /// @return [Future<HiveSecureStorage>] hive secure storage
  ///
  @override
  Future<HiveSecureStorage> build() async {
    return HiveSecureStorage._(
      await Hive.openBox<String>(
        _boxName,
        encryptionCipher: HiveAesCipher(
          _keyFromString(ref.watch(secureStorageServiceProvider).value!),
        ),
      ),
    );
  }

  /// Get list of int from [encryptionKey]
  /// @param [encryptionKey] encryption key
  /// @return [List<int>] list of int
  ///
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
  /// @param [key] key
  /// @return [Future<String?>] data
  ///
  @override
  Future<String?> get(String key) async => _box.get(key);

  /// Delete all data from storage
  /// @return [Future<void>] void
  ///
  @override
  Future<void> deleteAll() => _box.deleteFromDisk();

  /// Clear all data from storage
  /// @return [Future<void>] void
  ///
  @override
  Future<void> clearAll() => _box.clear();

  /// Check if the storage contains [key]
  /// @param [key] key
  /// @return [Future<bool>] true if the storage contains [key], false otherwise
  ///
  @override
  Future<bool> contains(String key) async => _box.containsKey(key);

  /// Get all data from storage
  /// @return [Future<List<String?>>] list of data
  ///
  @override
  Future<List<String?>> getAll() async => _box.values.toList();

  /// Remove a string value from storage
  /// @param [key] key
  /// @return [Future<void>] void
  ///
  @override
  Future<void> remove(String key) => _box.delete(key);

  /// Set a string value in storage
  /// @param [key] key
  /// @param [value] value
  /// @return [Future<void>] void
  ///
  @override
  Future<void> set(String key, String value) => _box.put(key, value);
}
