import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'client.entity.g.dart';

/// [Client]
@CopyWith()
class Client with EquatableMixin {
  final String name;
  final String? socialsName;
  final double? orderTotalAmount;
  final double? commissionTotalAmount;  
  final int? orderQuantity;
  final int? sponsorshipQuantity;
  final String? sponsorName;
  final DateTime? lastOrderDate;
  final DateTime? firstOrderDate;

  /// Constructor
  /// @param client: String
  /// @param socialsName: String
  /// @param orderTotalAmount: double
  /// @param orderQuantity: int
  /// @param sponsorshipQuantity: int
  /// @param sponsorName: String?
  /// @param lastOrderDate: DateTime?
  /// @param firstOrderDate: DateTime?
  ///
  Client({
    required this.name,
    this.socialsName,
    this.orderTotalAmount,
    this.commissionTotalAmount,
    this.orderQuantity,
    this.sponsorshipQuantity,
    this.sponsorName,
    this.lastOrderDate,
    this.firstOrderDate,
  });

  /// Props
  ///
  @override
  List<Object?> get props => [
        name,
        socialsName,
        orderTotalAmount,
        orderQuantity,
        sponsorshipQuantity,
        sponsorName,
        lastOrderDate,
        firstOrderDate,
        commissionTotalAmount,
      ];
}
