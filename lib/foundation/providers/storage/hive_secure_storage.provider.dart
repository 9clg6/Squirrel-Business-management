import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/storage/hive_secure_storage.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';

part 'hive_secure_storage.provider.g.dart';

/// [HiveSecureStorage] provider
/// @param [ref] ref
/// @return [Future<HiveSecureStorage>] hive secure storage
///
@riverpod
Future<HiveSecureStorage> hiveSecureStorage(Ref ref) async {
  final String encryptionKey = ref.watch(secureStorageServiceProvider).value!;
  return HiveSecureStorage(
    await Hive.openBox<String>(
      'hive_local_storage',
      encryptionCipher: HiveAesCipher(
        keyFromString(encryptionKey),
      ),
    ),
  );
}

/// Get list of int from [encryptionKey]
/// @param [encryptionKey] encryption key
/// @return [List<int>] list of int
///
List<int> keyFromString(String encryptionKey) {
  String key = encryptionKey;
  if (key.length > 32) {
    key = key.substring(0, 32);
  } else if (key.length < 32) {
    key = key + key.substring(0, 32 - key.length);
  }
  return utf8.encode(key);
}
