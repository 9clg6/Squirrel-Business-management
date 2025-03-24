import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'auth.state.g.dart';

/// [AuthState]
@CopyWith()
class AuthState with EquatableMixin {
  /// Is user authenticated
  final bool isUserAuthenticated;

  /// License id
  final String? licenseId;

  /// Is initialized
  final bool isInitialized;

  /// Expiration date
  final DateTime? expirationDate;

  /// Constructor
  /// @param [isUserAuthenticated] is user authenticated
  /// @param [licenseId] license id
  /// @param [expirationDate] expiration date
  ///
  AuthState({
    required this.isUserAuthenticated,
    this.licenseId,
    this.expirationDate,
    required this.isInitialized,
  });

  /// Initial
  ///
  AuthState.initial({
    bool? isInitialized,
    this.isUserAuthenticated = false,
    this.licenseId,
    this.expirationDate,
  }) : isInitialized = isInitialized ?? false;

  @override
  List<Object?> get props => [
        isUserAuthenticated,
        licenseId,
        expirationDate,
        isInitialized,
      ];
}
