import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

part 'hive_secure_storage.service.g.dart';

/// [HiveSecureStorageService]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    SecureStorageService,
  ],
)

/// Use it when you want to save secured data that won't
///  be backed up by the system.
class HiveSecureStorageService extends _$HiveSecureStorageService
    implements StorageInterface<String?> {
  /// Box
  Box<String>? _box;

  /// Box name
  static const String _boxName = 'hive_local_storage';

  /// Is initialized
  bool _isInitialized = false;

  /// Encryption key
  String? _encryptionKey;

  /// Build
  /// @return [Future<HiveSecureStorageService>] hive secure storage service
  ///
  @override
  Future<HiveSecureStorageService> build() async {
    if (_isInitialized && _box != null) {
      return this;
    }

    await _initialize();
    return this;
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;

    LoggerService.instance.i('🔌 Initializing HiveSecureStorageService');

    try {
      _encryptionKey = await ref.watch(secureStorageServiceProvider.future);
      await _openBox();
      _isInitialized = true;
      LoggerService.instance
          .i('🔌 HiveSecureStorageService initialized successfully');
    } catch (e) {
      LoggerService.instance.e(
        "Erreur lors de l'initialisation de HiveSecureStorageService: $e",
      );
      rethrow;
    }
  }

  Future<void> _openBox() async {
    if (_box != null && _box!.isOpen) return;

    try {
      _box = await Hive.openBox<String>(
        _boxName,
        encryptionCipher: HiveAesCipher(
          base64Decode(_encryptionKey!),
        ),
      );
    } catch (e) {
      if (e.toString().contains('corrupted')) {
        await _handleCorruptedBox();
      } else {
        rethrow;
      }
    }
  }

  Future<void> _handleCorruptedBox() async {
    LoggerService.instance.i('Suppression de la boîte corrompue');
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory boxPath = Directory('${directory.path}/hive/$_boxName');
    if (boxPath.existsSync()) {
      boxPath.deleteSync(recursive: true);
    }

    _box = await Hive.openBox<String>(
      _boxName,
      encryptionCipher: HiveAesCipher(
        base64Decode(_encryptionKey!),
      ),
    );
  }

  /// Ensure box is initialized and return it
  Future<Box<String>> _ensureBox() async {
    if (!_isInitialized || _box == null || !_box!.isOpen) {
      await _initialize();
    }
    return _box!;
  }

  /// Get data from storage
  @override
  Future<String?> get(String key) async {
    try {
      final Box<String> box = await _ensureBox();
      return box.get(key);
    } on Exception catch (e) {
      LoggerService.instance
          .e('Erreur lors de la récupération de la donnée: $e');
      return null;
    }
  }

  /// Delete all data from storage
  @override
  Future<void> deleteAll() async {
    try {
      final Box<String> box = await _ensureBox();
      await box.deleteFromDisk();
    } on Exception catch (e) {
      LoggerService.instance.e('Erreur lors de la suppression des données: $e');
    }
  }

  /// Clear all data from storage
  @override
  Future<void> clearAll() async {
    try {
      final Box<String> box = await _ensureBox();
      await box.clear();
    } on Exception catch (e) {
      LoggerService.instance.e('Erreur lors du nettoyage des données: $e');
    }
  }

  /// Contains key
  @override
  Future<bool> contains(String key) async {
    try {
      final Box<String> box = await _ensureBox();
      return box.containsKey(key);
    } on Exception catch (e) {
      LoggerService.instance.e('Erreur lors de la vérification de la clé: $e');
      return false;
    }
  }

  /// Get all data from storage
  @override
  Future<List<String?>> getAll() async {
    try {
      final Box<String> box = await _ensureBox();
      return box.values.toList();
    } on Exception catch (e) {
      LoggerService.instance
          .e('Erreur lors de la récupération des données: $e');
      return <String?>[];
    }
  }

  /// Remove key
  @override
  Future<void> remove(String key) async {
    try {
      final Box<String> box = await _ensureBox();
      await box.delete(key);
    } on Exception catch (e) {
      LoggerService.instance.e('Erreur lors de la suppression de la clé: $e');
    }
  }

  /// Set key
  @override
  Future<void> set(String key, String value) async {
    try {
      final Box<String> box = await _ensureBox();
      await box.put(key, value);
    } on Exception catch (e) {
      LoggerService.instance
          .e("Erreur lors de l'enregistrement de la donnée: $e");
    }
  }
}
