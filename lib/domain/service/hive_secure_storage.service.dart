// ignore_for_file: lines_longer_than_80_chars no

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
)

/// Use it when you want to save secured data that won't
///  be backed up by the system.
class HiveSecureStorageService extends _$HiveSecureStorageService
    implements StorageInterface<String?> {
  /// Default constructor
  ///
  HiveSecureStorageService();

  /// Constructor
  /// @param [String] encryptionKey
  ///
  HiveSecureStorageService.withKey(this._encryptionKey);

  /// Box
  Box<String>? _box;

  /// Box name
  static const String _boxName = 'hive_local_storage';

  /// Encryption key
  late final String _encryptionKey;

  /// Build
  /// @return [Future<HiveSecureStorageService>] hive secure storage service
  ///
  @override
  Future<HiveSecureStorageService> build() async {
    LoggerService.instance.i('🔌 Construction de HiveSecureStorageService');

    // Récupération de la clé de chiffrement
    _encryptionKey = await ref.watch(secureStorageServiceProvider.future);

    // Initialisation explicite
    await _initialize();

    // Ouverture explicite de la box après initialisation
    await _openBox();

    return this;
  }

  Future<void> _initialize() async {
    LoggerService.instance.i('🔌 Initialisation de HiveSecureStorageService');
    // Ici, tu peux ajouter d'autres logiques d'initialisation si nécessaire
  }

  Future<void> _openBox() async {
    if (_box != null && _box!.isOpen) return;

    LoggerService.instance.i('💡 Ouverture de la box $_boxName');
    try {
      _box = await Hive.openBox<String>(
        _boxName,
        encryptionCipher: HiveAesCipher(base64Decode(_encryptionKey)),
      );
      LoggerService.instance.i('✅ Box $_boxName ouverte avec succès');
    } catch (e) {
      LoggerService.instance.e("❌ Erreur lors de l'ouverture de la box : $e");
      if (e.toString().contains('corrupted')) {
        await _handleCorruptedBox();
      } else {
        rethrow;
      }
    }
  }

  Future<void> _handleCorruptedBox() async {
    LoggerService.instance
        .w('⚠️ Box corrompue détectée, suppression en cours...');
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory boxPath = Directory('${directory.path}/hive/$_boxName');
    if (boxPath.existsSync()) {
      boxPath.deleteSync(recursive: true);
      LoggerService.instance.i('✅ Box corrompue supprimée');
    }
    // Réessayer d'ouvrir la box après suppression
    await _openBox();
  }

  /// Ensure box is initialized and return it
  Future<Box<String>> _ensureBox() async {
    if (_box == null || !_box!.isOpen) {
      LoggerService.instance
          .w('⚠️ Box non ouverte, tentative de réouverture...');
      await _openBox();
    }
    return _box!;
  }

  /// Get data from storage
  @override
  Future<String?> get(String key) async {
    try {
      LoggerService.instance.i('Getting data from storage');
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
      LoggerService.instance.i('Deleting all data from storage');
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
      LoggerService.instance.i('Clearing all data from storage');
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
      LoggerService.instance.i('Checking if key exists');
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
      LoggerService.instance.i('Getting all data from storage');
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
