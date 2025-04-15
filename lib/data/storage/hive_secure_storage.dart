import 'package:hive/hive.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

/// [HiveSecureStorage]
class HiveSecureStorage implements StorageInterface<String?> {
  /// Constructor
  /// @param [_box] box
  ///
  HiveSecureStorage(this._box);

  /// Hive box
  late final Box<String> _box;

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
