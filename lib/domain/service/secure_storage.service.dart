import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.service.g.dart';

/// [SecureStorageService]
@Riverpod(
  keepAlive: true,
  dependencies: [],
)
class SecureStorageService extends _$SecureStorageService {
  /// Encrypted key
  static const String _encryptionKey = 'encryption_key';
  String? _cachedKey;
  bool _isInitialized = false;

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    wOptions: WindowsOptions(),
    mOptions: MacOsOptions(
      synchronizable: true,
      accessibility: KeychainAccessibility.unlocked,
      accountName: 'squirrel_app_keychain',
    ),
  );

  /// Build
  /// @return [Future<String>] encryption key
  @override
  Future<String> build() async {
    if (_isInitialized && _cachedKey != null) {
      return _cachedKey!;
    }

    await _initialize();
    return _cachedKey!;
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;
    
    log('🔌 Initializing SecureStorageService');
    
    try {
      _cachedKey = await _storage.read(key: _encryptionKey);

      if (_cachedKey == null) {
        // Génération d'une clé sécurisée de 32 bytes (256 bits)
        final List<int> secureKey = Hive.generateSecureKey();
        _cachedKey = base64Encode(secureKey);
        await _storage.write(key: _encryptionKey, value: _cachedKey);
        log('🔌 Nouvelle clé de chiffrement générée');
      }

      _isInitialized = true;
      log('🔌 SecureStorageService initialized');
    } catch (e) {
      log('Erreur lors de l\'initialisation de SecureStorageService: $e');
      rethrow;
    }
  }
}
