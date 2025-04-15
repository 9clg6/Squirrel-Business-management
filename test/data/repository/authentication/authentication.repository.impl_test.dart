import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';
import 'package:squirrel/data/remote_data_source/authentication/authentication.data_source.dart';
import 'package:squirrel/data/repository/authentification/authentication.repository.impl.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';

class MockAuthenticationDataSource extends Mock
    implements AuthenticationDataSource {}

void main() {
  /// Mock
  late AuthenticationRepositoryImpl repository;
  late MockAuthenticationDataSource mockAuthenticationDataSource;

  /// Test License Key
  const String testLicenseKey = 'testLicenseKey';

  /// Setup
  setUpAll(() {
    log('🦕 Setup AuthenticationRepositoryImpl Tests');
    mockAuthenticationDataSource = MockAuthenticationDataSource();
    repository = AuthenticationRepositoryImpl(mockAuthenticationDataSource);
  });

  tearDownAll(() {
    log('🦕🦕🦕 Teardown AuthenticationRepositoryImpl Tests');
  });

  /// Tests
  group(' AuthenticationRepositoryImpl Tests', () {
    log('🦕🦕🦕 Start AuthenticationRepositoryImpl Tests');

    /// Login
    test('checkValidity with valid license key', () async {
      log('🦕 Start "checkValidity with valid license key" test');

      // 1. Create the expected RemoteModel returned by the data source
      final DateTime expirationDate = DateTime.now().add(
        const Duration(days: 30),
      );
      final CheckValidityRemoteModel remoteModel = CheckValidityRemoteModel(
        valid: true,
        expirationDate: expirationDate,
      );

      // 2. Mock the DATA SOURCE method to return the RemoteModel
      when(() => mockAuthenticationDataSource.checkValidity(testLicenseKey))
          .thenAnswer((_) async => remoteModel);

      // 3. Call the REPOSITORY method (the actual code being tested)
      final CheckValidityEntity result =
          await repository.checkValidity(testLicenseKey);

      // 4. Assert the result (Entity) mapped by the repository
      expect(result.valid, isTrue);
      expect(result.expirationDate, equals(expirationDate));

      // 5. Verify the DATA SOURCE method was called
      verify(
        () => mockAuthenticationDataSource.checkValidity(testLicenseKey),
      ).called(1);

      log('🦕💤 End "checkValidity with valid license key" test');
    });

    test('checkValidity with empty license key should throw ArgumentError',
        () async {
      log('🦕 Start "checkValidity with empty license key" test');

      final ArgumentError argumentError = ArgumentError(
        'La clé de licence ne peut pas être vide.',
      );

      when(
        () => mockAuthenticationDataSource.checkValidity(''),
      ).thenThrow(argumentError);

      expect(
        () async => repository.checkValidity(''),
        throwsA(isA<ArgumentError>()),
      );

      verify(() => mockAuthenticationDataSource.checkValidity('')).called(1);

      log('🦕💤 End "checkValidity with empty license key" test');
    });

    test('checkValidity with invalid license key', () async {
      log('🦕 Start "checkValidity with invalid license key" test');

      final DateTime expirationDate =
          DateTime.now().add(const Duration(days: 30));
      final CheckValidityRemoteModel remoteModel = CheckValidityRemoteModel(
        valid: false,
        expirationDate: expirationDate,
      );
      when(
        () => mockAuthenticationDataSource.checkValidity(testLicenseKey),
      ).thenAnswer(
        (_) async => remoteModel,
      );

      final CheckValidityEntity actualEntity =
          await repository.checkValidity(testLicenseKey);

      expect(actualEntity.valid, isFalse);
      expect(actualEntity.expirationDate, expirationDate);

      verify(() => mockAuthenticationDataSource.checkValidity(testLicenseKey))
          .called(1);

      log('🦕💤 End "checkValidity with invalid license key" test');
    });
  });
}
