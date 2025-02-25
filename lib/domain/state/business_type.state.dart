import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrel/foundation/enums/service_type.enum.dart';

part 'business_type.state.g.dart';

/// [BusinessTypeState]
@CopyWith()
class BusinessTypeState with EquatableMixin {
  /// Type of app use
  final BusinessType businessType;

  bool get isService => businessType == BusinessType.service;

  /// Constructor
  /// @param [businessType] type of service
  BusinessTypeState({
    required this.businessType,
  });

  BusinessTypeState.initial() : businessType = BusinessType.service;

  /// Props
  ///
  @override
  List<Object?> get props => [
        businessType,
      ];
}
