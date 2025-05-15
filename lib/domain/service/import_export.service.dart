import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:file_picker/file_picker.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/logger.service.dart';

/// Service for import and export data
class ImportExportService {
  /// Constructor
  /// @param file: The file to export and import data
  ///
  ImportExportService({
    required this.file,
    required this.dataToExport,
    required this.dialogService,
    required this.onImportSuccess,
  });

  // Taille de l'IV pour AES-GCM (12 bytes = 96 bits est recommandé)
  static const int _ivLength = 12;
  // Taille de la clé AES (32 bytes = 256 bits)
  static const int _keyLength = 32;

  /// Dialog service
  final DialogService dialogService;

  /// File
  final File file;

  /// Data to export
  final Map<String, List<Map<String, dynamic>>> dataToExport;

  /// On import success
  final Null Function(
    List<Order> orders,
    List<Customer> customers,
  ) onImportSuccess;

  /// Exporte les données vers un fichier JSON chiffré.
  ///
  /// [data]: Les données à exporter (doivent être sérialisables en JSON).
  /// [file]: Le fichier de destination.
  /// [password]: Le mot de passe utilisé pour générer la clé de chiffrement.
  Future<void> exportData() async {
    try {
      final String jsonData = jsonEncode(dataToExport);
      final Uint8List jsonDataBytes = utf8.encode(jsonData);

      // 2. Préparer le chiffrement
      // Générer une clé AES-256 aléatoire sécurisée
      final enc.Key key = enc.Key.fromSecureRandom(_keyLength);
      // Générer un IV aléatoire sécurisé
      final enc.IV iv = enc.IV.fromSecureRandom(_ivLength);
      final enc.Encrypter encrypter = enc.Encrypter(
        enc.AES(
          key,
          mode: enc.AESMode.gcm,
        ),
      );

      // 3. Chiffrer les données
      final enc.Encrypted encryptedData = encrypter.encryptBytes(
        jsonDataBytes,
        iv: iv,
      );

      // 4. Combiner IV et données chiffrées
      // L'IV est placé au début du fichier pour pouvoir le récupérer
      //  lors du déchiffrement
      final BytesBuilder fileContent = BytesBuilder()
        ..add(iv.bytes) // Ajouter l'IV (12 bytes)
        ..add(encryptedData.bytes); // Ajouter les données chiffrées

      // 5. Écrire dans le fichier
      await file.writeAsBytes(
        fileContent.toBytes(),
        flush: true,
      );

      await dialogService.showExportKeyDialog(
        key: key.base64,
      );
    } catch (e) {
      LoggerService.instance.e("Erreur lors de l'exportation chiffrée: $e");
      rethrow; // Propage l'erreur si nécessaire
    }
  }

  /// Importe et déchiffre les données depuis un fichier JSON chiffré.
  ///
  /// [file]: Le fichier source chiffré.
  /// [password]: Le mot de passe utilisé lors du chiffrement.
  /// Retourne les données déchiffrées et désérialisées
  /// (souvent un Map ou une List).
  Future<dynamic> importData({
    required FilePickerResult? file,
    required String? key,
    required bool? overrideData,
  }) async {
    try {
      if (file == null) {
        throw Exception("Le fichier n'existe pas.");
      }

      // 1. Lire le contenu chiffré du fichier
      final Uint8List fileContent = await File(
        file.files.first.path!,
      ).readAsBytes();

      if (fileContent.length < _ivLength) {
        throw const FormatException(
          'Fichier chiffré invalide ou corrompu (trop court).',
        );
      }

      // 2. Extraire l'IV et les données chiffrées
      final Uint8List ivBytes = fileContent.sublist(0, _ivLength);
      final Uint8List encryptedBytes = fileContent.sublist(_ivLength);

      final enc.IV iv = enc.IV(ivBytes);
      final enc.Encrypted encryptedData = enc.Encrypted(encryptedBytes);

      // 3. Préparer le déchiffrement
      // Décoder la clé Base64 fournie par l'utilisateur
      if (key == null || key.isEmpty) {
        throw ArgumentError('La clé de déchiffrement est manquante.');
      }
      final enc.Key originalKey = enc.Key.fromBase64(key);

      // Vérifier si la longueur de la clé décodée est correcte
      if (originalKey.bytes.length != _keyLength) {
        throw ArgumentError(
          // ignore: lines_longer_than_80_chars w
          'Clé de déchiffrement invalide. La longueur attendue est $_keyLength bytes.',
        );
      }

      final enc.Encrypter encrypter = enc.Encrypter(
        enc.AES(
          originalKey, // Utiliser la clé décodée
          mode: enc.AESMode.gcm,
        ),
      );

      // 4. Déchiffrer les données
      // AES-GCM lève une exception si les données ont été altérées
      //(échec de l'authentification)
      final List<int> decryptedBytes = encrypter.decryptBytes(
        encryptedData,
        iv: iv,
      );

      // 5. Convertir les bytes déchiffrés en chaîne JSON
      final String jsonData = utf8.decode(decryptedBytes);

      // 6. Désérialiser le JSON
      final Map<String, dynamic> data =
          jsonDecode(jsonData) as Map<String, dynamic>;

      // 7. Parser les données désérialisées
      final List<Order> orders = (data['orders'] as List<dynamic>?)
              ?.map(
                (dynamic orderJson) =>
                    Order.fromJson(orderJson as Map<String, dynamic>),
              )
              .toList() ??
          <Order>[];

      final List<Customer> customers = (data['clients'] as List<dynamic>?)
              ?.map(
                (dynamic clientJson) =>
                    Customer.fromJson(clientJson as Map<String, dynamic>),
              )
              .toList() ??
          <Customer>[];

      onImportSuccess(orders, customers);
      return <String, dynamic>{'orders': orders, 'clients': customers};
    } catch (e) {
      LoggerService.instance.e("Erreur lors de l'importation déchiffrée: $e");
      rethrow;
    }
  }
}
