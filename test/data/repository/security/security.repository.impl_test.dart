import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:squirrel/data/local_data_source/security/security.local.data_source.dart';
import 'package:squirrel/data/repository/security/security.repository.impl.dart';

class MockSecurityLocalDataSource extends Mock
    implements SecurityLocalDataSource {}

void main() {
  late SecurityRepositoryImpl repository;
  late MockSecurityLocalDataSource mockSecurityLocalDataSource;

  setUpAll(() {
    log('🦕 Setup SecurityRepositoryImpl Tests');
    mockSecurityLocalDataSource = MockSecurityLocalDataSource();
    repository = SecurityRepositoryImpl(mockSecurityLocalDataSource);
  });

  tearDownAll(() {
    log('🦕🦕🦕 Teardown SecurityRepositoryImpl Tests');
  });

  group('SecurityRepositoryImpl Tests', () {
    log('🦕 Start SecurityRepositoryImpl Tests');
    test('setAppLockState should call local data source', () async {
      const bool isLocked = true;

      when(
        () => mockSecurityLocalDataSource.setAppLockState(isLocked: isLocked),
      ).thenAnswer((_) async => Future<void>.value());

      await repository.setAppLockState(isLocked: isLocked);

      verify(
        () => mockSecurityLocalDataSource.setAppLockState(isLocked: isLocked),
      ).called(1);
    });

    test('isAppLocked should call local data source', () async {
      const bool isLocked = true;

      when(
        () => mockSecurityLocalDataSource.getAppLockState(),
      ).thenAnswer((_) async => isLocked);

      final bool result = await repository.isAppLocked();

      expect(result, isLocked);

      verify(
        () => mockSecurityLocalDataSource.getAppLockState(),
      ).called(1);
    });

    test('setFailCount should call local data source', () async {
      const int count = 1;

      when(
        () => mockSecurityLocalDataSource.setFailCount(count),
      ).thenAnswer((_) async => Future<void>.value());

      await repository.setFailCount(count);

      verify(
        () => mockSecurityLocalDataSource.setFailCount(count),
      ).called(1);
    });

    test('getFailCount should call local data source', () async {
      const int count = 1;

      when(
        () => mockSecurityLocalDataSource.getFailCount(),
      ).thenAnswer((_) async => count);

      final int result = await repository.getFailCount();

      expect(result, count);

      verify(
        () => mockSecurityLocalDataSource.getFailCount(),
      ).called(1);
    });

    test('setLastCheckSuccess should call local data source', () async {
      final DateTime dateTime = DateTime.now();

      when(
        () => mockSecurityLocalDataSource.setLastCheckSuccess(
          dateTime.toIso8601String(),
        ),
      ).thenAnswer((_) async => Future<void>.value());

      await repository.setLastCheckSuccess(dateTime.toIso8601String());

      verify(
        () => mockSecurityLocalDataSource.setLastCheckSuccess(
          dateTime.toIso8601String(),
        ),
      ).called(1);
    });

    test('getLastCheckSuccess should call local data source', () async {
      when(
        () => mockSecurityLocalDataSource.getLastCheckSuccess(),
      ).thenAnswer((_) async => DateTime.now());

      final DateTime result = await repository.getLastCheckSuccess();

      expect(result, isA<DateTime>());

      verify(
        () => mockSecurityLocalDataSource.getLastCheckSuccess(),
      ).called(1);
    });

    test('setLastKnownTime should call local data source', () async {
      final DateTime dateTime = DateTime.now();

      when(
        () => mockSecurityLocalDataSource.setLastKnownTime(
          dateTime.toIso8601String(),
        ),
      ).thenAnswer((_) async => Future<void>.value());

      await repository.setLastKnownTime(dateTime);

      verify(
        () => mockSecurityLocalDataSource.setLastKnownTime(
          dateTime.toIso8601String(),
        ),
      ).called(1);
    });
  });
}
