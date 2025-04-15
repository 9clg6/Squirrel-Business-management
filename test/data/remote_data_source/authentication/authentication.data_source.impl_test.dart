// Générer les mocks (exécuter build_runner)
// Définir la classe Mock directement avec Mocktail
import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';
import 'package:squirrel/data/model/remote/login_result.remote_model.dart';
import 'package:squirrel/data/remote_data_source/authentication/impl/authentication.data_source.impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabase extends Mock implements Supabase {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockFunctionsClient extends Mock implements FunctionsClient {}

class MockFunctionResponseFromMocktail extends Mock
    implements FunctionResponse {}

void main() {
  /// Mock
  late AuthenticationDataSourceImpl dataSource;
  late MockSupabaseClient mockSupabaseClient;
  late MockFunctionsClient mockFunctionsClient;
  late MockSupabase mockSupabase;

  /// Data
  const String testLicenseKey = 'test-key-123';

  final DateTime expiredDate = DateTime.now().subtract(
    const Duration(days: 30),
  );
  final DateTime validDate = DateTime.now().add(
    const Duration(days: 30),
  );

  final Map<String, dynamic> loginExpiredResponseData = <String, dynamic>{
    'valid': true,
    'licenseKey': testLicenseKey,
    'expirationDate': expiredDate.toIso8601String(),
  };

  final Map<String, dynamic> loginValidResponseData = <String, dynamic>{
    'valid': true,
    'licenseKey': testLicenseKey,
    'expirationDate': validDate.toIso8601String(),
  };

  final Map<String, dynamic> checkValidResponseData = <String, dynamic>{
    'valid': true,
    'expirationDate': validDate.toIso8601String(),
  };

  /// Setup
  ///
  setUpAll(() {
    log('🦕 Setup AuthenticationDataSourceImpl Tests');

    mockSupabaseClient = MockSupabaseClient();
    mockFunctionsClient = MockFunctionsClient();
    mockSupabase = MockSupabase();

    when(() => mockSupabase.client).thenReturn(mockSupabaseClient);
    when(() => mockSupabaseClient.functions).thenReturn(mockFunctionsClient);

    dataSource = AuthenticationDataSourceImpl(
      mockSupabaseClient,
    );

    registerFallbackValue(<String, String>{});
  });

  tearDownAll(() {
    log('🦕🦕🦕 Teardown AuthenticationDataSourceImpl Tests');
  });

  group('AuthenticationDataSourceImpl Tests', () {
    log('🦕🦕🦕 Start AuthenticationDataSourceImpl Tests');
    test('login SUCCESS - Clé Valide', () async {
      log('🦕 Start "login SUCCESS - Clé Valide" test');
      final MockFunctionResponseFromMocktail mockResponse =
          MockFunctionResponseFromMocktail();
      when(() => mockResponse.data).thenReturn(loginValidResponseData);
      when(
        () => mockFunctionsClient.invoke(
          'login',
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final LoginResultRemoteModel result =
          await dataSource.login(testLicenseKey);

      expect(result, isA<LoginResultRemoteModel>());
      expect(result.valid, isTrue);
      expect(result.licenseKey, testLicenseKey);
      expect(result.expirationDate?.day, validDate.day);

      verify(
        () => mockFunctionsClient.invoke(
          'login',
          body: <String, String>{'licenseKey': testLicenseKey},
        ),
      ).called(1);
      log('🦕💤 End "login SUCCESS - Clé Valide" test');
    });

    test('login SUCCESS - Clé Expirée (API OK, mais date passée)', () async {
      log('🦕 Start "login SUCCESS - Clé Expirée" test');
      final MockFunctionResponseFromMocktail mockResponse =
          MockFunctionResponseFromMocktail();

      when(() => mockResponse.data).thenReturn(loginExpiredResponseData);
      when(
        () => mockFunctionsClient.invoke(
          'login',
          body: <String, String>{'licenseKey': testLicenseKey},
        ),
      ).thenAnswer((_) async => mockResponse);

      final LoginResultRemoteModel result =
          await dataSource.login(testLicenseKey);

      expect(result, isA<LoginResultRemoteModel>());
      expect(result.valid, isTrue);
      expect(result.licenseKey, testLicenseKey);
      expect(result.expirationDate?.isBefore(DateTime.now()), isTrue);

      verify(
        () => mockFunctionsClient.invoke(
          'login',
          body: <String, String>{'licenseKey': testLicenseKey},
        ),
      ).called(1);
      log('🦕💤 End "login SUCCESS - Clé Expirée" test');
    });

    test('login FAILURE - Clé Vide', () async {
      log('🦕 Start "login FAILURE - Clé Vide" test');
      const String emptyKey = '';

      final LoginResultRemoteModel result = await dataSource.login(emptyKey);

      expect(result.valid, isFalse);
      expect(result.licenseKey, isEmpty);
      expect(result.expirationDate, isNull);

      verifyNever(
        () => mockFunctionsClient.invoke(
          any(),
          body: any(named: 'body'),
        ),
      );
      log('🦕💤 End "login FAILURE - Clé Vide" test');
    });

    test('login FAILURE - Erreur Supabase (Exception)', () async {
      log('🦕 Start "login FAILURE - Erreur Supabase" test');
      final Exception exception = Exception('Erreur réseau Supabase');
      when(
        () => mockFunctionsClient.invoke('login', body: any(named: 'body')),
      ).thenThrow(exception);

      final LoginResultRemoteModel result =
          await dataSource.login(testLicenseKey);

      expect(result.valid, isFalse);
      expect(result.licenseKey, isEmpty);
      expect(result.expirationDate, isNull);

      verify(
        () => mockFunctionsClient.invoke(
          'login',
          body: <String, String>{'licenseKey': testLicenseKey},
        ),
      ).called(1);
      log('🦕💤 End "login FAILURE - Erreur Supabase" test');
    });

    test('checkValidity SUCCESS', () async {
      log('🦕 Start "checkValidity SUCCESS" test');
      final MockFunctionResponseFromMocktail mockResponse =
          MockFunctionResponseFromMocktail();
      when(() => mockResponse.data).thenReturn(checkValidResponseData);
      when(
        () => mockFunctionsClient.invoke(
          'checkValidity',
          body: <String, String>{'licenseKey': testLicenseKey},
        ),
      ).thenAnswer((_) async => mockResponse);

      final CheckValidityRemoteModel result =
          await dataSource.checkValidity(testLicenseKey);

      expect(result.valid, isTrue);
      expect(result.expirationDate.isAfter(DateTime.now()), isTrue);

      verify(
        () => mockFunctionsClient.invoke(
          'checkValidity',
          body: <String, String>{'licenseKey': testLicenseKey},
        ),
      ).called(1);
      log('🦕💤 End "checkValidity SUCCESS" test');
    });

    test('checkValidity FAILURE - Erreur Supabase', () async {
      log('🦕 Start "checkValidity FAILURE - Erreur Supabase" test');
      final Exception exception = Exception('Erreur réseau Supabase');
      when(
        () => mockFunctionsClient.invoke(
          'checkValidity',
          body: any(named: 'body'),
        ),
      ).thenThrow(exception);

      final CheckValidityRemoteModel result =
          await dataSource.checkValidity(testLicenseKey);

      expect(result.valid, isFalse);
      expect(result.expirationDate, isNotNull);

      verify(
        () => mockFunctionsClient.invoke(
          'checkValidity',
          body: <String, String>{'licenseKey': testLicenseKey},
        ),
      ).called(1);
      log('🦕💤 End "checkValidity FAILURE - Erreur Supabase" test');
    });

    test('checkValidity FAILURE - Clé Vide (lance Exception)', () async {
      log('🦕 Start "checkValidity FAILURE - Clé Vide (lance Exception)" test');
      const String emptyKey = '';

      expect(
        () async => dataSource.checkValidity(emptyKey),
        throwsA(isA<Exception>()),
      );

      verifyNever(
        () => mockFunctionsClient.invoke(
          any(),
          body: any(named: 'body'),
        ),
      );
      log('🦕💤 End "checkValidity FAILURE - Clé Vide (lance Exception)" test');
    });
  });
}
