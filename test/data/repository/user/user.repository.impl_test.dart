import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:squirrel/data/local_data_source/user/user.local.data_source.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/data/repository/user/user.repository.impl.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class FakeLoginResultLocalModel extends Fake implements LoginResultLocalModel {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserLocalDataSource mockUserLocalDataSource;

  setUpAll(() {
    registerFallbackValue(FakeLoginResultLocalModel());
    mockUserLocalDataSource = MockUserLocalDataSource();
    repository = UserRepositoryImpl(mockUserLocalDataSource);
  });

  tearDownAll(() {
    log('🦕🦕🦕 Teardown UserRepositoryImpl Tests');
  });

  group('UserRepositoryImpl Tests', () {
    log('🦕 Start UserRepositoryImpl Tests');

    test('getLicence should call local data source', () async {
      const String license = 'testLicense';

      when(
        () => mockUserLocalDataSource.getLicence(),
      ).thenAnswer(
        (_) async => LoginResultLocalModel(
          licenseKey: license,
          valid: true,
          expirationDate: DateTime.now(),
        ),
      );

      final LoginResult? result = await repository.getLicence();

      expect(result, isA<LoginResult>());
      expect(result?.licenseKey, license);
      expect(result?.valid, isTrue);
      expect(result?.expirationDate, isA<DateTime>());
    });

    test('saveLicense should call local data source', () async {
      const String license = 'testLicense';

      final LoginResult loginResult = LoginResult(
        licenseKey: license,
        valid: true,
        expirationDate: DateTime.now(),
      );

      when(
        () => mockUserLocalDataSource.saveLicense(any()),
      ).thenAnswer((_) async {});

      await repository.saveLicense(loginResult);

      verify(
        () => mockUserLocalDataSource
            .saveLicense(any(that: isA<LoginResultLocalModel>())),
      ).called(1);
    });
  });
}
