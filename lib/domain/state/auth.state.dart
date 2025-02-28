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
  });

  /// Initial
  ///
  AuthState.initial()
      : isUserAuthenticated = false,
        licenseId = null,
        expirationDate = null;

  @override
  List<Object?> get props => [
        isUserAuthenticated,
        licenseId,
        expirationDate,
      ];
}
