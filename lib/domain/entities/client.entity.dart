import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';
import 'package:uuid/uuid.dart';

part 'client.entity.g.dart';

/// [Client]
@CopyWith()
@JsonSerializable()
class Client with EquatableMixin, SerializableMixin {
  final String id;
  final String name;
  final String? socialsName;
  final double orderTotalAmount;
  final double commissionTotalAmount;
  final int orderQuantity;
  final int sponsorshipQuantity;
  final String? sponsorName;
  final DateTime? lastOrderDate;
  final DateTime? firstOrderDate;

  /// Constructor
  /// @param id: String
  /// @param name: String
  /// @param socialsName: String
  /// @param orderTotalAmount: double
  /// @param orderQuantity: int
  /// @param sponsorshipQuantity: int
  /// @param sponsorName: String?
  /// @param lastOrderDate: DateTime?
  /// @param firstOrderDate: DateTime?
  ///
  Client({
    String? id,
    required this.name,
    this.socialsName,
    this.orderTotalAmount = 0,
    this.commissionTotalAmount = 0,
    this.orderQuantity = 0,
    this.sponsorshipQuantity = 0,
    this.sponsorName,
    this.lastOrderDate,
    this.firstOrderDate,
  }) : id = id ?? const Uuid().v4();

  /// Props
  ///
  @override
  List<Object?> get props => [
        id,
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

  @override
  Map<String, dynamic> toJson() => _$ClientToJson(this);

  @override
  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
}
