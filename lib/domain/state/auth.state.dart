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
  ///
  AuthState({
    required this.isUserAuthenticated,
    required this.isInitialized,
    this.licenseId,
    this.expirationDate,
  });

  /// Initial
  /// @param [isInitialized] is initialized
  /// @param [isUserAuthenticated] is user authenticated
  /// @param [licenseId] license id
  /// @param [expirationDate] expiration date
  ///
  AuthState.initial({
    bool? isInitialized,
    this.isUserAuthenticated = false,
    this.licenseId,
    this.expirationDate,
  }) : isInitialized = isInitialized ?? false;

  /// Is user authenticated
  final bool isUserAuthenticated;

  /// License id
  final String? licenseId;

  /// Is initialized
  final bool isInitialized;

  /// Expiration date
  final DateTime? expirationDate;

  /// Get props
  /// @return [List<Object?>] props
  ///
  @override
  List<Object?> get props => <Object?>[
        isUserAuthenticated,
        licenseId,
        expirationDate,
        isInitialized,
      ];
}
