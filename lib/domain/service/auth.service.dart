import 'package:init/data/storage/hive_secure_storage.dart';
import 'package:init/domain/use_case/login.use_case.dart';

class AuthService {
  final LoginUseCase _loginUseCase;
  late final HiveSecureStorage _secureStorageService;

  bool _isUserAuthenticated = false;
  bool get isUserAuthenticated => _isUserAuthenticated;

  String? licenseId;
  DateTime? expirationDate;


  /// Constructor
  /// @param [_loginUseCase] login use case
  /// @param [_secureStorageService] secure storage service
  /// 
  AuthService(
    this._loginUseCase,
    this._secureStorageService,
  );

  /// Set user authenticated
  /// @param [isAuthenticated] is user authenticated
  /// @param [licenseId] license id
  /// 
  void _setUserAuthenticated(
    bool isAuthenticated, {
    required String licenseId,
  }) {
    _isUserAuthenticated = isAuthenticated;
    this.licenseId = licenseId;
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [bool] login result
  ///
  Future<bool> login(String licenseKey) async {
    final loginResult = await _loginUseCase.login(licenseKey);

    if (loginResult) {
      await _secureStorageService.set(
        'licenseId',
        licenseKey,
      );
      _setUserAuthenticated(
        true,
        licenseId: licenseKey,
      );
    }

    return loginResult;
  }
}
