import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'auth.state.g.dart';

/// [AuthState]
@CopyWith()
class AuthState with EquatableMixin {
  /// Constructor
  /// @param [isUserAuthenticated] is user authenticated
  /// @param [licenseId] license id
  /// @param [expirationDate] expiration date
  /// @param [isInitialized] is initialized
  /// @param [isAppLocked] is app locked due to security checks
  ///
  AuthState({
    required this.isUserAuthenticated,
    required this.isInitialized,
    this.licenseId,
    this.expirationDate,
    this.isAppLocked = false,
  });

  /// Initial
  /// @param [isInitialized] is initialized
  /// @param [isUserAuthenticated] is user authenticated
  /// @param [licenseId] license id
  /// @param [expirationDate] expiration date
  /// @param [isAppLocked] is app locked due to security checks
  ///
  AuthState.initial({
    bool? isInitialized,
    this.isUserAuthenticated = false,
    this.licenseId,
    this.expirationDate,
    this.isAppLocked = false,
  }) : isInitialized = isInitialized ?? false;

  /// Is user authenticated
  final bool isUserAuthenticated;

  /// License id
  final String? licenseId;

  /// Is initialized
  final bool isInitialized;

  /// Expiration date
  final DateTime? expirationDate;
  
  /// Is app locked due to security checks
  final bool isAppLocked;

  /// Get props
  /// @return [List<Object?>] props
  ///
  @override
  List<Object?> get props => <Object?>[
        isUserAuthenticated,
        licenseId,
        expirationDate,
        isInitialized,
        isAppLocked,
      ];
}
