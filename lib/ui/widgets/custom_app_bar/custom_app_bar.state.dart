import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'custom_app_bar.state.g.dart';

/// [CustomAppBarState]
@CopyWith()
class CustomAppBarState with EquatableMixin {
  /// Constructor
  /// @param [expirationDate] expiration date
  ///
  CustomAppBarState({
    this.expirationDate,
  });

  /// Expiration date
  final DateTime? expirationDate;

  /// Copy with
  @override
  List<Object?> get props => <Object?>[];
}
